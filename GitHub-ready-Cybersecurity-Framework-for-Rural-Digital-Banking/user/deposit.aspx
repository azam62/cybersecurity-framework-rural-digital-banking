<%@ Page Title="" Language="C#" MasterPageFile="~/user/user-masterpage.Master" AutoEventWireup="true" CodeBehind="deposit.aspx.cs" Inherits="Cybersecurity_Framework_for_Rural_Digital_Banking.user.deposit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<style>
    #particles-canvas {
        position: fixed; top: 0; left: 0; width: 100%; height: 100%;
        pointer-events: none; z-index: 0;
    }
    .dp-page {
        position: relative; z-index: 1;
        min-height: 100vh;
        display: flex; align-items: center; justify-content: center;
        padding: 40px 20px;
        font-family: 'Poppins', sans-serif;
    }
    .dp-page::before {
        content: '';
        position: fixed; top: 50%; left: 50%;
        transform: translate(-50%,-50%);
        width: 580px; height: 580px;
        background: radial-gradient(circle, rgba(0,255,213,0.07) 0%, transparent 68%);
        pointer-events: none; z-index: 0;
    }

    .dp-card {
        position: relative; z-index: 1;
        width: 100%; max-width: 500px;
        background: rgba(255,255,255,0.05);
        backdrop-filter: blur(22px);
        -webkit-backdrop-filter: blur(22px);
        border: 1px solid rgba(0,255,213,0.16);
        border-radius: 22px;
        padding: 40px 38px;
        box-shadow: 0 0 0 1px rgba(0,255,213,0.05), 0 20px 60px rgba(0,0,0,0.5),
                    inset 0 1px 0 rgba(255,255,255,0.07);
        animation: cardIn 0.5s ease both;
    }
    @keyframes cardIn {
        from { opacity: 0; transform: translateY(20px); }
        to   { opacity: 1; transform: translateY(0); }
    }

    .dp-icon-wrap { display: flex; justify-content: center; margin-bottom: 20px; }
    .dp-icon {
        width: 60px; height: 60px; border-radius: 16px;
        background: linear-gradient(135deg, rgba(0,255,213,0.16), rgba(0,255,213,0.04));
        border: 1px solid rgba(0,255,213,0.3);
        display: flex; align-items: center; justify-content: center; font-size: 26px;
        box-shadow: 0 0 22px rgba(0,255,213,0.15);
    }
    .dp-title { text-align: center; font-size: 22px; font-weight: 700; color: #00ffd5;
                text-shadow: 0 0 16px rgba(0,255,213,0.4); margin-bottom: 4px; }
    .dp-subtitle { text-align: center; font-size: 11px; color: rgba(0,255,213,0.45);
                   letter-spacing: 1.6px; text-transform: uppercase; margin-bottom: 30px; }

    /* Balance display */
    .dp-balance-display {
        background: rgba(0,0,0,0.25);
        border: 1px solid rgba(0,255,213,0.12);
        border-radius: 14px;
        padding: 16px 18px;
        display: flex; justify-content: space-between; align-items: center;
        margin-bottom: 26px;
    }
    .dp-balance-label { font-size: 11px; color: rgba(0,255,213,0.5); letter-spacing: 1px; text-transform: uppercase; }
    .dp-balance-value { font-size: 22px; font-weight: 700; color: #00ffd5;
                        text-shadow: 0 0 10px rgba(0,255,213,0.3); }
    .dp-balance-value .rupee { font-size: 14px; opacity: 0.7; }

    /* Fields */
    .dp-field { margin-bottom: 20px; }
    .dp-label {
        display: block; font-size: 11px; font-weight: 600;
        letter-spacing: 1.5px; text-transform: uppercase;
        color: rgba(0,255,213,0.5); margin-bottom: 8px;
    }
    .dp-input-wrap { position: relative; }
    .dp-input-wrap .fi {
        position: absolute; left: 14px; top: 50%; transform: translateY(-50%);
        color: rgba(0,255,213,0.35); font-size: 13px; pointer-events: none;
    }
    .dp-input-wrap .dp-textbox,
    .dp-input-wrap input[type="text"] {
        width: 100% !important;
        height: 44px !important;
        background: rgba(0,0,0,0.3) !important;
        border: 1px solid rgba(0,255,213,0.18) !important;
        border-radius: 10px !important;
        color: #fff !important;
        font-family: 'Poppins', sans-serif !important;
        font-size: 14px !important;
        padding: 0 14px 0 40px !important;
        outline: none !important;
        transition: border-color 0.25s, box-shadow 0.25s !important;
        box-sizing: border-box !important;
    }
    .dp-input-wrap .dp-textbox:focus {
        border-color: rgba(0,255,213,0.42) !important;
        box-shadow: 0 0 0 3px rgba(0,255,213,0.08) !important;
    }
    .dp-input-wrap .dp-textbox[disabled] { opacity: 0.5 !important; cursor: not-allowed !important; }

    /* OTP section — hidden by default, shown via server */
    .dp-otp-section {
        background: rgba(0,0,0,0.2);
        border: 1px solid rgba(0,255,213,0.1);
        border-radius: 12px;
        padding: 18px;
        margin-bottom: 18px;
    }
    .dp-otp-label { font-size: 12px; color: rgba(200,230,255,0.7); margin-bottom: 8px; }

    /* Buttons */
    .dp-btn {
        width: 100% !important;
        height: 46px !important;
        background: linear-gradient(135deg, #0066cc, #0044aa) !important;
        border: 1px solid rgba(0,255,213,0.18) !important;
        border-radius: 12px !important;
        color: #fff !important;
        font-family: 'Poppins', sans-serif !important;
        font-size: 14px !important; font-weight: 600 !important;
        cursor: pointer !important; margin-top: 6px !important;
        transition: transform 0.2s, box-shadow 0.2s !important;
        box-shadow: 0 4px 18px rgba(0,80,200,0.35) !important;
    }
    .dp-btn:hover {
        transform: translateY(-2px) !important;
        box-shadow: 0 8px 28px rgba(0,100,220,0.5) !important;
    }
    .dp-btn:active { transform: translateY(0) !important; }
    .dp-btn-submit {
        background: linear-gradient(135deg, #008f6e, #006650) !important;
        box-shadow: 0 4px 18px rgba(0,150,110,0.35) !important;
        margin-top: 10px !important;
    }
    .dp-btn-submit:hover { box-shadow: 0 8px 28px rgba(0,180,130,0.45) !important; }

    .dp-status {
        margin-top: 14px; font-size: 14px; font-weight: 600;
        text-align: center; min-height: 22px; color: #ff6b6b;
    }

    .dp-validator { color: #ff8080 !important; font-size: 12px !important; margin-top: 5px !important; display: block !important; }
</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <canvas id="particles-canvas"></canvas>

    <div class="dp-page">
        <div class="dp-card">

            <asp:HiddenField ID="hfCustomerID" runat="server" />
            <asp:HiddenField ID="hfAccountNo" runat="server" />
            <asp:HiddenField ID="hfOtp" runat="server" />
            <asp:HiddenField ID="hfEmail" runat="server" />

            <div class="dp-icon-wrap"><div class="dp-icon">💰</div></div>
            <div class="dp-title">Deposit Funds</div>
            <div class="dp-subtitle">Secure · Instant · Verified</div>

            <!-- Balance display -->
            <div class="dp-balance-display">
                <div>
                    <div class="dp-balance-label">Current Balance</div>
                    <div class="dp-balance-value">
                        <span class="rupee"></span>
                        <asp:TextBox ID="txtCurrentBal" runat="server" Enabled="false"
                            CssClass="dp-textbox"
                            style="display:inline !important; width:auto !important; height:auto !important;
                                   background:transparent !important; border:none !important;
                                   padding:0 !important; font-size:22px !important;
                                   font-weight:700 !important; color:#00ffd5 !important;" />
                    </div>
                </div>
                <span style="font-size:28px; opacity:0.4;">🏦</span>
            </div>

            <!-- Amount field -->
            <div class="dp-field">
                <label class="dp-label">Amount to Deposit</label>
                <div class="dp-input-wrap">
                   <%-- <span class="fi"><i class="fas fa-rupee-sign"></i></span>--%>
                    <asp:TextBox ID="txtDeposit" runat="server" CssClass="dp-textbox"
                        placeholder="Enter amount..." />
                </div>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                    ControlToValidate="txtDeposit"
                    ErrorMessage="Please enter an amount to deposit"
                    CssClass="dp-validator"
                    Display="Dynamic" SetFocusOnError="True" />
            </div>

            <!-- Deposit button -->
            <asp:Button ID="btnDeposit" runat="server" Text="Send OTP & Continue"
                CssClass="dp-btn" OnClick="btnDeposit_Click" />

            <!-- OTP section -->
            <div class="dp-otp-section" style="margin-top: 20px;">
                <div class="dp-otp-label">
                    <asp:Label ID="lblOTP" runat="server" Text="Enter the OTP sent to your email:" Visible="false" />
                </div>
                <div class="dp-input-wrap">
                    <span class="fi"><i class="fas fa-shield-alt"></i></span>
                    <asp:TextBox ID="txtOTP" runat="server" CssClass="dp-textbox"
                        Visible="false" placeholder="6-digit OTP" />
                </div>
            </div>

            <asp:Button ID="btnSubmit" runat="server" Text="Confirm Deposit"
                CssClass="dp-btn dp-btn-submit"
                OnClick="btnSubmit_Click" Visible="false" />

            <div class="dp-status">
                <asp:Label ID="lblBalance" runat="server" Text="" />
            </div>

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
    (function () {
        var c = document.getElementById('particles-canvas');
        var ctx = c.getContext('2d'), W, H, pts = [];
        function resize() { W=c.width=window.innerWidth; H=c.height=window.innerHeight; }
        resize(); window.addEventListener('resize', resize);
        for(var i=0;i<50;i++) pts.push({x:Math.random()*1920,y:Math.random()*1080,
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
