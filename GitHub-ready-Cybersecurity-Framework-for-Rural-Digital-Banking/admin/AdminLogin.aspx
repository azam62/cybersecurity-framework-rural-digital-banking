<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminLogin.aspx.cs" Inherits="Cybersecurity_Framework_for_Rural_Digital_Banking.admin.AdminLogin" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Login | Rural Bank Security</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            position: relative;
        }

        /* ── Animated grid background ── */
        body::before {
            content: '';
            position: fixed; inset: 0;
            background-image:
                linear-gradient(rgba(0,255,213,0.04) 1px, transparent 1px),
                linear-gradient(90deg, rgba(0,255,213,0.04) 1px, transparent 1px);
            background-size: 40px 40px;
            pointer-events: none;
            z-index: 0;
        }

        /* ── Glow orbs ── */
        .orb {
            position: fixed;
            border-radius: 50%;
            filter: blur(80px);
            pointer-events: none;
            z-index: 0;
        }

        .orb-1 {
            width: 400px; height: 400px;
            background: rgba(0,114,255,0.12);
            top: -100px; left: -100px;
        }

        .orb-2 {
            width: 350px; height: 350px;
            background: rgba(0,255,213,0.08);
            bottom: -80px; right: -80px;
        }

        /* ── Page header ── */
        .page-header {
            text-align: center;
            margin-bottom: 32px;
            position: relative; z-index: 1;
        }

        .page-header .shield-icon {
            font-size: 42px;
            display: block;
            margin-bottom: 8px;
            filter: drop-shadow(0 0 12px rgba(0,255,213,0.5));
        }

        .page-header h1 {
            font-size: 22px;
            font-weight: 700;
            color: #00ffd5;
            text-shadow: 0 0 14px rgba(0,255,213,0.4);
            letter-spacing: 0.5px;
        }

        .page-header p {
            font-size: 13px;
            color: rgba(200,230,255,0.55);
            margin-top: 4px;
        }

        /* ── Login Card ── */
        .login-card {
            width: 100%;
            max-width: 400px;
            background: rgba(255,255,255,0.07);
            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);
            border: 1px solid rgba(0,255,213,0.18);
            border-radius: 22px;
            padding: 40px 36px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.6), 0 0 40px rgba(0,198,213,0.06);
            position: relative; z-index: 1;
        }

        .login-card::before {
            content: '';
            position: absolute; top: -50px; left: 50%;
            transform: translateX(-50%);
            width: 250px; height: 250px;
            background: radial-gradient(circle, rgba(0,255,213,0.1) 0%, transparent 70%);
            pointer-events: none;
        }

        /* Avatar */
        .avatar-box {
            text-align: center;
            margin-bottom: 28px;
        }

        .avatar-circle {
            width: 68px; height: 68px;
            background: rgba(0,255,213,0.12);
            border: 2px solid rgba(0,255,213,0.3);
            border-radius: 50%;
            display: inline-flex; align-items: center; justify-content: center;
            font-size: 28px;
            box-shadow: 0 0 20px rgba(0,255,213,0.15);
        }

        .avatar-label {
            display: block; margin-top: 10px;
            font-size: 13px; font-weight: 600;
            color: rgba(200,230,255,0.7);
            letter-spacing: 0.5px;
        }

        /* Field */
        .field-group { margin-bottom: 20px; }

        .field-group label {
            display: block;
            font-size: 12.5px; font-weight: 500;
            color: #cce8ff; margin-bottom: 7px;
        }

        .input-wrapper { position: relative; }

        .input-icon {
            position: absolute; left: 14px; top: 50%;
            transform: translateY(-50%);
            color: rgba(0,255,213,0.5); font-size: 14px;
            pointer-events: none;
        }

        .input-textbox {
            width: 100%;
            background: rgba(255,255,255,0.08) !important;
            border: 1px solid rgba(0,255,213,0.35) !important;
            border-radius: 12px !important;
            color: #fff !important;
            font-family: 'Poppins', sans-serif !important;
            font-size: 14px !important;
            height: 48px;
            padding: 0 14px 0 40px;
            transition: border-color 0.3s, box-shadow 0.3s;
            outline: none;
        }

        .input-textbox:focus {
            border-color: #00ffd5 !important;
            box-shadow: 0 0 14px rgba(0,255,213,0.3) !important;
            background: rgba(255,255,255,0.12) !important;
        }

        .input-textbox::placeholder { color: rgba(255,255,255,0.3); }

        /* Button */
        .btn-login {
            width: 100%;
            background: linear-gradient(90deg, #00c6ff, #0072ff);
            border: none;
            color: #fff;
            font-family: 'Poppins', sans-serif;
            font-size: 15px;
            font-weight: 600;
            height: 50px;
            border-radius: 30px;
            cursor: pointer;
            letter-spacing: 0.5px;
            transition: transform 0.25s, box-shadow 0.25s;
            margin-top: 8px;
        }

        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 0 24px rgba(0,198,255,0.55);
        }

        /* Error */
        .error-label {
            display: block; text-align: center;
            margin-top: 14px; font-size: 13px;
            color: #ff5c5c; font-weight: 600;
        }

        /* Divider */
        .card-divider {
            border: none; border-top: 1px solid rgba(0,255,213,0.12);
            margin: 24px 0;
        }

        /* Security note */
        .security-note {
            text-align: center;
            font-size: 11.5px;
            color: rgba(200,230,255,0.4);
            line-height: 1.6;
        }

        /* Floating particles */
        .particle {
            position: fixed;
            width: 2px; height: 2px;
            background: rgba(0,255,213,0.45);
            border-radius: 50%;
            animation: float-p linear infinite;
            pointer-events: none; z-index: 0;
        }

        .particle:nth-child(1) { left: 10%; animation-duration: 14s; animation-delay: 0s; }
        .particle:nth-child(2) { left: 30%; animation-duration: 18s; animation-delay: 3s; width: 3px; height: 3px; }
        .particle:nth-child(3) { left: 55%; animation-duration: 12s; animation-delay: 6s; }
        .particle:nth-child(4) { left: 75%; animation-duration: 16s; animation-delay: 2s; width: 3px; height: 3px; }
        .particle:nth-child(5) { left: 90%; animation-duration: 20s; animation-delay: 8s; }

        @keyframes float-p {
            0%   { transform: translateY(100vh); opacity: 0; }
            10%  { opacity: 0.6; }
            90%  { opacity: 0.3; }
            100% { transform: translateY(-5vh); opacity: 0; }
        }
    </style>
</head>
<body>

    <div class="orb orb-1"></div>
    <div class="orb orb-2"></div>
    <div class="particle"></div>
    <div class="particle"></div>
    <div class="particle"></div>
    <div class="particle"></div>
    <div class="particle"></div>

    <form id="form1" runat="server">

        <div class="page-header">
            <span class="shield-icon">🛡</span>
            <h1>Rural Bank Security</h1>
            <p>Secure Admin Access Portal</p>
        </div>

        <div class="login-card">

            <div class="avatar-box">
                <div class="avatar-circle">👤</div>
                <span class="avatar-label">ADMINISTRATOR LOGIN</span>
            </div>

            <div class="field-group">
                <label>Username</label>
                <div class="input-wrapper">
                    <i class="fa fa-user input-icon"></i>
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="input-textbox" placeholder="Enter username"></asp:TextBox>
                </div>
            </div>

            <div class="field-group">
                <label>Password</label>
                <div class="input-wrapper">
                    <i class="fa fa-lock input-icon"></i>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="input-textbox" TextMode="Password" placeholder="Enter password"></asp:TextBox>
                </div>
            </div>

            <asp:Button ID="btnSubmit" CssClass="btn-login" runat="server" Text="Login Securely" OnClick="btnSubmit_Click" />

            <asp:Label ID="lblError" runat="server" Text="" CssClass="error-label"></asp:Label>

            <hr class="card-divider" />

            <p class="security-note">
                🔒 This portal is restricted to authorized administrators only.<br />
                All login attempts are logged and monitored.
            </p>

        </div>

    </form>
</body>
</html>
