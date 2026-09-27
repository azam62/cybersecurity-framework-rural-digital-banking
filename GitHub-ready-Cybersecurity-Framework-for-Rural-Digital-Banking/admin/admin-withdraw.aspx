<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin-masterpage.Master" AutoEventWireup="true" CodeBehind="admin-withdraw.aspx.cs" Inherits="Cybersecurity_Framework_for_Rural_Digital_Banking.admin.admin_withdraw" %>

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

    .search-row { display: flex; gap: 14px; align-items: flex-end; flex-wrap: wrap; }
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
        color: rgba(200,230,255,0.6) !important;
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

    .btn-withdraw {
        background: linear-gradient(90deg, #ff6b35, #f7931e) !important;
        border: none !important; color: #fff !important;
        font-weight: 600 !important; padding: 13px 36px !important;
        border-radius: 30px !important; font-size: 14px !important;
        font-family: 'Poppins', sans-serif !important; cursor: pointer;
        transition: transform 0.25s, box-shadow 0.25s !important;
        width: 100%; margin-top: 8px !important;
    }

    .btn-withdraw:hover { transform: translateY(-2px) !important; box-shadow: 0 0 22px rgba(255,107,53,0.5) !important; }

    .two-col { display: grid; grid-template-columns: 1fr 1fr; gap: 28px; }

    .photo-box {
        background: rgba(0,0,0,0.25);
        border: 1px solid rgba(0,255,213,0.15);
        border-radius: 14px; padding: 20px; text-align: center;
    }

    .photo-box .photo-label {
        color: #00ffd5; font-size: 13px; font-weight: 600;
        margin-bottom: 14px; display: block;
    }

    .photo-box img {
        border-radius: 12px;
        border: 2px solid rgba(0,255,213,0.35);
        box-shadow: 0 0 16px rgba(0,255,213,0.15);
        max-width: 160px; max-height: 160px; object-fit: cover;
    }

    .status-label {
        display: block; text-align: center;
        margin-top: 12px; font-size: 14px; font-weight: 600;
    }

    @media(max-width: 640px) { .two-col { grid-template-columns: 1fr; } }
</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <asp:HiddenField ID="hfCustomerID" runat="server" />

    <div class="page-wrapper">

        <div class="page-header">
            <div class="page-header-icon">💸</div>
            <div class="page-header-text">
                <h2>Withdrawal</h2>
                <p>Search an account and process a withdrawal securely</p>
            </div>
        </div>

        <!-- Lookup -->
        <div class="search-card">
            <div class="section-header">🔍 Account Lookup</div>
            <div class="search-row">
                <div class="field-wrap">
                    <label>Account Number</label>
                    <asp:TextBox ID="txtAccountNo" runat="server" CssClass="form-control" Placeholder="Enter account number"></asp:TextBox>
                </div>
                <asp:Button ID="btnShow" runat="server" Text="Show Details" CssClass="btn-search" OnClick="btnShow_Click" />
            </div>
        </div>

        <!-- Details -->
        <div class="glass-card">
            <div class="two-col">
                <div>
                    <div class="section-header">👤 Account Details</div>

                    <div class="field-group">
                        <label>First Name</label>
                        <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                    </div>
                    <div class="field-group">
                        <label>Middle Name</label>
                        <asp:TextBox ID="txtMiddleName" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                    </div>
                    <div class="field-group">
                        <label>Last Name</label>
                        <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                    </div>
                    <div class="field-group">
                        <label>Mobile</label>
                        <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                    </div>
                    <div class="field-group">
                        <label>Email</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                    </div>
                    <div class="field-group">
                        <label>Current Balance (₹)</label>
                        <asp:TextBox ID="txtCurrentBal" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                    </div>

                    <div class="section-header" style="margin-top:24px;">💳 Withdrawal</div>
                    <div class="field-group">
                        <label>Amount to Withdraw (₹)</label>
                        <asp:TextBox ID="txtWithdraw" runat="server" CssClass="form-control" Placeholder="Enter amount"></asp:TextBox>
                    </div>
                    <asp:Button ID="btnWithdraw" runat="server" Text="💸 Withdraw Amount" CssClass="btn-withdraw" OnClick="btnWithdraw_Click" />
                    <asp:Label ID="lblWithdraw" runat="server" Text="" ForeColor="Red" Font-Size="Large" CssClass="status-label"></asp:Label>
                </div>

                <div>
                    <div class="section-header">🖼 Profile Photo</div>
                    <div class="photo-box">
                        <span class="photo-label">Customer Photo</span>
                        <asp:Label ID="lblPhoto" runat="server" Text=""></asp:Label>
                        <asp:Image ID="imgPhoto" runat="server" Height="160px" Width="160px" />
                    </div>
                </div>
            </div>
        </div>

    </div>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</asp:Content>
