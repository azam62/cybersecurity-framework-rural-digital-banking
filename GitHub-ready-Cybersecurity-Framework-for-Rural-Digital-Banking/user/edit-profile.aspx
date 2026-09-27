<%@ Page Title="" Language="C#" MasterPageFile="~/user/user-masterpage.Master" AutoEventWireup="true" CodeBehind="edit-profile.aspx.cs" Inherits="Cybersecurity_Framework_for_Rural_Digital_Banking.user.edit_profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<style>
    #particles-canvas {
        position: fixed; top: 0; left: 0; width: 100%; height: 100%;
        pointer-events: none; z-index: 0;
    }
    .ep-page {
        position: relative; z-index: 1;
        padding: 36px 32px;
        min-height: 100vh;
        font-family: 'Poppins', sans-serif;
    }
    .ep-page::before {
        content: '';
        position: fixed; top: 40%; left: 50%;
        transform: translate(-50%,-50%);
        width: 700px; height: 700px;
        background: radial-gradient(circle, rgba(0,255,213,0.06) 0%, transparent 68%);
        pointer-events: none; z-index: 0;
    }

    /* Header */
    .ep-header { display: flex; align-items: center; gap: 14px; margin-bottom: 28px; }
    .ep-header-icon {
        width: 46px; height: 46px; border-radius: 12px;
        background: linear-gradient(135deg, rgba(0,255,213,0.16), rgba(0,255,213,0.04));
        border: 1px solid rgba(0,255,213,0.32);
        display: flex; align-items: center; justify-content: center; font-size: 22px;
        box-shadow: 0 0 18px rgba(0,255,213,0.13);
    }
    .ep-header-title { font-size: 24px; font-weight: 700; color: #00ffd5;
                       text-shadow: 0 0 18px rgba(0,255,213,0.42); }
    .ep-header-sub { font-size: 11px; color: rgba(0,255,213,0.45);
                     letter-spacing: 1.5px; text-transform: uppercase; }

    /* Warning banner */
    .ep-banner {
        display: flex; align-items: flex-start; gap: 12px;
        background: rgba(255,100,100,0.07);
        border: 1px solid rgba(255,100,100,0.2);
        border-radius: 14px;
        padding: 14px 18px;
        margin-bottom: 26px;
        animation: cardIn 0.4s ease both;
    }
    .ep-banner-icon { font-size: 18px; flex-shrink: 0; }
    .ep-banner-text { font-size: 13px; line-height: 1.65; color: rgba(255,180,180,0.88); }
    .ep-banner-text strong { color: #ff8080; }

    @keyframes cardIn {
        from { opacity: 0; transform: translateY(14px); }
        to   { opacity: 1; transform: translateY(0); }
    }

    /* Grid */
    .ep-grid {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 24px;
        margin-bottom: 24px;
    }
    @media (max-width: 900px) { .ep-grid { grid-template-columns: 1fr; } }
    .ep-grid-full { grid-column: 1 / -1; }

    /* Glass card */
    .ep-card {
        background: rgba(255,255,255,0.05);
        backdrop-filter: blur(18px);
        -webkit-backdrop-filter: blur(18px);
        border: 1px solid rgba(0,255,213,0.14);
        border-radius: 18px;
        padding: 28px;
        box-shadow: 0 8px 40px rgba(0,0,0,0.4), inset 0 1px 0 rgba(255,255,255,0.06);
        transition: border-color 0.3s;
        animation: cardIn 0.5s ease both;
    }
    .ep-card:nth-child(1) { animation-delay: 0.05s; }
    .ep-card:nth-child(2) { animation-delay: 0.12s; }
    .ep-card:nth-child(3) { animation-delay: 0.18s; }
    .ep-card:nth-child(4) { animation-delay: 0.24s; }
    .ep-card:hover { border-color: rgba(0,255,213,0.28); }

    .ep-card-title {
        font-size: 10.5px; font-weight: 700;
        letter-spacing: 2px; text-transform: uppercase;
        color: rgba(0,255,213,0.52); margin-bottom: 20px;
        display: flex; align-items: center; gap: 8px;
    }
    .ep-card-title::before {
        content: ''; width: 3px; height: 13px; border-radius: 3px;
        background: linear-gradient(180deg, #00ffd5, rgba(0,255,213,0.15));
        display: inline-block;
    }

    /* Form row */
    .ep-field { margin-bottom: 16px; }
    .ep-label {
        display: block; font-size: 10.5px; font-weight: 600;
        letter-spacing: 1.3px; text-transform: uppercase;
        color: rgba(0,255,213,0.48); margin-bottom: 7px;
    }
    .ep-input-wrap { position: relative; }
    .ep-input-wrap .fi {
        position: absolute; left: 12px; top: 50%; transform: translateY(-50%);
        color: rgba(0,255,213,0.3); font-size: 12px; pointer-events: none;
    }
    .ep-textbox, .ep-textarea {
        width: 100% !important;
        background: rgba(0,0,0,0.28) !important;
        border: 1px solid rgba(0,255,213,0.16) !important;
        border-radius: 9px !important;
        color: #fff !important;
        font-family: 'Poppins', sans-serif !important;
        font-size: 13px !important;
        padding: 0 12px 0 36px !important;
        outline: none !important;
        transition: border-color 0.25s, box-shadow 0.25s !important;
        box-sizing: border-box !important;
    }
    .ep-textbox { height: 40px !important; }
    .ep-textarea { height: 80px !important; padding-top: 10px !important; resize: vertical !important; }
    .ep-textbox:focus, .ep-textarea:focus {
        border-color: rgba(0,255,213,0.4) !important;
        box-shadow: 0 0 0 3px rgba(0,255,213,0.07) !important;
    }
    .ep-textbox[disabled], .ep-textbox:disabled { opacity: 0.5 !important; cursor: not-allowed !important; }

    /* Radio group */
    .ep-radio-group { display: flex; flex-direction: column; gap: 8px; padding: 4px 0; }
    .ep-radio-label {
        display: flex; align-items: center; gap: 10px;
        font-size: 13px; color: rgba(185,222,255,0.78); cursor: pointer;
    }
    .ep-radio-label input[type="radio"] { accent-color: #00ffd5; width: 15px; height: 15px; }

    /* Photo preview */
    .ep-photo-wrap {
        display: flex; flex-direction: column; align-items: center; gap: 14px;
    }
    .ep-photo-frame {
        width: 130px; height: 130px; border-radius: 50%;
        border: 2px solid rgba(0,255,213,0.3);
        overflow: hidden;
        box-shadow: 0 0 20px rgba(0,255,213,0.12);
        background: rgba(0,0,0,0.3);
        display: flex; align-items: center; justify-content: center;
    }
    .ep-photo-frame img { width: 100%; height: 100%; object-fit: cover; }
    .ep-file-upload {
        width: 100% !important;
        background: rgba(0,0,0,0.25) !important;
        border: 1px solid rgba(0,255,213,0.16) !important;
        border-radius: 9px !important;
        color: rgba(185,222,255,0.7) !important;
        font-family: 'Poppins', sans-serif !important;
        font-size: 12px !important;
        padding: 8px 10px !important;
        box-sizing: border-box !important;
    }
    .ep-note-text { font-size: 11.5px; color: rgba(255,180,100,0.75); text-align: center; line-height: 1.5; }

    /* Document row */
    .ep-doc-row {
        display: grid; grid-template-columns: 1fr 1fr auto; gap: 12px;
        align-items: end; padding: 14px 0;
        border-bottom: 1px solid rgba(255,255,255,0.05);
    }
    .ep-doc-row:last-child { border-bottom: none; }
    .ep-view-link {
        color: rgba(0,255,213,0.6) !important;
        font-size: 12px !important; text-decoration: none !important;
        white-space: nowrap;
        display: flex; align-items: center; gap: 5px;
        transition: color 0.2s;
    }
    .ep-view-link:hover { color: #00ffd5 !important; }

    /* Buttons */
    .ep-btn {
        height: 36px !important;
        background: linear-gradient(135deg, #0066cc, #0044aa) !important;
        border: 1px solid rgba(0,255,213,0.15) !important;
        border-radius: 9px !important;
        color: #fff !important;
        font-family: 'Poppins', sans-serif !important;
        font-size: 12.5px !important; font-weight: 600 !important;
        cursor: pointer !important; padding: 0 16px !important;
        transition: transform 0.2s, box-shadow 0.2s !important;
        box-shadow: 0 3px 12px rgba(0,80,200,0.3) !important;
        white-space: nowrap !important;
    }
    .ep-btn:hover {
        transform: translateY(-1px) !important;
        box-shadow: 0 6px 20px rgba(0,100,220,0.45) !important;
    }
    .ep-btn-save {
        width: 100% !important; height: 48px !important;
        font-size: 14px !important;
        background: linear-gradient(135deg, #0077ee, #0055cc) !important;
        box-shadow: 0 4px 18px rgba(0,100,220,0.38) !important;
        margin-top: 4px !important;
    }
    .ep-btn-save:hover { box-shadow: 0 8px 28px rgba(0,120,240,0.5) !important; transform: translateY(-2px) !important; }

    .ep-status { margin-top: 14px; font-size: 13px; text-align: center; min-height: 20px; color: #00ffd5; }
    .ep-lbl-msg { font-size: 12px; color: rgba(0,255,213,0.7); display: block; margin-top: 6px; }
</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <canvas id="particles-canvas"></canvas>

    <div class="ep-page">

        <asp:HiddenField ID="hfCustomerID" runat="server" />

        <!-- Header -->
        <div class="ep-header">
            <div class="ep-header-icon">👤</div>
            <div>
                <div class="ep-header-title">Edit Profile</div>
                <div class="ep-header-sub">Manage your personal information</div>
            </div>
        </div>

        <!-- Warning banner -->
        <div class="ep-banner">
            <span class="ep-banner-icon">ℹ️</span>
            <div class="ep-banner-text">
                <strong>Note:</strong> To update your Aadhar, PAN, Signature, or Photo, please use the dedicated upload buttons for each document individually. Clicking <em>Save All Information</em> updates only your personal details.
            </div>
        </div>

        <div class="ep-grid">

            <!-- Personal Info -->
            <div class="ep-card">
                <div class="ep-card-title">Personal Information</div>

                <div class="ep-field">
                    <label class="ep-label">First Name</label>
                    <div class="ep-input-wrap">
                        <span class="fi"><i class="fas fa-user"></i></span>
                        <asp:TextBox ID="txtFirstName" runat="server" CssClass="ep-textbox" />
                    </div>
                </div>
                <div class="ep-field">
                    <label class="ep-label">Middle Name</label>
                    <div class="ep-input-wrap">
                        <span class="fi"><i class="fas fa-user"></i></span>
                        <asp:TextBox ID="txtMiddleName" runat="server" CssClass="ep-textbox" />
                    </div>
                </div>
                <div class="ep-field">
                    <label class="ep-label">Last Name</label>
                    <div class="ep-input-wrap">
                        <span class="fi"><i class="fas fa-user"></i></span>
                        <asp:TextBox ID="txtLastName" runat="server" CssClass="ep-textbox" />
                    </div>
                </div>
                <div class="ep-field">
                    <label class="ep-label">Mobile</label>
                    <div class="ep-input-wrap">
                        <span class="fi"><i class="fas fa-mobile-alt"></i></span>
                        <asp:TextBox ID="txtMobile" runat="server" CssClass="ep-textbox" />
                    </div>
                </div>
                <div class="ep-field">
                    <label class="ep-label">Email</label>
                    <div class="ep-input-wrap">
                        <span class="fi"><i class="fas fa-envelope"></i></span>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="ep-textbox" Enabled="false" />
                    </div>
                </div>
                <div class="ep-field">
                    <label class="ep-label">Date of Birth</label>
                    <div class="ep-input-wrap">
                        <span class="fi"><i class="fas fa-calendar"></i></span>
                        <asp:TextBox ID="txtDOB" runat="server" CssClass="ep-textbox" type="date" />
                    </div>
                </div>
                <div class="ep-field">
                    <label class="ep-label">Gender</label>
                    <div class="ep-radio-group">
                        <label class="ep-radio-label">
                            <asp:RadioButton ID="rbtnMale" runat="server" GroupName="gender" />&nbsp;Male
                        </label>
                        <label class="ep-radio-label">
                            <asp:RadioButton ID="rbtnFemale" runat="server" GroupName="gender" />&nbsp;Female
                        </label>
                        <label class="ep-radio-label">
                            <asp:RadioButton ID="rbtnNA" runat="server" GroupName="gender" />&nbsp;Prefer not to say
                        </label>
                    </div>
                </div>
                <div class="ep-field">
                    <label class="ep-label">Address</label>
                    <div class="ep-input-wrap">
                        <asp:TextBox ID="txtAddress" runat="server" CssClass="ep-textarea"
                            TextMode="MultiLine"
                            style="padding-left:12px !important;" />
                    </div>
                </div>
                <div class="ep-field">
                    <label class="ep-label">City</label>
                    <div class="ep-input-wrap">
                        <span class="fi"><i class="fas fa-city"></i></span>
                        <asp:TextBox ID="txtCity" runat="server" CssClass="ep-textbox" />
                    </div>
                </div>
                <div class="ep-field">
                    <label class="ep-label">State</label>
                    <div class="ep-input-wrap">
                        <span class="fi"><i class="fas fa-map-marker-alt"></i></span>
                        <asp:TextBox ID="txtState" runat="server" CssClass="ep-textbox" />
                    </div>
                </div>
            </div>

            <!-- Photo -->
            <div class="ep-card">
                <div class="ep-card-title">Profile Photo</div>
                <div class="ep-photo-wrap">
                    <div class="ep-photo-frame">
                        <asp:Image ID="imgPhoto" runat="server" Height="130px" Width="130px"
                            style="border-radius:50%; object-fit:cover;" />
                    </div>
                    <asp:FileUpload ID="fuPhoto" runat="server" CssClass="ep-file-upload" />
                    <asp:Label ID="lblPhoto" runat="server" CssClass="ep-lbl-msg" />
                    <asp:Button ID="btnUploadPhoto" runat="server" Text="Upload Photo"
                        CssClass="ep-btn" style="width:100% !important;"
                        OnClick="btnUploadPhoto_Click" />
                    <div class="ep-note-text">
                        <asp:Label ID="lblNote" runat="server"
                            Text="Select a file then click Upload Photo to update your profile picture." />
                    </div>
                </div>

                <!-- Documents inside same card, stacked below -->
                <div style="margin-top: 28px;">
                    <div class="ep-card-title" style="margin-bottom:14px;">Identity Documents</div>

                    <!-- Aadhar -->
                    <div class="ep-doc-row">
                        <div>
                            <label class="ep-label">Aadhar Card</label>
                            <asp:FileUpload ID="fuAadhar" runat="server" CssClass="ep-file-upload" />
                        </div>
                        <div style="align-self:end;">
                            <asp:Button ID="btnUploadAadhar" runat="server" Text="Upload"
                                CssClass="ep-btn" OnClick="btnUploadAadhar_Click" />
                        </div>
                        <div style="align-self:end; padding-bottom:2px;">
                            <asp:HyperLink ID="hplkAadhar" runat="server" CssClass="ep-view-link" Target="_blank">
                                <i class="fas fa-eye"></i> View
                            </asp:HyperLink>
                        </div>
                    </div>

                    <!-- PAN -->
                    <div class="ep-doc-row">
                        <div>
                            <label class="ep-label">PAN Card</label>
                            <asp:FileUpload ID="fuPAN" runat="server" CssClass="ep-file-upload" />
                        </div>
                        <div style="align-self:end;">
                            <asp:Button ID="btnUploadPan" runat="server" Text="Upload"
                                CssClass="ep-btn" OnClick="btnUploadPan_Click" />
                        </div>
                        <div style="align-self:end; padding-bottom:2px;">
                            <asp:HyperLink ID="hplkPAN" runat="server" CssClass="ep-view-link" Target="_blank">
                                <i class="fas fa-eye"></i> View
                            </asp:HyperLink>
                        </div>
                    </div>

                    <!-- Signature -->
                    <div class="ep-doc-row">
                        <div>
                            <label class="ep-label">Signature</label>
                            <asp:FileUpload ID="fuSign" runat="server" CssClass="ep-file-upload" />
                        </div>
                        <div style="align-self:end;">
                            <asp:Button ID="btnUploadSign" runat="server" Text="Upload"
                                CssClass="ep-btn" OnClick="btnUploadSign_Click" />
                        </div>
                        <div style="align-self:end; padding-bottom:2px;">
                            <asp:HyperLink ID="hplkSign" runat="server" CssClass="ep-view-link" Target="_blank">
                                <i class="fas fa-eye"></i> View
                            </asp:HyperLink>
                        </div>
                    </div>
                </div>
            </div>

        </div>

        <!-- Save button -->
        <div class="ep-card ep-grid-full" style="max-width:480px; margin: 0 auto;">
            <div class="ep-card-title">Save Changes</div>
            <asp:Button ID="btnSave" runat="server" Text="💾  Save All Information"
                CssClass="ep-btn ep-btn-save" OnClick="btnSave_Click" />
            <div class="ep-status">
                <asp:Label ID="lblSubmit" runat="server" Text="" />
            </div>
        </div>

    </div>

    <script>
    (function () {
        var c = document.getElementById('particles-canvas');
        var ctx = c.getContext('2d'), W, H, pts = [];
        function resize() { W=c.width=window.innerWidth; H=c.height=window.innerHeight; }
        resize(); window.addEventListener('resize', resize);
        for(var i=0;i<55;i++) pts.push({x:Math.random()*1920,y:Math.random()*1080,
            r:Math.random()*1.4+0.4,vx:(Math.random()-0.5)*0.26,vy:(Math.random()-0.5)*0.26,a:Math.random()*0.38+0.08});
        function draw() {
            ctx.clearRect(0,0,W,H);
            pts.forEach(function(p){
                ctx.beginPath();ctx.arc(p.x,p.y,p.r,0,Math.PI*2);
                ctx.fillStyle='rgba(0,255,213,'+p.a+')';ctx.fill();
                p.x+=p.vx;p.y+=p.vy;
                if(p.x<0)p.x=W;if(p.x>W)p.x=0;if(p.y<0)p.y=H;if(p.y>H)p.y=0;
            });
            requestAnimationFrame(draw);
        }
        draw();
    })();
    </script>

</asp:Content>