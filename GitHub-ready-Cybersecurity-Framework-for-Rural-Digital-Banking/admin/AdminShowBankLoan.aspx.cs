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
    public partial class AdminShowBankLoan : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        private void BindData()
        {
            Repeater1.DataBind(); // Refresh data after deletion
        }


        protected void Button1_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int schemeId = Convert.ToInt32(btn.CommandArgument);

            string connStr = ConfigurationManager.ConnectionStrings["PMSConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "DELETE FROM LoanData WHERE id = @id";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@id", schemeId);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }
            }
            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Scheme deleted successfully!');", true);
            // Refresh the repeater after deletion
            BindData();
        }



    }
}