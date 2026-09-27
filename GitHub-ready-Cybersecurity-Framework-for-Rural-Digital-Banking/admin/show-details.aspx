<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin-masterpage.Master" AutoEventWireup="true" CodeBehind="show-details.aspx.cs" Inherits="Cybersecurity_Framework_for_Rural_Digital_Banking.admin.show_details" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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
        outline: none !important; border-color: #00ffd5 !important;
        box-shadow: 0 0 14px rgba(0,255,213,0.3) !important;
        background: rgba(255,255,255,0.12) !important;
    }
    .form-control:disabled {
        background: rgba(255,255,255,0.04) !important;
        border-color: rgba(0,255,213,0.15) !important;
        color: rgba(200,230,255,0.6) !important;
    }
    /* Enabled reason box */
    .form-control:not(:disabled) {
        background: rgba(255,255,255,0.1) !important;
        border-color: rgba(0,255,213,0.5) !important;
    }
    textarea.form-control { height: 90px !important; padding: 12px 14px !important; }
    .field-group { margin-bottom: 18px; }
    .two-col { display: grid; grid-template-columns: 1fr 1fr; gap: 28px; }
    .radio-row { display: flex; flex-direction: column; gap: 8px; padding-top: 6px; }
    .radio-row label {
        display: flex !important; align-items: center; gap: 8px;
        font-weight: 400 !important; color: rgba(200,230,255,0.8) !important; cursor: default;
    }
    .radio-row input[type=radio] { accent-color: #00ffd5; }
    .photo-docs-box {
        background: rgba(0,0,0,0.25);
        border: 1px solid rgba(0,255,213,0.15);
        border-radius: 14px; padding: 22px; text-align: center;
    }
    .photo-docs-box img {
        border-radius: 12px;
        border: 2px solid rgba(0,255,213,0.35);
        box-shadow: 0 0 16px rgba(0,255,213,0.15);
        max-width: 180px; max-height: 180px; object-fit: cover; margin-bottom: 18px;
    }
    .doc-link-row {
        display: flex; align-items: center; justify-content: space-between;
        padding: 10px 14px;
        background: rgba(255,255,255,0.05);
        border: 1px solid rgba(0,255,213,0.12);
        border-radius: 10px; margin-bottom: 10px; font-size: 13px;
    }
    .doc-link-row span { color: rgba(200,230,255,0.7); }
    .doc-link-row a {
        color: #00ffd5; text-decoration: none; font-weight: 600; font-size: 12.5px;
        padding: 4px 14px; background: rgba(0,255,213,0.1);
        border: 1px solid rgba(0,255,213,0.3); border-radius: 20px; transition: background 0.2s;
    }
    .doc-link-row a:hover { background: rgba(0,255,213,0.2); }
    .action-row {
        display: flex; gap: 16px; justify-content: center;
        margin-top: 32px; padding-top: 24px;
        border-top: 1px solid rgba(0,255,213,0.12);
    }
    .btn-approve {
        background: linear-gradient(90deg, #11998e, #38ef7d) !important;
        border: none !important; color: #fff !important;
        font-weight: 700 !important; padding: 13px 36px !important;
        border-radius: 30px !important; font-size: 14px !important;
        font-family: 'Poppins', sans-serif !important; cursor: pointer;
        transition: transform 0.25s, box-shadow 0.25s !important; min-width: 180px;
    }
    .btn-approve:hover { transform: translateY(-2px) !important; box-shadow: 0 0 22px rgba(56,239,125,0.45) !important; }
    .btn-reject {
        background: linear-gradient(90deg, #c0392b, #e74c3c) !important;
        border: none !important; color: #fff !important;
        font-weight: 700 !important; padding: 13px 36px !important;
        border-radius: 30px !important; font-size: 14px !important;
        font-family: 'Poppins', sans-serif !important; cursor: pointer;
        transition: transform 0.25s, box-shadow 0.25s !important; min-width: 180px;
    }
    .btn-reject:hover { transform: translateY(-2px) !important; box-shadow: 0 0 22px rgba(231,76,60,0.45) !important; }
    .status-label { display: block; margin-top: 14px; font-size: 14px; font-weight: 600; text-align: center; }
    @media(max-width: 640px) { .two-col { grid-template-columns: 1fr; } .action-row { flex-direction: column; } }
</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <asp:HiddenField ID="hfCustomerID" runat="server" />

    <div class="page-wrapper">

        <div class="page-header">
            <div class="page-header-icon">📋</div>
            <div class="page-header-text">
                <h2>Customer Details</h2>
                <p>Review complete profile and take an approval decision</p>
            </div>
        </div>

        <div class="glass-card">
            <div class="two-col">

                <!-- Left: Info -->
                <div>
                    <div class="section-header">👤 Personal Information</div>
                    <div class="field-group"><label>First Name</label>
                        <asp:TextBox ID="txtFirstName" CssClass="form-control" runat="server" Enabled="false"></asp:TextBox></div>
                    <div class="field-group"><label>Middle Name</label>
                        <asp:TextBox ID="txtMiddleName" CssClass="form-control" runat="server" Enabled="false"></asp:TextBox></div>
                    <div class="field-group"><label>Last Name</label>
                        <asp:TextBox ID="txtLastName" CssClass="form-control" runat="server" Enabled="false"></asp:TextBox></div>
                    <div class="field-group"><label>Mobile</label>
                        <asp:TextBox ID="txtMobile" CssClass="form-control" runat="server" Enabled="false"></asp:TextBox></div>
                    <div class="field-group"><label>Email</label>
                        <asp:TextBox ID="txtEmail" CssClass="form-control" runat="server" Enabled="false"></asp:TextBox></div>
                    <div class="field-group"><label>Date of Birth</label>
                        <asp:TextBox ID="txtDOB" runat="server" CssClass="form-control" type="date" Enabled="false"></asp:TextBox></div>
                    <div class="field-group">
                        <label>Gender</label>
                        <div class="radio-row">
                            <label><asp:RadioButton ID="rbtnMale" runat="server" GroupName="gender" Text="Male" Enabled="false" /> Male</label>
                            <label><asp:RadioButton ID="rbtnFemale" runat="server" GroupName="gender" Text="Female" Enabled="false" /> Female</label>
                            <label><asp:RadioButton ID="rbtnNA" runat="server" GroupName="gender" Text="Not ready to disclose" Enabled="false" /> Prefer not to say</label>
                        </div>
                    </div>
                    <div class="field-group"><label>Address</label>
                        <asp:TextBox ID="txtAddress" CssClass="form-control" runat="server" TextMode="MultiLine" Enabled="false"></asp:TextBox></div>
                    <div class="field-group"><label>City</label>
                        <asp:TextBox ID="txtCity" CssClass="form-control" runat="server" Enabled="false"></asp:TextBox></div>
                    <div class="field-group"><label>State</label>
                        <asp:TextBox ID="txtState" CssClass="form-control" runat="server" Enabled="false"></asp:TextBox></div>

                    <div class="section-header" style="margin-top:24px;">🔐 Account Info</div>
                    <div class="field-group"><label>Username</label>
                        <asp:TextBox ID="txtUsername" CssClass="form-control" runat="server" Enabled="false"></asp:TextBox></div>
                    <div class="field-group"><label>Password</label>
                        <asp:TextBox ID="txtPassword" CssClass="form-control" runat="server" Enabled="false"></asp:TextBox></div>
                    <div class="field-group"><label>Account Number</label>
                        <asp:TextBox ID="txtAccountNo" CssClass="form-control" runat="server" Enabled="false"></asp:TextBox></div>
                    <div class="field-group"><label>Status</label>
                        <asp:TextBox ID="txtstatus" CssClass="form-control" runat="server" Enabled="false"></asp:TextBox></div>
                    <div class="field-group">
                        <label>Reason / Admin Notes</label>
                        <asp:TextBox ID="txtreason" CssClass="form-control" runat="server" Enabled="true" Visible="true" TextMode="MultiLine" placeholder="Add a note or reason..."></asp:TextBox>
                        <asp:Label ID="Label1" runat="server" Text="lblmessage" Visible="False"></asp:Label>
                    </div>
                </div>

                <!-- Right: Photo & Docs -->
                <div>
                    <div class="section-header">🖼 Profile Photo</div>
                    <div class="photo-docs-box">
                        <asp:Image ID="imgPhoto" runat="server" Height="180px" Width="180px" />
                        <div class="section-header" style="margin-top:20px; text-align:left;">📁 Documents</div>
                        <div class="doc-link-row">
                            <span>Aadhar Card</span>
                            <asp:HyperLink ID="hplkAadhar" runat="server">View Aadhar</asp:HyperLink>
                        </div>
                        <div class="doc-link-row">
                            <span>PAN Card</span>
                            <asp:HyperLink ID="hplkPAN" runat="server">View PAN</asp:HyperLink>
                        </div>
                        <div class="doc-link-row">
                            <span>Signature</span>
                            <asp:HyperLink ID="hplkSignature" runat="server">View Signature</asp:HyperLink>
                        </div>
                    </div>
                </div>

            </div>

            <!-- Action Buttons -->
            <div class="action-row">
                <asp:Button ID="btnApprove" runat="server"
                    Text="✅ Approve Customer"
                    CssClass="btn-approve"
                    OnClientClick="return confirm('Are you sure you want to approve this customer?')"
                    OnClick="btnApprove_Click" />
                <asp:Button ID="btnNotApprove" runat="server"
                    Text="❌ Do Not Approve"
                    CssClass="btn-reject"
                    OnClick="btnNotApprove_Click" />
            </div>

            <asp:Label ID="lblSubmit" runat="server" Text="" CssClass="status-label"></asp:Label>
        </div>
    </div>

</asp:Content>
