using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Net.Mail;
using System.Security.Cryptography;
using System.Text;

namespace Cybersecurity_Framework_for_Rural_Digital_Banking
{
    public partial class Login : System.Web.UI.Page
    {
        private readonly string cs = ConfigurationManager.ConnectionStrings["LIS"].ConnectionString;

        // ──────────────────────────────────────────────────────────────────────
        //  Page_Load
        //  On every load (first visit AND every postback) we:
        //    1. Ensure a CAPTCHA code exists in Session
        //    2. Sync the hidden field with the Session value
        //    3. Call initPage() in JS so the canvas gets painted and the
        //       correct tab is shown — even after a postback wipes the DOM
        // ──────────────────────────────────────────────────────────────────────
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Fresh visit — generate a brand new CAPTCHA
                GenerateNewCaptcha();
            }
            // On postback we keep the same CAPTCHA code unless the server
            // explicitly calls GenerateNewCaptcha() (e.g. after wrong entry).
            // Either way we must re-sync hidden field and repaint canvas.

            string captchaCode = Session["LoginCaptcha"] != null
                                  ? Session["LoginCaptcha"].ToString()
                                  : GenerateNewCaptcha();

            string activeMode = hdnAuthMode.Value == "otp" ? "otp" : "voice";
            string isPostBackJs = IsPostBack ? "true" : "false";

            // Inject initPage() call — this fires after the page HTML is ready
            // and reliably repaints the canvas and restores the active panel.
            string script = string.Format(
                "window.addEventListener('load', function(){{ initPage('{0}', '{1}', {2}); }});",
                activeMode, captchaCode, isPostBackJs);

            ClientScript.RegisterStartupScript(this.GetType(), "InitPage", script, true);
        }

        // ──────────────────────────────────────────────────────────────────────
        //  GenerateNewCaptcha — creates a new code, stores in Session + hidden field
        // ──────────────────────────────────────────────────────────────────────
        private string GenerateNewCaptcha()
        {
            const string chars = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789";
            var rng = new Random();
            var code = new char[6];
            for (int i = 0; i < 6; i++)
                code[i] = chars[rng.Next(chars.Length)];

            string captchaCode = new string(code);
            Session["LoginCaptcha"] = captchaCode;
            hdnCaptchaValue.Value = captchaCode; // keep hidden field in sync
            return captchaCode;
        }

        // ──────────────────────────────────────────────────────────────────────
        //  ValidateCaptcha — shared by btnSendOTP and btnLogin
        //  Compares what the user typed against the Session value (authoritative).
        //  Always generates a fresh CAPTCHA after validation so codes are single-use.
        // ──────────────────────────────────────────────────────────────────────
        private bool ValidateCaptcha()
        {
            string entered = (txtCaptcha.Text ?? "").Trim().ToUpper();
            string stored = Session["LoginCaptcha"] != null
                             ? Session["LoginCaptcha"].ToString().ToUpper()
                             : "";

            // Generate a new CAPTCHA regardless of pass/fail (single-use)
            GenerateNewCaptcha();
            txtCaptcha.Text = "";

            if (string.IsNullOrEmpty(entered) || entered != stored)
            {
                lblMessage.Text = "Incorrect CAPTCHA. A new one has been generated — please try again.";
                return false;
            }
            return true;
        }

        // ──────────────────────────────────────────────────────────────────────
        //  Send OTP (OTP panel — requires CAPTCHA + Mobile + Password first)
        // ──────────────────────────────────────────────────────────────────────
        protected void btnSendOTP_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";
            lblOTPStatus.Text = "";

            // 1. CAPTCHA
            if (!ValidateCaptcha()) return;

            // 2. Mobile and password must be filled
            string mobile = txtMobile.Text.Trim();
            string password = txtPassword.Text.Trim();

            if (string.IsNullOrEmpty(mobile))
            {
                lblMessage.Text = "Please enter your mobile number.";
                return;
            }
            if (string.IsNullOrEmpty(password))
            {
                lblMessage.Text = "Please enter your password.";
                return;
            }

            // 3. Verify the user exists, is approved, and password is correct
            //    before sending OTP — no point sending if credentials are wrong
            DataRow user = GetUserByMobile(mobile);
            if (user == null)
            {
                lblMessage.Text = "Mobile number not registered.";
                return;
            }

            string status = user["status"] != DBNull.Value ? user["status"].ToString() : "No";
            if (!status.Equals("Yes", StringComparison.OrdinalIgnoreCase))
            {
                lblMessage.Text = "Your account is pending admin approval.";
                return;
            }

            bool isLocked = user["IsLocked"] != DBNull.Value && Convert.ToBoolean(user["IsLocked"]);
            DateTime? lockUntil = user["LockUntil"] != DBNull.Value
                                  ? (DateTime?)Convert.ToDateTime(user["LockUntil"]) : null;
            if (isLocked && lockUntil != null && lockUntil > DateTime.Now)
            {
                lblMessage.Text = "Account locked. Try again after "
                                + lockUntil.Value.ToString("dd-MM-yyyy HH:mm:ss");
                return;
            }

            // Verify password before sending OTP
            string storedHash = user["password"].ToString();
            string enteredHash = ComputeSha256Hash(password);
            if (enteredHash != storedHash)
            {
                lblMessage.Text = "Incorrect password. Please check and try again.";
                return;
            }

            string email = user["email"] != DBNull.Value ? user["email"].ToString() : "";
            if (string.IsNullOrEmpty(email))
            {
                lblMessage.Text = "No email address found for this account.";
                return;
            }

            // 4. Generate 6-digit OTP and store in Session
            string otp = new Random().Next(100000, 999999).ToString();
            Session["loginOtp"] = otp;
            Session["loginOtpMobile"] = mobile;
            Session["loginOtpExpiry"] = DateTime.Now.AddMinutes(5);

            string result = SendEmail(
                email,
                "Your Banking Login OTP",
                "Your OTP for login is: " + otp
                + "\n\nThis OTP is valid for 5 minutes. Do not share it with anyone.");

            if (result == "Success")
            {
                int at = email.IndexOf('@');
                string masked = at > 1
                    ? email.Substring(0, 1) + "*****" + email.Substring(at)
                    : "your registered email";

                lblOTPStatus.ForeColor = System.Drawing.Color.LightGreen;
                lblOTPStatus.Text = "✅ OTP sent to " + masked + " — valid for 5 minutes.";
            }
            else
            {
                lblMessage.Text = "Failed to send OTP: " + result;
            }
        }

        // ──────────────────────────────────────────────────────────────────────
        //  btnLogin_Click — handles both Voice and OTP login
        // ──────────────────────────────────────────────────────────────────────
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";

            // Step 1: CAPTCHA — mandatory for both modes
            if (!ValidateCaptcha()) return;

            // Step 2: Basic fields
            string mobile = txtMobile.Text.Trim();
            string password = txtPassword.Text.Trim();
            string authMode = hdnAuthMode.Value == "otp" ? "otp" : "voice";

            if (string.IsNullOrEmpty(mobile) || string.IsNullOrEmpty(password))
            {
                lblMessage.Text = "Please enter your mobile number and password.";
                return;
            }

            // Step 3: Fetch user
            DataRow user = GetUserByMobile(mobile);
            if (user == null)
            {
                lblMessage.Text = "Mobile number not registered.";
                return;
            }

            int userId = Convert.ToInt32(user["cid"]);
            string storedHash = user["password"].ToString();
            bool isLocked = user["IsLocked"] != DBNull.Value && Convert.ToBoolean(user["IsLocked"]);
            int failedAttempts = user["FailedLoginAttempts"] != DBNull.Value
                                      ? Convert.ToInt32(user["FailedLoginAttempts"]) : 0;
            DateTime? lockUntil = user["LockUntil"] != DBNull.Value
                                     ? (DateTime?)Convert.ToDateTime(user["LockUntil"]) : null;
            string status = user["status"] != DBNull.Value ? user["status"].ToString() : "No";

            // Step 4: Account approval
            if (!status.Equals("Yes", StringComparison.OrdinalIgnoreCase))
            {
                lblMessage.Text = "Your account is pending admin approval.";
                return;
            }

            // Step 5: Lock check
            if (isLocked && lockUntil != null && lockUntil > DateTime.Now)
            {
                lblMessage.Text = "Account locked. Try again after "
                                + lockUntil.Value.ToString("dd-MM-yyyy HH:mm:ss");
                return;
            }
            if (isLocked && (lockUntil == null || lockUntil <= DateTime.Now))
            {
                ResetFailedAttempts(userId);
                isLocked = false; failedAttempts = 0;
            }

            // Step 6: Password check
            string enteredHash = ComputeSha256Hash(password);
            if (enteredHash != storedHash)
            {
                IncreaseFailedAttempt(userId, failedAttempts);
                lblMessage.Text = "Incorrect password.";
                return;
            }

            // Step 7: Second factor
            if (authMode == "voice")
            {
                if (string.IsNullOrEmpty(hdnLoginVoicePath.Value))
                {
                    lblMessage.Text = "Please record your voice before logging in.";
                    return;
                }

                string voice1 = user["VoiceFilePath"].ToString();
                string voice2 = user["VoiceFilePath2"].ToString();
                string voice3 = user["VoiceFilePath3"].ToString();

                string loginVoicePath = SaveLoginVoice(mobile);
                if (loginVoicePath == null)
                {
                    lblMessage.Text = "Voice processing failed. Please try again.";
                    return;
                }

                bool voiceMatch = VoiceHelper.CompareVoiceWithMultipleSamples(
                    loginVoicePath, voice1, voice2, voice3);

                if (!voiceMatch)
                {
                    IncreaseFailedAttempt(userId, failedAttempts);
                    lblMessage.Text = "Voice authentication failed. Please try again.";
                    return;
                }
            }
            else // otp
            {
                string enteredOtp = (txtOTP.Text ?? "").Trim();
                string sessionOtp = Session["loginOtp"] != null ? Session["loginOtp"].ToString() : "";
                string sessionMob = Session["loginOtpMobile"] != null ? Session["loginOtpMobile"].ToString() : "";
                DateTime? expiry = Session["loginOtpExpiry"] != null
                                     ? (DateTime?)Convert.ToDateTime(Session["loginOtpExpiry"]) : null;

                if (string.IsNullOrEmpty(enteredOtp))
                {
                    lblMessage.Text = "Please enter the OTP sent to your email.";
                    return;
                }
                if (string.IsNullOrEmpty(sessionOtp))
                {
                    lblMessage.Text = "No OTP found. Please click Send OTP first.";
                    return;
                }
                if (sessionMob != mobile)
                {
                    lblMessage.Text = "OTP was sent to a different mobile number. Please request a new one.";
                    return;
                }
                if (expiry == null || DateTime.Now > expiry)
                {
                    lblMessage.Text = "OTP has expired. Please request a new one.";
                    Session.Remove("loginOtp");
                    Session.Remove("loginOtpExpiry");
                    Session.Remove("loginOtpMobile");
                    return;
                }
                if (enteredOtp != sessionOtp)
                {
                    IncreaseFailedAttempt(userId, failedAttempts);
                    lblMessage.Text = "Invalid OTP. Please check and try again.";
                    return;
                }

                // Consume — single use
                Session.Remove("loginOtp");
                Session.Remove("loginOtpExpiry");
                Session.Remove("loginOtpMobile");
            }

            // ── SUCCESS ───────────────────────────────────────────────────
            ResetFailedAttempts(userId);
            Session["cid"] = userId;
            Session["Mobile"] = mobile;
            Session["Username"] = user["username"] != DBNull.Value ? user["username"].ToString() : mobile;
            Session["FirstName"] = user["firstname"] != DBNull.Value ? user["firstname"].ToString() : "";
            Session["AccountNo"] = user["accountno"] != DBNull.Value ? user["accountno"].ToString() : "";
            Session["AuthMethod"] = authMode;
            // Clear CAPTCHA session on successful login
            Session.Remove("LoginCaptcha");

            Response.Redirect("user/Default.aspx");
        }

        // ──────────────────────────────────────────────────────────────────────
        //  DB helpers
        // ──────────────────────────────────────────────────────────────────────
        private DataRow GetUserByMobile(string mobile)
        {
            using (SqlConnection conn = new SqlConnection(cs))
            {
                string sql = @"
                    SELECT cid, password, email,
                           VoiceFilePath, VoiceFilePath2, VoiceFilePath3,
                           IsLocked, LockUntil, FailedLoginAttempts,
                           status, username, firstname, accountno
                    FROM   Registration
                    WHERE  mobile = @Mobile";
                var da = new SqlDataAdapter(new SqlCommand(sql, conn));
                ((SqlCommand)da.SelectCommand).Parameters.AddWithValue("@Mobile", mobile);
                var dt = new DataTable(); da.Fill(dt);
                return dt.Rows.Count > 0 ? dt.Rows[0] : null;
            }
        }

        private void IncreaseFailedAttempt(int userId, int current)
        {
            using (SqlConnection conn = new SqlConnection(cs))
            {
                conn.Open(); current++;
                string sql = current >= 5
                    ? "UPDATE Registration SET IsLocked=1, LockUntil=DATEADD(MINUTE,15,GETDATE()), FailedLoginAttempts=@A WHERE cid=@cid"
                    : "UPDATE Registration SET FailedLoginAttempts=@A WHERE cid=@cid";
                var cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@A", current);
                cmd.Parameters.AddWithValue("@cid", userId);
                cmd.ExecuteNonQuery();
            }
        }

        private void ResetFailedAttempts(int userId)
        {
            using (SqlConnection conn = new SqlConnection(cs))
            {
                conn.Open();
                var cmd = new SqlCommand(@"
                    UPDATE Registration
                    SET FailedLoginAttempts=0, IsLocked=0, LockUntil=NULL, LastLoginTime=GETDATE()
                    WHERE cid=@cid", conn);
                cmd.Parameters.AddWithValue("@cid", userId);
                cmd.ExecuteNonQuery();
            }
        }

        private string SaveLoginVoice(string mobile)
        {
            try
            {
                string b64 = hdnLoginVoicePath.Value;
                string ext = ".webm";
                if (b64.Contains(","))
                {
                    string mime = b64.Substring(0, b64.IndexOf(",")).Replace("data:", "").Split(';')[0];
                    if (mime.Contains("mp4")) ext = ".mp4";
                    else if (mime.Contains("ogg")) ext = ".ogg";
                    else if (mime.Contains("wav")) ext = ".wav";
                    b64 = b64.Substring(b64.IndexOf(",") + 1);
                }
                byte[] bytes = Convert.FromBase64String(b64);
                string folder = Server.MapPath("~/TempLoginVoice/");
                if (!Directory.Exists(folder)) Directory.CreateDirectory(folder);
                string path = Path.Combine(folder, "LoginVoice_" + mobile + "_"
                              + DateTime.Now.ToString("yyyyMMddHHmmss") + ext);
                File.WriteAllBytes(path, bytes);
                return path;
            }
            catch { return null; }
        }

        private static string ComputeSha256Hash(string raw)
        {
            using (SHA256 sha = SHA256.Create())
            {
                byte[] bytes = sha.ComputeHash(Encoding.UTF8.GetBytes(raw));
                var sb = new StringBuilder();
                foreach (byte b in bytes) sb.Append(b.ToString("x2"));
                return sb.ToString();
            }
        }

        private string SendEmail(string to, string subject, string body)
        {
            try
            {
                using (var client = new SmtpClient())
                {
                    var mail = new MailMessage();
                    mail.To.Add(to); mail.Subject = subject;
                    mail.Body = body; mail.IsBodyHtml = false;
                    client.Send(mail);
                }
                return "Success";
            }
            catch (Exception ex) { return ex.Message; }
        }
    }
}
