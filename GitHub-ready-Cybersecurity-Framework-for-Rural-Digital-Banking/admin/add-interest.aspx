<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin-masterpage.Master" AutoEventWireup="true" CodeBehind="add-interest.aspx.cs" Inherits="Cybersecurity_Framework_for_Rural_Digital_Banking.admin.add_interest" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet" />
    <style>
        /* ── Page Base ── */
        body, #layoutSidenav_content {
            background: linear-gradient(135deg, #0f2027, #203a43, #2c5364) !important;
            font-family: 'Poppins', 'Segoe UI', sans-serif !important;
            min-height: 100vh;
            color: #fff !important;
        }

        /* ── Page wrapper ── */
        .interest-wrapper {
            min-height: 90vh;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            padding: 40px 20px;
        }

        /* ── Glass Card ── */
        .interest-card {
            width: 100%;
            max-width: 560px;
            background: rgba(255, 255, 255, 0.07);
            backdrop-filter: blur(14px);
            -webkit-backdrop-filter: blur(14px);
            border: 1px solid rgba(0, 255, 213, 0.18);
            border-radius: 22px;
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.55), 0 0 30px rgba(0, 198, 213, 0.08);
            padding: 42px 40px;
            position: relative;
            overflow: hidden;
        }

        /* top glow accent */
        .interest-card::before {
            content: '';
            position: absolute;
            top: -60px;
            left: 50%;
            transform: translateX(-50%);
            width: 280px;
            height: 280px;
            background: radial-gradient(circle, rgba(0, 255, 213, 0.12) 0%, transparent 70%);
            pointer-events: none;
        }

        /* ── Title ── */
        .interest-title {
            text-align: center;
            font-size: 22px;
            font-weight: 700;
            color: #00ffd5;
            text-shadow: 0 0 12px rgba(0, 255, 213, 0.6);
            margin-bottom: 10px;
            letter-spacing: 0.5px;
        }

        .interest-subtitle {
            text-align: center;
            font-size: 13px;
            color: rgba(200, 230, 255, 0.65);
            margin-bottom: 34px;
        }

        /* ── Divider ── */
        .divider {
            border: none;
            border-top: 1px solid rgba(0, 255, 213, 0.2);
            margin: 0 0 30px;
        }

        /* ── Label ── */
        .field-label {
            display: block;
            font-size: 13px;
            font-weight: 500;
            color: #cce8ff;
            margin-bottom: 8px;
            letter-spacing: 0.3px;
        }

        /* ── Input ── */
        .interest-input {
            width: 100%;
            background: rgba(255, 255, 255, 0.08) !important;
            border: 1px solid rgba(0, 255, 213, 0.4) !important;
            border-radius: 12px !important;
            color: #ffffff !important;
            font-family: 'Poppins', sans-serif !important;
            font-size: 15px !important;
            height: 50px !important;
            padding: 0 18px !important;
            margin-top: 0 !important;
            transition: border-color 0.3s, box-shadow 0.3s;
            box-sizing: border-box;
        }

        .interest-input:focus {
            outline: none !important;
            border-color: #00ffd5 !important;
            box-shadow: 0 0 14px rgba(0, 255, 213, 0.35) !important;
            background: rgba(255, 255, 255, 0.12) !important;
        }

        .interest-input::placeholder {
            color: rgba(255, 255, 255, 0.35) !important;
        }

        /* ── Percent Badge ── */
        .input-wrapper {
            position: relative;
        }

        .percent-badge {
            position: absolute;
            right: 16px;
            top: 50%;
            transform: translateY(-50%);
            color: #00ffd5;
            font-size: 18px;
            font-weight: 700;
            pointer-events: none;
        }

        /* ── Info note ── */
        .info-note {
            display: flex;
            align-items: flex-start;
            gap: 10px;
            background: rgba(0, 255, 213, 0.07);
            border: 1px solid rgba(0, 255, 213, 0.2);
            border-radius: 10px;
            padding: 12px 16px;
            margin: 24px 0;
            font-size: 12.5px;
            color: rgba(200, 240, 255, 0.8);
            line-height: 1.6;
        }

        .info-note .info-icon {
            font-size: 16px;
            flex-shrink: 0;
            margin-top: 1px;
        }

        /* ── Submit Button ── */
        .btn-interest {
            width: 100%;
            background: linear-gradient(90deg, #00c6ff, #0072ff) !important;
            border: none !important;
            color: #fff !important;
            font-family: 'Poppins', sans-serif !important;
            font-size: 15px !important;
            font-weight: 600 !important;
            height: 52px !important;
            border-radius: 30px !important;
            cursor: pointer;
            letter-spacing: 0.5px;
            transition: transform 0.25s, box-shadow 0.25s !important;
            margin-top: 8px !important;
        }

        .btn-interest:hover {
            transform: translateY(-2px) !important;
            box-shadow: 0 0 22px rgba(0, 198, 255, 0.55) !important;
        }

        .btn-interest:active {
            transform: translateY(0) !important;
        }

        /* ── Status Label ── */
        .status-label {
            display: block;
            text-align: center;
            margin-top: 16px;
            font-size: 13px;
            font-weight: 600;
        }

        /* ── Floating particles (pure CSS, no JS) ── */
        .particles {
            position: fixed;
            inset: 0;
            pointer-events: none;
            z-index: 0;
            overflow: hidden;
        }

        .particle {
            position: absolute;
            width: 2px;
            height: 2px;
            background: rgba(0, 255, 213, 0.5);
            border-radius: 50%;
            animation: float-up linear infinite;
        }

        .particle:nth-child(1)  { left: 10%; animation-duration: 12s; animation-delay: 0s;   width: 3px; height: 3px; }
        .particle:nth-child(2)  { left: 25%; animation-duration: 16s; animation-delay: 3s; }
        .particle:nth-child(3)  { left: 40%; animation-duration: 11s; animation-delay: 6s;   width: 3px; height: 3px; }
        .particle:nth-child(4)  { left: 60%; animation-duration: 14s; animation-delay: 1s; }
        .particle:nth-child(5)  { left: 75%; animation-duration: 18s; animation-delay: 4s;   width: 4px; height: 4px; }
        .particle:nth-child(6)  { left: 88%; animation-duration: 13s; animation-delay: 7s; }
        .particle:nth-child(7)  { left: 50%; animation-duration: 15s; animation-delay: 2s; }
        .particle:nth-child(8)  { left: 5%;  animation-duration: 17s; animation-delay: 9s; }

        @keyframes float-up {
            0%   { transform: translateY(100vh) scale(1);   opacity: 0; }
            10%  { opacity: 0.6; }
            90%  { opacity: 0.3; }
            100% { transform: translateY(-10vh) scale(1.5); opacity: 0; }
        }

        /* keep card above particles */
        .interest-wrapper { position: relative; z-index: 1; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <%-- Hidden fields — backend unchanged --%>
    <asp:HiddenField ID="hfCustomerID" runat="server" />
    <asp:HiddenField ID="hfAccountNo"  runat="server" />

    <%-- Floating particles --%>
    <div class="particles" aria-hidden="true">
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
    </div>

    <div class="interest-wrapper">
        <div class="interest-card">

            <%-- Title --%>
            <div class="interest-title">💹 Add Interest</div>
            <div class="interest-subtitle">Apply a percentage-based interest to all active accounts</div>
            <hr class="divider" />

            <%-- Interest Input --%>
            <div style="margin-bottom: 6px;">
                <label class="field-label" for="<%= txtInterest.ClientID %>">
                    Interest Rate
                </label>
                <div class="input-wrapper">
                    <asp:TextBox 
                        ID="txtInterest" 
                        runat="server" 
                        CssClass="interest-input" 
                        placeholder="e.g. 4.5">
                    </asp:TextBox>
                    <span class="percent-badge">%</span>
                </div>
            </div>

            <%-- Info note --%>
            <div class="info-note">
                <span class="info-icon">⚠️</span>
                <span>
                    This action will apply the specified interest rate to <strong>all</strong> customer accounts. 
                    Please double-check the value before submitting. This cannot be undone.
                </span>
            </div>

            <%-- Submit — same ID and OnClick as original --%>
            <asp:Button 
                ID="btnInterest" 
                runat="server" 
                Text="Apply Interest to All Accounts" 
                CssClass="btn-interest" 
                OnClick="btnInterest_Click" />

            <%-- Status label — same ID as original --%>
            <asp:Label 
                ID="lblBalance" 
                runat="server" 
                Text="" 
                ForeColor="Red" 
                Font-Size="Large" 
                CssClass="status-label">
            </asp:Label>

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</asp:Content>
