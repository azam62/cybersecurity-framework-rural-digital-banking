using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
namespace Cybersecurity_Framework_for_Rural_Digital_Banking.user
{
    public partial class add_customer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            BasicCode b = new BasicCode();
            string cid = b.generateID("cid", "Registration");

            string gender = "";
            if (rbtnMale.Checked) gender = "Male";
            else if (rbtnFemale.Checked) gender = "Female";
            else gender = "NA";

            DateTime dob;
            if (!DateTime.TryParse(Request.Form["DOB"], out dob))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                    "alert('Invalid Date of Birth');", true);
                return;
            }

            using (SqlConnection con = new SqlConnection(
                ConfigurationManager.ConnectionStrings["LIS"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(@"
        INSERT INTO Registration
        (cid, firstname, middlename, lastname, mobile, email, dob, gender,
         address, city, state, username, password,
         aadhar, pan, signature, photo, status, balance)
        VALUES
        (@cid, @firstname, @middlename, @lastname, @mobile, @email, @dob, @gender,
         @address, @city, @state, @username, @password,
         @aadhar, @pan, @signature, @photo, @status, @balance)", con))
                {
                    cmd.Parameters.Add("@cid", SqlDbType.Int).Value = Convert.ToInt32(cid);
                    cmd.Parameters.Add("@firstname", SqlDbType.VarChar).Value = txtFirstName.Text.Trim();
                    cmd.Parameters.Add("@middlename", SqlDbType.VarChar).Value = txtMiddleName.Text.Trim();
                    cmd.Parameters.Add("@lastname", SqlDbType.VarChar).Value = txtLastName.Text.Trim();
                    cmd.Parameters.Add("@mobile", SqlDbType.VarChar).Value = txtMobile.Text.Trim();
                    cmd.Parameters.Add("@email", SqlDbType.VarChar).Value = txtEmail.Text.Trim();
                    cmd.Parameters.Add("@dob", SqlDbType.Date).Value = dob;
                    cmd.Parameters.Add("@gender", SqlDbType.VarChar).Value = gender;
                    cmd.Parameters.Add("@address", SqlDbType.VarChar).Value = txtAddress.Text.Trim();
                    cmd.Parameters.Add("@city", SqlDbType.VarChar).Value = txtCity.Text.Trim();
                    cmd.Parameters.Add("@state", SqlDbType.VarChar).Value = txtState.Text.Trim();
                    cmd.Parameters.Add("@username", SqlDbType.VarChar).Value = txtUsername.Text.Trim();
                    cmd.Parameters.Add("@password", SqlDbType.VarChar).Value = txtPassword.Text.Trim();

                    // -------- FILE UPLOADS --------

                    string folderAadhar = Server.MapPath("~/user/Aadhar/");
                    string folderPAN = Server.MapPath("~/user/PAN/");
                    string folderSign = Server.MapPath("~/user/Signature/");
                    string folderPhoto = Server.MapPath("~/user/Photos/");

                    string aadharFile = cid + "_Aadhar.jpg";
                    string panFile = cid + "_PAN.jpg";
                    string signFile = cid + "_Sign.jpg";
                    string photoFile = cid + "_Photo.jpg";

                    if (fuAadhar.HasFile)
                        fuAadhar.SaveAs(folderAadhar + aadharFile);

                    if (fuPAN.HasFile)
                        fuPAN.SaveAs(folderPAN + panFile);

                    if (fuSign.HasFile)
                        fuSign.SaveAs(folderSign + signFile);

                    if (fuPhoto.HasFile)
                        fuPhoto.SaveAs(folderPhoto + photoFile);

                    cmd.Parameters.Add("@aadhar", SqlDbType.VarChar).Value = aadharFile;
                    cmd.Parameters.Add("@pan", SqlDbType.VarChar).Value = panFile;
                    cmd.Parameters.Add("@signature", SqlDbType.VarChar).Value = signFile;
                    cmd.Parameters.Add("@photo", SqlDbType.VarChar).Value = photoFile;

                    cmd.Parameters.Add("@status", SqlDbType.VarChar).Value = "No";
                    cmd.Parameters.Add("@balance", SqlDbType.Decimal).Value = 0;

                    con.Open();
                    int x = cmd.ExecuteNonQuery();

                    if (x > 0)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                            "Swal.fire('Success','Data Inserted Successfully','success');", true);
                    }
                    else
                    {
                        lblSubmit.Text = "Data Save Unsuccessful";
                    }
                }
            }
        }


    }
}