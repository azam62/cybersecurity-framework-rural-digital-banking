using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Net;
using System.Net.Mail;
using Cybersecurity_Framework_for_Rural_Digital_Banking;
using System.Data;

namespace Cybersecurity_Framework_for_Rural_Digital_Banking.admin
{
    public partial class show_details : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["cid"] == null)
            {
                Response.Redirect("CustomerList.aspx");
                return;
            }

            hfCustomerID.Value = Request.QueryString["cid"].ToString();

            if (!IsPostBack)
            {
                LoadCustomerDetails();
            }
        }

        private void LoadCustomerDetails()
        {
            using (SqlConnection con = new SqlConnection(
                ConfigurationManager.ConnectionStrings["LIS"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(
                    "SELECT * FROM Registration WHERE cid=@cid", con))
                {
                    cmd.Parameters.Add("@cid", SqlDbType.Int)
                        .Value = Convert.ToInt32(hfCustomerID.Value);

                    con.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            txtFirstName.Text = reader["firstname"].ToString();
                            txtMiddleName.Text = reader["middlename"].ToString();
                            txtLastName.Text = reader["lastname"].ToString();
                            txtMobile.Text = reader["mobile"].ToString();
                            txtEmail.Text = reader["email"].ToString();
                            txtDOB.Text = reader["dob"].ToString();

                            string gender = reader["gender"].ToString();
                            if (gender == "Male") rbtnMale.Checked = true;
                            else if (gender == "Female") rbtnFemale.Checked = true;
                            else rbtnNA.Checked = true;

                            txtAddress.Text = reader["address"].ToString();
                            txtCity.Text = reader["city"].ToString();
                            txtState.Text = reader["state"].ToString();
                            txtUsername.Text = reader["username"].ToString();
                            txtPassword.Text = reader["password"].ToString();

                            hplkAadhar.NavigateUrl = "../user/Aadhar/" + reader["aadhar"].ToString();
                            hplkPAN.NavigateUrl = "../user/PAN/" + reader["pan"].ToString();
                            hplkSignature.NavigateUrl = "../user/Signature/" + reader["signature"].ToString();
                            imgPhoto.ImageUrl = "../user/Photos/" + reader["photo"].ToString();

                            txtstatus.Text = reader["status"].ToString();
                            txtAccountNo.Text = reader["accountno"].ToString();
                        }
                    }
                }
            }
        }

        protected void btnApprove_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(
                ConfigurationManager.ConnectionStrings["LIS"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(
                    "UPDATE Registration SET status=@status WHERE cid=@cid", con))
                {
                    cmd.Parameters.Add("@status", SqlDbType.VarChar).Value = "Yes";
                    cmd.Parameters.Add("@cid", SqlDbType.Int)
                        .Value = Convert.ToInt32(hfCustomerID.Value);

                    con.Open();
                    int x = cmd.ExecuteNonQuery();

                    if (x > 0)
                    {
                        SendMailApprove();

                        ScriptManager.RegisterStartupScript(this, GetType(), "alertMessage",
                            "Swal.fire('Success','Customer approved successfully!','success');", true);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "alertMessage",
                            "alert('Problem occurred while approving');", true);
                    }
                }
            }
        }

        protected void btnNotApprove_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(
                ConfigurationManager.ConnectionStrings["LIS"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(
                    "DELETE FROM Registration WHERE cid=@cid", con))
                {
                    cmd.Parameters.Add("@cid", SqlDbType.Int)
                        .Value = Convert.ToInt32(hfCustomerID.Value);

                    con.Open();
                    int x = cmd.ExecuteNonQuery();

                    if (x > 0)
                    {
                        SendMailNonApprove();

                        ScriptManager.RegisterStartupScript(this, GetType(), "alertMessage",
                            "Swal.fire('Rejected','Customer rejected and email sent','error');", true);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "alertMessage",
                            "alert('Problem occurred while deleting');", true);
                    }
                }
            }
        }

        public void SendMailApprove()
        {
            string userEmail = txtEmail.Text.Trim();
            string fullName = txtFirstName.Text.Trim() + " " + txtLastName.Text.Trim();
            string subject = "Account Approval Confirmation";

            string message = string.Format(@"
<html>
<body style='font-family: Arial; line-height:1.6;'>
<h2 style='color:green;'>Dear {0},</h2>
<p>Your account has been <strong>approved</strong>.</p>
<p>You can now login and access your account.</p>
<p>Thank you,<br><strong>Bank Team</strong></p>
</body>
</html>", fullName);

            BasicCode b = new BasicCode();
            b.SendOTPEmail(userEmail, subject, message);
        }

        public void SendMailNonApprove()
        {
            string email = txtEmail.Text.Trim();
            string fullName = txtFirstName.Text.Trim() + " " + txtLastName.Text.Trim();
            string reason = txtreason.Text.Trim();
            string subject = "Application Rejection";

            string msg = string.Format(@"
<html>
<body style='font-family: Arial; line-height:1.6;'>
<h2 style='color:red;'>Dear {0},</h2>
<p>We regret to inform you that your application has not been approved.</p>
<p><strong>Reason:</strong> {1}</p>
<p>If you have any questions, please contact us.</p>
<p>Thank you,<br><strong>Bank Team</strong></p>
</body>
</html>", fullName, reason);

            BasicCode b = new BasicCode();
            b.SendOTPEmail(email, subject, msg);
        }
    }
}