<%@ Page Title="" Language="C#" MasterPageFile="~/user/user-masterpage.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Cybersecurity_Framework_for_Rural_Digital_Banking.user.Default" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<style>
    body, #page-content {
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
    .page-header-text h2 { font-size: 22px; font-weight: 700; color: #00ffd5; margin: 0; text-shadow: 0 0 10px rgba(0,255,213,0.4); }
    .page-header-text p { font-size: 13px; color: rgba(200,230,255,0.6); margin: 4px 0 0; }
    .glass-card {
        background: rgba(255,255,255,0.06);
        backdrop-filter: blur(14px); -webkit-backdrop-filter: blur(14px);
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
        background: rgba(0,198,213,0.1); border-left: 4px solid #00ffd5;
        padding: 9px 16px; border-radius: 8px;
        font-weight: 600; color: #00ffd5; margin: 0 0 22px; font-size: 13.5px;
    }
    label {
        font-size: 12.5px !important; font-weight: 500 !important;
        color: #cce8ff !important; margin-bottom: 6px !important;
        display: block !important; font-family: 'Poppins', sans-serif !important;
    }
    .form-control {
        background: rgba(255,255,255,0.05) !important;
        border: 1px solid rgba(0,255,213,0.2) !important;
        color: rgba(200,230,255,0.85) !important;
        height: 44px !important; border-radius: 12px !important;
        font-size: 13.5px !important; font-family: 'Poppins', sans-serif !important;
        padding: 0 14px !important; width: 100% !important;
        box-sizing: border-box !important; cursor: default !important;
        margin-top: 0 !important;
    }
    .field-group { margin-bottom: 16px; }
    .two-col { display: grid; grid-template-columns: 1fr 1fr; gap: 28px; }
    /* Balance highlight */
    .balance-box .form-control {
        color: #00ffd5 !important; font-weight: 600 !important;
        border-color: rgba(0,255,213,0.35) !important;
        font-size: 15px !important;
    }
    .photo-box {
        background: rgba(0,0,0,0.25);
        border: 1px solid rgba(0,255,213,0.15);
        border-radius: 16px; padding: 24px; text-align: center;
    }
    .photo-box img {
        border-radius: 14px;
        border: 2px solid rgba(0,255,213,0.35);
        box-shadow: 0 0 20px rgba(0,255,213,0.15);
        max-width: 200px; max-height: 200px; object-fit: cover;
    }
    .photo-label { display: block; margin-top: 14px; color: rgba(200,230,255,0.45); font-size: 12px; }
    @media(max-width: 640px) { .two-col { grid-template-columns: 1fr; } }
</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <asp:HiddenField ID="hfCustomerID" runat="server" />

    <div class="page-wrapper">

        <div class="page-header">
            <div class="page-header-icon">👤</div>
            <div class="page-header-text">
                <h2>Customer Details</h2>
                <p>Your account overview and personal information</p>
            </div>
        </div>

        <div class="glass-card">
            <div class="two-col">

                <div>
                    <div class="section-header">🪪 Account Information</div>
                    <div class="field-group">
                        <label>Account Number</label>
                        <asp:TextBox ID="txtAccountNo" CssClass="form-control" runat="server" Enabled="false"></asp:TextBox>
                    </div>
                    <div class="field-group">
                        <label>First Name</label>
                        <asp:TextBox ID="txtFirstName" CssClass="form-control" runat="server" Enabled="false"></asp:TextBox>
                    </div>
                    <div class="field-group">
                        <label>Middle Name</label>
                        <asp:TextBox ID="txtMiddleName" CssClass="form-control" runat="server" Enabled="false"></asp:TextBox>
                    </div>
                    <div class="field-group">
                        <label>Last Name</label>
                        <asp:TextBox ID="txtLastName" CssClass="form-control" runat="server" Enabled="false"></asp:TextBox>
                    </div>
                    <div class="field-group">
                        <label>Mobile</label>
                        <asp:TextBox ID="txtMobile" CssClass="form-control" runat="server" Enabled="false"></asp:TextBox>
                    </div>
                    <div class="field-group">
                        <label>Email</label>
                        <asp:TextBox ID="txtEmail" CssClass="form-control" runat="server" Enabled="false"></asp:TextBox>
                    </div>
                    <div class="field-group balance-box">
                        <label>Current Balance (₹)</label>
                        <asp:TextBox ID="txtBalance" CssClass="form-control" runat="server" Enabled="false"></asp:TextBox>
                    </div>
                </div>

                <div>
                    <div class="section-header">🖼 Profile Photo</div>
                    <div class="photo-box">
                        <asp:Image ID="imgPhoto" runat="server" Height="200px" Width="200px" />
                        <span class="photo-label">Customer Profile Photo</span>
                    </div>
                </div>

            </div>
        </div>

    </div>

</asp:Content>
