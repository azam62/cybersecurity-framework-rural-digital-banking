using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

namespace Cybersecurity_Framework_for_Rural_Digital_Banking.admin
{
    public partial class admin_deposit : System.Web.UI.Page
    {
        // ─────────────────────────────────────────────────────────────
        //  Safely get connection string from EITHER config section.
        //  Your original code mixed AppSettings and ConnectionStrings —
        //  this handles both so it works regardless of where you put it.
        // ─────────────────────────────────────────────────────────────
        private string GetConnectionString()
        {
            var cs = ConfigurationManager.ConnectionStrings["LIS"];
            if (cs != null && !string.IsNullOrEmpty(cs.ConnectionString))
                return cs.ConnectionString;

            string app = ConfigurationManager.AppSettings["LIS"];
            if (!string.IsNullOrEmpty(app))
                return app;

            throw new Exception("Connection string 'LIS' not found in Web.config.");
        }

        // ─────────────────────────────────────────────────────────────
        //  Page Load
        // ─────────────────────────────────────────────────────────────
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                detailsPanel.Visible = false;
                lblSearchError.Text  = "";
            }
        }

        // ─────────────────────────────────────────────────────────────
        //  Show Details
        // ─────────────────────────────────────────────────────────────
        protected void btnShow_Click(object sender, EventArgs e)
        {
            lblSearchError.Text  = "";
            lblDepositResult.Text = "";
            detailsPanel.Visible = false;

            string accNo = txtAccountNo.Text.Trim();
            if (string.IsNullOrEmpty(accNo))
            {
                lblSearchError.Text = "⚠️ Please enter an account number.";
                return;
            }

            try
            {
                using (SqlConnection con = new SqlConnection(GetConnectionString()))
                {
                    con.Open();

                    SqlCommand cmd = new SqlCommand(
                        @"SELECT cid,
                                 ISNULL(firstname,'') + ' ' + ISNULL(middlename,'') + ' ' + ISNULL(lastname,'') AS fullname,
                                 accountno, mobile, email, balance, photo, status
                          FROM   Registration
                          WHERE  accountno = @accno", con);

                    cmd.Parameters.Add("@accno", SqlDbType.NVarChar).Value = accNo;

                    using (SqlDataReader r = cmd.ExecuteReader())
                    {
                        if (!r.Read())
                        {
                            lblSearchError.Text = "❌ No account found with number: <strong>" + accNo + "</strong>";
                            return;
                        }

                        hfCustomerID.Value   = r["cid"].ToString();
                        txtFullName.Text     = r["fullname"].ToString().Trim();
                        txtAccNoDisplay.Text = r["accountno"]?.ToString() ?? accNo;
                        txtMobile.Text       = r["mobile"]?.ToString() ?? "";
                        txtEmail.Text        = r["email"]?.ToString() ?? "";
                        txtCurrentBal.Text   = r["balance"]?.ToString() ?? "0";
                        txtStatus.Text       = (r["status"]?.ToString() == "Yes") ? "✅ Active" : "⚠️ Inactive";

                        string photoFile = r["photo"]?.ToString() ?? "";
                        if (!string.IsNullOrWhiteSpace(photoFile))
                        {
                            imgPhoto.ImageUrl          = ResolveUrl("~/admin/CustomerPhotos/" + photoFile);
                            imgPhoto.Style["display"]  = "block";
                            lblNoPhoto.Visible         = false;
                        }
                        else
                        {
                            imgPhoto.Style["display"] = "none";
                            lblNoPhoto.Visible        = true;
                        }

                        detailsPanel.Visible = true;
                    }
                }
            }
            catch (Exception ex)
            {
                lblSearchError.Text = "❌ Error: " + ex.Message;
            }
        }

        // ─────────────────────────────────────────────────────────────
        //  Deposit
        // ─────────────────────────────────────────────────────────────
        protected void btnDeposit_Click(object sender, EventArgs e)
        {
            lblDepositResult.ForeColor = System.Drawing.Color.OrangeRed;
            detailsPanel.Visible = true;   // keep panel open on error

            if (string.IsNullOrEmpty(hfCustomerID.Value))
            {
                lblDepositResult.Text = "⚠️ No account loaded. Please search first.";
                return;
            }

            decimal balance, deposit;

            if (!decimal.TryParse(txtCurrentBal.Text.Trim(), out balance))
            {
                lblDepositResult.Text = "⚠️ Could not read balance. Search the account again.";
                return;
            }

            if (!decimal.TryParse(txtDeposit.Text.Trim(), out deposit) || deposit <= 0)
            {
                lblDepositResult.Text = "⚠️ Please enter a valid amount greater than zero.";
                return;
            }

            decimal finalBalance = balance + deposit;

            try
            {
                using (SqlConnection con = new SqlConnection(GetConnectionString()))
                {
                    con.Open();

                    // 1. Update Registration balance
                    using (SqlCommand cmdUp = new SqlCommand(
                        "UPDATE Registration SET balance = @balance WHERE cid = @cid", con))
                    {
                        cmdUp.Parameters.Add("@balance", SqlDbType.Decimal).Value = finalBalance;
                        cmdUp.Parameters.Add("@cid",     SqlDbType.Int).Value     = Convert.ToInt32(hfCustomerID.Value);

                        if (cmdUp.ExecuteNonQuery() == 0)
                        {
                            lblDepositResult.Text = "❌ Update failed — no matching record.";
                            return;
                        }
                    }

                    // 2. Insert BankStatement
                    // Columns: cid | trans_date | deposit | withdraw | balance | accountno
                    using (SqlCommand cmdSt = new SqlCommand(
                        @"INSERT INTO BankStatement (cid, trans_date, deposit, withdraw, balance, accountno)
                          VALUES (@cid, @trans_date, @deposit, @withdraw, @balance, @accountno)", con))
                    {
                        cmdSt.Parameters.Add("@cid",        SqlDbType.Int).Value      = Convert.ToInt32(hfCustomerID.Value);
                        cmdSt.Parameters.Add("@trans_date", SqlDbType.NVarChar).Value = DateTime.Now.ToString("dd-MM-yyyy hh:mm tt");
                        cmdSt.Parameters.Add("@deposit",    SqlDbType.NVarChar).Value = deposit.ToString("F2");
                        cmdSt.Parameters.Add("@withdraw",   SqlDbType.NVarChar).Value = "0";
                        cmdSt.Parameters.Add("@balance",    SqlDbType.Decimal).Value  = finalBalance;
                        cmdSt.Parameters.Add("@accountno",  SqlDbType.NVarChar).Value = txtAccountNo.Text.Trim();
                        cmdSt.ExecuteNonQuery();
                    }

                    // Update display
                    txtCurrentBal.Text    = finalBalance.ToString("F2");
                    txtDeposit.Text       = "";

                    lblDepositResult.ForeColor = System.Drawing.Color.LightGreen;
                    lblDepositResult.Text = $"✅ ₹{deposit:F2} deposited. New balance: ₹{finalBalance:F2}";

                    ScriptManager.RegisterStartupScript(this, GetType(), "swal",
                        $@"Swal.fire({{
                            icon:'success',
                            title:'Deposit Successful!',
                            html:'Amount deposited: <b>₹{deposit:F2}</b><br>New balance: <b>₹{finalBalance:F2}</b>',
                            background:'#1a2a3a',
                            color:'#fff',
                            confirmButtonColor:'#00b09b'
                        }});", true);
                }
            }
            catch (Exception ex)
            {
                lblDepositResult.Text = "❌ Error: " + ex.Message;
            }
        }
    }
}
