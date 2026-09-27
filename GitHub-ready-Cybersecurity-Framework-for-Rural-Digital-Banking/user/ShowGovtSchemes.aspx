<%@ Page Title="" Language="C#" MasterPageFile="~/user/user-masterpage.Master" AutoEventWireup="true" CodeBehind="ShowGovtSchemes.aspx.cs" Inherits="Cybersecurity_Framework_for_Rural_Digital_Banking.user.ShowGovtSchemes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<style>
    #particles-canvas {
        position: fixed; top: 0; left: 0; width: 100%; height: 100%;
        pointer-events: none; z-index: 0;
    }
    .gs-page {
        position: relative; z-index: 1;
        padding: 36px 32px;
        min-height: 100vh;
        font-family: 'Poppins', sans-serif;
    }
    .gs-page::before {
        content: '';
        position: fixed; top: 40%; left: 50%;
        transform: translate(-50%,-50%);
        width: 680px; height: 680px;
        background: radial-gradient(circle, rgba(0,255,213,0.06) 0%, transparent 70%);
        pointer-events: none; z-index: 0;
    }

    @keyframes fadeUp {
        from { opacity: 0; transform: translateY(16px); }
        to   { opacity: 1; transform: translateY(0); }
    }

    .gs-header { display: flex; align-items: center; gap: 14px; margin-bottom: 28px; animation: fadeUp 0.4s ease both; }
    .gs-header-icon {
        width: 46px; height: 46px; border-radius: 12px;
        background: linear-gradient(135deg, rgba(0,255,213,0.16), rgba(0,255,213,0.04));
        border: 1px solid rgba(0,255,213,0.32);
        display: flex; align-items: center; justify-content: center; font-size: 22px;
        box-shadow: 0 0 18px rgba(0,255,213,0.13);
    }
    .gs-header-title { font-size: 24px; font-weight: 700; color: #00ffd5; text-shadow: 0 0 18px rgba(0,255,213,0.42); }
    .gs-header-sub { font-size: 11px; color: rgba(0,255,213,0.45); letter-spacing: 1.5px; text-transform: uppercase; }

    .gs-search-wrap {
        display: flex; justify-content: center; margin-bottom: 28px;
        animation: fadeUp 0.45s ease both; animation-delay: 0.07s;
    }
    .gs-search-inner {
        display: flex; align-items: center;
        background: rgba(0,0,0,0.3);
        border: 1px solid rgba(0,255,213,0.2);
        border-radius: 12px; overflow: hidden; width: 320px;
        transition: box-shadow 0.3s, border-color 0.3s;
    }
    .gs-search-inner:focus-within {
        border-color: rgba(0,255,213,0.45);
        box-shadow: 0 0 0 3px rgba(0,255,213,0.08);
    }
    .gs-search-icon { padding: 0 14px; color: rgba(0,255,213,0.4); font-size: 13px; }
    .gs-search-input {
        flex: 1; height: 42px;
        background: transparent !important; border: none !important; outline: none !important;
        color: #fff !important; font-family: 'Poppins', sans-serif !important; font-size: 13px !important; padding: 0 !important;
    }
    .gs-search-input::placeholder { color: rgba(185,222,255,0.35) !important; }

    .gs-table-card {
        background: rgba(255,255,255,0.04);
        backdrop-filter: blur(18px); -webkit-backdrop-filter: blur(18px);
        border: 1px solid rgba(0,255,213,0.13); border-radius: 18px; overflow: hidden;
        box-shadow: 0 8px 40px rgba(0,0,0,0.4);
        animation: fadeUp 0.5s ease both; animation-delay: 0.12s;
    }

    .gs-table { width: 100%; border-collapse: collapse; font-size: 13px; }
    .gs-table thead tr { background: linear-gradient(90deg, rgba(0,40,80,0.9), rgba(0,60,100,0.9)); }
    .gs-table thead th {
        padding: 14px 16px; text-align: left;
        font-size: 10px; font-weight: 700; letter-spacing: 1.5px; text-transform: uppercase;
        color: rgba(0,255,213,0.7); border-bottom: 1px solid rgba(0,255,213,0.15); white-space: nowrap;
    }
    .gs-table thead th:first-child { padding-left: 24px; }

    .gs-table tbody tr {
        border-bottom: 1px solid rgba(255,255,255,0.05);
        transition: background 0.2s;
    }
    .gs-table tbody tr:last-child { border-bottom: none; }
    .gs-table tbody tr:hover { background: rgba(0,255,213,0.04); }
    .gs-table tbody td { padding: 13px 16px; color: rgba(200,228,255,0.82); vertical-align: middle; }
    .gs-table tbody td:first-child { padding-left: 24px; }

    .gs-id-badge {
        display: inline-block;
        background: rgba(0,255,213,0.08); border: 1px solid rgba(0,255,213,0.2);
        border-radius: 6px; padding: 2px 10px; font-size: 11px; font-weight: 700; color: #00ffd5;
    }
    .gs-type-pill {
        display: inline-block;
        background: rgba(0,150,80,0.18); border: 1px solid rgba(0,200,100,0.22);
        border-radius: 50px; padding: 3px 12px; font-size: 11.5px; font-weight: 600;
        color: rgba(100,230,160,0.9); white-space: nowrap;
    }
    .gs-benefit {
        font-weight: 700; color: #ffd700;
        font-size: 13px;
    }
    .gs-benefit .rupee { opacity: 0.65; font-size: 11px; }

    .gs-date { font-size: 12px; color: rgba(180,215,255,0.7); white-space: nowrap; }

    /* Date badge — start=green, end=red hint */
    .gs-date-start { color: rgba(100,230,160,0.85); }
    .gs-date-end   { color: rgba(255,150,150,0.8); }

    .gs-desc { max-width: 200px; color: rgba(185,215,255,0.7); font-size: 12.5px; line-height: 1.55; }

    .gs-photo {
        width: 72px; height: 52px; object-fit: cover;
        border-radius: 8px; border: 1px solid rgba(0,255,213,0.15);
        box-shadow: 0 3px 12px rgba(0,0,0,0.4);
    }
    .gs-photo-placeholder {
        width: 72px; height: 52px; border-radius: 8px;
        background: rgba(0,255,213,0.05); border: 1px dashed rgba(0,255,213,0.2);
        display: flex; align-items: center; justify-content: center;
        color: rgba(0,255,213,0.3); font-size: 18px;
    }
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $("#<%= txtName.ClientID %>").on("keyup", function () {
            var value = $(this).val().toLowerCase();
            $("#tableid tbody tr").filter(function () {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
            });
        });
    });
</script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <canvas id="particles-canvas"></canvas>

    <div class="gs-page">

        <div class="gs-header">
            <div class="gs-header-icon">🏛️</div>
            <div>
                <div class="gs-header-title">Government Schemes</div>
                <div class="gs-header-sub">Welfare &amp; financial assistance programs</div>
            </div>
        </div>

        <div class="gs-search-wrap">
            <div class="gs-search-inner">
                <span class="gs-search-icon"><i class="fas fa-search"></i></span>
                <asp:TextBox ID="txtName" runat="server" CssClass="gs-search-input" placeholder="Search schemes..." />
            </div>
        </div>

        <div class="gs-table-card">
            <table class="gs-table" id="tableid">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Scheme Name</th>
                        <th>Type</th>
                        <th>Description</th>
                        <th>Benefit Amount</th>
                        <th>Start Date</th>
                        <th>End Date</th>
                        <th>Photo</th>
                    </tr>
                </thead>
                <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
                    <ItemTemplate>
                        <tbody>
                            <tr>
                                <td><span class="gs-id-badge"><%# Eval("s_id") %></span></td>
                                <td style="font-weight:600; color:#fff;"><%# Eval("schemename") %></td>
                                <td><span class="gs-type-pill"><%# Eval("schemetype") %></span></td>
                                <td><div class="gs-desc"><%# Eval("description") %></div></td>
                                <td>
                                    <span class="gs-benefit">
                                        <span class="rupee">₹ </span><%# Eval("benefitamt") %>
                                    </span>
                                </td>
                                <td><span class="gs-date gs-date-start"><%# Eval("appstartdate") %></span></td>
                                <td><span class="gs-date gs-date-end"><%# Eval("appenddate") %></span></td>
                                <td>
                                    <img class="gs-photo" src="/admin/Photos/<%# Eval("photo") %>"
                                         onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';" />
                                    <div class="gs-photo-placeholder" style="display:none;">🏛️</div>
                                </td>
                            </tr>
                        </tbody>
                    </ItemTemplate>
                </asp:Repeater>
            </table>
        </div>

    </div>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server"
        ConnectionString="<%$ ConnectionStrings:PMSConnectionString %>"
        SelectCommand="SELECT * FROM [SchemesData] ORDER BY s_id DESC" />

    <script>
        (function () {
            var c = document.getElementById('particles-canvas');
            var ctx = c.getContext('2d'), W, H, pts = [];
            function resize() { W = c.width = window.innerWidth; H = c.height = window.innerHeight; }
            resize(); window.addEventListener('resize', resize);
            for (var i = 0; i < 50; i++) pts.push({
                x: Math.random() * 1920, y: Math.random() * 1080,
                r: Math.random() * 1.4 + 0.4, vx: (Math.random() - 0.5) * 0.25, vy: (Math.random() - 0.5) * 0.25, a: Math.random() * 0.36 + 0.08
            });
            function draw() {
                ctx.clearRect(0, 0, W, H);
                pts.forEach(function (p) {
                    ctx.beginPath(); ctx.arc(p.x, p.y, p.r, 0, Math.PI * 2);
                    ctx.fillStyle = 'rgba(0,255,213,' + p.a + ')'; ctx.fill();
                    p.x += p.vx; p.y += p.vy;
                    if (p.x < 0) p.x = W; if (p.x > W) p.x = 0; if (p.y < 0) p.y = H; if (p.y > H) p.y = 0;
                });
                requestAnimationFrame(draw);
            }
            draw();
        })();
    </script>

</asp:Content>
