<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin-masterpage.Master" AutoEventWireup="true" CodeBehind="AddBankScheme.aspx.cs" Inherits="Cybersecurity_Framework_for_Rural_Digital_Banking.admin.AddBankScheme" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet" />
<style>
    body, #layoutSidenav_content {
        background: linear-gradient(135deg, #0f2027, #203a43, #2c5364) !important;
        font-family: 'Poppins', sans-serif !important;
        color: #fff !important;
    }

    .page-wrapper {
        padding: 36px 30px 60px;
        min-height: 90vh;
    }

    /* ── Page Header ── */
    .page-header {
        display: flex; align-items: center; gap: 18px;
        margin-bottom: 32px;
        padding-bottom: 22px;
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
        font-size: 13px; color: rgba(200,230,255,0.6);
        margin: 4px 0 0;
    }

    /* ── Glass Card ── */
    .glass-card {
        background: rgba(255,255,255,0.06);
        backdrop-filter: blur(14px);
        -webkit-backdrop-filter: blur(14px);
        border: 1px solid rgba(0,255,213,0.15);
        border-radius: 20px;
        padding: 36px 32px;
        box-shadow: 0 16px 45px rgba(0,0,0,0.5);
        position: relative; overflow: hidden;
    }

    .glass-card::before {
        content: ''; position: absolute; top: -60px; right: -60px;
        width: 220px; height: 220px;
        background: radial-gradient(circle, rgba(0,255,213,0.08) 0%, transparent 70%);
        pointer-events: none;
    }

    /* ── Section Header ── */
    .section-header {
        background: rgba(0,198,213,0.1);
        border-left: 4px solid #00ffd5;
        padding: 9px 16px;
        border-radius: 8px;
        font-weight: 600; color: #00ffd5;
        margin: 0 0 22px; font-size: 13.5px;
        letter-spacing: 0.3px;
    }

    /* ── Labels ── */
    label {
        font-size: 13px !important;
        font-weight: 500 !important;
        color: #cce8ff !important;
        margin-bottom: 7px !important;
        display: block !important;
        font-family: 'Poppins', sans-serif !important;
    }

    /* ── Inputs & Selects ── */
    .form-control, .custom-select {
        background: rgba(255,255,255,0.08) !important;
        border: 1px solid rgba(0,255,213,0.35) !important;
        color: #fff !important;
        height: 46px !important;
        border-radius: 12px !important;
        font-size: 13.5px !important;
        font-family: 'Poppins', sans-serif !important;
        padding: 0 14px !important;
        width: 100% !important;
        transition: border-color 0.3s, box-shadow 0.3s;
        box-sizing: border-box;
    }

    .form-control:focus, .custom-select:focus {
        outline: none !important;
        border-color: #00ffd5 !important;
        box-shadow: 0 0 14px rgba(0,255,213,0.3) !important;
        background: rgba(255,255,255,0.12) !important;
    }

    .form-control::placeholder { color: rgba(255,255,255,0.3) !important; }

    textarea.form-control { height: 100px !important; padding: 12px 14px !important; resize: vertical; }

    select.form-control option { background: #1a2a3a !important; color: #fff !important; }

    /* ── File Input ── */
    .file-input-wrapper {
        background: rgba(255,255,255,0.06) !important;
        border: 1.5px dashed rgba(0,255,213,0.4) !important;
        border-radius: 12px !important;
        padding: 14px !important;
        width: 100%; text-align: center;
        transition: border-color 0.3s;
        cursor: pointer;
    }

    .file-input-wrapper:hover { border-color: #00ffd5 !important; }

    .file-input-wrapper .file-icon { font-size: 24px; display: block; margin-bottom: 6px; }

    .file-input-wrapper span {
        font-size: 12.5px; color: rgba(200,230,255,0.6);
        display: block;
    }

    input[type=file].form-control {
        height: auto !important; padding: 10px 14px !important;
        cursor: pointer;
    }

    /* ── Field Group ── */
    .field-group { margin-bottom: 20px; }

    /* ── Submit ── */
    .btn-submit {
        background: linear-gradient(90deg, #00c6ff, #0072ff) !important;
        border: none !important;
        color: #fff !important;
        font-weight: 600 !important;
        padding: 14px 40px !important;
        border-radius: 30px !important;
        font-size: 15px !important;
        font-family: 'Poppins', sans-serif !important;
        cursor: pointer;
        transition: transform 0.25s, box-shadow 0.25s !important;
        letter-spacing: 0.4px;
        min-width: 180px;
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

    /* ── Row spacing ── */
    .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }

    @media(max-width: 640px) { .form-row { grid-template-columns: 1fr; } }
</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="page-wrapper">

    <!-- Page Header -->
    <div class="page-header">
        <div class="page-header-icon">🏦</div>
        <div class="page-header-text">
            <h2>Add Bank Loan Scheme</h2>
            <p>Create a new loan scheme and make it available to customers</p>
        </div>
    </div>

    <!-- Glass Card -->
    <div class="glass-card">
        <div class="section-header">📋 Scheme Details</div>

        <!-- Row 1: Name & Type -->
        <div class="form-row">
            <div class="field-group">
                <label>Scheme Name</label>
                <asp:TextBox ID="txtSchemeName" CssClass="form-control" placeholder="Enter Scheme Name" runat="server"></asp:TextBox>
            </div>
            <div class="field-group">
                <label>Scheme Type</label>
                <asp:DropDownList ID="ddlschemetype" CssClass="form-control" runat="server">
                    <asp:ListItem Text="Select Scheme Type" Value="" />
                    <asp:ListItem Text="Education Loan"   Value="Education Loan" />
                    <asp:ListItem Text="Home Loan"        Value="Home Loan" />
                    <asp:ListItem Text="Agricultural Loan" Value="Agricultural Loan" />
                    <asp:ListItem Text="Personal Loan"    Value="Personal Loan" />
                    <asp:ListItem Text="Car Loan"         Value="Car Loan" />
                    <asp:ListItem Text="Business Loan"    Value="Business Loan" />
                </asp:DropDownList>
            </div>
        </div>

        <!-- Row 2: Details & Interest -->
        <div class="form-row">
            <div class="field-group">
                <label>Scheme Details</label>
                <asp:TextBox ID="txtschemedetail" CssClass="form-control" placeholder="Enter Scheme Details" runat="server" TextMode="MultiLine"></asp:TextBox>
            </div>
            <div class="field-group">
                <label>Interest Rate (%)</label>
                <asp:TextBox ID="txtinterestrate" CssClass="form-control" placeholder="e.g. 8.5" runat="server" TextMode="SingleLine"></asp:TextBox>
            </div>
        </div>

        <!-- Row 3: Tenure & Loan Amount -->
        <div class="form-row">
            <div class="field-group">
                <label>Tenure (years / months)</label>
                <asp:TextBox ID="txttenure" CssClass="form-control" placeholder="e.g. 5 Years" runat="server" TextMode="SingleLine"></asp:TextBox>
            </div>
            <div class="field-group">
                <label>Loan Amount (₹)</label>
                <asp:TextBox ID="txtloanamount" CssClass="form-control" placeholder="e.g. 500000" runat="server" TextMode="SingleLine"></asp:TextBox>
            </div>
        </div>

        <!-- Row 4: Image -->
        <div class="section-header" style="margin-top:10px;">🖼 Scheme Image</div>
        <div class="field-group" style="max-width: 420px;">
            <label>Upload Image</label>
            <asp:FileUpload ID="FileUpload" CssClass="form-control" runat="server" />
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
            title: "Scheme Added!",
            text: "Bank loan scheme has been saved successfully.",
            icon: "success",
            confirmButtonText: "OK",
            background: '#1a2a3a',
            color: '#fff',
            confirmButtonColor: '#0072ff'
        });
    }
</script>
</asp:Content>
