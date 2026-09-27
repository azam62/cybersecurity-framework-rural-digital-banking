<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="Cybersecurity_Framework_for_Rural_Digital_Banking.About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<style>
    .about-header {
        text-align: center;
        padding: 40px 20px;
    }

    .about-header h2 {
        font-size: 36px;
        font-weight: 700;
        color: #00ffd5;
        text-shadow: 0 0 15px #00ffd5;
    }

    .about-header p {
        color: #ccc;
        margin-top: 10px;
        font-size: 17px;
    }

    .about-section {
        background: rgba(255,255,255,0.05);
        padding: 30px;
        border-radius: 15px;
        margin-bottom: 30px;
        box-shadow: 0 8px 25px rgba(0,0,0,0.4);
    }

    .about-section h4 {
        color: #00ffd5;
        margin-bottom: 15px;
    }

    .feature-box {
        background: rgba(0,0,0,0.3);
        padding: 20px;
        border-radius: 12px;
        text-align: center;
        transition: 0.3s;
        height: 100%;
    }

    .feature-box:hover {
        transform: translateY(-6px);
        box-shadow: 0 10px 25px rgba(0,255,213,0.4);
    }

    .feature-box h5 {
        color: #00ffd5;
        margin-bottom: 10px;
    }

    @media (max-width: 768px) {
        .about-header h2 {
            font-size: 26px;
        }
    }
</style>

<!-- HEADER -->
<div class="about-header">
    <h2>About the Project</h2>
    <p>
        A lightweight multi-layer cybersecurity framework designed to protect rural digital banking users.
    </p>
</div>

<!-- OBJECTIVE SECTION -->
<div class="about-section">
    <h4>🎯 Project Objective</h4>
    <p>
        The objective of this project is to develop a secure and lightweight authentication 
        framework for rural digital banking systems. It integrates OTP verification, CAPTCHA, 
        voice authentication, encryption techniques, and fraud detection mechanisms while 
        remaining compatible with low-end smartphones and limited internet connectivity.
    </p>
</div>

<!-- PROBLEM STATEMENT -->
<div class="about-section">
    <h4>⚠ Problem Statement</h4>
    <p>
        Rural users face increasing risks of digital banking fraud due to weak authentication,
        low digital literacy, and poor network connectivity. Traditional security systems
        are often complex and resource-heavy. This project addresses the need for a
        simple, secure, and user-friendly framework tailored for rural environments.
    </p>
</div>

<!-- KEY FEATURES -->
<div class="container mb-4">
    <h4 class="text-center mb-4" style="color:#00ffd5;">🔐 Key Security Features</h4>
    <div class="row g-4">

        <div class="col-md-4">
            <div class="feature-box">
                <h5>Multi-Factor Authentication</h5>
                <p>Password + OTP + Voice + CAPTCHA verification.</p>
            </div>
        </div>

        <div class="col-md-4">
            <div class="feature-box">
                <h5>AES Encryption</h5>
                <p>Secures sensitive user data and stored credentials.</p>
            </div>
        </div>

        <div class="col-md-4">
            <div class="feature-box">
                <h5>Fraud Detection</h5>
                <p>Detects abnormal login attempts and suspicious behavior.</p>
            </div>
        </div>

        <div class="col-md-4">
            <div class="feature-box">
                <h5>Session Management</h5>
                <p>Automatic logout after inactivity to prevent misuse.</p>
            </div>
        </div>

        <div class="col-md-4">
            <div class="feature-box">
                <h5>Account Lock System</h5>
                <p>Locks account after repeated failed login attempts.</p>
            </div>
        </div>

        <div class="col-md-4">
            <div class="feature-box">
                <h5>Lightweight Design</h5>
                <p>Optimized for rural networks and low-end devices.</p>
            </div>
        </div>

    </div>
</div>

<!-- FUTURE SCOPE -->
<div class="about-section">
    <h4>🚀 Future Scope</h4>
    <p>
        Future enhancements may include AI-based fraud detection,
        biometric authentication integration, multilingual support,
        and integration with real banking APIs for real-time transactions.
    </p>
</div>

</asp:Content>
