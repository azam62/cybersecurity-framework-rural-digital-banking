<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Cybersecurity_Framework_for_Rural_Digital_Banking.Register" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<style>
    body { background: linear-gradient(135deg, #0f2027, #203a43, #2c5364); font-family: 'Segoe UI', sans-serif; }
    .register-wrapper { min-height: 90vh; display: flex; justify-content: center; align-items: flex-start; padding: 30px 20px; }
    .register-container { width: 100%; max-width: 960px; background: rgba(255,255,255,0.07); backdrop-filter: blur(12px); padding: 35px; border-radius: 20px; box-shadow: 0 15px 35px rgba(0,0,0,0.5); color: #fff; }
    .register-title { text-align: center; font-size: 26px; font-weight: 700; margin-bottom: 30px; color: #00ffd5; text-shadow: 0 0 10px #00ffd5; }
    .section-header { background: rgba(0,198,213,0.2); border-left: 4px solid #00ffd5; padding: 8px 14px; border-radius: 6px; font-weight: 600; color: #00ffd5; margin: 22px 0 14px; font-size: 15px; }
    label { font-weight: 500; margin-bottom: 4px; display: block; font-size: 14px; color: #cce8ff; }
    .form-control { background: rgba(255,255,255,0.08); border: 1px solid #00ffd5; color: #fff !important; height: 45px; border-radius: 10px; font-size: 14px; width: 100%; padding: 0 12px; }
    .form-control:focus { box-shadow: 0 0 10px #00ffd5; border-color: #00ffd5; background: rgba(255,255,255,0.12); color: #fff; outline: none; }
    textarea.form-control { height: 80px; padding: 10px 12px; }
    .radio-group label { display: inline-block; margin-right: 18px; font-weight: 400; color: #fff; }
    .radio-group input { margin-right: 5px; }
    .file-input { background: rgba(255,255,255,0.08); border: 1px dashed #00ffd5; color: #fff; border-radius: 10px; padding: 8px 12px; width: 100%; font-size: 13px; }
    .btn-otp { background: linear-gradient(90deg, #00b09b, #96c93d); border: none; color: #fff; font-weight: 600; padding: 8px 18px; border-radius: 20px; font-size: 13px; cursor: pointer; margin-top: 8px; }
    .btn-otp:hover { opacity: 0.88; }
    .btn-register { background: linear-gradient(90deg, #00c6ff, #0072ff); border: none; color: #fff; font-weight: 600; padding: 13px; border-radius: 30px; width: 100%; transition: 0.3s; font-size: 16px; margin-top: 10px; }
    .btn-register:hover { transform: translateY(-2px); box-shadow: 0 0 18px #00c6ff; }
    .voice-box { background: rgba(0,0,0,0.35); padding: 15px; border-radius: 12px; text-align: center; margin-top: 10px; }
    .voice-box button { width: 100%; margin-top: 8px; border-radius: 25px; }
    .voice-sample { border: 1px solid rgba(0,255,213,0.3); border-radius: 10px; padding: 10px; margin-top: 10px; }
    .voice-sample.done { border-color: #00ffd5; background: rgba(0,255,213,0.05); }
    audio { width: 100%; }
    .login-link a { color: #00ffd5; text-decoration: none; font-weight: 600; }
    .error-label { color: #ff4d4d; font-weight: 600; text-align: center; display: block; margin-top: 10px; }
    .success-label { color: #33cc33; font-weight: 600; }
    .status-text { font-size: 13px; margin-top: 6px; color: #00ffd5; }
    .two-col { display: grid; grid-template-columns: 1fr 1fr; gap: 16px; }
    .three-col { display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 16px; }
    .field-group { margin-bottom: 14px; }
    .validator-msg { color: #ff6b6b; font-size: 12px; display: block; margin-top: 3px; }
    .otp-row { display: flex; gap: 10px; align-items: flex-end; }
    .otp-row .field-group { flex: 1; }
    .note-text { font-size: 12px; color: #ffcc80; margin-top: 4px; line-height: 1.5; }
    @media(max-width: 640px) { .two-col, .three-col { grid-template-columns: 1fr; } }
</style>

<div class="register-wrapper">
  <div class="register-container">

    <h3 class="register-title">🛡 Secure User Registration</h3>
    <asp:Label ID="lblError" runat="server" CssClass="error-label"></asp:Label>

    <!-- ══════════════ PERSONAL INFO ══════════════ -->
    <div class="section-header">👤 Personal Information</div>

    <div class="three-col">
      <div class="field-group">
        <label>First Name</label>
        <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" Placeholder="First Name"></asp:TextBox>
        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtFirstName" CssClass="validator-msg"
            Display="Dynamic" ErrorMessage="First name is required" ValidationGroup="REG" />
      </div>
      <div class="field-group">
        <label>Middle Name</label>
        <asp:TextBox ID="txtMiddleName" runat="server" CssClass="form-control" Placeholder="Middle Name"></asp:TextBox>
        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtMiddleName" CssClass="validator-msg"
            Display="Dynamic" ErrorMessage="Middle name is required" ValidationGroup="REG" />
      </div>
      <div class="field-group">
        <label>Last Name</label>
        <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control" Placeholder="Last Name"></asp:TextBox>
        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtLastName" CssClass="validator-msg"
            Display="Dynamic" ErrorMessage="Last name is required" ValidationGroup="REG" />
      </div>
    </div>

    <div class="two-col">
      <div class="field-group">
        <label>Date of Birth</label>
        <asp:TextBox ID="txtDOB" runat="server" CssClass="form-control" type="date"></asp:TextBox>
        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDOB" CssClass="validator-msg"
            Display="Dynamic" ErrorMessage="Date of birth is required" ValidationGroup="REG" />
      </div>
      <div class="field-group">
        <label>Gender</label>
        <div class="radio-group" style="padding-top:10px;">
          <label><asp:RadioButton ID="rbtnMale" runat="server" GroupName="gender" Text="Male" Checked="true" /></label>
          <label><asp:RadioButton ID="rbtnFemale" runat="server" GroupName="gender" Text="Female" /></label>
          <label><asp:RadioButton ID="rbtnNA" runat="server" GroupName="gender" Text="Not ready to disclose" /></label>
        </div>
      </div>
    </div>

    <div class="field-group">
      <label>Address</label>
      <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" TextMode="MultiLine" Placeholder="Full address"></asp:TextBox>
      <asp:RequiredFieldValidator runat="server" ControlToValidate="txtAddress" CssClass="validator-msg"
          Display="Dynamic" ErrorMessage="Address is required" ValidationGroup="REG" />
    </div>

    <div class="two-col">
      <div class="field-group">
        <label>City</label>
        <asp:TextBox ID="txtCity" runat="server" CssClass="form-control" Placeholder="City"></asp:TextBox>
        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCity" CssClass="validator-msg"
            Display="Dynamic" ErrorMessage="City is required" ValidationGroup="REG" />
      </div>
      <div class="field-group">
        <label>State</label>
        <asp:TextBox ID="txtState" runat="server" CssClass="form-control" Placeholder="State"></asp:TextBox>
        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtState" CssClass="validator-msg"
            Display="Dynamic" ErrorMessage="State is required" ValidationGroup="REG" />
      </div>
    </div>

    <!-- ══════════════ ACCOUNT CREDENTIALS ══════════════ -->
    <div class="section-header">🔐 Login Credentials</div>

    <div class="two-col">
      <div class="field-group">
        <label>Mobile Number</label>
        <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control" MaxLength="10" Placeholder="10-digit mobile number"></asp:TextBox>
        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtMobile" CssClass="validator-msg"
            Display="Dynamic" ErrorMessage="Mobile number is required" ValidationGroup="REG" />
        <asp:RegularExpressionValidator runat="server" ControlToValidate="txtMobile" CssClass="validator-msg"
            Display="Dynamic" ErrorMessage="Enter a valid 10-digit number" ValidationExpression="\d{10}" ValidationGroup="REG" />
      </div>
      <div class="field-group">
        <label>Username</label>
        <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" Placeholder="Choose a username"></asp:TextBox>
        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtUsername" CssClass="validator-msg"
            Display="Dynamic" ErrorMessage="Username is required" ValidationGroup="REG" />
      </div>
    </div>

    <div class="two-col">
      <div class="field-group">
        <label>Password</label>
        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" Placeholder="Strong password"></asp:TextBox>
        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPassword" CssClass="validator-msg"
            Display="Dynamic" ErrorMessage="Password is required" ValidationGroup="REG" />
      </div>
      <div class="field-group">
        <label>Confirm Password</label>
        <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="form-control" Placeholder="Confirm password"></asp:TextBox>
        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtConfirmPassword" CssClass="validator-msg"
            Display="Dynamic" ErrorMessage="Please confirm your password" ValidationGroup="REG" />
      </div>
    </div>

    <!-- ══════════════ EMAIL VERIFICATION ══════════════ -->
    <div class="section-header">📧 Email Verification</div>

    <div class="field-group">
      <label>
        Email Address
        <span class="note-text">⚠ Use your correct email — it will receive approval notifications and cannot be changed later.</span>
      </label>
      <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" Placeholder="your@email.com"></asp:TextBox>
      <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail" CssClass="validator-msg"
          Display="Dynamic" ErrorMessage="Email is required" ValidationGroup="REG" />
      <asp:Label ID="lblEmailStatus" runat="server" CssClass="success-label"></asp:Label>
    </div>

    <div class="otp-row">
      <div class="field-group">
        <label>Enter OTP</label>
        <asp:TextBox ID="txtOTP" runat="server" CssClass="form-control" Placeholder="4-digit OTP"></asp:TextBox>
        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtOTP" CssClass="validator-msg"
            Display="Dynamic" ErrorMessage="OTP is required" ValidationGroup="REG" />
        <asp:Label ID="lblOTPCheck" runat="server"></asp:Label>
      </div>
      <div style="margin-bottom:14px; display:flex; gap:8px; flex-direction:column;">
        <asp:Button ID="btnSendOTP" runat="server" Text="Send OTP" CssClass="btn-otp" OnClick="btnSendOTP_Click" CausesValidation="false" />
        <asp:Button ID="btnVerifyOTP" runat="server" Text="Verify OTP" CssClass="btn-otp" OnClick="btnVerifyOTP_Click" CausesValidation="false" />
      </div>
    </div>

    <!-- ══════════════ DOCUMENTS ══════════════ -->
    <div class="section-header">📁 Documents &amp; Photo</div>

    <div class="two-col">
      <div class="field-group">
        <label>Aadhar Card</label>
        <asp:FileUpload ID="fuAadhar" runat="server" CssClass="file-input" />
        <asp:RequiredFieldValidator runat="server" ControlToValidate="fuAadhar" CssClass="validator-msg"
            Display="Dynamic" ErrorMessage="Aadhar card is required" ValidationGroup="REG" />
      </div>
      <div class="field-group">
        <label>PAN Card</label>
        <asp:FileUpload ID="fuPAN" runat="server" CssClass="file-input" />
        <asp:RequiredFieldValidator runat="server" ControlToValidate="fuPAN" CssClass="validator-msg"
            Display="Dynamic" ErrorMessage="PAN card is required" ValidationGroup="REG" />
      </div>
      <div class="field-group">
        <label>Signature</label>
        <asp:FileUpload ID="fuSign" runat="server" CssClass="file-input" />
        <asp:RequiredFieldValidator runat="server" ControlToValidate="fuSign" CssClass="validator-msg"
            Display="Dynamic" ErrorMessage="Signature is required" ValidationGroup="REG" />
      </div>
      <div class="field-group">
        <label>Profile Photo</label>
        <asp:FileUpload ID="fuPhoto" runat="server" CssClass="file-input" />
        <asp:RequiredFieldValidator runat="server" ControlToValidate="fuPhoto" CssClass="validator-msg"
            Display="Dynamic" ErrorMessage="Profile photo is required" ValidationGroup="REG" />
      </div>
    </div>

    <!-- ══════════════ VOICE BIOMETRICS ══════════════ -->
    <div class="section-header">🎙 Voice Biometric Enrollment</div>

    <!-- Voice Sample 1 -->
    <div class="voice-box">
      <label>🎤 Voice Sample 1 of 3 — say your name</label>
      <div class="voice-sample" id="sample1Box">
        <button type="button" class="btn btn-outline-info" onclick="startRec(1)">▶ Start</button>
        <button type="button" class="btn btn-outline-danger" onclick="stopRec(1)">⏹ Stop</button>
        <div class="status-text" id="status1">Speak for at least 4 seconds</div>
        <audio id="audio1" controls class="mt-2"></audio>
      </div>
      <asp:HiddenField ID="hdnVoice1" runat="server" />
    </div>

    <!-- Voice Sample 2 -->
    <div class="voice-box">
      <label>🎤 Voice Sample 2 of 3 — say your mobile number</label>
      <div class="voice-sample" id="sample2Box">
        <button type="button" class="btn btn-outline-info" onclick="startRec(2)">▶ Start</button>
        <button type="button" class="btn btn-outline-danger" onclick="stopRec(2)">⏹ Stop</button>
        <div class="status-text" id="status2">Speak for at least 4 seconds</div>
        <audio id="audio2" controls class="mt-2"></audio>
      </div>
      <asp:HiddenField ID="hdnVoice2" runat="server" />
    </div>

    <!-- Voice Sample 3 -->
    <div class="voice-box">
      <label>🎤 Voice Sample 3 of 3 — say "I am authorised user"</label>
      <div class="voice-sample" id="sample3Box">
        <button type="button" class="btn btn-outline-info" onclick="startRec(3)">▶ Start</button>
        <button type="button" class="btn btn-outline-danger" onclick="stopRec(3)">⏹ Stop</button>
        <div class="status-text" id="status3">Speak for at least 4 seconds</div>
        <audio id="audio3" controls class="mt-2"></audio>
      </div>
      <asp:HiddenField ID="hdnVoice3" runat="server" />
    </div>

    <!-- Hidden field to store hybrid-encrypted mobile -->
    <asp:HiddenField ID="hfHybridMobile" runat="server" />

    <div class="mt-4">
      <asp:Button ID="btnRegister" runat="server" Text="Register Securely" CssClass="btn-register"
          OnClick="btnRegister_Click" ValidationGroup="REG" />
    </div>

    <div class="text-center mt-3 login-link">
      Already have an account? <a href="Login.aspx">Login Here</a>
    </div>

  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
    // ── Voice recording ──────────────────────────────────────────────────
    let recorders = {}, chunks = {}, timers = {}, seconds = {};

    async function startRec(n) {
        chunks[n] = []; seconds[n] = 0;
        const stream = await navigator.mediaDevices.getUserMedia({ audio: true });
        recorders[n] = new MediaRecorder(stream);
        recorders[n].start();
        recorders[n].ondataavailable = e => chunks[n].push(e.data);
        timers[n] = setInterval(() => {
            seconds[n]++;
            document.getElementById('status' + n).innerText = '🔴 Recording... ' + seconds[n] + 's';
        }, 1000);
    }

    function stopRec(n) {
        if (!recorders[n]) return;
        if (seconds[n] < 4) { alert('Please record at least 4 seconds!'); return; }
        clearInterval(timers[n]);
        recorders[n].stop();
        recorders[n].onstop = () => {
            const mimeType = recorders[n].mimeType || 'audio/webm';
            const blob = new Blob(chunks[n], { type: mimeType });
            document.getElementById('audio' + n).src = URL.createObjectURL(blob);
            document.getElementById('status' + n).innerText = '✅ Sample ' + n + ' recorded (' + seconds[n] + 's)';
            document.getElementById('sample' + n + 'Box').classList.add('done');
            const reader = new FileReader();
            reader.readAsDataURL(blob);
            reader.onloadend = () => {
                const hiddenIds = {
                    1: '<%= hdnVoice1.ClientID %>',
                    2: '<%= hdnVoice2.ClientID %>',
                    3: '<%= hdnVoice3.ClientID %>'
                };
                document.getElementById(hiddenIds[n]).value = reader.result;
            };
        };
    }

    // ── Success popup (called from code-behind) ──────────────────────────
    function showSuccessPopup() {
        Swal.fire({
            title: 'Account Created Successfully!',
            text: 'Your account is under review. Please wait for approval.',
            icon: 'success',
            confirmButtonText: 'Go to Login'
        }).then(result => {
            if (result.isConfirmed) window.location.href = 'Login.aspx';
        });
    }
</script>
</asp:Content>
