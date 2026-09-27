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
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            hfCustomerID.Value = Session["cid"].ToString();
            if (!IsPostBack)
            {
                SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["LIS"]); 
                SqlCommand cmd = new SqlCommand();
                con.Open();
                cmd.CommandText = "SELECT accountno, firstname, middlename, lastname, mobile, email, balance, photo FROM Registration WHERE cid=@cid";
                cmd.Parameters.Add("@cid", SqlDbType.Int).Value = Convert.ToInt32(hfCustomerID.Value);
                cmd.Connection = con; cmd.ExecuteNonQuery();

                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    txtAccountNo.Text = reader.GetString(0); 
                    txtFirstName.Text = reader.GetString(1); 
                    txtMiddleName.Text = reader.GetString(2);
                    txtLastName.Text = reader.GetString(3); 
                    txtMobile.Text = reader.GetString(4);
                    txtEmail.Text = reader.GetString(5); 
                    txtBalance.Text = reader.GetDecimal(6).ToString();

                    imgPhoto.ImageUrl = "../user/Photos/" + reader.GetString(7);
                }

                con.Close();
            }
        }


    }
}