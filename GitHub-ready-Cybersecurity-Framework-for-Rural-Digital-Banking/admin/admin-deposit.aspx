<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin-masterpage.Master" AutoEventWireup="true" CodeBehind="admin-deposit.aspx.cs" Inherits="Cybersecurity_Framework_for_Rural_Digital_Banking.admin.admin_deposit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<style>
    body, #layoutSidenav_content {
        background: linear-gradient(135deg, #0f2027, #203a43, #2c5364) !important;
        font-family: 'Poppins', sans-serif !important;
        color: #fff !important;
    }

    .page-wrapper { padding: 36px 30px 60px; min-height: 90vh; }

    .page-header {
        display: flex; align-items: center; gap: 18px;
        margin-bottom: 32px; padding-bottom: 22px;
        border-bottom: 1px solid rgba(0,255,213,0.15);
    }
    .page-header-icon {
        width: 60px; height: 60px;
        background: rgba(0,255,213,0.12);
        border: 1px solid rgba(0,255,213,0.3);
        border-radius: 16px;
        display: flex; align-items: center; justify-content: center;
        font-size: 26px; box-shadow: 0 0 16px rgba(0,255,213,0.15);
    }
    .page-header-text h2 {
        font-size: 22px; font-weight: 700; color: #00ffd5; margin: 0;
        text-shadow: 0 0 10px rgba(0,255,213,0.4);
    }
    .page-header-text p { font-size: 13px; color: rgba(200,230,255,0.6); margin: 4px 0 0; }

    .search-card {
        background: rgba(255,255,255,0.06);
        backdrop-filter: blur(14px);
        border: 1px solid rgba(0,255,213,0.15);
        border-radius: 18px; padding: 26px 28px;
        box-shadow: 0 12px 35px rgba(0,0,0,0.4);
        margin-bottom: 28px;
    }

    .search-row {
        display: flex; gap: 14px; align-items: flex-end; flex-wrap: wrap;
    }
    .search-row .field-wrap { flex: 1; min-width: 200px; }

    .glass-card {
        background: rgba(255,255,255,0.06);
        backdrop-filter: blur(14px);
        -webkit-backdrop-filter: blur(14px);
        border: 1px solid rgba(0,255,213,0.15);
        border-radius: 20px; padding: 32px 28px;
        box-shadow: 0 16px 45px rgba(0,0,0,0.5);
        position: relative; overflow: hidden;
    }
    .glass-card::before {
        content: ''; position: absolute; top: -60px; right: -60px;
        width: 220px; height: 220px;
        background: radial-gradient(circle, rgba(0,255,213,0.07) 0%, transparent 70%);
        pointer-events: none;
    }

    .section-header {
        background: rgba(0,198,213,0.1);
        border-left: 4px solid #00ffd5;
        padding: 9px 16px; border-radius: 8px;
        font-weight: 600; color: #00ffd5;
        margin: 0 0 22px; font-size: 13.5px;
    }

    label {
        font-size: 12.5px !important; font-weight: 500 !important;
        color: #cce8ff !important; margin-bottom: 6px !important;
        display: block !important; font-family: 'Poppins', sans-serif !important;
    }

    .form-control {
        background: rgba(255,255,255,0.08) !important;
        border: 1px solid rgba(0,255,213,0.35) !important;
        color: #fff !important; height: 44px !important;
        border-radius: 12px !important; font-size: 13.5px !important;
        font-family: 'Poppins', sans-serif !important;
        padding: 0 14px !important; width: 100% !important;
        transition: border-color 0.3s, box-shadow 0.3s;
        box-sizing: border-box;
    }
    .form-control:focus {
        outline: none !important;
        border-color: #00ffd5 !important;
        box-shadow: 0 0 14px rgba(0,255,213,0.3) !important;
        background: rgba(255,255,255,0.12) !important;
    }
    .form-control::placeholder { color: rgba(255,255,255,0.3) !important; }
    .form-control:disabled {
        background: rgba(255,255,255,0.04) !important;
        border-color: rgba(0,255,213,0.15) !important;
        color: rgba(200,230,255,0.7) !important;
        cursor: not-allowed;
    }

    .field-group { margin-bottom: 18px; }

    .btn-search {
        background: linear-gradient(90deg, #00b09b, #96c93d) !important;
        border: none !important; color: #fff !important;
        font-weight: 600 !important; height: 44px !important;
        padding: 0 26px !important; border-radius: 12px !important;
        font-size: 13.5px !important; font-family: 'Poppins', sans-serif !important;
        cursor: pointer; white-space: nowrap;
        transition: transform 0.2s, box-shadow 0.2s !important;
    }
    .btn-search:hover { transform: translateY(-1px) !important; box-shadow: 0 0 16px rgba(0,176,155,0.4) !important; }

    .btn-deposit {
        background: linear-gradient(90deg, #00c6ff, #0072ff) !important;
        border: none !important; color: #fff !important;
        font-weight: 600 !important; padding: 13px 36px !important;
        border-radius: 30px !important; font-size: 14px !important;
        font-family: 'Poppins', sans-serif !important; cursor: pointer;
        transition: transform 0.25s, box-shadow 0.25s !important;
        width: 100%; margin-top: 8px !important;
    }
    .btn-deposit:hover { transform: translateY(-2px) !important; box-shadow: 0 0 22px rgba(0,198,255,0.5) !important; }

    .two-col { display: grid; grid-template-columns: 1fr 1fr; gap: 28px; }

    .photo-box {
        background: rgba(0,0,0,0.25);
        border: 1px solid rgba(0,255,213,0.15);
        border-radius: 14px; padding: 20px;
        text-align: center;
    }
    .photo-box .photo-label {
        color: #00ffd5; font-size: 13px; font-weight: 600;
        margin-bottom: 14px; display: block;
    }
    .photo-box img {
        border-radius: 12px;
        border: 2px solid rgba(0,255,213,0.35);
        box-shadow: 0 0 16px rgba(0,255,213,0.15);
        max-width: 130px; max-height: 130px;
        object-fit: cover;
    }

    .status-label {
        display: block; text-align: center;
        margin-top: 12px; font-size: 14px; font-weight: 600;
    }

    /* Details panel hidden by default, shown after search */
    #detailsPanel { display: none; }

    @media(max-width: 640px) { .two-col { grid-template-columns: 1fr; } }
</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <asp:HiddenField ID="hfCustomerID" runat="server" />

    <div class="page-wrapper">

        <!-- Header -->
        <div class="page-header">
            <div class="page-header-icon">💰</div>
            <div class="page-header-text">
                <h2>Deposit Funds</h2>
                <p>Search a customer account and deposit funds securely</p>
            </div>
        </div>

        <!-- Account Lookup -->
        <div class="search-card">
            <div class="section-header">🔍 Account Lookup</div>
            <div class="search-row">
                <div class="field-wrap">
                    <label for="<%= txtAccountNo.ClientID %>">Account Number</label>
                    <asp:TextBox ID="txtAccountNo" runat="server" CssClass="form-control"
                        placeholder="Enter account number" />
                </div>
                <asp:Button ID="btnShow" runat="server" Text="🔎 Show Details"
                    CssClass="btn-search"
                    OnClick="btnShow_Click"
                    CausesValidation="false" />
            </div>
            <!-- Error shown inline here if account not found -->
            <asp:Label ID="lblSearchError" runat="server" Text=""
                style="color:#ff8080;font-size:13px;margin-top:10px;display:block;" />
        </div>

        <!-- Details + Deposit — hidden until a valid account is found -->
    <asp:Panel ID="detailsPanel"   class="glass-card" runat="server">
        
            <div class="two-col">

                <!-- Left: Account Details + Deposit -->
                <div>
                    <div class="section-header">👤 Account Details</div>

                    <div class="field-group">
                        <label>Full Name</label>
                        <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" Enabled="false" />
                    </div>
                    <div class="field-group">
                        <label>Account Number</label>
                        <asp:TextBox ID="txtAccNoDisplay" runat="server" CssClass="form-control" Enabled="false" />
                    </div>
                    <div class="field-group">
                        <label>Mobile</label>
                        <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control" Enabled="false" />
                    </div>
                    <div class="field-group">
                        <label>Email</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" Enabled="false" />
                    </div>
                    <div class="field-group">
                        <label>Account Status</label>
                        <asp:TextBox ID="txtStatus" runat="server" CssClass="form-control" Enabled="false" />
                    </div>
                    <div class="field-group">
                        <label>Current Balance (₹)</label>
                        <asp:TextBox ID="txtCurrentBal" runat="server" CssClass="form-control" Enabled="false" />
                    </div>

                    <div class="section-header" style="margin-top:24px;">💳 Deposit</div>
                    <div class="field-group">
                        <label>Amount to Deposit (₹)</label>
                        <asp:TextBox ID="txtDeposit" runat="server" CssClass="form-control"
                            placeholder="Enter amount" />
                    </div>
                    <asp:Button ID="btnDeposit" runat="server" Text="✅ Deposit Amount"
                        CssClass="btn-deposit" OnClick="btnDeposit_Click"
                        CausesValidation="false" />
                    <asp:Label ID="lblDepositResult" runat="server" Text=""
                        CssClass="status-label" />
                </div>

                <!-- Right: Profile Photo -->
                <div>
                    <div class="section-header">🖼 Profile Photo</div>
                    <div class="photo-box">
                        <span class="photo-label">Customer Photo</span>
                        <asp:Image ID="imgPhoto" runat="server"
                            Height="130px" Width="130px"
                            style="display:none;" />
                        <asp:Label ID="lblNoPhoto" runat="server"
                            Text="<span style='color:rgba(200,230,255,0.4);font-size:13px;'>No photo on file</span>" />
                    </div>
                </div>

            </div>
                      </asp:Panel>

    </div>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <script>
        // Show the details panel if the server set it visible
        // (we use a CSS-driven approach so it doesn't flicker)
        var panel = document.getElementById('<%= detailsPanel.ClientID %>');
        if (panel && panel.getAttribute('data-show') === '1') {
            panel.style.display = 'block';
        }
    </script>

</asp:Content>
