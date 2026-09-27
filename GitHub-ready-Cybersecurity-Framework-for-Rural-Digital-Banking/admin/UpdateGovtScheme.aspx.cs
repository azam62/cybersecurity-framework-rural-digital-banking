using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Configuration;
using System.IO;

namespace Cybersecurity_Framework_for_Rural_Digital_Banking.admin
{
    public partial class UpdateGovtScheme : System.Web.UI.Page
    {
        private object txtSchemeId;
        private object e;

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
        private void GetSchemeDetails(int schemeId)
        {
            string connString = ConfigurationManager.ConnectionStrings["PMSConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("SELECT * FROM SchemesData WHERE s_id=@id", con);
                cmd.Parameters.AddWithValue("@id", schemeId);

                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    // Populate fields
                    txtSchemeName.Text = reader["schemename"].ToString();
                    txtSchemeType.Text = reader["schemetype"].ToString();
                    txtDescription.Text = reader["description"].ToString();
                    txtBenefitAmount.Text = reader["benefitamt"].ToString();

                    txtStartDate.Text = Convert.ToDateTime(reader["appstartdate"]).ToString("yyyy-MM-dd");
                    txtEndDate.Text = Convert.ToDateTime(reader["appenddate"]).ToString("yyyy-MM-dd");

                    // Handle photo preview
                    hiddenPhoto.Value = "Photos/" + reader["photo"].ToString();
                    imgPreview.ImageUrl = "/admin/" + hiddenPhoto.Value;
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                if (fileUploadPhoto.HasFile)
                {
                    string ppath = Server.MapPath("/admin/") + "/Photos/" + fileUploadPhoto.FileName;
                    fileUploadPhoto.SaveAs(ppath);
                }
                string schemeId = Request.QueryString["id"];
                if (!string.IsNullOrEmpty(schemeId))
                {
                    string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["PMSConnectionString"].ConnectionString;
                    using (SqlConnection con = new SqlConnection(connectionString))
                    {
                        if (fileUploadPhoto.HasFile)
                        {
                            string query = "UPDATE SchemesData SET schemename = @schemename, schemetype = @schemetype, description = @description, benefitamt = @benefitamt, appstartdate = @appstartdate, appenddate = @appenddate, photo=@photo   WHERE s_id = @id";


                            SqlCommand cmd = new SqlCommand(query, con);
                            cmd.Parameters.AddWithValue("@schemename", txtSchemeName.Text);
                            cmd.Parameters.AddWithValue("@schemetype", txtSchemeType.Text);
                            cmd.Parameters.AddWithValue("@description", txtDescription.Text);
                            cmd.Parameters.AddWithValue("@benefitamt", txtBenefitAmount.Text);
                            cmd.Parameters.AddWithValue("@appstartdate", Convert.ToDateTime(txtStartDate.Text));
                            cmd.Parameters.AddWithValue("@appenddate", Convert.ToDateTime(txtEndDate.Text));
                            cmd.Parameters.AddWithValue("@photo", fileUploadPhoto.FileName);
                            cmd.Parameters.AddWithValue("@id", Convert.ToInt32(schemeId));

                            con.Open();
                            int rowsAffected = cmd.ExecuteNonQuery();
                            if (rowsAffected > 0)
                            {
                                // Update the current image on the page if a new photo was uploaded


                                ClientScript.RegisterStartupScript(this.GetType(), "Popup", "showSuccessPopup();", true);
                            }
                            else
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "sweetAlert", "Swal.fire('Oops...', 'No changes were made. Please check if the data was updated.', 'error');", true);
                            }
                        }
                        else
                        {
                            string query = "UPDATE SchemesData SET schemename = @schemename, schemetype = @schemetype, description = @description, benefitamt = @benefitamt, appstartdate = @appstartdate, appenddate = @appenddate  WHERE s_id = @id";


                            SqlCommand cmd = new SqlCommand(query, con);
                            cmd.Parameters.AddWithValue("@schemename", txtSchemeName.Text);
                            cmd.Parameters.AddWithValue("@schemetype", txtSchemeType.Text);
                            cmd.Parameters.AddWithValue("@description", txtDescription.Text);
                            cmd.Parameters.AddWithValue("@benefitamt", txtBenefitAmount.Text);
                            cmd.Parameters.AddWithValue("@appstartdate", Convert.ToDateTime(txtStartDate.Text));
                            cmd.Parameters.AddWithValue("@appenddate", Convert.ToDateTime(txtEndDate.Text));

                            cmd.Parameters.AddWithValue("@id", Convert.ToInt32(schemeId));

                            con.Open();
                            int rowsAffected = cmd.ExecuteNonQuery();
                            if (rowsAffected > 0)
                            {
                                // Update the current image on the page if a new photo was uploaded


                                ClientScript.RegisterStartupScript(this.GetType(), "Popup", "showSuccessPopup();", true);
                            }
                            else
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "sweetAlert", "Swal.fire('Oops...', 'No changes were made. Please check if the data was updated.', 'error');", true);
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "sweetAlert", "Swal.fire('Error', 'Database error: " + ex.Message + "', 'error');", true);

            }
        }

    }
}