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
    public partial class add_interest : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        protected void btnInterest_Click(object sender, EventArgs e)
        {
            decimal interest;

            if (!decimal.TryParse(txtInterest.Text, out interest))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage",
                    "alert('Please enter a valid interest value');", true);
                return;
            }

            using (SqlConnection con = new SqlConnection(
                ConfigurationManager.ConnectionStrings["LIS"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = con;
                    cmd.CommandText = @"UPDATE Registration 
                                SET balance = balance + (balance * @interest / 100) 
                                WHERE status = 'Yes'";

                    cmd.Parameters.Add("@interest", SqlDbType.Decimal).Value = interest;

                    con.Open();
                    int x = cmd.ExecuteNonQuery();

                    if (x > 0)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage",
                            "alert('Balance Updated Successfully');", true);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage",
                            "alert('No records updated');", true);
                    }
                }
            }
        }


    }
}