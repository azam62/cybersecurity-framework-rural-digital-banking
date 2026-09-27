<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="Cybersecurity_Framework_for_Rural_Digital_Banking.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<style>
    .contact-header {
        text-align: center;
        padding: 40px 20px;
    }

    .contact-header h2 {
        font-size: 36px;
        font-weight: 700;
        color: #00ffd5;
        text-shadow: 0 0 15px #00ffd5;
    }

    .contact-header p {
        color: #ccc;
        margin-top: 10px;
    }

    .contact-card {
        background: rgba(255,255,255,0.05);
        padding: 25px;
        border-radius: 15px;
        box-shadow: 0 8px 25px rgba(0,0,0,0.4);
        transition: 0.3s;
        height: 100%;
    }

    .contact-card:hover {
        transform: translateY(-6px);
        box-shadow: 0 12px 30px rgba(0,255,213,0.4);
    }

    .contact-card h5 {
        color: #00ffd5;
        margin-bottom: 15px;
    }

    .form-control {
        background: rgba(255,255,255,0.08);
        border: 1px solid #00ffd5;
        color: #fff;
    }

    .form-control:focus {
        box-shadow: 0 0 10px #00ffd5;
        border-color: #00ffd5;
        background: rgba(255,255,255,0.12);
        color: #fff;
    }

    .btn-send {
        background: linear-gradient(90deg, #00c6ff, #0072ff);
        border: none;
        color: #fff;
        font-weight: 600;
        padding: 10px 25px;
        border-radius: 30px;
        transition: 0.3s;
    }

    .btn-send:hover {
        transform: scale(1.05);
        box-shadow: 0 0 15px #00c6ff;
    }

    @media (max-width: 768px) {
        .contact-header h2 {
            font-size: 26px;
        }
    }
</style>

<!-- HEADER -->
<div class="contact-header">
    <h2>📞 Contact & Support</h2>
    <p>We are committed to securing rural digital banking. Reach out for support or security assistance.</p>
</div>

<!-- CONTACT INFO + FORM -->
<div class="container mt-4">
    <div class="row g-4">

        <!-- Contact Information -->
        <div class="col-md-5">
            <div class="contact-card">
                <h5>🛡 Security Support</h5>
                <p><strong>Email:</strong> support@ruralsecurebank.com</p>
                <p><strong>Phone:</strong> +91 98765 43210</p>
                <p><strong>Working Hours:</strong> 9:00 AM – 6:00 PM</p>
                <p>
                    For fraud reports or suspicious activity,
                    contact us immediately to secure your account.
                </p>
            </div>
        </div>

        <!-- Contact Form -->
        <div class="col-md-7">
            <div class="contact-card">
                <h5>📩 Send Us a Message</h5>

                <div class="mb-3">
                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control" Placeholder="Your Name"></asp:TextBox>
                </div>

                <div class="mb-3">
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" Placeholder="Your Email"></asp:TextBox>
                </div>

                <div class="mb-3">
                    <asp:TextBox ID="txtMessage" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" Placeholder="Your Message"></asp:TextBox>
                </div>

                <div class="text-center">
                    <asp:Button ID="btnSend" runat="server" Text="Send Secure Message" CssClass="btn-send" />
                </div>

            </div>
        </div>

    </div>
</div>

</asp:Content>
