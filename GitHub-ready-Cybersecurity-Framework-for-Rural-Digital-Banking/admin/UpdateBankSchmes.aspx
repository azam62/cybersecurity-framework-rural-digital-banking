<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin-masterpage.Master" AutoEventWireup="true" CodeBehind="UpdateBankSchmes.aspx.cs" Inherits="Cybersecurity_Framework_for_Rural_Digital_Banking.admin.UpdateBankSchmes" %>

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
    .glass-card {
        background: rgba(255,255,255,0.06);
        backdrop-filter: blur(14px);
        border: 1px solid rgba(0,255,213,0.15);
        border-radius: 20px; padding: 36px 32px;
        box-shadow: 0 16px 45px rgba(0,0,0,0.5);
        max-width: 720px; position: relative; overflow: hidden;
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
    }
    label, .form-label {
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
        transition: border-color 0.3s, box-shadow 0.3s; box-sizing: border-box;
    }
    .form-control:focus {
        outline: none !important; border-color: #00ffd5 !important;
        box-shadow: 0 0 14px rgba(0,255,213,0.3) !important;
        background: rgba(255,255,255,0.12) !important;
    }
    .form-control::placeholder { color: rgba(255,255,255,0.3) !important; }
    textarea.form-control { height: 110px !important; padding: 12px 14px !important; resize: vertical; }
    input[type=file].form-control { height: auto !important; padding: 10px 14px !important; cursor: pointer; }
    .field-group { margin-bottom: 20px; }
    .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
    /* Image preview */
    .image-preview-wrap {
        background: rgba(0,0,0,0.25);
        border: 1px solid rgba(0,255,213,0.15);
        border-radius: 12px; padding: 16px;
        text-align: center; margin-bottom: 20px;
    }
    .image-preview {
        border-radius: 10px;
        border: 2px solid rgba(0,255,213,0.3);
        box-shadow: 0 0 14px rgba(0,255,213,0.1);
        max-width: 140px; max-height: 100px; object-fit: cover;
    }
    .image-preview-wrap .img-label {
        font-size: 12px; color: rgba(200,230,255,0.5);
        margin-bottom: 10px; display: block;
    }
    .btn-update {
        background: linear-gradient(90deg, #00c6ff, #0072ff) !important;
        border: none !important; color: #fff !important;
        font-weight: 600 !important; padding: 14px 40px !important;
        border-radius: 30px !important; font-size: 15px !important;
        font-family: 'Poppins', sans-serif !important; cursor: pointer;
        transition: transform 0.25s, box-shadow 0.25s !important;
        letter-spacing: 0.4px; min-width: 200px;
    }
    .btn-update:hover { transform: translateY(-2px) !important; box-shadow: 0 0 24px rgba(0,198,255,0.5) !important; }
    .submit-row {
        display: flex; justify-content: center;
        padding-top: 12px; border-top: 1px solid rgba(0,255,213,0.1); margin-top: 28px;
    }
    @media(max-width: 640px) { .form-row { grid-template-columns: 1fr; } }
</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="page-wrapper">

    <div class="page-header">
        <div class="page-header-icon">✏️</div>
        <div class="page-header-text">
            <h2>Update Bank Loan Scheme</h2>
            <p>Edit and save changes to an existing loan scheme</p>
        </div>
    </div>

    <div class="glass-card">
        <div class="section-header">📋 Scheme Details</div>

        <div class="form-row">
            <div class="field-group">
                <label class="form-label">Scheme Name</label>
                <asp:TextBox ID="txtSchemeName" runat="server" CssClass="form-control" />
            </div>
            <div class="field-group">
                <label class="form-label">Scheme Type</label>
                <asp:TextBox ID="txtSchemeType" runat="server" CssClass="form-control" />
            </div>
        </div>

        <div class="field-group">
            <label class="form-label">Description</label>
            <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" />
        </div>

        <div class="form-row">
            <div class="field-group">
                <label class="form-label">Interest Rate (%)</label>
                <asp:TextBox ID="txtrate" runat="server" CssClass="form-control" />
            </div>
            <div class="field-group">
                <label class="form-label">Amount (₹)</label>
                <asp:TextBox ID="txtamount" runat="server" CssClass="form-control" TextMode="SingleLine" />
            </div>
        </div>

        <div class="field-group">
            <label class="form-label">Tenure</label>
            <asp:TextBox ID="txttenure" runat="server" CssClass="form-control" TextMode="SingleLine" />
        </div>

        <div class="section-header" style="margin-top:8px;">🖼 Scheme Image</div>

        <div class="image-preview-wrap">
            <span class="img-label">Current Image</span>
            <asp:Image ID="imgPreview" runat="server" CssClass="image-preview" Width="140px" Height="95px" />
            <asp:HiddenField ID="hiddenPhoto" runat="server" />
        </div>

        <div class="field-group">
            <label class="form-label">Upload New Image (Optional)</label>
            <asp:FileUpload ID="fileUploadPhoto" runat="server" CssClass="form-control" />
        </div>

        <div class="submit-row">
            <asp:Button ID="btnUpdate" runat="server" CssClass="btn-update" Text="💾 Update Scheme" OnClick="btnUpdate_Click" />
        </div>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
    function showSuccessPopup() {
        Swal.fire({
            title: "Updated Successfully!",
            text: "Bank loan scheme has been updated.",
            icon: "success",
            confirmButtonText: "OK",
            background: '#1a2a3a', color: '#fff', confirmButtonColor: '#0072ff'
        }).then(() => { window.location.href = "UpdateBankSchmes.aspx"; });
    }
</script>
</asp:Content>
