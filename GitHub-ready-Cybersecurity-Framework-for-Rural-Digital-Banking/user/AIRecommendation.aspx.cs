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
    public partial class AIRecommendation : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["PMSConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["cid"] != null)
                {
                    LoadAIRecommendation();
                }
                else
                {
                    Response.Redirect("~/Login.aspx");
                }
            }
        }

        void LoadAIRecommendation()
        {
            int cid = Convert.ToInt32(Session["cid"]);

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                // 🔹 Get User Information
                SqlCommand cmdUser = new SqlCommand(
                    "SELECT firstname, accountno, balance FROM Registration WHERE cid=@cid", con);
                cmdUser.Parameters.AddWithValue("@cid", cid);

                SqlDataReader dr = cmdUser.ExecuteReader();

                if (dr.Read())
                {
                    lblName.Text = dr["firstname"].ToString();
                    lblAcc.Text = dr["accountno"].ToString();
                    lblBalance.Text = dr["balance"].ToString();
                }
                dr.Close();

                // 🔹 Get Transaction Summary
                SqlCommand cmdTrans = new SqlCommand(
                    "SELECT SUM(CAST(deposit AS FLOAT)) AS totalDeposit, " +
                    "SUM(CAST(withdraw AS FLOAT)) AS totalWithdraw " +
                    "FROM BankStatement WHERE cid=@cid", con);

                cmdTrans.Parameters.AddWithValue("@cid", cid);

                SqlDataReader dr2 = cmdTrans.ExecuteReader();

                decimal totalDeposit = 0;
                decimal totalWithdraw = 0;

                if (dr2.Read())
                {
                    totalDeposit = dr2["totalDeposit"] != DBNull.Value ?
                        Convert.ToDecimal(dr2["totalDeposit"]) : 0;

                    totalWithdraw = dr2["totalWithdraw"] != DBNull.Value ?
                        Convert.ToDecimal(dr2["totalWithdraw"]) : 0;
                }
                dr2.Close();

                // 🔹 AI Financial Score Calculation
                decimal score = 0;

                if (totalDeposit > 0)
                {
                    decimal ratio = totalWithdraw / totalDeposit;

                    if (ratio <= 0.3m)
                        score = 90;   // Excellent saver
                    else if (ratio <= 0.6m)
                        score = 70;   // Moderate saver
                    else if (ratio <= 1m)
                        score = 50;   // Balanced
                    else
                        score = 30;   // High spender
                }
                else
                {
                    score = 20; // No deposit history
                }

                lblScore.Text = score + "%";


                // 🔹 AI Recommendation Logic
                if (score >= 75)
                {
                    lblGovScheme.Text = "Pradhan Mantri High Return Scheme";
                    lblBankScheme.Text = "Premium Fixed Deposit Plan";
                }
                else if (score >= 50)
                {
                    lblGovScheme.Text = "Standard Government Savings Scheme";
                    lblBankScheme.Text = "Recurring Deposit Plan";
                }
                else
                {
                    lblGovScheme.Text = "Low Risk Government Support Scheme";
                    lblBankScheme.Text = "Basic Savings Account Plan";
                }

                // 🔹 AI Confidence Level
                lblConfidence.Text = score.ToString("0.00") + "% Confidence Level";
            }
        }


    }
}