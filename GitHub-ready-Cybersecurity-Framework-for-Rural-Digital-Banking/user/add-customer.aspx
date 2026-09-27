<%@ Page Title="" Language="C#" MasterPageFile="~/user/user-masterpage.Master" AutoEventWireup="true" CodeBehind="add-customer.aspx.cs" Inherits="Cybersecurity_Framework_for_Rural_Digital_Banking.user.add_customer" %>

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
        position: relative; overflow: hidden; margin-bottom: 24px;
    }
    .glass-card::before {
        content: ''; position: absolute; top: -60px; right: -60px;
        width: 200px; height: 200px;
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
        background: rgba(255,255,255,0.08) !important;
        border: 1px solid rgba(0,255,213,0.35) !important;
        color: #fff !important; height: 46px !important;
        border-radius: 12px !important; font-size: 13.5px !important;
        font-family: 'Poppins', sans-serif !important;
        padding: 0 14px !important; width: 100% !important;
        transition: border-color 0.3s, box-shadow 0.3s;
        box-sizing: border-box !important; margin-top: 0 !important;
    }
    .form-control:focus {
        outline: none !important; border-color: #00ffd5 !important;
        box-shadow: 0 0 14px rgba(0,255,213,0.3) !important;
        background: rgba(255,255,255,0.12) !important;
    }
    .form-control::placeholder { color: rgba(255,255,255,0.3) !important; }
    textarea.form-control { height: 90px !important; padding: 12px 14px !important; resize: vertical; }
    input[type=date].form-control { color-scheme: dark; }
    input[type=file].form-control { height: auto !important; padding: 10px 14px !important; cursor: pointer; }
    .field-group { margin-bottom: 18px; }
    .two-col { display: grid; grid-template-columns: 1fr 1fr; gap: 28px; }
    /* Radio */
    .radio-row { display: flex; flex-direction: column; gap: 9px; padding-top: 4px; }
    .radio-row label {
        display: flex !important; align-items: center; gap: 9px;
        font-weight: 400 !important; color: rgba(200,230,255,0.8) !important; cursor: pointer;
    }
    .radio-row input[type=radio] { accent-color: #00ffd5; width: 15px; height: 15px; flex-shrink: 0; }
    /* File upload */
    .file-upload-box {
        background: rgba(0,0,0,0.2);
        border: 1px dashed rgba(0,255,213,0.3);
        border-radius: 12px; padding: 16px;
        transition: border-color 0.2s;
    }
    .file-upload-box:hover { border-color: rgba(0,255,213,0.6); }
    /* Save button */
    .btn-save {
        background: linear-gradient(90deg, #00c6ff, #0072ff) !important;
        border: none !important; color: #fff !important;
        font-weight: 600 !important; padding: 14px 50px !important;
        border-radius: 30px !important; font-size: 15px !important;
        font-family: 'Poppins', sans-serif !important; cursor: pointer;
        transition: transform 0.25s, box-shadow 0.25s !important;
        letter-spacing: 0.4px;
    }
    .btn-save:hover { transform: translateY(-2px) !important; box-shadow: 0 0 24px rgba(0,198,255,0.5) !important; }
    .submit-row { display: flex; justify-content: center; padding-top: 12px; }
    .label-msg { display: block; text-align: center; margin-top: 12px; font-size: 14px; font-weight: 600; }
    @media(max-width: 640px) { .two-col { grid-template-columns: 1fr; } }
</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="page-wrapper">

    <div class="page-header">
        <div class="page-header-icon">📝</div>
        <div class="page-header-text">
            <h2>Customer Registration</h2>
            <p>Fill in all required details to register a new customer</p>
        </div>
    </div>

    <!-- Personal Info + Photo -->
    <div class="glass-card">
        <div class="two-col">

            <!-- Left: Personal Info -->
            <div>
                <div class="section-header">👤 Personal Information</div>

                <div class="field-group">
                    <label>First Name</label>
                    <asp:TextBox ID="txtFirstName" CssClass="form-control" runat="server" placeholder="Enter first name"></asp:TextBox>
                </div>
                <div class="field-group">
                    <label>Middle Name</label>
                    <asp:TextBox ID="txtMiddleName" CssClass="form-control" runat="server" placeholder="Enter middle name"></asp:TextBox>
                </div>
                <div class="field-group">
                    <label>Last Name</label>
                    <asp:TextBox ID="txtLastName" CssClass="form-control" runat="server" placeholder="Enter last name"></asp:TextBox>
                </div>
                <div class="field-group">
                    <label>Mobile</label>
                    <asp:TextBox ID="txtMobile" CssClass="form-control" runat="server" placeholder="Enter mobile number"></asp:TextBox>
                </div>
                <div class="field-group">
                    <label>Email</label>
                    <asp:TextBox ID="txtEmail" CssClass="form-control" runat="server" placeholder="Enter email address"></asp:TextBox>
                </div>
                <div class="field-group">
                    <label>Date of Birth</label>
                    <input type="date" id="txtDOB" name="DOB" class="form-control" required />
                </div>
                <div class="field-group">
                    <label>Gender</label>
                    <div class="radio-row">
                        <label><asp:RadioButton ID="rbtnMale" runat="server" GroupName="gender" /> Male</label>
                        <label><asp:RadioButton ID="rbtnFemale" runat="server" GroupName="gender" /> Female</label>
                        <label><asp:RadioButton ID="rbtnNA" runat="server" GroupName="gender" /> Prefer not to say</label>
                    </div>
                </div>
                <div class="field-group">
                    <label>Address</label>
                    <asp:TextBox ID="txtAddress" CssClass="form-control" runat="server" TextMode="MultiLine" placeholder="Enter address"></asp:TextBox>
                </div>
                <div class="field-group">
                    <label>City</label>
                    <asp:TextBox ID="txtCity" CssClass="form-control" runat="server" placeholder="Enter city"></asp:TextBox>
                </div>
                <div class="field-group">
                    <label>State</label>
                    <asp:TextBox ID="txtState" CssClass="form-control" runat="server" placeholder="Enter state"></asp:TextBox>
                </div>
                <div class="field-group">
                    <label>Username</label>
                    <asp:TextBox ID="txtUsername" CssClass="form-control" runat="server" placeholder="Choose a username"></asp:TextBox>
                </div>
                <div class="field-group">
                    <label>Password</label>
                    <asp:TextBox ID="txtPassword" CssClass="form-control" runat="server" TextMode="Password" placeholder="Choose a password"></asp:TextBox>
                </div>
            </div>

            <!-- Right: Photo Upload -->
            <div>
                <div class="section-header">📸 Profile Photo</div>
                <div class="file-upload-box">
                    <label style="margin-bottom:10px !important;">Upload Profile Photo</label>
                    <asp:FileUpload ID="fuPhoto" runat="server" CssClass="form-control" />
                    <asp:Label ID="lblPhoto" runat="server" Text="" CssClass="label-msg"></asp:Label>
                </div>
            </div>

        </div>
    </div>

    <!-- Documents -->
    <div class="glass-card">
        <div class="section-header">📁 Identity Documents</div>
        <div class="two-col">
            <div class="field-group">
                <label>Aadhar Card</label>
                <div class="file-upload-box">
                    <asp:FileUpload ID="fuAadhar" runat="server" CssClass="form-control" />
                </div>
            </div>
            <div class="field-group">
                <label>PAN Card</label>
                <div class="file-upload-box">
                    <asp:FileUpload ID="fuPAN" runat="server" CssClass="form-control" />
                </div>
            </div>
            <div class="field-group">
                <label>Signature</label>
                <div class="file-upload-box">
                    <asp:FileUpload ID="fuSign" runat="server" CssClass="form-control" />
                </div>
            </div>
        </div>
    </div>

    <!-- Submit -->
    <div class="submit-row">
        <asp:Button ID="btnSave" runat="server" Text="💾 Save All Information"
            CssClass="btn-save" OnClick="btnSave_Click" />
    </div>
    <asp:Label ID="lblSubmit" runat="server" Text="" CssClass="label-msg"></asp:Label>

</div>
</asp:Content>