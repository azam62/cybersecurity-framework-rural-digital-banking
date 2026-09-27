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
    public partial class change_password : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["cid"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            hfCustomerID.Value = Session["cid"].ToString();

            if (!IsPostBack)
            {
                using (SqlConnection con = new SqlConnection(
                    ConfigurationManager.ConnectionStrings["LIS"].ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand(
                        "SELECT email FROM Registration WHERE cid=@cid", con))
                    {
                        cmd.Parameters.Add("@cid", SqlDbType.Int)
                            .Value = Convert.ToInt32(hfCustomerID.Value);

                        con.Open();
                        object email = cmd.ExecuteScalar();

                        if (email == null)
                        {
                            lblChangePassword.Text = "You have not provided the email";
                        }
                        else
                        {
                            txtEmail.Text = email.ToString();
                        }
                    }
                }
            }
        }
        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["LIS"]);
            SqlCommand cmd = new SqlCommand(); con.Open();
            cmd.CommandText = "update Registration set password=@password where cid=@cid";
            cmd.Parameters.Add("@cid", SqlDbType.Int).Value = Convert.ToInt32(hfCustomerID.Value);
            cmd.Parameters.Add("@password", SqlDbType.NVarChar).Value = txtPassword.Text;
            cmd.Connection = con;
            int x = cmd.ExecuteNonQuery();
            if (x > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "Popup", "showSuccessPopup();", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "sweetAlert", "Swal.fire('Oops...', 'No changes were made. Please check if the data was updated.', 'error');", true);
            }

            con.Close();
        }


    }
}