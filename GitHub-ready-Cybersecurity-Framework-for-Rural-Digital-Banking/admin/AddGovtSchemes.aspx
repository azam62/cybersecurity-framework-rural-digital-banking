<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin-masterpage.Master" AutoEventWireup="true" CodeBehind="AddGovtSchemes.aspx.cs" Inherits="Cybersecurity_Framework_for_Rural_Digital_Banking.admin.AddGovtSchemes" %>

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
        font-size: 26px;
        box-shadow: 0 0 16px rgba(0,255,213,0.15);
    }

    .page-header-text h2 {
        font-size: 22px; font-weight: 700;
        color: #00ffd5; margin: 0;
        text-shadow: 0 0 10px rgba(0,255,213,0.4);
    }

    .page-header-text p {
        font-size: 13px; color: rgba(200,230,255,0.6); margin: 4px 0 0;
    }

    .glass-card {
        background: rgba(255,255,255,0.06);
        backdrop-filter: blur(14px);
        -webkit-backdrop-filter: blur(14px);
        border: 1px solid rgba(0,255,213,0.15);
        border-radius: 20px; padding: 36px 32px;
        box-shadow: 0 16px 45px rgba(0,0,0,0.5);
        position: relative; overflow: hidden;
    }

    .glass-card::before {
        content: ''; position: absolute; top: -60px; right: -60px;
        width: 220px; height: 220px;
        background: radial-gradient(circle, rgba(0,255,213,0.08) 0%, transparent 70%);
        pointer-events: none;
    }

    .section-header {
        background: rgba(0,198,213,0.1);
        border-left: 4px solid #00ffd5;
        padding: 9px 16px; border-radius: 8px;
        font-weight: 600; color: #00ffd5;
        margin: 0 0 22px; font-size: 13.5px;
        letter-spacing: 0.3px;
    }

    label {
        font-size: 13px !important; font-weight: 500 !important;
        color: #cce8ff !important; margin-bottom: 7px !important;
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
        box-sizing: border-box;
    }

    .form-control:focus {
        outline: none !important;
        border-color: #00ffd5 !important;
        box-shadow: 0 0 14px rgba(0,255,213,0.3) !important;
        background: rgba(255,255,255,0.12) !important;
    }

    .form-control::placeholder { color: rgba(255,255,255,0.3) !important; }
    textarea.form-control { height: 100px !important; padding: 12px 14px !important; resize: vertical; }
    select.form-control option { background: #1a2a3a !important; color: #fff !important; }

    input[type=file].form-control { height: auto !important; padding: 10px 14px !important; cursor: pointer; }
    input[type=date].form-control { color-scheme: dark; }

    .field-group { margin-bottom: 20px; }
    .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }

    .validator-msg {
        color: #ff6b6b; font-size: 12px; display: block; margin-top: 4px;
        font-family: 'Poppins', sans-serif;
    }

    .btn-submit {
        background: linear-gradient(90deg, #00c6ff, #0072ff) !important;
        border: none !important; color: #fff !important;
        font-weight: 600 !important; padding: 14px 40px !important;
        border-radius: 30px !important; font-size: 15px !important;
        font-family: 'Poppins', sans-serif !important; cursor: pointer;
        transition: transform 0.25s, box-shadow 0.25s !important;
        letter-spacing: 0.4px; min-width: 180px;
    }

    .btn-submit:hover {
        transform: translateY(-2px) !important;
        box-shadow: 0 0 24px rgba(0,198,255,0.5) !important;
    }

    .submit-row {
        display: flex; justify-content: center;
        padding-top: 12px;
        border-top: 1px solid rgba(0,255,213,0.1);
        margin-top: 28px;
    }

    @media(max-width: 640px) { .form-row { grid-template-columns: 1fr; } }
</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="page-wrapper">

    <!-- Header -->
    <div class="page-header">
        <div class="page-header-icon">🏛</div>
        <div class="page-header-text">
            <h2>Add Government Scheme</h2>
            <p>Register a new government welfare or savings scheme for customers</p>
        </div>
    </div>

    <!-- Card -->
    <div class="glass-card">
        <div class="section-header">📋 Scheme Information</div>

        <!-- Row 1 -->
        <div class="form-row">
            <div class="field-group">
                <label>Scheme Name</label>
                <asp:TextBox ID="txtSchemeName" CssClass="form-control" placeholder="Enter Scheme Name" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtSchemeName"
                    CssClass="validator-msg" ErrorMessage="Please fill this field!" SetFocusOnError="True"></asp:RequiredFieldValidator>
            </div>
            <div class="field-group">
                <label>Scheme Type</label>
                <asp:DropDownList ID="ddlschemetype" CssClass="form-control" runat="server">
                    <asp:ListItem Text="Select Scheme Type" Value="" />
                    <asp:ListItem Text="Subsidy Schemes"              Value="Subsidy Schemes" />
                    <asp:ListItem Text="Pension Schemes"              Value="Pension Schemes" />
                    <asp:ListItem Text="Investment Schemes"           Value="Investment Schemes" />
                    <asp:ListItem Text="Savings Schemes"              Value="Savings Schemes" />
                    <asp:ListItem Text="Insurance Schemes"            Value="Insurance Schemes" />
                    <asp:ListItem Text="Employment & Skill Development" Value="Employment & Skill Development" />
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlschemetype"
                    CssClass="validator-msg" ErrorMessage="Please select a type!" SetFocusOnError="True"></asp:RequiredFieldValidator>
            </div>
        </div>

        <!-- Row 2 -->
        <div class="form-row">
            <div class="field-group">
                <label>Scheme Details</label>
                <asp:TextBox ID="txtschemedetail" CssClass="form-control" placeholder="Enter Scheme Details" runat="server" TextMode="MultiLine"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtschemedetail"
                    CssClass="validator-msg" ErrorMessage="Please fill this field!" SetFocusOnError="True"></asp:RequiredFieldValidator>
            </div>
            <div class="field-group">
                <label>Benefit Amount (₹)</label>
                <asp:TextBox ID="txtAmount" CssClass="form-control" placeholder="e.g. 50000" runat="server" TextMode="SingleLine"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtAmount"
                    CssClass="validator-msg" ErrorMessage="Please fill this field!" SetFocusOnError="True"></asp:RequiredFieldValidator>
            </div>
        </div>

        <!-- Row 3: Dates -->
        <div class="section-header" style="margin-top:10px;">📅 Application Window</div>
        <div class="form-row">
            <div class="field-group">
                <label>Application Start Date</label>
                <asp:TextBox ID="txtstartdate" CssClass="form-control" runat="server" type="date"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtstartdate"
                    CssClass="validator-msg" ErrorMessage="Please select a start date!" SetFocusOnError="True"></asp:RequiredFieldValidator>
            </div>
            <div class="field-group">
                <label>Application End Date</label>
                <asp:TextBox ID="txtEndDate" CssClass="form-control" runat="server" type="date"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtEndDate"
                    CssClass="validator-msg" ErrorMessage="Please select an end date!" SetFocusOnError="True"></asp:RequiredFieldValidator>
            </div>
        </div>

        <!-- Row 4: Image -->
        <div class="section-header" style="margin-top:10px;">🖼 Scheme Image</div>
        <div class="field-group" style="max-width: 420px;">
            <label>Upload Image</label>
            <asp:FileUpload ID="FileUpload1" CssClass="form-control" runat="server" />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="FileUpload1"
                CssClass="validator-msg" ErrorMessage="Please select an image!" SetFocusOnError="True"></asp:RequiredFieldValidator>
        </div>

        <!-- Submit -->
        <div class="submit-row">
            <asp:Button ID="Button1" runat="server" CssClass="btn-submit" Text="💾 Save Scheme" OnClick="Button1_Click" />
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
    function showSuccessPopup() {
        Swal.fire({
            title: "Success!",
            text: "Government scheme has been added successfully.",
            icon: "success",
            confirmButtonText: "OK",
            background: '#1a2a3a',
            color: '#fff',
            confirmButtonColor: '#0072ff'
        }).then((result) => {
            if (result.isConfirmed) window.location.href = "";
        });
    }
</script>
</asp:Content>
