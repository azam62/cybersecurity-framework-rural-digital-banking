using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Net.Mail;
using System.Data;

namespace Cybersecurity_Framework_for_Rural_Digital_Banking.user
{
    public partial class deposit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["cid"] == null)
            {
                Response.Redirect("~/login.aspx");
                return;
            }

            hfCustomerID.Value = Session["cid"].ToString();

            if (!IsPostBack)
            {
                try
                {
                    using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["LIS"]))
                    {
                        con.Open();
                        SqlCommand cmd = new SqlCommand(
                            "SELECT balance, accountno, email FROM Registration WHERE cid=@cid", con);
                        cmd.Parameters.Add("@cid", SqlDbType.Int).Value =
                            Convert.ToInt32(hfCustomerID.Value);

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                txtCurrentBal.Text = reader.GetDecimal(0).ToString();
                                hfAccountNo.Value = reader.IsDBNull(1) ? "" : reader.GetString(1);
                                hfEmail.Value = reader.IsDBNull(2) ? "" : reader.GetString(2);
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    lblBalance.Text = "Error loading account: " + ex.Message;
                }
            }
        }

        protected void btnDeposit_Click(object sender, EventArgs e)
        {
            decimal deposit;
            if (!decimal.TryParse(txtDeposit.Text.Trim(), out deposit) || deposit <= 0)
            {
                lblBalance.Text = "Please enter a valid deposit amount.";
                return;
            }

            Random r = new Random();
            int otp = r.Next(100000, 999999);

            // Store in Session — never in HiddenField
            Session["deposit_otp"] = otp.ToString();

            lblOTP.Visible = true;
            txtOTP.Visible = true;
            btnSubmit.Visible = true;

            string result = SendOTPEmail(hfEmail.Value, "OTP for Deposit", otp.ToString());

            lblBalance.Text = result == "Success"
                ? "OTP sent to your registered email. Enter it below to confirm."
                : "Could not send OTP. Error: " + result;
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string sessionOtp = Session["deposit_otp"] as string;

            if (string.IsNullOrEmpty(sessionOtp) || txtOTP.Text.Trim() != sessionOtp)
            {
                lblBalance.Text = "Invalid or expired OTP. Please try again.";
                return;
            }

            decimal balance;
            decimal deposit;

            if (!decimal.TryParse(txtCurrentBal.Text.Replace("₹", "").Trim(), out balance))
            {
                lblBalance.Text = "Invalid balance. Please refresh and try again.";
                return;
            }

            if (!decimal.TryParse(txtDeposit.Text.Trim(), out deposit) || deposit <= 0)
            {
                lblBalance.Text = "Please enter a valid deposit amount.";
                return;
            }

            decimal finalBalance = balance + deposit;

            try
            {
                using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["LIS"]))
                {
                    con.Open();

                    // Update Registration balance
                    SqlCommand cmdUpdate = new SqlCommand(
                        "UPDATE Registration SET balance=@balance WHERE cid=@cid", con);
                    cmdUpdate.Parameters.Add("@balance", SqlDbType.Decimal).Value = finalBalance;
                    cmdUpdate.Parameters.Add("@cid", SqlDbType.Int).Value =
                        Convert.ToInt32(hfCustomerID.Value);

                    int rows = cmdUpdate.ExecuteNonQuery();

                    if (rows > 0)
                    {
                        // Insert into BankStatement
                        // Note: trans_date, deposit, withdraw are all nvarchar in your schema
                        SqlCommand cmdStmt = new SqlCommand(
                            @"INSERT INTO BankStatement (cid, trans_date, deposit, withdraw, balance, accountno)
                              VALUES (@cid, @trans_date, @deposit, @withdraw, @balance, @accountno)", con);

                        cmdStmt.Parameters.Add("@cid", SqlDbType.Int).Value =
                            Convert.ToInt32(hfCustomerID.Value);
                        cmdStmt.Parameters.Add("@trans_date", SqlDbType.NVarChar).Value =
                            DateTime.Now.ToString("dd-MM-yyyy hh:mm tt");
                        cmdStmt.Parameters.Add("@deposit", SqlDbType.NVarChar).Value =
                            deposit.ToString();
                        cmdStmt.Parameters.Add("@withdraw", SqlDbType.NVarChar).Value = "0";
                        cmdStmt.Parameters.Add("@balance", SqlDbType.Decimal).Value = finalBalance;
                        cmdStmt.Parameters.Add("@accountno", SqlDbType.NVarChar).Value = hfAccountNo.Value;

                        cmdStmt.ExecuteNonQuery();

                        // Clear OTP and update UI
                        Session.Remove("deposit_otp");
                        txtCurrentBal.Text = finalBalance.ToString();
                        lblOTP.Visible = false;
                        txtOTP.Visible = false;
                        btnSubmit.Visible = false;
                        txtOTP.Text = "";
                        txtDeposit.Text = "";

                        lblBalance.ForeColor = System.Drawing.Color.LightGreen;
                        lblBalance.Text = "Deposited ₹" + deposit + " successfully. New balance: ₹" + finalBalance;
                    }
                    else
                    {
                        lblBalance.Text = "Update failed. Please try again.";
                    }
                }
            }
            catch (Exception ex)
            {
                lblBalance.Text = "Error: " + ex.Message;
            }
        }

        private string SendOTPEmail(string toEmail, string subject, string otp)
        {
            try
            {
                using (SmtpClient client = new SmtpClient())
                {
                    MailMessage mail = new MailMessage();
                    mail.To.Add(toEmail);
                    mail.Subject = subject;
                    mail.Body = "Your OTP for deposit is: " + otp +
                                      "\n\nDo not share this OTP with anyone.";
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