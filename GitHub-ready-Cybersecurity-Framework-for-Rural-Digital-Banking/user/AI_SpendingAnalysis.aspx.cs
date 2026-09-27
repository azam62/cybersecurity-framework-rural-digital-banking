using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
namespace Cybersecurity_Framework_for_Rural_Digital_Banking.user
{
    public partial class AI_SpendingAnalysis : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["PMSConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["cid"] != null)
                    LoadSpendingAnalysis();
                else
                    Response.Redirect("~/Login.aspx");
            }
        }

        void LoadSpendingAnalysis()
        {
            int cid = Convert.ToInt32(Session["cid"]);

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                SqlCommand cmd = new SqlCommand(@"
                SELECT 
                SUM(CASE WHEN ISNUMERIC(deposit)=1 THEN CAST(deposit AS DECIMAL(18,2)) ELSE 0 END) AS totalDeposit,
                SUM(CASE WHEN ISNUMERIC(withdraw)=1 THEN CAST(withdraw AS DECIMAL(18,2)) ELSE 0 END) AS totalWithdraw
                FROM BankStatement
                WHERE cid=@cid", con);

                cmd.Parameters.AddWithValue("@cid", cid);

                SqlDataReader dr = cmd.ExecuteReader();

                decimal deposit = 0;
                decimal withdraw = 0;

                if (dr.Read())
                {
                    deposit = dr["totalDeposit"] != DBNull.Value ?
                        Convert.ToDecimal(dr["totalDeposit"]) : 0;

                    withdraw = dr["totalWithdraw"] != DBNull.Value ?
                        Convert.ToDecimal(dr["totalWithdraw"]) : 0;
                }

                dr.Close();

                decimal savings = deposit - withdraw;

                lblDeposit.Text = deposit.ToString("0.00");
                lblWithdraw.Text = withdraw.ToString("0.00");
                lblSavings.Text = savings.ToString("0.00");

                // AI Logic
                decimal ratio = 0;
                if (deposit > 0)
                    ratio = withdraw / deposit;

                if (ratio < 0.4m)
                    lblCategory.Text = "Smart Saver 🟢";
                else if (ratio < 0.7m)
                    lblCategory.Text = "Moderate Spender 🟡";
                else
                    lblCategory.Text = "High Spender 🔴";

                if (savings > 5000)
                    lblPattern.Text = "Excellent savings trend.";
                else if (savings > 1000)
                    lblPattern.Text = "Average savings pattern.";
                else
                    lblPattern.Text = "Low savings this period.";

                if (ratio > 0.7m)
                    lblSuggestion.Text = "Reduce unnecessary spending and aim to save 20% more.";
                else if (ratio > 0.4m)
                    lblSuggestion.Text = "Try increasing your savings gradually.";
                else
                    lblSuggestion.Text = "Great financial discipline! Keep it up.";
            }
        }


    }
}