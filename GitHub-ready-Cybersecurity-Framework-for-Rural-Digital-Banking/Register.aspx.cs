using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Net;
using System.Net.Mail;
using System.Security.Cryptography;
using System.Text;

namespace Cybersecurity_Framework_for_Rural_Digital_Banking
{
    public partial class Register : System.Web.UI.Page
    {
        // Connection string from Web.config
        private readonly string cs = ConfigurationManager.ConnectionStrings["LIS"].ConnectionString;

        // RSA + AES helpers (same pattern as customer-reg)
        private readonly UnicodeEncoding ByteConverter = new UnicodeEncoding();
        private readonly RSACryptoServiceProvider RSA = new RSACryptoServiceProvider();

        protected void Page_Load(object sender, EventArgs e) { }

        // ──────────────────────────────────────────────────────────────────────
        //  OTP — send
        // ──────────────────────────────────────────────────────────────────────
        protected void btnSendOTP_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtEmail.Text))
            { lblEmailStatus.Text = "Please enter an email address first."; return; }

            string otp = new Random().Next(1000, 9999).ToString();
            Session["otp"] = otp;

            string status = SendOTPEmail(txtEmail.Text.Trim(),
                                         "OTP for Registration",
                                         "Your registration OTP is: " + otp);
            lblEmailStatus.Text = status == "Success"
                                 ? "OTP sent successfully."
                                 : "Failed to send OTP: " + status;
        }

        // ──────────────────────────────────────────────────────────────────────
        //  OTP — verify
        // ──────────────────────────────────────────────────────────────────────
        protected void btnVerifyOTP_Click(object sender, EventArgs e)
        {
            if (Session["otp"] != null && txtOTP.Text.Trim() == Session["otp"].ToString())
            {
                Session["otpVerified"] = true;
                lblOTPCheck.Text = "✅ OTP verified successfully!";
                lblOTPCheck.ForeColor = System.Drawing.Color.LightGreen;
            }
            else
            {
                Session["otpVerified"] = false;
                lblOTPCheck.Text = "❌ Invalid OTP, please try again.";
                lblOTPCheck.ForeColor = System.Drawing.Color.OrangeRed;
            }
        }

        // ──────────────────────────────────────────────────────────────────────
        //  Main registration handler
        // ──────────────────────────────────────────────────────────────────────
        protected void btnRegister_Click(object sender, EventArgs e)
        {
            lblError.Text = "";

            // ── Basic field validation ─────────────────────────────────────
            string mobile = txtMobile.Text.Trim();
            string password = txtPassword.Text.Trim();
            string confirmPassword = txtConfirmPassword.Text.Trim();

            if (string.IsNullOrEmpty(mobile) || string.IsNullOrEmpty(password))
            { lblError.Text = "Please fill in all required fields."; return; }

            if (password != confirmPassword)
            { lblError.Text = "Passwords do not match."; return; }

            // ── OTP must be verified ───────────────────────────────────────
            if (Session["otpVerified"] == null || !(bool)Session["otpVerified"])
            { lblError.Text = "Please verify your email OTP before registering."; return; }

            // ── Voice samples required ─────────────────────────────────────
            if (string.IsNullOrEmpty(hdnVoice1.Value) ||
                string.IsNullOrEmpty(hdnVoice2.Value) ||
                string.IsNullOrEmpty(hdnVoice3.Value))
            { lblError.Text = "Please record all 3 voice samples."; return; }

            // ── File uploads required ──────────────────────────────────────
            if (!fuAadhar.HasFile || !fuPAN.HasFile || !fuSign.HasFile || !fuPhoto.HasFile)
            { lblError.Text = "Please upload all required documents."; return; }

            // ── Encrypt password ───────────────────────────────────────────
            string passwordHash = ComputeSha256Hash(password);

            // ── Hybrid-encrypt mobile (RSA + AES, matching customer-reg) ──
            AES aes = new AES();
            byte[] plainMobileBytes = ByteConverter.GetBytes(mobile);
            byte[] rsaEncryptedBytes = RsaEncrypt(plainMobileBytes, RSA.ExportParameters(false));
            string hybridMobile = aes.Encrypt(mobile) + "@@" + ByteConverter.GetString(rsaEncryptedBytes);
            hfHybridMobile.Value = hybridMobile;

            // ── Save voice files ───────────────────────────────────────────
            string voice1 = SaveVoice(hdnVoice1.Value, "V1_" + mobile);
            string voice2 = SaveVoice(hdnVoice2.Value, "V2_" + mobile);
            string voice3 = SaveVoice(hdnVoice3.Value, "V3_" + mobile);

            if (voice1 == null || voice2 == null || voice3 == null)
            { lblError.Text = "Voice file saving failed. Please try again."; return; }

            // ── Generate IDs (matching customer-reg pattern) ───────────────
            BasicCode b = new BasicCode();
            string cid = b.generateID("cid", "Registration");
            string accountNo = b.generateID("accountno", "Registration");
            if (accountNo == "1") accountNo = "30001";

            // ── Save uploaded documents ────────────────────────────────────
            string aadharFile = SaveDocument(fuAadhar, "aadhar_" + cid);
            string panFile = SaveDocument(fuPAN, "pan_" + cid);
            string signFile = SaveDocument(fuSign, "sign_" + cid);
            string photoFile = SaveDocument(fuPhoto, "photo_" + cid);

            if (aadharFile == null || panFile == null || signFile == null || photoFile == null)
            { lblError.Text = "Document upload failed. Please try again."; return; }

            // ── Gender ─────────────────────────────────────────────────────
            string gender = rbtnFemale.Checked ? "Female"
                          : rbtnNA.Checked ? "Not ready to disclose"
                          : "Male";

            // ── Database insert ────────────────────────────────────────────
            string query = @"
INSERT INTO Registration
(
    mobile, password,
    firstname, middlename, lastname,
    email, dob, gender, address, city, state, username,
    aadhar, pan, signature, photo,
    hybrid_adhar, hybrid_pan,
    accountno, balance, status, HybridMobile,
    VoiceFilePath, VoiceFilePath2, VoiceFilePath3,
    IsLocked, FailedLoginAttempts, CreatedAt
)
VALUES
(
    @mobile, @password,
    @firstname, @middlename, @lastname,
    @email, @dob, @gender, @address, @city, @state, @username,
    @aadhar, @pan, @signature, @photo,
    @hybrid_adhar, @hybrid_pan,
    @accountno, @balance, @status, @HybridMobile,
    @Voice1, @Voice2, @Voice3,
    @IsLocked, @FailedLoginAttempts, GETDATE()
)";

            using (SqlConnection conn = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@mobile", mobile);
                cmd.Parameters.AddWithValue("@password", passwordHash);

                cmd.Parameters.AddWithValue("@firstname", txtFirstName.Text.Trim());
                cmd.Parameters.AddWithValue("@middlename", txtMiddleName.Text.Trim());
                cmd.Parameters.AddWithValue("@lastname", txtLastName.Text.Trim());

                cmd.Parameters.AddWithValue("@email", txtEmail.Text.Trim());
                cmd.Parameters.AddWithValue("@dob", txtDOB.Text.Trim());
                cmd.Parameters.AddWithValue("@gender", gender);
                cmd.Parameters.AddWithValue("@address", txtAddress.Text.Trim());
                cmd.Parameters.AddWithValue("@city", txtCity.Text.Trim());
                cmd.Parameters.AddWithValue("@state", txtState.Text.Trim());
                cmd.Parameters.AddWithValue("@username", txtUsername.Text.Trim());

                cmd.Parameters.AddWithValue("@aadhar", aadharFile);
                cmd.Parameters.AddWithValue("@pan", panFile);
                cmd.Parameters.AddWithValue("@signature", signFile);
                cmd.Parameters.AddWithValue("@photo", photoFile);

                cmd.Parameters.AddWithValue("@hybrid_adhar", aes.Encrypt(aadharFile));
                cmd.Parameters.AddWithValue("@hybrid_pan", aes.Encrypt(panFile));

                cmd.Parameters.AddWithValue("@accountno", accountNo);
                cmd.Parameters.AddWithValue("@balance", 500.0);
                cmd.Parameters.AddWithValue("@status", "No");

                cmd.Parameters.AddWithValue("@HybridMobile", hybridMobile);

                cmd.Parameters.AddWithValue("@Voice1", voice1);
                cmd.Parameters.AddWithValue("@Voice2", voice2);
                cmd.Parameters.AddWithValue("@Voice3", voice3);

                cmd.Parameters.AddWithValue("@IsLocked", 0);
                cmd.Parameters.AddWithValue("@FailedLoginAttempts", 0);

                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();

                    Session.Remove("otp");
                    Session.Remove("otpVerified");

                    ClientScript.RegisterStartupScript(
                        this.GetType(), "RegSuccess", "showSuccessPopup();", true);
                }
                catch (SqlException ex)
                {
                    if (ex.Number == 2627)
                        lblError.Text = "This mobile number is already registered.";
                    else
                        lblError.Text = "Registration failed: " + ex.Message;
                }
            }
        }

        // ──────────────────────────────────────────────────────────────────────
        //  Save voice file (base64 → disk)
        // ──────────────────────────────────────────────────────────────────────
        private string SaveVoice(string base64data, string filePrefix)
        {
            try
            {
                string ext = ".webm";
                if (base64data.Contains(","))
                {
                    string header = base64data.Substring(0, base64data.IndexOf(","));
                    string mime = header.Replace("data:", "").Split(';')[0];
                    if (mime.Contains("mp4")) ext = ".mp4";
                    else if (mime.Contains("ogg")) ext = ".ogg";
                    else if (mime.Contains("wav")) ext = ".wav";
                    base64data = base64data.Substring(base64data.IndexOf(",") + 1);
                }

                byte[] bytes = Convert.FromBase64String(base64data);
                string folder = Server.MapPath("~/VoiceFiles/");
                if (!Directory.Exists(folder)) Directory.CreateDirectory(folder);

                string path = Path.Combine(folder,
                    filePrefix + "_" + DateTime.Now.ToString("yyyyMMddHHmmss") + ext);
                File.WriteAllBytes(path, bytes);
                return path;
            }
            catch { return null; }
        }

        // ──────────────────────────────────────────────────────────────────────
        //  Save uploaded document (Aadhar / PAN / Signature / Photo)
        // ──────────────────────────────────────────────────────────────────────
        private string SaveDocument(System.Web.UI.WebControls.FileUpload fu, string prefix)
        {
            try
            {
                if (!fu.HasFile) return null;
                string ext = Path.GetExtension(fu.FileName);
                string fname = prefix + ext;

                // Determine sub-folder from prefix
                string subDir = prefix.StartsWith("aadhar") ? "Aadhar"
                               : prefix.StartsWith("pan") ? "PAN"
                               : prefix.StartsWith("sign") ? "Signature"
                               : "Photos";

                string folder = Path.Combine(Server.MapPath("~/user"), subDir);
                if (!Directory.Exists(folder)) Directory.CreateDirectory(folder);

                fu.SaveAs(Path.Combine(folder, fname));
                return fname;
            }
            catch { return null; }
        }

        // ──────────────────────────────────────────────────────────────────────
        //  RSA encrypt
        // ──────────────────────────────────────────────────────────────────────
        private static byte[] RsaEncrypt(byte[] data, RSAParameters key)
        {
            try
            {
                using (RSACryptoServiceProvider rsa = new RSACryptoServiceProvider())
                {
                    rsa.ImportParameters(key);
                    return rsa.Encrypt(data, false);
                }
            }
            catch (CryptographicException ex)
            {
                Console.WriteLine(ex.Message);
                return null;
            }
        }

        // ──────────────────────────────────────────────────────────────────────
        //  SHA-256 password hash
        // ──────────────────────────────────────────────────────────────────────
        private static string ComputeSha256Hash(string rawData)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(rawData));
                StringBuilder sb = new StringBuilder();
                foreach (byte b in bytes) sb.Append(b.ToString("x2"));
                return sb.ToString();
            }
        }

        // ──────────────────────────────────────────────────────────────────────
        //  Send OTP via email
        // ──────────────────────────────────────────────────────────────────────
        private string SendOTPEmail(string toEmail, string subject, string body)
        {
            try
            {
                using (SmtpClient client = new SmtpClient())   // no host, no port
                {
                    MailMessage mail = new MailMessage();
                    mail.To.Add(toEmail);
                    mail.Subject = subject;
                    mail.Body = body;
                    mail.IsBodyHtml = false;

                    client.Send(mail);
                }
                return "Success";
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }

    }
}
