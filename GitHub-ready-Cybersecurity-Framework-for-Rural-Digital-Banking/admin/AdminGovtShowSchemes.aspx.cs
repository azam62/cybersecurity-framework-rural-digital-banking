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
    public partial class AdminGovtShowSchemes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

       
        protected void Button1_Command(object sender, CommandEventArgs e)
        {
            string schemeId = e.CommandArgument.ToString();

            if (!string.IsNullOrEmpty(schemeId))
            {
                // Connection string from web.config
                string connStr = ConfigurationManager.ConnectionStrings["PMSConnectionString"].ConnectionString;

                // SQL query to delete the record
                string query = "DELETE FROM SchemesData WHERE s_id = @s_id";

                // Create a new SQL connection
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    // Create the SQL command and add parameters
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@s_id", schemeId);

                        // Open connection, execute the query, and close the connection
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        conn.Close();
                    }
                }
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Scheme deleted successfully!');", true);

                // Optionally, rebind the data to refresh the Repeater after deletion
                Repeater1.DataBind();
            }
        }



    }
}