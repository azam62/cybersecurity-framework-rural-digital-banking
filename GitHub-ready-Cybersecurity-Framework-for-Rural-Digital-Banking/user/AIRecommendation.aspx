<%@ Page Title="" Language="C#" MasterPageFile="~/user/user-masterpage.Master" AutoEventWireup="true" CodeBehind="AIRecommendation.aspx.cs" Inherits="Cybersecurity_Framework_for_Rural_Digital_Banking.user.AIRecommendation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<style>
    #particles-canvas {
        position: fixed; top: 0; left: 0;
        width: 100%; height: 100%;
        pointer-events: none; z-index: 0;
    }
    .ar-page {
        position: relative; z-index: 1;
        padding: 36px 32px;
        min-height: 100vh;
        font-family: 'Poppins', sans-serif;
    }
    .ar-page::before {
        content: '';
        position: fixed; top: 40%; left: 55%;
        transform: translate(-50%, -50%);
        width: 600px; height: 600px;
        background: radial-gradient(circle, rgba(0,255,213,0.06) 0%, transparent 70%);
        pointer-events: none; z-index: 0;
    }
    .ar-header { display: flex; align-items: center; gap: 14px; margin-bottom: 32px; }
    .ar-header-icon {
        width: 46px; height: 46px; border-radius: 12px;
        background: linear-gradient(135deg, rgba(0,255,213,0.18), rgba(0,255,213,0.05));
        border: 1px solid rgba(0,255,213,0.35);
        display: flex; align-items: center; justify-content: center; font-size: 22px;
        box-shadow: 0 0 16px rgba(0,255,213,0.15);
    }
    .ar-header-title { font-size: 24px; font-weight: 700; color: #00ffd5; text-shadow: 0 0 18px rgba(0,255,213,0.45); }
    .ar-header-sub { font-size: 11px; color: rgba(0,255,213,0.5); letter-spacing: 1.5px; text-transform: uppercase; }

    .ar-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
        gap: 20px;
    }
    .ar-card {
        background: rgba(255,255,255,0.05);
        backdrop-filter: blur(18px);
        -webkit-backdrop-filter: blur(18px);
        border: 1px solid rgba(0,255,213,0.14);
        border-radius: 18px;
        padding: 26px 28px;
        box-shadow: 0 8px 40px rgba(0,0,0,0.4), inset 0 1px 0 rgba(255,255,255,0.06);
        transition: border-color 0.3s, box-shadow 0.3s;
        animation: fadeUp 0.5s ease both;
    }
    .ar-card:hover {
        border-color: rgba(0,255,213,0.3);
        box-shadow: 0 12px 50px rgba(0,0,0,0.5), 0 0 28px rgba(0,255,213,0.06);
    }
    .ar-card:nth-child(1) { animation-delay: 0.04s; }
    .ar-card:nth-child(2) { animation-delay: 0.10s; }
    .ar-card:nth-child(3) { animation-delay: 0.16s; }
    .ar-card:nth-child(4) { animation-delay: 0.22s; }
    .ar-card:nth-child(5) { animation-delay: 0.28s; }
    @keyframes fadeUp {
        from { opacity: 0; transform: translateY(16px); }
        to   { opacity: 1; transform: translateY(0); }
    }

    .ar-card-title {
        font-size: 10.5px; font-weight: 700;
        letter-spacing: 2px; text-transform: uppercase;
        color: rgba(0,255,213,0.52); margin-bottom: 16px;
        display: flex; align-items: center; gap: 8px;
    }
    .ar-card-title::before {
        content: '';
        width: 3px; height: 13px;
        background: linear-gradient(180deg, #00ffd5, rgba(0,255,213,0.15));
        border-radius: 3px; display: inline-block;
    }

    /* Summary card */
    .ar-info-row {
        display: flex; justify-content: space-between; align-items: center;
        padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.06);
        font-size: 13.5px;
    }
    .ar-info-row:last-child { border-bottom: none; padding-bottom: 0; }
    .ar-info-label { color: rgba(185,222,255,0.6); }
    .ar-info-value { color: #fff; font-weight: 600; }
    .ar-info-value.teal { color: #00ffd5; }

    /* Score */
    .ar-score-wrap {
        display: flex; align-items: flex-end; gap: 12px;
        padding: 10px 0;
    }
    .ar-score-num {
        font-size: 56px; font-weight: 800; line-height: 1;
        background: linear-gradient(135deg, #00ffd5, #00ff99);
        -webkit-background-clip: text; -webkit-text-fill-color: transparent;
        filter: drop-shadow(0 0 12px rgba(0,255,213,0.4));
    }
    .ar-score-sub { font-size: 12px; color: rgba(0,255,213,0.5); padding-bottom: 8px; }
    .ar-score-bar-wrap {
        height: 6px; background: rgba(255,255,255,0.1);
        border-radius: 6px; overflow: hidden; margin-top: 14px;
    }
    .ar-score-bar {
        height: 100%;
        background: linear-gradient(90deg, #00ffd5, #00ff99);
        border-radius: 6px;
        box-shadow: 0 0 10px rgba(0,255,213,0.5);
        transition: width 1.2s cubic-bezier(0.4,0,0.2,1);
        width: 0%;
    }

    /* Recommend box */
    .ar-recommend-box {
        background: rgba(0,0,0,0.25);
        border: 1px solid rgba(0,255,213,0.1);
        border-radius: 12px;
        padding: 16px 18px;
        font-size: 14px; line-height: 1.75;
        color: rgba(200,230,255,0.85);
    }

    /* Confidence */
    .ar-confidence {
        font-size: 28px; font-weight: 700; color: #ffd700;
        text-shadow: 0 0 16px rgba(255,215,0,0.4);
        padding: 8px 0;
    }
    .ar-confidence-bar-wrap {
        height: 6px; background: rgba(255,255,255,0.1);
        border-radius: 6px; overflow: hidden; margin-top: 12px;
    }
    .ar-confidence-bar {
        height: 100%;
        background: linear-gradient(90deg, #ffd700, #ffaa00);
        border-radius: 6px;
        box-shadow: 0 0 10px rgba(255,215,0,0.4);
        transition: width 1.2s cubic-bezier(0.4,0,0.2,1);
        width: 0%;
    }
</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <canvas id="particles-canvas"></canvas>

    <div class="ar-page">

        <div class="ar-header">
            <div class="ar-header-icon">🤖</div>
            <div>
                <div class="ar-header-title">AI Recommendation Engine</div>
                <div class="ar-header-sub">Personalized financial intelligence</div>
            </div>
        </div>

        <div class="ar-grid">

            <!-- User Summary -->
            <div class="ar-card">
                <div class="ar-card-title">User Financial Summary</div>
                <div class="ar-info-row">
                    <span class="ar-info-label">Name</span>
                    <span class="ar-info-value teal"><asp:Label ID="lblName" runat="server" /></span>
                </div>
                <div class="ar-info-row">
                    <span class="ar-info-label">Account No.</span>
                    <span class="ar-info-value"><asp:Label ID="lblAcc" runat="server" /></span>
                </div>
                <div class="ar-info-row">
                    <span class="ar-info-label">Current Balance</span>
                    <span class="ar-info-value">₹<asp:Label ID="lblBalance" runat="server" /></span>
                </div>
            </div>

            <!-- Score -->
            <div class="ar-card">
                <div class="ar-card-title">AI Financial Stability Score</div>
                <div class="ar-score-wrap">
                    <div class="ar-score-num" id="scoreDisplay"><asp:Label ID="lblScore" runat="server" /></div>
                    <div class="ar-score-sub">/ 100</div>
                </div>
                <div class="ar-score-bar-wrap">
                    <div class="ar-score-bar" id="scoreBar"></div>
                </div>
            </div>

            <!-- Govt Scheme -->
            <div class="ar-card">
                <div class="ar-card-title">Recommended Government Scheme</div>
                <div class="ar-recommend-box">
                    🏛️ <asp:Label ID="lblGovScheme" runat="server" />
                </div>
            </div>

            <!-- Bank Scheme -->
            <div class="ar-card">
                <div class="ar-card-title">Recommended Bank Scheme</div>
                <div class="ar-recommend-box">
                    🏦 <asp:Label ID="lblBankScheme" runat="server" />
                </div>
            </div>

            <!-- Confidence -->
            <div class="ar-card">
                <div class="ar-card-title">AI Confidence Level</div>
                <div class="ar-confidence" id="confDisplay">
                    <asp:Label ID="lblConfidence" runat="server" />
                </div>
                <div class="ar-confidence-bar-wrap">
                    <div class="ar-confidence-bar" id="confBar"></div>
                </div>
            </div>

        </div>
    </div>

    <script>
    // Animate score bar
    window.addEventListener('load', function () {
        var scoreEl = document.getElementById('scoreBar');
        var confEl  = document.getElementById('confBar');
        var scoreText = document.querySelector('#scoreDisplay span') || document.querySelector('#scoreDisplay');
        var confText  = document.querySelector('#confDisplay span') || document.querySelector('#confDisplay');

        var scoreVal = parseFloat((scoreText ? scoreText.innerText : '0')) || 0;
        var confVal  = parseFloat((confText  ? confText.innerText  : '0')) || 0;

        setTimeout(function () {
            if (scoreEl) scoreEl.style.width = Math.min(scoreVal, 100) + '%';
            if (confEl)  confEl.style.width  = Math.min(confVal,  100) + '%';
        }, 300);
    });

    // Particles
    (function () {
        var canvas = document.getElementById('particles-canvas');
        var ctx = canvas.getContext('2d');
        var W, H, particles = [];
        function resize() { W = canvas.width = window.innerWidth; H = canvas.height = window.innerHeight; }
        resize(); window.addEventListener('resize', resize);
        for (var i = 0; i < 55; i++) {
            particles.push({ x: Math.random()*1920, y: Math.random()*1080,
                r: Math.random()*1.4+0.4, vx:(Math.random()-0.5)*0.28,
                vy:(Math.random()-0.5)*0.28, a:Math.random()*0.4+0.1 });
        }
        function draw() {
            ctx.clearRect(0,0,W,H);
            particles.forEach(function(p) {
                ctx.beginPath(); ctx.arc(p.x,p.y,p.r,0,Math.PI*2);
                ctx.fillStyle='rgba(0,255,213,'+p.a+')'; ctx.fill();
                p.x+=p.vx; p.y+=p.vy;
                if(p.x<0)p.x=W; if(p.x>W)p.x=0;
                if(p.y<0)p.y=H; if(p.y>H)p.y=0;
            });
            requestAnimationFrame(draw);
        }
        draw();
    })();
    </script>

</asp:Content>



