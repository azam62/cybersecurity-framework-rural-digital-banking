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
    public partial class edit_profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            hfCustomerID.Value = Session["cid"].ToString();
            if (!IsPostBack)
            {
                SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["LIS"]); SqlCommand cmd = new SqlCommand(); con.Open();

                cmd.CommandText = "select * from registration where cid=@cid";
                cmd.Parameters.Add("@cid", SqlDbType.Int).Value = Convert.ToInt32(hfCustomerID.Value);
                cmd.Connection = con; cmd.ExecuteNonQuery();

                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    txtFirstName.Text = reader.GetString(1); 
                    txtMiddleName.Text = reader.GetString(2);
                    txtLastName.Text = reader.GetString(3);
                    txtMobile.Text = reader.GetString(4); 
                    txtEmail.Text = reader.GetString(5); 
                    txtDOB.Text = reader.GetString(6);

                    if (reader.GetString(7) == "Male")
                    {
                        rbtnMale.Checked = true;
                    }
                    else if (reader.GetString(7) == "Female")
                    {
                        rbtnFemale.Checked = true;
                    }
                    else
                    {
                        rbtnNA.Checked = true;
                    }
                    txtAddress.Text = reader.GetString(8); 
                    txtCity.Text = reader.GetString(9);
                    txtState.Text = reader.GetString(10);
                    hplkAadhar.NavigateUrl = "~/user/Aadhar/" + reader.GetString(13);
                    hplkPAN.NavigateUrl = "~/user/PAN/" + reader.GetString(14);
                    hplkSign.NavigateUrl = "~/user/Signature/" + reader.GetString(15); 
                    imgPhoto.ImageUrl = "~/user/Photos/" + reader.GetString(16);

                }
                con.Close();
            }
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            string gender = "";
            if (rbtnMale.Checked) gender = "Male";
            else if (rbtnFemale.Checked) gender = "Female";
            else gender = "NA";
            SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["LIS"]);
            SqlCommand cmd = new SqlCommand();
            con.Open();

            BasicCode b = new BasicCode();

            //string date = String.Format("{0}", Request.Form["DOB"]);
            cmd.CommandText = "UPDATE Registration SET firstname=@firstname, middlename=@middlename, lastname=@lastname, mobile=@mobile, email=@email, dob=@dob, gender=@gender, address=@address, city=@city, state=@state WHERE cid=@cid";
            cmd.Parameters.Add("@cid", SqlDbType.Int).Value = Convert.ToInt32(hfCustomerID.Value);
            cmd.Parameters.Add("@firstname", SqlDbType.VarChar).Value = txtFirstName.Text.Trim();
            cmd.Parameters.Add("@middlename", SqlDbType.VarChar).Value = txtMiddleName.Text.Trim(); 
            cmd.Parameters.Add("@lastname", SqlDbType.VarChar).Value = txtLastName.Text.Trim();
            cmd.Parameters.Add("@mobile", SqlDbType.VarChar).Value = txtMobile.Text.Trim();
            cmd.Parameters.Add("@email", SqlDbType.VarChar).Value = txtEmail.Text.Trim();
            cmd.Parameters.Add("@dob",  SqlDbType.Date).Value = txtDOB.Text.Trim();
            cmd.Parameters.Add("@gender", SqlDbType.VarChar).Value = gender;
            cmd.Parameters.Add("@address", SqlDbType.VarChar).Value = txtAddress.Text.Trim();
            cmd.Parameters.Add("@city", SqlDbType.VarChar).Value = txtCity.Text.Trim();
            cmd.Parameters.Add("@state", SqlDbType.VarChar).Value = txtState.Text.Trim();


            cmd.Connection = con;
            int x = cmd.ExecuteNonQuery();
            if (x > 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Data Inserted Successfully')", true);
            }
            else
            {
                lblSubmit.Text = "Data Save Unsuccessful";
            }
            con.Close();
        }
        protected void btnUploadAadhar_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["LIS"]); SqlCommand cmd = new SqlCommand(); con.Open();
            cmd.CommandText = "UPDATE Registration SET aadhar=@aadhar WHERE cid=@cid";
            cmd.Parameters.Add("@cid", hfCustomerID.Value);

            //Aadhar save code
            string str1 = fuAadhar.FileName;
            int pos1 = str1.LastIndexOf(".");
            string ext1 = str1.Substring(pos1 + 1);    // Extension
            string fname1 = "aadhar_" + hfCustomerID.Value + "." + ext1; string upath1 = Server.MapPath("Aadhar"); String ppath1 = upath1 + "/" + fname1;
            fuAadhar.SaveAs(ppath1);
            cmd.Parameters.Add("@aadhar", fname1);

            cmd.Connection = con;
            int x = cmd.ExecuteNonQuery();
            if (x > 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Aadhar Updated Successfully')", true);
                hplkAadhar.NavigateUrl = "../user/Aadhar/" + fname1;
            }
            else
            {
                lblSubmit.Text = "Aadhar Save Unsuccessful";
            }
            con.Close();
        }
        protected void btnUploadPan_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["LIS"]); SqlCommand cmd = new SqlCommand(); con.Open();
            cmd.CommandText = "UPDATE Registration SET pan=@pan WHERE cid=@cid";
            cmd.Parameters.Add("@cid", hfCustomerID.Value);

            //PAN save code
            string str2 = fuPAN.FileName;
            int pos2 = str2.LastIndexOf(".");
            string ext2 = str2.Substring(pos2 + 1);    // Extension
            string fname2 = "pan_" + hfCustomerID.Value + "." + ext2; string upath2 = Server.MapPath("PAN"); String ppath2 = upath2 + "/" + fname2; fuPAN.SaveAs(ppath2);
            cmd.Parameters.Add("@pan", fname2);

            cmd.Connection = con;
            int x = cmd.ExecuteNonQuery();
            if (x > 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('PAN Updated Successfully')", true);
                hplkPAN.NavigateUrl = "../user/PAN/" + fname2;
            }
            else
            {
                lblSubmit.Text = "PAN Save Unsuccessful";
            }
            con.Close();
        }
        protected void btnUploadSign_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["LIS"]); SqlCommand cmd = new SqlCommand(); con.Open();
            cmd.CommandText = "UPDATE Registration SET signature=@signature WHERE cid=@cid";
            cmd.Parameters.Add("@cid", hfCustomerID.Value);

            //Signature save code
            string str3 = fuSign.FileName;
            int pos3 = str3.LastIndexOf(".");
            string ext3 = str3.Substring(pos3 + 1);    // Extension
            string fname3 = "sign_" + hfCustomerID.Value + "." + ext3; string upath3 = Server.MapPath("Signature"); String ppath3 = upath3 + "/" + fname3; fuSign.SaveAs(ppath3);
            cmd.Parameters.Add("@signature", fname3);

            cmd.Connection = con;
            int x = cmd.ExecuteNonQuery();
            if (x > 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Sign Updated Successfully')", true);
                hplkAadhar.NavigateUrl = "../user/Signature/" + fname3;
            }
            else
            {
                lblSubmit.Text = "Sign Save Unsuccessful";
            }
            con.Close();
        }
        protected void btnUploadPhoto_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["LIS"]); SqlCommand cmd = new SqlCommand(); con.Open();
            cmd.CommandText = "UPDATE Registration SET photo=@photo WHERE cid=@cid";
            cmd.Parameters.Add("@cid", hfCustomerID.Value);

            //Photo save code
            string str = fuPhoto.FileName;
            int pos = str.LastIndexOf(".");
            string ext = str.Substring(pos + 1);    // Extension
            string fname = "photo_" + hfCustomerID.Value + "." + ext; string upath = Server.MapPath("Photos"); String ppath = upath + "/" + fname; fuPhoto.SaveAs(ppath);
            cmd.Parameters.Add("@photo", fname);

            cmd.Connection = con;
            int x = cmd.ExecuteNonQuery();
            if (x > 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Photo Updated Successfully')", true);
                imgPhoto.ImageUrl = "../user/Photos/" + fname;
            }
            else
            {
                lblSubmit.Text = "Photo Save Unsuccessful";
            }
            con.Close();
        }



    }
}