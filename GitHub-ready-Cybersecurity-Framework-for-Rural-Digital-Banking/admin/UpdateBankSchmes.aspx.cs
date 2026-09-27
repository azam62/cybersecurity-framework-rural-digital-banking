using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

namespace Cybersecurity_Framework_for_Rural_Digital_Banking.admin
{
    public partial class UpdateBankSchmes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    int schemeId = Convert.ToInt32(Request.QueryString["id"]);

                    GetSchemeDetails(Convert.ToInt32(schemeId));
                }
            }
        }
        protected void GetSchemeDetails(int schemeid)
        {
            // Fetch the connection string from Web.config
            string connString = ConfigurationManager.ConnectionStrings["PMSConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("SELECT * FROM LoanData WHERE id=@id", con);
                cmd.Parameters.AddWithValue("@id", schemeid);

                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    // Populate fields with data from the database
                    txtSchemeName.Text = reader["schemename"].ToString();
                    txtSchemeType.Text = reader["schemetype"].ToString();
                    txtDescription.Text = reader["schemedetail"].ToString();
                    txtrate.Text = reader["rate"].ToString();
                    txttenure.Text = reader["tenure"].ToString();
                    txtamount.Text = reader["amount"].ToString();
                    hiddenPhoto.Value = "Photos/" + reader["photo"].ToString();

                    // Load the image preview
                    imgPreview.ImageUrl = "/admin/" + hiddenPhoto.Value;
                }
            }
        }
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            Update();
        }

        protected void Update()
        {


            if (fileUploadPhoto.HasFile)
            {
                string ppath = Server.MapPath("/admin/") + "/Photos/" + fileUploadPhoto.FileName;
                fileUploadPhoto.SaveAs(ppath);
            }
            // Connection string for database
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["PMSConnectionString"].ConnectionString;

            try
            {
                if (fileUploadPhoto.HasFile)
                {
                    // Open the connection to the database
                    using (SqlConnection con = new SqlConnection(connectionString))
                    {

                        // SQL command for updating the LoanData table
                        SqlCommand cmd = new SqlCommand();
                        cmd.CommandText = "UPDATE LoanData SET schemename=@schemename, schemetype=@schemetype, schemedetail=@schemedetail, rate=@rate, tenure=@tenure, amount=@amount, photo=@photo WHERE id=@id";

                        // Add parameters to the command
                        cmd.Parameters.AddWithValue("@schemename", txtSchemeName.Text);
                        cmd.Parameters.AddWithValue("@schemetype", txtSchemeType.Text);
                        cmd.Parameters.AddWithValue("@schemedetail", txtDescription.Text);
                        cmd.Parameters.AddWithValue("@rate", txtrate.Text);
                        cmd.Parameters.AddWithValue("@tenure", txttenure.Text);
                        cmd.Parameters.AddWithValue("@amount", txtamount.Text);
                        cmd.Parameters.AddWithValue("@photo", fileUploadPhoto.FileName); // Assuming the image URL is saved directly to the database
                        cmd.Parameters.AddWithValue("@id", Request.QueryString["id"]); // Get the id from the query string

                        cmd.Connection = con;

                        // Open the connection
                        con.Open();

                        // Execute the update query
                        int rowsAffected = cmd.ExecuteNonQuery();

                        // Check if any rows were affected
                        if (rowsAffected > 0)
                        {
                            // If the photo URL was changed, update the image on the page



                            // Show success message
                            ScriptManager.RegisterStartupScript(this, GetType(), "showSuccessPopup", "showSuccessPopup();", true);
                        }

                    }
                }
                else
                {
                    using (SqlConnection con = new SqlConnection(connectionString))
                    {

                        // SQL command for updating the LoanData table
                        SqlCommand cmd = new SqlCommand();
                        cmd.CommandText = "UPDATE LoanData SET schemename=@schemename, schemetype=@schemetype, schemedetail=@schemedetail, rate=@rate, tenure=@tenure, amount=@amount WHERE id=@id";

                        // Add parameters to the command
                        cmd.Parameters.AddWithValue("@schemename", txtSchemeName.Text);
                        cmd.Parameters.AddWithValue("@schemetype", txtSchemeType.Text);
                        cmd.Parameters.AddWithValue("@schemedetail", txtDescription.Text);
                        cmd.Parameters.AddWithValue("@rate", txtrate.Text);
                        cmd.Parameters.AddWithValue("@tenure", txttenure.Text);
                        cmd.Parameters.AddWithValue("@amount", txtamount.Text);
                        cmd.Parameters.AddWithValue("@id", Request.QueryString["id"]); // Get the id from the query string

                        cmd.Connection = con;

                        // Open the connection
                        con.Open();

                        // Execute the update query
                        int rowsAffected = cmd.ExecuteNonQuery();

                        // Check if any rows were affected
                        if (rowsAffected > 0)
                        {
                            // If the photo URL was changed, update the image on the page



                            // Show success message
                            ClientScript.RegisterStartupScript(this.GetType(), "success", "<script>Swal.fire('Success!', 'Loan scheme Data updated successfully.', 'success');</script>");
                        }

                    }
                }
            }
            catch (SqlException ex)
            {
                // Handle SQL exception (e.g., database connection issues, query issues)
                ClientScript.RegisterStartupScript(this.GetType(), "sweetAlert", "<script>Swal.fire('Error', 'Database error: " + ex.Message + "', 'error');</script>");
            }
        }


    }
}