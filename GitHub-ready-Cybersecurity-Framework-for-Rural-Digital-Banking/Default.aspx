<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Cybersecurity_Framework_for_Rural_Digital_Banking._Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<style>
    /* Hero Section */
    .hero-section {
        text-align: center;
        padding: 60px 20px;
    }

    .hero-section h1 {
        font-size: 40px;
        font-weight: 700;
        color: #00ffd5;
        text-shadow: 0 0 15px #00ffd5;
    }

    .hero-section p {
        font-size: 18px;
        margin-top: 20px;
        color: #ddd;
    }

    .hero-buttons {
        margin-top: 30px;
    }

    .hero-buttons .btn {
        margin: 10px;
        padding: 12px 25px;
        border-radius: 30px;
        font-weight: 600;
    }

    /* Feature Cards */
    .feature-card {
        background: rgba(255,255,255,0.05);
        border-radius: 15px;
        padding: 25px;
        text-align: center;
        transition: 0.3s;
        height: 100%;
        box-shadow: 0 5px 15px rgba(0,0,0,0.4);
    }

    .feature-card:hover {
        transform: translateY(-8px);
        box-shadow: 0 10px 25px rgba(0,255,213,0.4);
    }

    .feature-card h4 {
        color: #00ffd5;
        margin-bottom: 15px;
    }

    /* Awareness Section */
    .awareness-section {
        margin-top: 60px;
        padding: 30px;
        background: rgba(0,0,0,0.3);
        border-radius: 15px;
    }

    .awareness-section h3 {
        color: #00ffd5;
        margin-bottom: 20px;
    }

    @media (max-width: 768px) {
        .hero-section h1 {
            font-size: 28px;
        }
    }
</style>

<!-- HERO SECTION -->
<div class="hero-section">
    <h1>Secure Rural Digital Banking</h1>
    <p>
        Protecting rural users with multi-layer authentication, encryption,
        OTP verification, and voice-based identity protection.
    </p>

    <div class="hero-buttons">
        <a href="Register.aspx" class="btn btn-primary">Register Now</a>
        <a href="Login.aspx" class="btn btn-outline-info">Secure Login</a>
          <a href="admin/AdminLogin.aspx" class="btn btn-primary">Admin Login</a>
    </div>
</div>

<!-- FEATURES SECTION -->
<div class="container mt-5">
    <div class="row g-4">

        <div class="col-md-4">
            <div class="feature-card">
                <h4>🔐 Multi-Factor Authentication</h4>
                <p>Password, OTP, CAPTCHA, and Voice Authentication
                   ensure maximum security.</p>
            </div>
        </div>

        <div class="col-md-4">
            <div class="feature-card">
                <h4>🛡 Fraud Detection</h4>
                <p>Detects suspicious login attempts and protects
                   users from digital fraud.</p>
            </div>
        </div>

        <div class="col-md-4">
            <div class="feature-card">
                <h4>⚡ Lightweight & Fast</h4>
                <p>Designed for low-end smartphones and limited
                   internet connectivity.</p>
               <%-- <asp:Label ID="lblshow" runat="server" Text="dfs"></asp:Label>--%>
            </div>
        </div>

    </div>
</div>

<!-- AWARENESS SECTION -->
<div class="awareness-section mt-5">
    <h3>📢 Cybersecurity Awareness</h3>
    <p>
        Never share your OTP with anyone.  
        Always verify the website before logging in.  
        Report suspicious activity immediately.  
        Keep your mobile device secure.
    </p>
</div>


</asp:Content>
