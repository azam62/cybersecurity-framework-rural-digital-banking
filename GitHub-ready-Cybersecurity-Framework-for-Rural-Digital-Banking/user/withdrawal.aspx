<%@ Page Title="" Language="C#" MasterPageFile="~/user/user-masterpage.Master" AutoEventWireup="true" CodeBehind="withdrawal.aspx.cs" Inherits="Cybersecurity_Framework_for_Rural_Digital_Banking.user.withdrawal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<style>
    #particles-canvas {
        position: fixed; top: 0; left: 0; width: 100%; height: 100%;
        pointer-events: none; z-index: 0;
    }

    body, #layoutSidenav_content {
        font-family: 'Poppins', sans-serif !important;
    }

    .txn-page {
        position: relative; z-index: 1;
        min-height: 100vh;
        padding: 40px 20px 80px;
        font-family: 'Poppins', sans-serif;
    }

    /* ── Page header ── */
    .txn-header {
        max-width: 820px; margin: 0 auto 32px;
        display: flex; align-items: center; gap: 16px;
        border-bottom: 1px solid rgba(0,255,213,0.12);
        padding-bottom: 22px;
    }
    .txn-header-icon {
        width: 56px; height: 56px; border-radius: 14px;
        background: linear-gradient(135deg, rgba(0,255,213,0.14), rgba(0,198,255,0.08));
        border: 1px solid rgba(0,255,213,0.28);
        display: flex; align-items: center; justify-content: center;
        font-size: 24px; box-shadow: 0 0 20px rgba(0,255,213,0.1);
    }
    .txn-header h2 { font-size: 22px; font-weight: 700; color: #00ffd5; margin: 0;
                     text-shadow: 0 0 12px rgba(0,255,213,0.35); }
    .txn-header p  { font-size: 12px; color: rgba(0,255,213,0.45); margin: 3px 0 0;
                     letter-spacing: 1.2px; text-transform: uppercase; }

    /* ── Balance strip at top ── */
    .balance-strip {
        max-width: 820px; margin: 0 auto 28px;
        background: linear-gradient(135deg, rgba(0,255,213,0.08), rgba(0,198,255,0.05));
        border: 1px solid rgba(0,255,213,0.18);
        border-radius: 18px; padding: 22px 28px;
        display: flex; align-items: center; justify-content: space-between;
        box-shadow: 0 8px 32px rgba(0,0,0,0.35);
    }
    .balance-strip .bl-label { font-size: 11px; color: rgba(0,255,213,0.5);
                                letter-spacing: 1.4px; text-transform: uppercase; }
    .balance-strip .bl-value { font-size: 32px; font-weight: 700; color: #00ffd5;
                                text-shadow: 0 0 14px rgba(0,255,213,0.4); margin-top: 4px; }
    .balance-strip .bl-right  { font-size: 44px; opacity: 0.2; }

    /* ── Main card ── */
    .txn-card {
        max-width: 820px; margin: 0 auto;
        background: rgba(255,255,255,0.05);
        backdrop-filter: blur(20px); -webkit-backdrop-filter: blur(20px);
        border: 1px solid rgba(0,255,213,0.14);
        border-radius: 22px; padding: 36px 34px;
        box-shadow: 0 20px 60px rgba(0,0,0,0.5),
                    inset 0 1px 0 rgba(255,255,255,0.06);
    }

    /* ── Section label ── */
    .sec-label {
        font-size: 10.5px; font-weight: 600;
        letter-spacing: 1.8px; text-transform: uppercase;
        color: rgba(0,255,213,0.45); margin-bottom: 18px;
        display: flex; align-items: center; gap: 8px;
    }
    .sec-label::after {
        content: ''; flex: 1; height: 1px;
        background: rgba(0,255,213,0.1);
    }

    /* ── Recipient selector ── */
    .recipient-grid {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 14px; margin-bottom: 28px;
    }

    .field-group { margin-bottom: 0; }
    .field-label {
        display: block; font-size: 10.5px; font-weight: 600;
        letter-spacing: 1.3px; text-transform: uppercase;
        color: rgba(0,255,213,0.45); margin-bottom: 7px;
    }

    select.txn-select,
    .txn-input {
        width: 100% !important; height: 46px !important;
        background: rgba(0,0,0,0.3) !important;
        border: 1px solid rgba(0,255,213,0.18) !important;
        border-radius: 12px !important; color: #fff !important;
        font-family: 'Poppins', sans-serif !important; font-size: 13.5px !important;
        padding: 0 14px !important; box-sizing: border-box !important;
        outline: none !important;
        transition: border-color 0.25s, box-shadow 0.25s !important;
        -webkit-appearance: none;
    }
    select.txn-select { padding: 0 38px 0 14px !important; cursor: pointer; }
    .select-wrap { position: relative; }
    .select-wrap::after {
        content: '▾'; position: absolute; right: 14px; top: 50%;
        transform: translateY(-50%); color: rgba(0,255,213,0.5);
        pointer-events: none; font-size: 14px;
    }
    select.txn-select option { background: #1a2a3a; color: #fff; }

    .txn-input:focus, select.txn-select:focus {
        border-color: rgba(0,255,213,0.45) !important;
        box-shadow: 0 0 0 3px rgba(0,255,213,0.08) !important;
    }
    .txn-input[disabled], select.txn-select[disabled] {
        opacity: 0.5 !important; cursor: not-allowed !important;
    }

    /* ── Recipient preview card ── */
    .recipient-preview {
        background: rgba(0,0,0,0.25); border: 1px solid rgba(0,255,213,0.12);
        border-radius: 14px; padding: 18px 20px;
        display: flex; align-items: center; gap: 16px;
        margin-bottom: 26px;
        transition: all 0.3s;
    }
    .rp-avatar {
        width: 48px; height: 48px; border-radius: 50%;
        background: linear-gradient(135deg, rgba(0,255,213,0.15), rgba(0,198,255,0.1));
        border: 1px solid rgba(0,255,213,0.25);
        display: flex; align-items: center; justify-content: center;
        font-size: 20px; flex-shrink: 0;
    }
    .rp-name  { font-size: 15px; font-weight: 600; color: #fff; }
    .rp-acc   { font-size: 11.5px; color: rgba(0,255,213,0.5); margin-top: 2px; }
    .rp-bank  { font-size: 11px; color: rgba(200,230,255,0.4); margin-top: 1px; }

    /* ── Amount input row ── */
    .amount-row { margin-bottom: 28px; }
    .amount-input-wrap { position: relative; }
    .amount-input-wrap .rupee-symbol {
        position: absolute; left: 16px; top: 50%; transform: translateY(-50%);
        color: rgba(0,255,213,0.5); font-size: 16px; font-weight: 600;
    }
    .amount-input-wrap .txn-input { padding-left: 36px !important; font-size: 22px !important;
                                     font-weight: 700 !important; height: 58px !important; }

    /* ── Warning ── */
    .txn-warning {
        background: rgba(255,150,50,0.07); border: 1px solid rgba(255,150,50,0.2);
        border-radius: 12px; padding: 12px 16px; margin-bottom: 24px;
        font-size: 12.5px; color: rgba(255,190,130,0.85); line-height: 1.6;
        display: flex; gap: 10px; align-items: flex-start;
    }

    /* ── OTP box ── */
    .otp-box {
        background: rgba(0,0,0,0.2); border: 1px solid rgba(0,255,213,0.1);
        border-radius: 14px; padding: 20px;
        margin-bottom: 20px;
    }
    .otp-desc { font-size: 12.5px; color: rgba(200,230,255,0.6); margin-bottom: 12px; }

    /* ── Buttons ── */
    .btn-send-otp, .btn-confirm {
        width: 100%; height: 50px !important;
        border-radius: 14px !important; font-family: 'Poppins', sans-serif !important;
        font-size: 14px !important; font-weight: 600 !important; cursor: pointer !important;
        border: none !important; color: #fff !important;
        transition: transform 0.2s, box-shadow 0.2s !important;
        letter-spacing: 0.5px;
    }
    .btn-send-otp {
        background: linear-gradient(135deg, #00c6ff, #0072ff) !important;
        box-shadow: 0 4px 20px rgba(0,114,255,0.35) !important;
        margin-bottom: 0 !important;
    }
    .btn-send-otp:hover {
        transform: translateY(-2px) !important;
        box-shadow: 0 8px 28px rgba(0,114,255,0.5) !important;
    }
    .btn-confirm {
        background: linear-gradient(135deg, #00b09b, #0072ff) !important;
        box-shadow: 0 4px 20px rgba(0,176,155,0.35) !important;
    }
    .btn-confirm:hover {
        transform: translateY(-2px) !important;
        box-shadow: 0 8px 28px rgba(0,176,155,0.5) !important;
    }

    .status-msg { text-align: center; margin-top: 14px; font-size: 13.5px;
                  font-weight: 600; min-height: 22px; }

    /* ── Transfer animation overlay ── */
    #txn-overlay {
        display: none;
        position: fixed; inset: 0;
        background: rgba(5,15,25,0.96);
        z-index: 9999;
        align-items: center; justify-content: center;
        flex-direction: column;
        font-family: 'Poppins', sans-serif;
    }
    #txn-overlay.show { display: flex; }

    .anim-card {
        text-align: center;
        background: rgba(255,255,255,0.04);
        border: 1px solid rgba(0,255,213,0.18);
        border-radius: 24px;
        padding: 50px 60px;
        max-width: 420px; width: 90%;
        box-shadow: 0 0 60px rgba(0,255,213,0.08);
    }
    .anim-row {
        display: flex; align-items: center; justify-content: center;
        gap: 20px; margin: 30px 0;
    }
    .anim-bank, .anim-user {
        text-align: center;
    }
    .anim-bank .ico, .anim-user .ico {
        width: 64px; height: 64px; border-radius: 50%;
        display: flex; align-items: center; justify-content: center;
        font-size: 26px; margin: 0 auto 8px;
    }
    .anim-bank .ico { background: rgba(0,255,213,0.1); border: 1px solid rgba(0,255,213,0.25); }
    .anim-user .ico { background: rgba(0,198,255,0.1); border: 1px solid rgba(0,198,255,0.25); }
    .anim-bank .lbl, .anim-user .lbl {
        font-size: 11px; color: rgba(200,230,255,0.5);
        letter-spacing: 1px; text-transform: uppercase;
    }
    .anim-bank .name, .anim-user .name {
        font-size: 13px; font-weight: 600; color: #fff; margin-top: 3px;
    }

    /* arrow animation */
    .anim-arrow { display: flex; flex-direction: column; align-items: center; gap: 5px; }
    .arrow-track {
        width: 80px; height: 6px;
        background: rgba(0,255,213,0.1);
        border-radius: 3px;
        position: relative; overflow: hidden;
    }
    .arrow-dot {
        width: 20px; height: 6px;
        background: linear-gradient(90deg, transparent, #00ffd5);
        border-radius: 3px;
        position: absolute; left: -20px;
        animation: slideDot 1.2s ease-in-out infinite;
    }
    @keyframes slideDot {
        0%   { left: -20px; opacity: 0; }
        10%  { opacity: 1; }
        90%  { opacity: 1; }
        100% { left: 100%; opacity: 0; }
    }

    .anim-amount {
        font-size: 38px; font-weight: 700; color: #00ffd5;
        text-shadow: 0 0 24px rgba(0,255,213,0.5);
        margin: 18px 0 10px;
        animation: countPulse 0.5s ease;
    }
    @keyframes countPulse {
        from { transform: scale(0.8); opacity: 0; }
        to   { transform: scale(1); opacity: 1; }
    }

    .anim-title { font-size: 17px; font-weight: 700; color: #fff; margin-bottom: 6px; }
    .anim-sub   { font-size: 12.5px; color: rgba(200,230,255,0.5); }

    .anim-progress {
        width: 100%; height: 4px;
        background: rgba(255,255,255,0.06);
        border-radius: 2px; margin: 28px 0 0;
        overflow: hidden;
    }
    .anim-progress-bar {
        height: 100%;
        background: linear-gradient(90deg, #00b09b, #00ffd5);
        border-radius: 2px;
        width: 0%;
        transition: width 2.5s cubic-bezier(0.4,0,0.2,1);
    }

    /* success state */
    .anim-success { display: none; }
    .success-ring {
        width: 80px; height: 80px; border-radius: 50%;
        background: rgba(0,255,213,0.08);
        border: 2px solid #00ffd5;
        display: flex; align-items: center; justify-content: center;
        font-size: 32px; margin: 0 auto 20px;
        box-shadow: 0 0 30px rgba(0,255,213,0.25);
        animation: ringPop 0.4s ease;
    }
    @keyframes ringPop {
        from { transform: scale(0.5); opacity: 0; }
        to   { transform: scale(1); opacity: 1; }
    }
    .success-title { font-size: 22px; font-weight: 700; color: #00ffd5; margin-bottom: 8px; }
    .success-detail { font-size: 13px; color: rgba(200,230,255,0.6); line-height: 1.7; }
    .success-ref { font-size: 11px; color: rgba(0,255,213,0.4); margin-top: 14px;
                   letter-spacing: 1.2px; }
    .btn-done {
        margin-top: 28px;
        background: linear-gradient(90deg, #00b09b, #00ffd5);
        border: none; border-radius: 12px;
        color: #0a1a2a; font-family: 'Poppins', sans-serif;
        font-size: 14px; font-weight: 700;
        padding: 12px 40px; cursor: pointer;
        transition: transform 0.2s, box-shadow 0.2s;
    }
    .btn-done:hover { transform: translateY(-2px); box-shadow: 0 8px 24px rgba(0,255,213,0.35); }

    @media (max-width: 580px) {
        .txn-card { padding: 24px 18px; }
        .recipient-grid { grid-template-columns: 1fr; }
        .anim-card { padding: 36px 24px; }
        .balance-strip { flex-direction: column; align-items: flex-start; gap: 8px; }
    }
</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <canvas id="particles-canvas"></canvas>

    <!-- Hidden fields -->
    <asp:HiddenField ID="hfCustomerID" runat="server" />
    <asp:HiddenField ID="hfAccountNo"  runat="server" />
    <asp:HiddenField ID="hfEmail"      runat="server" />
    <asp:HiddenField ID="hfSenderName" runat="server" />

    <!-- Transfer animation overlay -->
    <div id="txn-overlay">
        <div class="anim-card">
            <!-- Processing state -->
            <div id="anim-processing">
                <div class="anim-title">Processing Transfer</div>
                <div class="anim-sub">Please wait while we process your transaction...</div>
                <div class="anim-row">
                    <div class="anim-bank">
                        <div class="ico">🏦</div>
                        <div class="lbl">From</div>
                        <div class="name" id="anim-sender-name">Your Account</div>
                    </div>
                    <div class="anim-arrow">
                        <div class="arrow-track"><div class="arrow-dot"></div></div>
                        <div style="font-size:10px;color:rgba(0,255,213,0.4);margin-top:4px;">SENDING</div>
                    </div>
                    <div class="anim-user">
                        <div class="ico">👤</div>
                        <div class="lbl">To</div>
                        <div class="name" id="anim-receiver-name">Recipient</div>
                    </div>
                </div>
                <div class="anim-amount" id="anim-amount-display">₹0</div>
                <div style="font-size:11.5px;color:rgba(200,230,255,0.45);">Transferring funds...</div>
                <div class="anim-progress"><div class="anim-progress-bar" id="anim-bar"></div></div>
            </div>
            <!-- Success state -->
            <div class="anim-success" id="anim-success">
                <div class="success-ring">✓</div>
                <div class="success-title">Transfer Successful</div>
                <div class="success-detail" id="anim-success-detail">
                    ₹500 has been sent successfully.
                </div>
                <div class="success-ref" id="anim-ref">TXN ID: #--</div>
                <br>
                <button class="btn-done" onclick="closeTxnOverlay()">Back to Dashboard</button>
            </div>
        </div>
    </div>

    <div class="txn-page">

        <!-- Header -->
        <div class="txn-header">
            <div class="txn-header-icon">💸</div>
            <div>
                <h2>Transfer Money</h2>
                <p>Secure · OTP Verified · Instant</p>
            </div>
        </div>

        <!-- Your balance strip -->
        <div class="balance-strip">
            <div>
                <div class="bl-label">Your Available Balance</div>
                <div class="bl-value">
                    ₹ <asp:Literal ID="litBalance" runat="server" Text="0" />
                </div>
            </div>
            <div class="bl-right">🏦</div>
        </div>

        <!-- Main card -->
        <div class="txn-card">

            <!-- Step 1: Recipient -->
            <div class="sec-label">Step 1 — Choose Recipient</div>

            <div class="recipient-grid">
                <div class="field-group">
                    <label class="field-label">Select Account</label>
                    <div class="select-wrap">
                        <asp:DropDownList ID="ddlRecipient" runat="server"
                            CssClass="txn-select"
                            AutoPostBack="true"
                            OnSelectedIndexChanged="ddlRecipient_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="field-group">
                    <label class="field-label">Account Number</label>
                    <asp:TextBox ID="txtRecipientAcc" runat="server" CssClass="txn-input"
                        Enabled="false" placeholder="Auto-filled" />
                </div>
            </div>

            <!-- Recipient preview -->
            <div class="recipient-preview" id="rp-preview">
                <div class="rp-avatar">👤</div>
                <div>
                    <div class="rp-name">
                        <asp:Literal ID="litRecipientName" runat="server" Text="Select a recipient above" />
                    </div>
                    <div class="rp-acc">
                        <asp:Literal ID="litRecipientAcc" runat="server" Text="" />
                    </div>
                    <div class="rp-bank">Rural Digital Bank · Savings Account</div>
                </div>
            </div>

            <!-- Step 2: Amount -->
            <div class="sec-label">Step 2 — Enter Amount</div>

            <div class="amount-row">
                <div class="amount-input-wrap">
                    <span class="rupee-symbol">₹</span>
                    <asp:TextBox ID="txtAmount" runat="server" CssClass="txn-input"
                        placeholder="0.00" />
                </div>
            </div>

            <!-- Warning -->
            <div class="txn-warning">
                <span>⚠️</span>
                <div><strong style="color:#ffb080;">This action is irreversible.</strong>
                Funds will be debited immediately after OTP verification. Double-check the recipient and amount before confirming.</div>
            </div>

            <!-- Send OTP button -->
            <asp:Button ID="btnSendOtp" runat="server" Text="🔐  Send OTP &amp; Continue"
                CssClass="btn-send-otp" OnClick="btnSendOtp_Click" />

            <!-- Step 3: OTP -->
            <div class="otp-box" style="margin-top:22px;">
                <div class="otp-desc">
                    <asp:Label ID="lblOtpMsg" runat="server"
                        Text="Enter the 6-digit OTP sent to your registered email to confirm the transfer."
                        Visible="false" />
                </div>
                <asp:TextBox ID="txtOTP" runat="server" CssClass="txn-input"
                    Visible="false" placeholder="6-digit OTP" MaxLength="6" />
            </div>

            <asp:Button ID="btnConfirm" runat="server" Text="✅  Confirm Transfer"
                CssClass="btn-confirm" OnClick="btnConfirm_Click" Visible="false" />

            <div class="status-msg">
                <asp:Label ID="lblStatus" runat="server" Text="" />
            </div>

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
    // Particle background
    (function () {
        var c = document.getElementById('particles-canvas');
        var ctx = c.getContext('2d'), W, H, pts = [];
        function resize() { W = c.width = window.innerWidth; H = c.height = window.innerHeight; }
        resize(); window.addEventListener('resize', resize);
        for (var i = 0; i < 60; i++) pts.push({
            x: Math.random() * 1920, y: Math.random() * 1080,
            r: Math.random() * 1.4 + 0.4,
            vx: (Math.random() - 0.5) * 0.2, vy: (Math.random() - 0.5) * 0.2,
            a: Math.random() * 0.25 + 0.06
        });
        function draw() {
            ctx.clearRect(0, 0, W, H);
            pts.forEach(function (p) {
                ctx.beginPath(); ctx.arc(p.x, p.y, p.r, 0, Math.PI * 2);
                ctx.fillStyle = 'rgba(0,255,213,' + p.a + ')'; ctx.fill();
                p.x += p.vx; p.y += p.vy;
                if (p.x < 0) p.x = W; if (p.x > W) p.x = 0;
                if (p.y < 0) p.y = H; if (p.y > H) p.y = 0;
            });
            requestAnimationFrame(draw);
        }
        draw();
    })();

    // Transfer animation
    function showTransferAnimation(sender, receiver, amount) {
        document.getElementById('anim-sender-name').textContent = sender;
        document.getElementById('anim-receiver-name').textContent = receiver;
        document.getElementById('anim-amount-display').textContent = '₹' + amount;

        var overlay = document.getElementById('txn-overlay');
        overlay.classList.add('show');

        // Start progress bar
        setTimeout(function () {
            document.getElementById('anim-bar').style.width = '100%';
        }, 100);
    }

    function showTransferSuccess(amount, receiver, txnId) {
        document.getElementById('anim-processing').style.display = 'none';
        var s = document.getElementById('anim-success');
        s.style.display = 'block';
        document.getElementById('anim-success-detail').innerHTML =
            '₹<strong>' + amount + '</strong> has been sent to <strong>' + receiver + '</strong> successfully.';
        document.getElementById('anim-ref').textContent = 'TXN ID: #' + txnId;
    }

    function closeTxnOverlay() {
        window.location.reload();
    }

    // Called from code-behind via ScriptManager
    function triggerAnimation(sender, receiver, amount, txnId) {
        showTransferAnimation(sender, receiver, amount);
        setTimeout(function () {
            showTransferSuccess(amount, receiver, txnId);
        }, 3000);
    }
    </script>

</asp:Content>
