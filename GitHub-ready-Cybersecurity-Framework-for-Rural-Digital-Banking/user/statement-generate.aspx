<%@ Page Title="" Language="C#" MasterPageFile="~/user/user-masterpage.Master" AutoEventWireup="true" CodeBehind="statement-generate.aspx.cs" Inherits="Cybersecurity_Framework_for_Rural_Digital_Banking.user.statement_generate" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<style>
    #particles-canvas {
        position: fixed; top: 0; left: 0; width: 100%; height: 100%;
        pointer-events: none; z-index: 0;
    }
    .st-page {
        position: relative; z-index: 1;
        padding: 36px 32px;
        min-height: 100vh;
        font-family: 'Poppins', sans-serif;
    }
    .st-page::before {
        content: '';
        position: fixed; top: 40%; left: 50%;
        transform: translate(-50%,-50%);
        width: 600px; height: 600px;
        background: radial-gradient(circle, rgba(0,255,213,0.06) 0%, transparent 70%);
        pointer-events: none; z-index: 0;
    }

    @keyframes fadeUp {
        from { opacity: 0; transform: translateY(16px); }
        to   { opacity: 1; transform: translateY(0); }
    }

    /* Header */
    .st-header { display: flex; align-items: center; justify-content: space-between; margin-bottom: 28px; animation: fadeUp 0.4s ease both; flex-wrap: wrap; gap: 14px; }
    .st-header-left { display: flex; align-items: center; gap: 14px; }
    .st-header-icon {
        width: 46px; height: 46px; border-radius: 12px;
        background: linear-gradient(135deg, rgba(0,255,213,0.16), rgba(0,255,213,0.04));
        border: 1px solid rgba(0,255,213,0.32);
        display: flex; align-items: center; justify-content: center; font-size: 22px;
        box-shadow: 0 0 18px rgba(0,255,213,0.13);
    }
    .st-header-title { font-size: 24px; font-weight: 700; color: #00ffd5; text-shadow: 0 0 18px rgba(0,255,213,0.42); }
    .st-header-sub { font-size: 11px; color: rgba(0,255,213,0.45); letter-spacing: 1.5px; text-transform: uppercase; }

    /* Print button */
    .st-print-btn {
        display: inline-flex; align-items: center; gap: 8px;
        height: 40px; padding: 0 20px;
        background: linear-gradient(135deg, #0066cc, #0044aa);
        border: 1px solid rgba(0,255,213,0.18); border-radius: 10px;
        color: #fff; font-family: 'Poppins', sans-serif; font-size: 13px; font-weight: 600;
        cursor: pointer; text-decoration: none;
        box-shadow: 0 4px 14px rgba(0,80,200,0.3);
        transition: transform 0.2s, box-shadow 0.2s;
    }
    .st-print-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 7px 22px rgba(0,100,220,0.45);
        color: #fff; text-decoration: none;
    }

    /* Summary cards row */
    .st-summary-row {
        display: grid; grid-template-columns: repeat(3, 1fr); gap: 18px;
        margin-bottom: 26px;
        animation: fadeUp 0.45s ease both; animation-delay: 0.07s;
    }
    @media (max-width: 700px) { .st-summary-row { grid-template-columns: 1fr; } }
    .st-stat-card {
        background: rgba(255,255,255,0.05);
        backdrop-filter: blur(14px); -webkit-backdrop-filter: blur(14px);
        border: 1px solid rgba(0,255,213,0.12); border-radius: 14px;
        padding: 18px 20px;
        display: flex; align-items: center; gap: 14px;
    }
    .st-stat-icon { font-size: 24px; }
    .st-stat-label { font-size: 10px; font-weight: 600; letter-spacing: 1.3px; text-transform: uppercase; color: rgba(0,255,213,0.5); margin-bottom: 4px; }
    .st-stat-value { font-size: 20px; font-weight: 700; color: #fff; }
    .st-stat-value.green { color: #00ffd5; }
    .st-stat-value.red   { color: #ff6b6b; }
    .st-stat-value.gold  { color: #ffd700; }
    .st-stat-value .rupee { font-size: 13px; opacity: 0.6; }

    /* Table card */
    .st-table-card {
        background: rgba(255,255,255,0.04);
        backdrop-filter: blur(18px); -webkit-backdrop-filter: blur(18px);
        border: 1px solid rgba(0,255,213,0.13); border-radius: 18px; overflow: auto;
        box-shadow: 0 8px 40px rgba(0,0,0,0.4);
        animation: fadeUp 0.5s ease both; animation-delay: 0.13s;
    }
    .st-table { width: 100%; border-collapse: collapse; font-size: 13.5px; min-width: 500px; }
    .st-table thead tr { background: linear-gradient(90deg, rgba(0,40,80,0.9), rgba(0,60,100,0.9)); }
    .st-table thead th {
        padding: 14px 20px; text-align: left;
        font-size: 10px; font-weight: 700; letter-spacing: 1.5px; text-transform: uppercase;
        color: rgba(0,255,213,0.7); border-bottom: 1px solid rgba(0,255,213,0.15); white-space: nowrap;
    }
    .st-table thead th:first-child { padding-left: 28px; }

    .st-table tbody tr { border-bottom: 1px solid rgba(255,255,255,0.05); transition: background 0.2s; }
    .st-table tbody tr:last-child { border-bottom: none; }
    .st-table tbody tr:hover { background: rgba(0,255,213,0.04); }
    .st-table tbody td { padding: 14px 20px; vertical-align: middle; color: rgba(200,228,255,0.8); }
    .st-table tbody td:first-child { padding-left: 28px; }

    /* Cell styles */
    .st-date { font-size: 12.5px; color: rgba(180,215,255,0.7); white-space: nowrap; }
    .st-deposit  { font-weight: 700; color: #00ffd5; }
    .st-withdraw { font-weight: 700; color: #ff6b6b; }
    .st-balance  { font-weight: 700; color: #ffd700; }
    .st-zero     { color: rgba(255,255,255,0.25); font-size: 12px; }
    .rupee-sm    { font-size: 11px; opacity: 0.6; margin-right: 2px; }

    /* Row stripe */
    .st-table tbody tr:nth-child(even) { background: rgba(0,0,0,0.06); }
    .st-table tbody tr:nth-child(even):hover { background: rgba(0,255,213,0.04); }

    /* Empty state */
    .st-empty { text-align: center; padding: 60px 20px; color: rgba(0,255,213,0.3); font-size: 15px; }

    @media print {
        #particles-canvas, .st-print-btn { display: none !important; }
        .st-page { padding: 10px; }
        .st-table-card { box-shadow: none; border: 1px solid #ccc; }
    }
</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <asp:SqlDataSource ID="sdsStatementGenerate" runat="server"
        ConnectionString="<%$ ConnectionStrings:PMSConnectionString %>"
        SelectCommand="SELECT [trans_date], [deposit], [withdraw], [balance] FROM [BankStatement] WHERE ([cid] = @cid)">
        <SelectParameters>
            <asp:SessionParameter Name="cid" SessionField="cid" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <canvas id="particles-canvas"></canvas>

    <div class="st-page">

        <!-- Header -->
        <div class="st-header">
            <div class="st-header-left">
                <div class="st-header-icon">📄</div>
                <div>
                    <div class="st-header-title">Account Statement</div>
                    <div class="st-header-sub">Transaction history</div>
                </div>
            </div>
            <button class="st-print-btn" onclick="window.print(); return false;">
                <i class="fas fa-print"></i> Print Statement
            </button>
        </div>

        <!-- Table -->
        <asp:Panel ID="Panel1" runat="server" Width="100%">
            <div class="st-table-card">
                <table class="st-table" id="dataTable">
                    <thead>
                        <tr>
                            <th>Date</th>
                            <th>Deposit</th>
                            <th>Withdrawal</th>
                            <th>Balance</th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="Repeater1" runat="server" DataSourceID="sdsStatementGenerate">
                            <ItemTemplate>
                                <tr>
                                    <td>
                                        <span class="st-date">
                                            <i class="fas fa-calendar-alt" style="color:rgba(0,255,213,0.3); margin-right:6px; font-size:11px;"></i>
                                            <%# Eval("trans_date") %>
                                        </span>
                                    </td>
                                    <td>
                                        <%# (Eval("deposit") != DBNull.Value && Convert.ToDecimal(Eval("deposit")) > 0)
                                            ? "<span class='st-deposit'><span class='rupee-sm'>₹</span>" + Eval("deposit") + "</span>"
                                            : "<span class='st-zero'>—</span>" %>
                                    </td>
                                    <td>
                                        <%# (Eval("withdraw") != DBNull.Value && Convert.ToDecimal(Eval("withdraw")) > 0)
                                            ? "<span class='st-withdraw'><span class='rupee-sm'>₹</span>" + Eval("withdraw") + "</span>"
                                            : "<span class='st-zero'>—</span>" %>
                                    </td>
                                    <td>
                                        <span class="st-balance"><span class="rupee-sm">₹</span><%# Eval("balance") %></span>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
            </div>
        </asp:Panel>

    </div>

    <script>
    (function () {
        var c = document.getElementById('particles-canvas');
        var ctx = c.getContext('2d'), W, H, pts = [];
        function resize() { W=c.width=window.innerWidth; H=c.height=window.innerHeight; }
        resize(); window.addEventListener('resize', resize);
        for(var i=0;i<50;i++) pts.push({x:Math.random()*1920,y:Math.random()*1080,
            r:Math.random()*1.4+0.4,vx:(Math.random()-0.5)*0.25,vy:(Math.random()-0.5)*0.25,a:Math.random()*0.36+0.08});
        function draw() {
            ctx.clearRect(0,0,W,H);
            pts.forEach(function(p){
                ctx.beginPath();ctx.arc(p.x,p.y,p.r,0,Math.PI*2);
                ctx.fillStyle='rgba(0,255,213,'+p.a+')';ctx.fill();
                p.x+=p.vx;p.y+=p.vy;
                if(p.x<0)p.x=W;if(p.x>W)p.x=0;if(p.y<0)p.y=H;if(p.y>H)p.y=0;
            });
            requestAnimationFrame(draw);
        }
        draw();
    })();
    </script>

</asp:Content>
