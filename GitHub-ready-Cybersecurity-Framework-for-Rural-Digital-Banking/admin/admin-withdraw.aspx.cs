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
    public partial class admin_withdraw : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnWithdraw_Click(object sender, EventArgs e)
        {
            decimal balance, withdraw;

            if (!decimal.TryParse(txtCurrentBal.Text, out balance) ||
                !decimal.TryParse(txtWithdraw.Text, out withdraw))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage",
                    "alert('Invalid amount entered');", true);
                return;
            }

            if (withdraw > balance)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage",
                    "alert('Insufficient balance');", true);
                return;
            }

            decimal finalbalance = balance - withdraw;

            using (SqlConnection con = new SqlConnection(
                ConfigurationManager.ConnectionStrings["LIS"].ConnectionString))
            {
                con.Open();
                SqlTransaction tran = con.BeginTransaction();

                try
                {
                    // 1️⃣ Update Balance
                    using (SqlCommand cmd = new SqlCommand(
                        "UPDATE Registration SET balance=@balance WHERE accountno=@accountno",
                        con, tran))
                    {
                        cmd.Parameters.Add("@balance", SqlDbType.Decimal).Value = finalbalance;
                        cmd.Parameters.Add("@accountno", SqlDbType.VarChar).Value = txtAccountNo.Text;

                        cmd.ExecuteNonQuery();
                    }

                    // 2️⃣ Insert Bank Statement
                    using (SqlCommand cmd2 = new SqlCommand(
                        @"INSERT INTO BankStatement
                  (cid, date, deposit, withdraw, balance1, accountno)
                  VALUES (@cid, @date, @deposit, @withdraw, @balance1, @accountno)",
                        con, tran))
                    {
                        cmd2.Parameters.Add("@cid", SqlDbType.Int).Value = Convert.ToInt32(hfCustomerID.Value);
                        cmd2.Parameters.Add("@date", SqlDbType.DateTime).Value = DateTime.Now;
                        cmd2.Parameters.Add("@deposit", SqlDbType.Decimal).Value = 0;
                        cmd2.Parameters.Add("@withdraw", SqlDbType.Decimal).Value = withdraw;
                        cmd2.Parameters.Add("@balance1", SqlDbType.Decimal).Value = finalbalance;
                        cmd2.Parameters.Add("@accountno", SqlDbType.VarChar).Value = txtAccountNo.Text;

                        cmd2.ExecuteNonQuery();
                    }

                    tran.Commit();

                    txtCurrentBal.Text = finalbalance.ToString();

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage",
                        "Swal.fire('Success','Balance Updated Successfully','success');", true);
                }
                catch
                {
                    tran.Rollback();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage",
                        "alert('Transaction failed');", true);
                }
            }
        }

        protected void btnShow_Click(object sender, EventArgs e)
        {

        }
    }
}