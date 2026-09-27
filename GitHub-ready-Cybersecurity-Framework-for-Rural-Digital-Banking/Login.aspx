<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Cybersecurity_Framework_for_Rural_Digital_Banking.Login" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<style>
    body { background: linear-gradient(135deg,#0f2027,#203a43,#2c5364); font-family:'Segoe UI',sans-serif; }
    .login-wrapper { min-height:90vh; display:flex; justify-content:center; align-items:center; padding:20px; }
    .login-container { width:100%; max-width:480px; background:rgba(255,255,255,0.07); backdrop-filter:blur(15px); padding:35px 30px; border-radius:20px; box-shadow:0 15px 35px rgba(0,0,0,0.6); color:#fff; }
    .login-title { text-align:center; font-size:24px; font-weight:700; margin-bottom:6px; color:#00ffd5; text-shadow:0 0 10px #00ffd5; }
    .login-subtitle { text-align:center; font-size:13px; color:#a0c4d8; margin-bottom:22px; }

    .auth-toggle { display:flex; background:rgba(0,0,0,0.3); border-radius:30px; padding:4px; margin-bottom:22px; gap:4px; }
    .auth-toggle button { flex:1; padding:9px 10px; border:none; border-radius:25px; font-size:13px; font-weight:600; cursor:pointer; transition:all 0.25s; background:transparent; color:#a0c4d8; }
    .auth-toggle button.active { background:linear-gradient(90deg,#00c6ff,#0072ff); color:#fff; box-shadow:0 0 12px rgba(0,198,255,0.45); }
    .auth-toggle button:hover:not(.active) { background:rgba(255,255,255,0.08); color:#fff; }

    label { font-weight:500; margin-bottom:5px; display:block; font-size:13px; color:#cce8ff; }
    .form-control { background:rgba(255,255,255,0.08); border:1px solid #00ffd5; color:#fff; height:45px; border-radius:10px; font-size:14px; width:100%; padding:0 12px; box-sizing:border-box; }
    .form-control:focus { box-shadow:0 0 10px #00ffd5; border-color:#00ffd5; background:rgba(255,255,255,0.12); color:#fff; outline:none; }
    .form-control::placeholder { color:rgba(255,255,255,0.35); }
    .field-group { margin-bottom:16px; }

    /* Password notice shown after postback */
    .pwd-notice { background:rgba(255,200,0,0.1); border:1px solid rgba(255,200,0,0.35); border-radius:8px; padding:8px 12px; font-size:12px; color:#ffd966; margin-top:6px; display:none; }

    /* CAPTCHA */
    .captcha-box { background:rgba(0,0,0,0.3); border:1px solid rgba(0,255,213,0.35); border-radius:12px; padding:14px; margin-bottom:18px; }
    .captcha-section-label { font-size:12px; color:#a0c4d8; font-weight:600; margin-bottom:10px; letter-spacing:0.3px; }
    .captcha-row { display:flex; align-items:center; gap:10px; }
    .captcha-canvas-wrap { flex-shrink:0; border-radius:8px; overflow:hidden; border:2px solid rgba(0,255,213,0.4); }
    canvas#captchaCanvas { display:block; }
    .btn-refresh { background:rgba(0,255,213,0.1); border:1px solid #00ffd5; color:#00ffd5; border-radius:8px; width:38px; height:38px; font-size:18px; cursor:pointer; transition:0.25s; flex-shrink:0; display:flex; align-items:center; justify-content:center; }
    .btn-refresh:hover { background:rgba(0,255,213,0.22); transform:rotate(90deg); }

    /* Voice */
    .voice-box { background:rgba(0,0,0,0.35); padding:14px; border-radius:12px; text-align:center; margin-bottom:16px; }
    .voice-label { font-size:13px; color:#cce8ff; margin-bottom:10px; }
    .voice-btn-row { display:flex; gap:8px; justify-content:center; margin-bottom:8px; }
    .voice-btn-row button { border-radius:25px; flex:1; font-size:13px; }
    audio { width:100%; margin-top:8px; }
    .recording-status { color:#00ffd5; font-size:12px; margin-top:6px; }

    /* OTP */
    .otp-row { display:flex; gap:8px; align-items:flex-end; margin-bottom:14px; }
    .otp-row .field-group { flex:1; margin-bottom:0; }
    .btn-otp { background:linear-gradient(90deg,#00b09b,#96c93d); border:none; color:#fff; font-weight:600; padding:0 16px; border-radius:20px; font-size:13px; cursor:pointer; transition:0.2s; white-space:nowrap; height:45px; }
    .btn-otp:hover { opacity:0.88; transform:translateY(-1px); }

    /* Login button */
    .btn-login { background:linear-gradient(90deg,#00c6ff,#0072ff); border:none; color:#fff; font-weight:600; padding:12px; border-radius:30px; width:100%; transition:0.3s; font-size:15px; cursor:pointer; margin-top:4px; }
    .btn-login:hover { transform:translateY(-2px); box-shadow:0 0 18px #00c6ff; }

    /* Divider */
    .divider { text-align:center; color:rgba(255,255,255,0.3); font-size:12px; margin:4px 0 18px; position:relative; }
    .divider::before,.divider::after { content:''; position:absolute; top:50%; width:36%; height:1px; background:rgba(255,255,255,0.15); }
    .divider::before { left:0; } .divider::after { right:0; }

    /* Messages */
    .error-label { color:#ff4d4d; font-weight:600; text-align:center; display:block; margin-top:12px; font-size:13px; min-height:18px; }
    .otp-status { font-size:12px; display:block; margin-top:4px; min-height:16px; }
    .register-link { text-align:center; margin-top:18px; font-size:13px; }
    .register-link a { color:#00ffd5; text-decoration:none; font-weight:600; }
    .register-link a:hover { text-decoration:underline; }

    /* Panels */
    .auth-panel { display:none; }
    .auth-panel.show { display:block; }

    @media(max-width:480px) {
        .login-container { padding:22px 16px; }
        .login-title { font-size:20px; }
        .form-control { height:40px; font-size:13px; }
    }
</style>

<div class="login-wrapper">
<div class="login-container">

    <h3 class="login-title">🔐 Secure Banking Login</h3>
    <p class="login-subtitle">Mobile Number &amp; Password required for both methods</p>

    <!-- Mobile -->
    <div class="field-group">
        <label>Mobile Number</label>
        <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control" TextMode="SingleLine" MaxLength="10" Placeholder="Enter Registered Mobile Number"></asp:TextBox>
    </div>

    <!-- Password -->
    <div class="field-group">
        <label>Password</label>
        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" Placeholder="Enter Password"></asp:TextBox>
        <%-- Shown after postback (e.g. after Send OTP) to remind user to re-enter password --%>
        <div class="pwd-notice" id="pwdNotice">
            ⚠ For security, your password was cleared. Please re-enter it before clicking Login.
        </div>
    </div>

    <!-- CAPTCHA — mandatory for BOTH modes -->
    <%-- Server regenerates code on every postback and re-paints canvas via RegisterStartupScript --%>
    <div class="captcha-box">
        <div class="captcha-section-label">🛡 Security Check — type the characters shown</div>
        <div class="captcha-row">
            <div class="captcha-canvas-wrap">
                <canvas id="captchaCanvas" width="150" height="46"></canvas>
            </div>
            <button type="button" class="btn-refresh" onclick="clientRefreshCaptcha()" title="New CAPTCHA">↻</button>
            <div style="flex:1;">
                <asp:TextBox ID="txtCaptcha" runat="server" CssClass="form-control" MaxLength="6" Placeholder="Type here"></asp:TextBox>
            </div>
        </div>
        <%-- Stores current CAPTCHA answer; synced from server after each postback --%>
        <asp:HiddenField ID="hdnCaptchaValue" runat="server" />
    </div>

    <div class="divider">choose authentication method</div>

    <!-- Toggle -->
    <div class="auth-toggle">
        <button type="button" id="btnToggleVoice" onclick="switchMode('voice')">🎤 Voice Authentication</button>
        <button type="button" id="btnToggleOTP"   onclick="switchMode('otp')">📧 OTP Authentication</button>
    </div>

    <%-- Persists which panel is active across postbacks --%>
    <asp:HiddenField ID="hdnAuthMode" runat="server" Value="voice" />

    <!-- PANEL A — Voice -->
    <div id="panelVoice" class="auth-panel">
        <div class="voice-box">
            <div class="voice-label">🎤 Record your voice to authenticate</div>
            <div class="voice-btn-row">
                <button type="button" class="btn btn-outline-info"   onclick="startRecording()">▶ Start Recording</button>
                <button type="button" class="btn btn-outline-danger" onclick="stopRecording()">⏹ Stop Recording</button>
            </div>
            <audio id="audioPlayback" controls></audio>
            <div id="recordingStatus" class="recording-status">Press Start and speak for at least 4 seconds</div>
        </div>
        <asp:HiddenField ID="hdnLoginVoicePath" runat="server" />
        <asp:Button ID="btnLoginVoice" runat="server" Text="Login with Voice" CssClass="btn-login" OnClick="btnLogin_Click" />
    </div>

    <!-- PANEL B — OTP -->
    <div id="panelOTP" class="auth-panel">
        <div class="otp-row">
            <div class="field-group">
                <label>OTP (sent to your registered email)</label>
                <asp:TextBox ID="txtOTP" runat="server" CssClass="form-control" MaxLength="6" Placeholder="Enter 6-digit OTP"></asp:TextBox>
            </div>
            <asp:Button ID="btnSendOTP" runat="server" Text="Send OTP" CssClass="btn-otp" OnClick="btnSendOTP_Click" CausesValidation="false" />
        </div>
        <asp:Label ID="lblOTPStatus" runat="server" CssClass="otp-status"></asp:Label>
        <asp:Button ID="btnLoginOTP" runat="server" Text="Login with OTP" CssClass="btn-login" OnClick="btnLogin_Click" style="margin-top:10px;" />
    </div>

    <asp:Label ID="lblMessage" runat="server" CssClass="error-label"></asp:Label>

    <div class="register-link">Don't have an account? <a href="Register.aspx">Register Here</a></div>

</div>
</div>

<script>
    // ──────────────────────────────────────────────────────────────────────────────
    //  drawCaptchaCode(code)
    //  Paints the canvas with the given 6-char code.
    //  Called both on first load and after every postback via RegisterStartupScript.
    // ──────────────────────────────────────────────────────────────────────────────
    function drawCaptchaCode(code) {
        var canvas = document.getElementById('captchaCanvas');
        if (!canvas) return;
        var ctx = canvas.getContext('2d');
        var W = canvas.width, H = canvas.height;

        ctx.clearRect(0, 0, W, H);

        var grad = ctx.createLinearGradient(0, 0, W, H);
        grad.addColorStop(0, '#0d2137'); grad.addColorStop(1, '#0a3d62');
        ctx.fillStyle = grad; ctx.fillRect(0, 0, W, H);

        for (var d = 0; d < 90; d++) {
            ctx.beginPath();
            ctx.arc(Math.random() * W, Math.random() * H, Math.random() * 1.4, 0, 2 * Math.PI);
            ctx.fillStyle = 'rgba(0,255,213,' + (Math.random() * 0.35 + 0.08) + ')';
            ctx.fill();
        }
        for (var l = 0; l < 5; l++) {
            ctx.beginPath();
            ctx.moveTo(Math.random() * W, Math.random() * H);
            ctx.lineTo(Math.random() * W, Math.random() * H);
            ctx.strokeStyle = 'rgba(0,198,255,' + (Math.random() * 0.25 + 0.1) + ')';
            ctx.lineWidth = 1; ctx.stroke();
        }

        var colors = ['#00ffd5', '#00c6ff', '#ffffff', '#96c93d', '#00e5ff', '#aaffcc'];
        var step = (W - 16) / 6;
        for (var c = 0; c < code.length; c++) {
            ctx.save();
            ctx.translate(8 + step * c + step / 2, H / 2 + 4);
            ctx.rotate((Math.random() - 0.5) * 0.5);
            ctx.font = 'bold ' + (Math.floor(Math.random() * 4) + 18) + 'px "Courier New",monospace';
            ctx.fillStyle = colors[c % colors.length];
            ctx.textAlign = 'center'; ctx.textBaseline = 'middle';
            ctx.shadowColor = 'rgba(0,0,0,0.6)'; ctx.shadowBlur = 3;
            ctx.fillText(code[c], 0, 0);
            ctx.restore();
        }
    }

    // ──────────────────────────────────────────────────────────────────────────────
    //  clientRefreshCaptcha() — refresh button
    //  Generates a new code client-side, paints it, and stores it in the hidden
    //  field AND the server Session via a quick async call to the handler.
    // ──────────────────────────────────────────────────────────────────────────────
    function clientRefreshCaptcha() {
        var chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
        var code = '';
        for (var i = 0; i < 6; i++) code += chars.charAt(Math.floor(Math.random() * chars.length));
        document.getElementById('<%= hdnCaptchaValue.ClientID %>').value = code;
    drawCaptchaCode(code);
    document.getElementById('<%= txtCaptcha.ClientID %>').value = '';
    // Update Session so server-side validation stays in sync
    fetch('LoginCaptchaHandler.ashx?code=' + encodeURIComponent(code));
}

// ──────────────────────────────────────────────────────────────────────────────
//  Auth Mode Toggle
// ──────────────────────────────────────────────────────────────────────────────
function switchMode(mode) {
    document.getElementById('panelVoice').classList.toggle('show', mode === 'voice');
    document.getElementById('panelOTP').classList.toggle('show',   mode === 'otp');
    document.getElementById('btnToggleVoice').classList.toggle('active', mode === 'voice');
    document.getElementById('btnToggleOTP').classList.toggle('active',   mode === 'otp');
    document.getElementById('<%= hdnAuthMode.ClientID %>').value = mode;
}

// ──────────────────────────────────────────────────────────────────────────────
//  Voice Recording
// ──────────────────────────────────────────────────────────────────────────────
var mediaRecorder, audioChunks = [], recordingTimer, secondsRecorded = 0;

async function startRecording() {
    audioChunks = []; secondsRecorded = 0;
    try {
        var stream = await navigator.mediaDevices.getUserMedia({ audio: true });
        mediaRecorder = new MediaRecorder(stream);
        mediaRecorder.start();
        mediaRecorder.ondataavailable = function(e) { audioChunks.push(e.data); };
        recordingTimer = setInterval(function() {
            secondsRecorded++;
            document.getElementById('recordingStatus').innerText = '🔴 Recording... '+secondsRecorded+'s (min 4s)';
        }, 1000);
        document.getElementById('recordingStatus').innerText = '🔴 Recording... 0s (min 4s)';
    } catch(err) {
        document.getElementById('recordingStatus').innerText = '❌ Microphone access denied.';
    }
}

function stopRecording() {
    if (!mediaRecorder || mediaRecorder.state === 'inactive') return;
    if (secondsRecorded < 4) { alert('Please record at least 4 seconds!'); return; }
    clearInterval(recordingTimer);
    document.getElementById('recordingStatus').innerText = '✅ Voice captured ('+secondsRecorded+'s) — ready to submit';
    mediaRecorder.stop();
    mediaRecorder.onstop = function() {
        var blob = new Blob(audioChunks, { type: mediaRecorder.mimeType || 'audio/webm' });
        document.getElementById('audioPlayback').src = URL.createObjectURL(blob);
        var reader = new FileReader();
        reader.readAsDataURL(blob);
        reader.onloadend = function() {
            document.getElementById('<%= hdnLoginVoicePath.ClientID %>').value = reader.result;
            };
        };
    }

    // ──────────────────────────────────────────────────────────────────────────────
    //  Page init — runs after every load/postback
    //  Server injects: initPage(mode, captchaCode, isPostBack)
    // ──────────────────────────────────────────────────────────────────────────────
    function initPage(mode, captchaCode, isPostBack) {
        // 1. Restore correct tab
        switchMode(mode);

        // 2. Paint CAPTCHA canvas with server-supplied code
        drawCaptchaCode(captchaCode);

        // 3. If this is a postback, show the password-cleared notice
        if (isPostBack) {
            document.getElementById('pwdNotice').style.display = 'block';
        }
    }
</script>

<%-- Server calls initPage(...) on every load via RegisterStartupScript --%>

</asp:Content>

