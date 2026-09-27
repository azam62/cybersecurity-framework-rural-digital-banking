using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

namespace Cybersecurity_Framework_for_Rural_Digital_Banking.admin
{
    public partial class AddBankScheme : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Button1.Click += new EventHandler(Button1_Click); // This is OK
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            save();
        }



        protected void save()
        {
            try
            {
                // Validate required fields
                if (string.IsNullOrWhiteSpace(txtSchemeName.Text) ||
                    string.IsNullOrWhiteSpace(txtschemedetail.Text) ||
                    string.IsNullOrWhiteSpace(txtinterestrate.Text) ||
                    string.IsNullOrWhiteSpace(txttenure.Text) ||
                    string.IsNullOrWhiteSpace(txtloanamount.Text) ||
                    !FileUpload.HasFile)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "sweetAlert",
                        "Swal.fire('Error', 'Please fill in all the required fields!', 'error');", true);
                    return;
                }

                // Save file to Photos folder
                string filePath = "~/admin/Photos/" + FileUpload.FileName;
                string physicalPath = Server.MapPath(filePath);
                FileUpload.SaveAs(physicalPath);

                // **Use LIS Connection from Web.config**
                string connStr = ConfigurationManager.ConnectionStrings["PMSConnectionString"].ConnectionString;

                using (SqlConnection con = new SqlConnection(connStr))
                {
                    con.Open();

                    // Insert Query
                    string query = "INSERT INTO LoanData(schemename, schemetype, schemedetail, rate, tenure, amount, photo) " +
                                   "VALUES(@schemename, @type, @details, @rate, @tenure, @amount, @photo)";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@schemename", txtSchemeName.Text);
                        cmd.Parameters.AddWithValue("@type", ddlschemetype.SelectedValue);
                        cmd.Parameters.AddWithValue("@details", txtschemedetail.Text);
                        cmd.Parameters.AddWithValue("@rate", txtinterestrate.Text);
                        cmd.Parameters.AddWithValue("@tenure", txttenure.Text);
                        cmd.Parameters.AddWithValue("@amount", txtloanamount.Text);
                        cmd.Parameters.AddWithValue("@photo", FileUpload.FileName);

                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "Popup", "showSuccessPopup();", true);
                            ClearFields();
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "sweetAlert",
                                "Swal.fire('Oops...', 'No changes were made. Please check if the data was updated.', 'error');", true);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "sweetAlert",
                    "Swal.fire('Error', 'An unexpected error occurred: " + ex.Message + "', 'error');", true);
            }

        }
        protected void ClearFields()
        {
            txtSchemeName.Text = "";
            ddlschemetype.SelectedIndex = 0;
            txtschemedetail.Text = "";
            txtinterestrate.Text = "";
            txttenure.Text = "";
            txtloanamount.Text = "";


        }

    }



}