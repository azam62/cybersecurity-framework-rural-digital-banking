<%@ Page Title="" Language="C#" MasterPageFile="~/user/user-masterpage.Master" AutoEventWireup="true" CodeBehind="AI_SpendingAnalysis.aspx.cs" Inherits="Cybersecurity_Framework_for_Rural_Digital_Banking.user.AI_SpendingAnalysis" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<style>
    /* ── PARTICLES CANVAS ── */
    #particles-canvas {
        position: fixed; top: 0; left: 0;
        width: 100%; height: 100%;
        pointer-events: none; z-index: 0;
    }

    /* ── PAGE SHELL ── */
    .sa-page {
        position: relative; z-index: 1;
        padding: 36px 32px;
        min-height: 100vh;
        font-family: 'Poppins', sans-serif;
    }

    /* ── RADIAL GLOW ── */
    .sa-page::before {
        content: '';
        position: fixed;
        top: 50%; left: 50%;
        transform: translate(-50%, -50%);
        width: 700px; height: 700px;
        background: radial-gradient(circle, rgba(0,255,213,0.07) 0%, transparent 70%);
        pointer-events: none; z-index: 0;
    }

    /* ── PAGE TITLE ── */
    .sa-header {
        display: flex;
        align-items: center;
        gap: 14px;
        margin-bottom: 32px;
    }
    .sa-header-icon {
        width: 46px; height: 46px;
        border-radius: 12px;
        background: linear-gradient(135deg, rgba(0,255,213,0.18), rgba(0,255,213,0.06));
        border: 1px solid rgba(0,255,213,0.35);
        display: flex; align-items: center; justify-content: center;
        font-size: 22px;
        box-shadow: 0 0 16px rgba(0,255,213,0.15);
    }
    .sa-header-title {
        font-size: 24px; font-weight: 700;
        color: #00ffd5;
        text-shadow: 0 0 18px rgba(0,255,213,0.45);
        letter-spacing: 0.4px;
    }
    .sa-header-sub {
        font-size: 12px; color: rgba(0,255,213,0.5);
        letter-spacing: 1.5px; text-transform: uppercase;
    }

    /* ── GRID ── */
    .sa-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
        gap: 22px;
    }
    .sa-grid-full { grid-column: 1 / -1; }

    /* ── GLASS CARD ── */
    .sa-card {
        background: rgba(255,255,255,0.05);
        backdrop-filter: blur(18px);
        -webkit-backdrop-filter: blur(18px);
        border: 1px solid rgba(0,255,213,0.15);
        border-radius: 18px;
        padding: 26px 28px;
        box-shadow:
            0 0 0 1px rgba(0,255,213,0.05),
            0 8px 40px rgba(0,0,0,0.4),
            inset 0 1px 0 rgba(255,255,255,0.07);
        transition: border-color 0.3s, box-shadow 0.3s;
        animation: cardIn 0.5s ease both;
    }
    .sa-card:hover {
        border-color: rgba(0,255,213,0.32);
        box-shadow:
            0 0 0 1px rgba(0,255,213,0.12),
            0 12px 50px rgba(0,0,0,0.5),
            0 0 30px rgba(0,255,213,0.06);
    }
    .sa-card:nth-child(1) { animation-delay: 0.05s; }
    .sa-card:nth-child(2) { animation-delay: 0.12s; }
    .sa-card:nth-child(3) { animation-delay: 0.19s; }
    .sa-card:nth-child(4) { animation-delay: 0.26s; }
    @keyframes cardIn {
        from { opacity: 0; transform: translateY(18px); }
        to   { opacity: 1; transform: translateY(0); }
    }

    /* ── CARD TITLE ── */
    .sa-card-title {
        font-size: 11px; font-weight: 700;
        letter-spacing: 2px; text-transform: uppercase;
        color: rgba(0,255,213,0.55);
        margin-bottom: 18px;
        display: flex; align-items: center; gap: 8px;
    }
    .sa-card-title::before {
        content: '';
        display: inline-block;
        width: 3px; height: 14px;
        background: linear-gradient(180deg, #00ffd5, rgba(0,255,213,0.2));
        border-radius: 3px;
    }

    /* ── SUMMARY ROWS ── */
    .sa-summary-row {
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 12px 0;
        border-bottom: 1px solid rgba(255,255,255,0.06);
    }
    .sa-summary-row:last-child { border-bottom: none; padding-bottom: 0; }
    .sa-summary-label {
        font-size: 13px; color: rgba(185,222,255,0.65);
        display: flex; align-items: center; gap: 8px;
    }
    .sa-summary-label .dot {
        width: 8px; height: 8px; border-radius: 50%;
        flex-shrink: 0;
    }
    .dot-green  { background: #00ffd5; box-shadow: 0 0 6px #00ffd5; }
    .dot-red    { background: #ff6b6b; box-shadow: 0 0 6px #ff6b6b; }
    .dot-yellow { background: #ffd700; box-shadow: 0 0 6px #ffd700; }
    .sa-summary-value {
        font-size: 18px; font-weight: 700;
        color: #fff;
    }
    .sa-summary-value.positive { color: #00ffd5; }
    .sa-summary-value.negative { color: #ff6b6b; }
    .sa-summary-value .rupee { font-size: 13px; opacity: 0.7; margin-right: 2px; }

    /* ── CATEGORY CHIP ── */
    .sa-category-chip {
        display: inline-flex; align-items: center; gap: 10px;
        background: linear-gradient(135deg, rgba(0,255,213,0.12), rgba(0,255,213,0.04));
        border: 1px solid rgba(0,255,213,0.28);
        border-radius: 50px;
        padding: 10px 20px;
        font-size: 15px; font-weight: 600;
        color: #00ffd5;
        box-shadow: 0 0 20px rgba(0,255,213,0.1);
    }

    /* ── PATTERN TEXT ── */
    .sa-pattern-text {
        font-size: 14px;
        line-height: 1.8;
        color: rgba(200,230,255,0.82);
    }

    /* ── SUGGESTIONS LIST ── */
    .sa-suggestions {
        display: flex; flex-direction: column; gap: 10px;
    }
    .sa-suggestion-item {
        display: flex; align-items: flex-start; gap: 12px;
        background: rgba(0,0,0,0.2);
        border-radius: 10px;
        padding: 12px 14px;
        font-size: 13.5px;
        line-height: 1.6;
        color: rgba(200,230,255,0.85);
        border-left: 3px solid rgba(0,255,213,0.3);
    }
    .sa-suggestion-icon { font-size: 16px; flex-shrink: 0; margin-top: 1px; }
</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <!-- Animated particle background -->
    <canvas id="particles-canvas"></canvas>

    <div class="sa-page">

        <!-- Header -->
        <div class="sa-header">
            <div class="sa-header-icon">📊</div>
            <div>
                <div class="sa-header-title">AI Spending Analysis</div>
                <div class="sa-header-sub">Powered by machine learning · Real-time insights</div>
            </div>
        </div>

        <div class="sa-grid">

            <!-- Monthly Summary -->
            <div class="sa-card">
                <div class="sa-card-title">Monthly Expense Summary</div>
                <div class="sa-summary-row">
                    <span class="sa-summary-label"><span class="dot dot-green"></span>Total Deposit</span>
                    <span class="sa-summary-value positive">
                        <span class="rupee">₹</span><asp:Label ID="lblDeposit" runat="server" />
                    </span>
                </div>
                <div class="sa-summary-row">
                    <span class="sa-summary-label"><span class="dot dot-red"></span>Total Withdrawal</span>
                    <span class="sa-summary-value negative">
                        <span class="rupee">₹</span><asp:Label ID="lblWithdraw" runat="server" />
                    </span>
                </div>
                <div class="sa-summary-row">
                    <span class="sa-summary-label"><span class="dot dot-yellow"></span>Net Savings</span>
                    <span class="sa-summary-value">
                        <span class="rupee">₹</span><asp:Label ID="lblSavings" runat="server" />
                    </span>
                </div>
            </div>

            <!-- Category -->
            <div class="sa-card">
                <div class="sa-card-title">Spending Category Prediction</div>
                <div style="padding: 8px 0;">
                    <span class="sa-category-chip">
                        🏷️ <asp:Label ID="lblCategory" runat="server" />
                    </span>
                </div>
            </div>

            <!-- Savings Pattern -->
            <div class="sa-card">
                <div class="sa-card-title">Savings Pattern Analysis</div>
                <div class="sa-pattern-text">
                    📈 <asp:Label ID="lblPattern" runat="server" />
                </div>
            </div>

            <!-- AI Suggestions -->
            <div class="sa-card">
                <div class="sa-card-title">Smart AI Suggestions</div>
                <div class="sa-suggestions">
                    <div class="sa-suggestion-item">
                        <span class="sa-suggestion-icon">💡</span>
                        <asp:Label ID="lblSuggestion" runat="server" />
                    </div>
                </div>
            </div>

        </div>
    </div>

    <script>
    // Floating particles
    (function () {
        const canvas = document.getElementById('particles-canvas');
        const ctx = canvas.getContext('2d');
        let W, H, particles = [];

        function resize() {
            W = canvas.width = window.innerWidth;
            H = canvas.height = window.innerHeight;
        }
        resize();
        window.addEventListener('resize', resize);

        for (let i = 0; i < 55; i++) {
            particles.push({
                x: Math.random() * 1920, y: Math.random() * 1080,
                r: Math.random() * 1.5 + 0.4,
                vx: (Math.random() - 0.5) * 0.3,
                vy: (Math.random() - 0.5) * 0.3,
                a: Math.random() * 0.45 + 0.1
            });
        }

        function draw() {
            ctx.clearRect(0, 0, W, H);
            particles.forEach(p => {
                ctx.beginPath();
                ctx.arc(p.x, p.y, p.r, 0, Math.PI * 2);
                ctx.fillStyle = `rgba(0,255,213,${p.a})`;
                ctx.fill();
                p.x += p.vx; p.y += p.vy;
                if (p.x < 0) p.x = W; if (p.x > W) p.x = 0;
                if (p.y < 0) p.y = H; if (p.y > H) p.y = 0;
            });
            requestAnimationFrame(draw);
        }
        draw();
    })();
    </script>

</asp:Content>
