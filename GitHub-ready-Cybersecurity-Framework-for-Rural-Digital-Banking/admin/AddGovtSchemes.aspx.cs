using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Data;
namespace Cybersecurity_Framework_for_Rural_Digital_Banking.admin
{
    public partial class AddGovtSchemes : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["PMSConnectionString"].ConnectionString; // Declare at class level

        protected void Page_Load(object sender, EventArgs e)
        {

        }


       

        protected void Button1_Click(object sender, EventArgs e)
        {
            df();
        }

        private void df()
        {


            try
            {


                if (string.IsNullOrWhiteSpace(txtSchemeName.Text) ||
              string.IsNullOrWhiteSpace(txtschemedetail.Text) ||
              string.IsNullOrWhiteSpace(txtAmount.Text) ||
              string.IsNullOrWhiteSpace(txtstartdate.Text) ||
              string.IsNullOrWhiteSpace(txtEndDate.Text) || !FileUpload1.HasFile)
                {
                    // If any required field is empty, show error
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "sweetAlert", "Swal.fire('Error', 'Please fill in all the required fields!', 'error');", true);
                    return;
                }
                // File upload logic
                if (FileUpload1.HasFile == true)
                {

                    string fpath = Server.MapPath("/admin/") + "/Photos/" + FileUpload1.FileName;
                    FileUpload1.SaveAs(fpath);
                }



                // Use the global connStr variable
                using (SqlConnection sqlCon = new SqlConnection(connStr)) // Use "sqlCon" instead of "con"
                {
                    string query = "INSERT INTO SchemesData (schemename, schemetype, description, benefitamt, appstartdate, appenddate, photo) " +
                                   "VALUES (@SchemeName, @SchemeType, @SchemeDetails, @BenefitAmount, @StartDate, @EndDate, @ImagePath)";

                    using (SqlCommand cmd = new SqlCommand(query, sqlCon))
                    {
                        // Add parameters
                        cmd.Parameters.AddWithValue("@SchemeName", txtSchemeName.Text);
                        cmd.Parameters.AddWithValue("@SchemeType", ddlschemetype.SelectedValue);
                        cmd.Parameters.AddWithValue("@SchemeDetails", txtschemedetail.Text);
                        cmd.Parameters.AddWithValue("@BenefitAmount", txtAmount.Text.ToString());
                        cmd.Parameters.AddWithValue("@StartDate", txtstartdate.Text);
                        cmd.Parameters.AddWithValue("@EndDate", txtEndDate.Text);
                        cmd.Parameters.AddWithValue("@ImagePath", FileUpload1.FileName);

                        sqlCon.Open();
                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "Popup", "showSuccessPopup();", true);

                            ClearFields();
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "sweetAlert", "Swal.fire('Oops...', 'No changes were made. Please check if the data was updated.', 'error');", true);

                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "sweetAlert", "Swal.fire('Oops...', 'No changes were made. Please check if the data was updated.', 'error');", true);

            }
        }

        private void ClearFields()
        {
            txtSchemeName.Text = "";
            ddlschemetype.SelectedIndex = 0;
            txtschemedetail.Text = "";
            txtAmount.Text = "";
            txtstartdate.Text = "";
            txtEndDate.Text = "";
        }


    }



}