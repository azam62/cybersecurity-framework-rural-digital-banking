<%@ Page Title="" Language="C#" MasterPageFile="~/user/user-masterpage.Master" AutoEventWireup="true" CodeBehind="change-password.aspx.cs" Inherits="Cybersecurity_Framework_for_Rural_Digital_Banking.user.change_password" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<style>
    #particles-canvas {
        position: fixed; top: 0; left: 0;
        width: 100%; height: 100%;
        pointer-events: none; z-index: 0;
    }
    .cp-page {
        position: relative; z-index: 1;
        min-height: 100vh;
        display: flex; align-items: center; justify-content: center;
        padding: 40px 20px;
        font-family: 'Poppins', sans-serif;
    }
    .cp-page::before {
        content: '';
        position: fixed; top: 50%; left: 50%;
        transform: translate(-50%,-50%);
        width: 560px; height: 560px;
        background: radial-gradient(circle, rgba(0,255,213,0.08) 0%, transparent 68%);
        pointer-events: none; z-index: 0;
    }
    .cp-card {
        position: relative; z-index: 1;
        width: 100%; max-width: 460px;
        background: rgba(255,255,255,0.05);
        backdrop-filter: blur(22px);
        -webkit-backdrop-filter: blur(22px);
        border: 1px solid rgba(0,255,213,0.18);
        border-radius: 22px;
        padding: 40px 38px;
        box-shadow: 0 0 0 1px rgba(0,255,213,0.06), 0 20px 60px rgba(0,0,0,0.5),
                    inset 0 1px 0 rgba(255,255,255,0.07);
        animation: cardIn 0.55s ease both;
    }
    @keyframes cardIn {
        from { opacity: 0; transform: translateY(22px) scale(0.98); }
        to   { opacity: 1; transform: translateY(0) scale(1); }
    }

    /* Lock icon header */
    .cp-icon-wrap {
        display: flex; justify-content: center; margin-bottom: 22px;
    }
    .cp-icon {
        width: 60px; height: 60px; border-radius: 16px;
        background: linear-gradient(135deg, rgba(0,255,213,0.16), rgba(0,255,213,0.04));
        border: 1px solid rgba(0,255,213,0.35);
        display: flex; align-items: center; justify-content: center; font-size: 26px;
        box-shadow: 0 0 24px rgba(0,255,213,0.18);
    }

    .cp-title {
        text-align: center;
        font-size: 22px; font-weight: 700;
        color: #00ffd5;
        text-shadow: 0 0 18px rgba(0,255,213,0.4);
        margin-bottom: 6px;
    }
    .cp-subtitle {
        text-align: center;
        font-size: 11.5px; color: rgba(0,255,213,0.45);
        letter-spacing: 1.6px; text-transform: uppercase;
        margin-bottom: 32px;
    }

    /* Warning box */
    .cp-warning {
        display: flex; align-items: flex-start; gap: 12px;
        background: rgba(255,100,100,0.07);
        border: 1px solid rgba(255,100,100,0.22);
        border-radius: 12px;
        padding: 14px 16px;
        margin-bottom: 28px;
    }
    .cp-warning-icon { font-size: 18px; flex-shrink: 0; margin-top: 1px; }
    .cp-warning-text {
        font-size: 12.5px; line-height: 1.65;
        color: rgba(255,180,180,0.85);
    }
    .cp-warning-text strong { color: #ff8080; }

    /* Form fields */
    .cp-field { margin-bottom: 20px; }
    .cp-label {
        display: block;
        font-size: 11px; font-weight: 600;
        letter-spacing: 1.5px; text-transform: uppercase;
        color: rgba(0,255,213,0.5);
        margin-bottom: 8px;
    }
    .cp-input-wrap { position: relative; }
    .cp-input-wrap .field-icon {
        position: absolute; left: 14px; top: 50%; transform: translateY(-50%);
        color: rgba(0,255,213,0.35); font-size: 14px; pointer-events: none;
    }
    .cp-input-wrap input[type="text"],
    .cp-input-wrap input[type="password"],
    .cp-input-wrap .cp-textbox {
        width: 100% !important;
        height: 44px !important;
        background: rgba(0,0,0,0.3) !important;
        border: 1px solid rgba(0,255,213,0.18) !important;
        border-radius: 10px !important;
        color: #fff !important;
        font-family: 'Poppins', sans-serif !important;
        font-size: 13px !important;
        padding: 0 14px 0 40px !important;
        outline: none !important;
        transition: border-color 0.25s, box-shadow 0.25s !important;
        box-sizing: border-box !important;
    }
    .cp-input-wrap input:focus,
    .cp-input-wrap .cp-textbox:focus {
        border-color: rgba(0,255,213,0.45) !important;
        box-shadow: 0 0 0 3px rgba(0,255,213,0.08) !important;
    }
    .cp-input-wrap input:disabled,
    .cp-input-wrap .cp-textbox[disabled] {
        opacity: 0.55 !important; cursor: not-allowed !important;
    }
    /* password eye toggle */
    .cp-eye-btn {
        position: absolute; right: 12px; top: 50%; transform: translateY(-50%);
        background: transparent; border: none; color: rgba(0,255,213,0.35);
        cursor: pointer; font-size: 14px; padding: 4px;
        transition: color 0.2s;
    }
    .cp-eye-btn:hover { color: #00ffd5; }

    /* Submit button */
    .cp-submit-btn {
        width: 100% !important;
        height: 46px !important;
        background: linear-gradient(135deg, #0066cc, #0044aa) !important;
        border: 1px solid rgba(0,255,213,0.2) !important;
        border-radius: 12px !important;
        color: #fff !important;
        font-family: 'Poppins', sans-serif !important;
        font-size: 14px !important; font-weight: 600 !important;
        letter-spacing: 0.5px !important;
        cursor: pointer !important;
        margin-top: 8px !important;
        transition: transform 0.2s, box-shadow 0.2s, background 0.2s !important;
        box-shadow: 0 4px 18px rgba(0,80,200,0.35) !important;
    }
    .cp-submit-btn:hover {
        transform: translateY(-2px) !important;
        box-shadow: 0 8px 28px rgba(0,100,220,0.5) !important;
        background: linear-gradient(135deg, #0077ee, #0055cc) !important;
    }
    .cp-submit-btn:active { transform: translateY(0) !important; }

    /* Status label */
    .cp-status { margin-top: 14px; font-size: 13px; text-align: center; min-height: 20px; }
</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <canvas id="particles-canvas"></canvas>

    <div class="cp-page">
        <div class="cp-card">

            <asp:HiddenField ID="hfCustomerID" runat="server" />

            <div class="cp-icon-wrap">
                <div class="cp-icon">🔐</div>
            </div>
            <div class="cp-title">Change Password</div>
            <div class="cp-subtitle">Secure account access</div>

            <!-- Warning -->
            <div class="cp-warning">
                <span class="cp-warning-icon">⚠️</span>
                <div class="cp-warning-text">
                    <strong>This action is irreversible.</strong> Once your password is changed, you will need the new password to log in. Make sure it's strong and memorable.
                </div>
            </div>

            <!-- Email -->
            <div class="cp-field">
                <label class="cp-label">Email Address</label>
                <div class="cp-input-wrap">
                    <span class="field-icon"><i class="fas fa-envelope"></i></span>
                    <asp:TextBox ID="txtEmail" runat="server" Enabled="false"
                        CssClass="cp-textbox" style="padding-left:40px !important;" />
                </div>
            </div>

            <!-- New Password -->
            <div class="cp-field">
                <label class="cp-label">New Password</label>
                <div class="cp-input-wrap">
                    <span class="field-icon"><i class="fas fa-lock"></i></span>
                    <asp:TextBox ID="txtPassword" runat="server"
                        CssClass="cp-textbox" TextMode="Password"
                        style="padding-left:40px !important;" />
                    <button type="button" class="cp-eye-btn" id="eyeToggle" title="Toggle visibility">
                        <i class="fas fa-eye" id="eyeIcon"></i>
                    </button>
                </div>
            </div>

            <!-- Submit -->
            <asp:Button ID="btnChangePassword" runat="server"
                Text="Update Password"
                CssClass="cp-submit-btn"
                OnClick="btnChangePassword_Click" />

            <div class="cp-status">
                <asp:Label ID="lblChangePassword" runat="server" Text=""></asp:Label>
            </div>

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        // Eye toggle for password
        var eyeBtn = document.getElementById('eyeToggle');
        var eyeIcon = document.getElementById('eyeIcon');
        var pwdBox = document.querySelector('#<%= txtPassword.ClientID %>');

        if (eyeBtn && pwdBox) {
            eyeBtn.addEventListener('click', function () {
                var isPass = pwdBox.type === 'password';
                pwdBox.type = isPass ? 'text' : 'password';
                eyeIcon.className = isPass ? 'fas fa-eye-slash' : 'fas fa-eye';
            });
        }

        function showSuccessPopup() {
            Swal.fire({
                title: "Password Updated Successfully!",
                text: "Your password has been changed.",
                icon: "success",
                background: '#001e3a',
                color: '#fff',
                iconColor: '#00ffd5',
                confirmButtonColor: '#0066cc',
                confirmButtonText: "Go to Login",
            });
        }

        // Particles
        (function () {
            var c = document.getElementById('particles-canvas');
            var ctx = c.getContext('2d'), W, H, pts = [];
            function resize() { W = c.width = window.innerWidth; H = c.height = window.innerHeight; }
            resize(); window.addEventListener('resize', resize);
            for (var i = 0; i < 45; i++) pts.push({
                x: Math.random() * 1920, y: Math.random() * 1080,
                r: Math.random() * 1.3 + 0.4, vx: (Math.random() - 0.5) * 0.25, vy: (Math.random() - 0.5) * 0.25, a: Math.random() * 0.38 + 0.08
            });
            function draw() {
                ctx.clearRect(0, 0, W, H);
                pts.forEach(function (p) {
                    ctx.beginPath(); ctx.arc(p.x, p.y, p.r, 0, Math.PI * 2);
                    ctx.fillStyle = 'rgba(0,255,213,' + p.a + ')'; ctx.fill();
                    p.x += p.vx; p.y += p.vy;
                    if (p.x < 0) p.x = W; if (p.x > W) p.x = 0; if (p.y < 0) p.y = H; if (p.y > H) p.y = 0;
                });
                requestAnimationFrame(draw);
            }
            draw();
        })();
    </script>

</asp:Content>
