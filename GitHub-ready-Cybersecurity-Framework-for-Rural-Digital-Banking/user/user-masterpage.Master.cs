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
    public partial class user_masterpage : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string cid = Session["cid"].ToString();
            if (!IsPostBack)
            {
                SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["LIS"]);
                SqlCommand cmd = new SqlCommand();
                con.Open();

                cmd.CommandText = "select firstname, lastname from Registration where cid=@cid";
                cmd.Parameters.Add("@cid", SqlDbType.Int).Value = Convert.ToInt32(cid);
                cmd.Connection = con;
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    lblUser.Text = dr.GetString(0) + dr.GetString(1);
                }
                else
                {

                }

                con.Close();
            }
        }
        protected void btnPoweroff_ServerClick(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("~/login.aspx");
        }

    }
}