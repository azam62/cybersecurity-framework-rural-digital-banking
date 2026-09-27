using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Net.Mail;

namespace Cybersecurity_Framework_for_Rural_Digital_Banking.user
{
    public partial class withdrawal : System.Web.UI.Page
    {
        // ─────────────────────────────────────────
        //  Page Load
        // ─────────────────────────────────────────
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["cid"] == null)
            {
                Response.Redirect("~/login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadSenderInfo();
                LoadRecipients();
            }
        }

        // ─────────────────────────────────────────
        //  Load logged-in user's balance
        // ─────────────────────────────────────────
        private void LoadSenderInfo()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["LIS"]))
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand(
                        @"SELECT balance, accountno, email,
                                 ISNULL(firstname,'') + ' ' + ISNULL(lastname,'') AS fullname
                          FROM Registration WHERE cid = @cid", con);
                    cmd.Parameters.Add("@cid", SqlDbType.Int).Value = Convert.ToInt32(Session["cid"]);

                    using (SqlDataReader r = cmd.ExecuteReader())
                    {
                        if (r.Read())
                        {
                            litBalance.Text       = r["balance"].ToString();
                            hfAccountNo.Value     = r["accountno"]?.ToString() ?? "";
                            hfEmail.Value         = r["email"]?.ToString() ?? "";
                            hfCustomerID.Value    = Session["cid"].ToString();
                            hfSenderName.Value    = r["fullname"]?.ToString().Trim() ?? "Account Holder";
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblStatus.ForeColor = System.Drawing.Color.OrangeRed;
                lblStatus.Text = "Error loading account: " + ex.Message;
            }
        }

        // ─────────────────────────────────────────
        //  Populate recipient dropdown
        //  (all customers except the logged-in user)
        // ─────────────────────────────────────────
        private void LoadRecipients()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["LIS"]))
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand(
                        @"SELECT cid, accountno,
                                 ISNULL(firstname,'') + ' ' + ISNULL(lastname,'') AS fullname
                          FROM Registration
                          WHERE cid <> @cid AND status = 'Yes'
                          ORDER BY firstname", con);
                    cmd.Parameters.Add("@cid", SqlDbType.Int).Value = Convert.ToInt32(Session["cid"]);

                    ddlRecipient.Items.Clear();
                    ddlRecipient.Items.Add(new ListItem("— Select recipient —", ""));

                    using (SqlDataReader r = cmd.ExecuteReader())
                    {
                        while (r.Read())
                        {
                            string name    = r["fullname"].ToString().Trim();
                            string accno   = r["accountno"]?.ToString() ?? "";
                            string cidVal  = r["cid"].ToString();

                            // value = "cid|accountno|fullname"
                            ddlRecipient.Items.Add(new ListItem(
                                name + "  ·  " + accno,
                                cidVal + "|" + accno + "|" + name));
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblStatus.Text = "Error loading recipients: " + ex.Message;
            }
        }

        // ─────────────────────────────────────────
        //  Recipient dropdown changed
        // ─────────────────────────────────────────
        protected void ddlRecipient_SelectedIndexChanged(object sender, EventArgs e)
        {
            string val = ddlRecipient.SelectedValue;
            if (string.IsNullOrEmpty(val))
            {
                litRecipientName.Text = "Select a recipient above";
                litRecipientAcc.Text  = "";
                txtRecipientAcc.Text  = "";
                return;
            }

            string[] parts = val.Split('|');
            // parts[0]=cid, parts[1]=accountno, parts[2]=name
            txtRecipientAcc.Text  = parts.Length > 1 ? parts[1] : "";
            litRecipientName.Text = parts.Length > 2 ? parts[2] : "";
            litRecipientAcc.Text  = "Account: " + txtRecipientAcc.Text;
        }

        // ─────────────────────────────────────────
        //  Send OTP
        // ─────────────────────────────────────────
        protected void btnSendOtp_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(ddlRecipient.SelectedValue))
            {
                ShowAlert("warning", "No Recipient", "Please select a recipient first.");
                return;
            }

            decimal amount;
            if (!decimal.TryParse(txtAmount.Text.Trim(), out amount) || amount <= 0)
            {
                ShowAlert("warning", "Invalid Amount", "Please enter a valid transfer amount.");
                return;
            }

            decimal balance;
            if (!decimal.TryParse(litBalance.Text, out balance) || amount > balance)
            {
                ShowAlert("warning", "Insufficient Funds",
                    "You don't have enough balance for this transfer. Available: ₹" + litBalance.Text);
                return;
            }

            // Generate and store OTP in Session
            string otp = new Random().Next(100000, 999999).ToString();
            Session["transfer_otp"] = otp;

            // Send email
            string result = SendOTPEmail(hfEmail.Value, "Transfer OTP", otp,
                amount.ToString(), ddlRecipient.SelectedItem.Text);

            lblOtpMsg.Visible  = true;
            txtOTP.Visible     = true;
            btnConfirm.Visible = true;

            if (result == "Success")
            {
                lblStatus.ForeColor = System.Drawing.Color.LightGreen;
                lblStatus.Text = "OTP sent to your registered email. Enter it below.";
            }
            else
            {
                lblStatus.ForeColor = System.Drawing.Color.OrangeRed;
                lblStatus.Text = "OTP email failed: " + result;
            }
        }

        // ─────────────────────────────────────────
        //  Confirm Transfer
        // ─────────────────────────────────────────
        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            // Validate OTP
            string sessionOtp = Session["transfer_otp"] as string;
            if (string.IsNullOrEmpty(sessionOtp) || txtOTP.Text.Trim() != sessionOtp)
            {
                lblStatus.ForeColor = System.Drawing.Color.OrangeRed;
                lblStatus.Text = "Invalid or expired OTP. Please try again.";
                return;
            }

            string recipientVal = ddlRecipient.SelectedValue;
            if (string.IsNullOrEmpty(recipientVal))
            {
                lblStatus.Text = "No recipient selected.";
                return;
            }

            string[] parts        = recipientVal.Split('|');
            int      receiverCid  = Convert.ToInt32(parts[0]);
            string   receiverAcc  = parts[1];
            string   receiverName = parts.Length > 2 ? parts[2] : "Recipient";

            decimal amount;
            if (!decimal.TryParse(txtAmount.Text.Trim(), out amount) || amount <= 0)
            {
                lblStatus.Text = "Invalid amount.";
                return;
            }

            int senderCid = Convert.ToInt32(Session["cid"]);

            try
            {
                using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["LIS"]))
                {
                    con.Open();

                    // ── Re-read sender balance (avoid stale value) ──
                    decimal senderBalance;
                    using (SqlCommand cmdBal = new SqlCommand(
                        "SELECT balance FROM Registration WHERE cid=@cid", con))
                    {
                        cmdBal.Parameters.Add("@cid", SqlDbType.Int).Value = senderCid;
                        object raw = cmdBal.ExecuteScalar();
                        if (raw == null || !decimal.TryParse(raw.ToString(), out senderBalance))
                        {
                            lblStatus.Text = "Could not read your balance. Please refresh.";
                            return;
                        }
                    }

                    if (amount > senderBalance)
                    {
                        lblStatus.ForeColor = System.Drawing.Color.OrangeRed;
                        lblStatus.Text = "Insufficient funds. Current balance: ₹" + senderBalance;
                        return;
                    }

                    decimal newSenderBalance = senderBalance - amount;

                    // ── Read receiver current balance ──
                    decimal receiverBalance;
                    using (SqlCommand cmdRBal = new SqlCommand(
                        "SELECT balance FROM Registration WHERE cid=@cid", con))
                    {
                        cmdRBal.Parameters.Add("@cid", SqlDbType.Int).Value = receiverCid;
                        object raw = cmdRBal.ExecuteScalar();
                        receiverBalance = raw != null ? Convert.ToDecimal(raw) : 0;
                    }
                    decimal newReceiverBalance = receiverBalance + amount;

                    string txnDate = DateTime.Now.ToString("dd-MM-yyyy hh:mm tt");
                    string txnId   = DateTime.Now.ToString("yyyyMMddHHmmss");

                    // ── 1. Deduct sender ──
                    using (SqlCommand cmd = new SqlCommand(
                        "UPDATE Registration SET balance=@bal WHERE cid=@cid", con))
                    {
                        cmd.Parameters.Add("@bal", SqlDbType.Decimal).Value = newSenderBalance;
                        cmd.Parameters.Add("@cid", SqlDbType.Int).Value     = senderCid;
                        cmd.ExecuteNonQuery();
                    }

                    // ── 2. Credit receiver ──
                    using (SqlCommand cmd = new SqlCommand(
                        "UPDATE Registration SET balance=@bal WHERE cid=@cid", con))
                    {
                        cmd.Parameters.Add("@bal", SqlDbType.Decimal).Value = newReceiverBalance;
                        cmd.Parameters.Add("@cid", SqlDbType.Int).Value     = receiverCid;
                        cmd.ExecuteNonQuery();
                    }

                    // ── 3. Sender BankStatement (withdrawal) ──
                    using (SqlCommand cmd = new SqlCommand(
                        @"INSERT INTO BankStatement (cid, trans_date, deposit, withdraw, balance, accountno)
                          VALUES (@cid, @date, @dep, @wd, @bal, @acc)", con))
                    {
                        cmd.Parameters.Add("@cid",  SqlDbType.Int).Value      = senderCid;
                        cmd.Parameters.Add("@date", SqlDbType.NVarChar).Value = txnDate;
                        cmd.Parameters.Add("@dep",  SqlDbType.NVarChar).Value = "0";
                        cmd.Parameters.Add("@wd",   SqlDbType.NVarChar).Value = amount.ToString();
                        cmd.Parameters.Add("@bal",  SqlDbType.Decimal).Value  = newSenderBalance;
                        cmd.Parameters.Add("@acc",  SqlDbType.NVarChar).Value = hfAccountNo.Value;
                        cmd.ExecuteNonQuery();
                    }

                    // ── 4. Receiver BankStatement (deposit) ──
                    using (SqlCommand cmd = new SqlCommand(
                        @"INSERT INTO BankStatement (cid, trans_date, deposit, withdraw, balance, accountno)
                          VALUES (@cid, @date, @dep, @wd, @bal, @acc)", con))
                    {
                        cmd.Parameters.Add("@cid",  SqlDbType.Int).Value      = receiverCid;
                        cmd.Parameters.Add("@date", SqlDbType.NVarChar).Value = txnDate;
                        cmd.Parameters.Add("@dep",  SqlDbType.NVarChar).Value = amount.ToString();
                        cmd.Parameters.Add("@wd",   SqlDbType.NVarChar).Value = "0";
                        cmd.Parameters.Add("@bal",  SqlDbType.Decimal).Value  = newReceiverBalance;
                        cmd.Parameters.Add("@acc",  SqlDbType.NVarChar).Value = receiverAcc;
                        cmd.ExecuteNonQuery();
                    }

                    // ── 5. transaction_history ──
                    // Note: transaction_id has no IDENTITY — using timestamp-based int
                    using (SqlCommand cmd = new SqlCommand(
                        @"INSERT INTO transaction_history
                          (transaction_id, sender_acc, sender_name, receiver_acc, receiver_name, amount, datetime, status)
                          VALUES (@tid, @sacc, @sname, @racc, @rname, @amount, @dt, @status)", con))
                    {
                        cmd.Parameters.Add("@tid",    SqlDbType.Int).Value      = Convert.ToInt32(txnId.Substring(txnId.Length - 8));
                        cmd.Parameters.Add("@sacc",   SqlDbType.VarChar).Value  = hfAccountNo.Value;
                        cmd.Parameters.Add("@sname",  SqlDbType.NVarChar).Value = hfSenderName.Value;
                        cmd.Parameters.Add("@racc",   SqlDbType.VarChar).Value  = receiverAcc;
                        cmd.Parameters.Add("@rname",  SqlDbType.NVarChar).Value = receiverName;
                        cmd.Parameters.Add("@amount", SqlDbType.Decimal).Value  = amount;
                        cmd.Parameters.Add("@dt",     SqlDbType.NVarChar).Value = txnDate;
                        cmd.Parameters.Add("@status", SqlDbType.NVarChar).Value = "Success";
                        cmd.ExecuteNonQuery();
                    }

                    // ── Clean up session ──
                    Session.Remove("transfer_otp");

                    // ── Trigger animation from JS ──
                    string js = $"triggerAnimation('{EscJs(hfSenderName.Value)}', '{EscJs(receiverName)}', '{amount}', '{txnId.Substring(txnId.Length - 8)}');";
                    ScriptManager.RegisterStartupScript(this, GetType(), "txnAnim", js, true);

                    // Update balance display
                    litBalance.Text    = newSenderBalance.ToString();
                    txtOTP.Text        = "";
                    txtOTP.Visible     = false;
                    lblOtpMsg.Visible  = false;
                    btnConfirm.Visible = false;
                    txtAmount.Text     = "";
                    lblStatus.Text     = "";
                }
            }
            catch (Exception ex)
            {
                lblStatus.ForeColor = System.Drawing.Color.OrangeRed;
                lblStatus.Text = "Transaction failed: " + ex.Message;
            }
        }

        // ─────────────────────────────────────────
        //  Helpers
        // ─────────────────────────────────────────
        private string SendOTPEmail(string toEmail, string subject, string otp,
                                    string amount, string recipientName)
        {
            try
            {
                using (SmtpClient client = new SmtpClient())
                {
                    MailMessage mail = new MailMessage();
                    mail.To.Add(toEmail);
                    mail.Subject = subject;
                    mail.Body = $"Your OTP for transferring ₹{amount} to {recipientName} is: {otp}\n\nDo not share this OTP with anyone.\n\nIf you did not initiate this, please contact us immediately.";
                    mail.IsBodyHtml = false;
                    client.Send(mail);
                }
                return "Success";
            }
            catch (Exception ex) { return ex.Message; }
        }

        private void ShowAlert(string icon, string title, string text)
        {
            string safe = text.Replace("'", "\\'").Replace("\n", " ");
            ScriptManager.RegisterStartupScript(this, GetType(), "swal",
                $"Swal.fire({{icon:'{icon}',title:'{title}',text:'{safe}',background:'#0f1e2e',color:'#fff',confirmButtonColor:'#00b09b'}});", true);
        }

        private string EscJs(string s) => (s ?? "").Replace("'", "\\'").Replace("\"", "\\\"");
    }
}
