<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin-masterpage.Master" AutoEventWireup="true" CodeBehind="pending-user.aspx.cs" Inherits="Cybersecurity_Framework_for_Rural_Digital_Banking.admin.pending_user" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<style>
    body, #layoutSidenav_content {
        background: linear-gradient(135deg, #0f2027, #203a43, #2c5364) !important;
        font-family: 'Poppins', sans-serif !important;
        color: #fff !important;
    }
    .page-wrapper { padding: 36px 30px 60px; min-height: 90vh; }
    .page-header {
        display: flex; align-items: center; gap: 18px;
        margin-bottom: 32px; padding-bottom: 22px;
        border-bottom: 1px solid rgba(0,255,213,0.15);
    }
    .page-header-icon {
        width: 60px; height: 60px;
        background: rgba(255,180,0,0.12);
        border: 1px solid rgba(255,180,0,0.3);
        border-radius: 16px;
        display: flex; align-items: center; justify-content: center;
        font-size: 26px; box-shadow: 0 0 16px rgba(255,180,0,0.1);
    }
    .page-header-text h2 {
        font-size: 22px; font-weight: 700; color: #00ffd5; margin: 0;
        text-shadow: 0 0 10px rgba(0,255,213,0.4);
    }
    .page-header-text p { font-size: 13px; color: rgba(200,230,255,0.6); margin: 4px 0 0; }
    .pending-badge {
        display: inline-flex; align-items: center; gap: 6px;
        background: rgba(255,180,0,0.12);
        border: 1px solid rgba(255,180,0,0.3);
        color: #ffb400; font-size: 12px; font-weight: 600;
        padding: 5px 14px; border-radius: 20px; letter-spacing: 0.3px;
    }
    .toolbar {
        display: flex; justify-content: space-between; align-items: center;
        margin-bottom: 22px; flex-wrap: wrap; gap: 14px;
    }
    .search-bar {
        display: flex; align-items: center; gap: 10px;
        background: rgba(255,255,255,0.06);
        border: 1px solid rgba(0,255,213,0.2);
        border-radius: 12px; padding: 8px 16px; max-width: 320px;
    }
    .search-bar i { color: rgba(0,255,213,0.5); font-size: 13px; }
    .search-input {
        background: transparent !important; border: none !important;
        color: #fff !important; font-family: 'Poppins', sans-serif !important;
        font-size: 13.5px !important; outline: none !important; width: 100%;
    }
    .search-input::placeholder { color: rgba(255,255,255,0.3) !important; }
    .table-glass {
        background: rgba(255,255,255,0.05);
        backdrop-filter: blur(12px);
        border: 1px solid rgba(0,255,213,0.12);
        border-radius: 16px; overflow: hidden;
        box-shadow: 0 12px 35px rgba(0,0,0,0.4);
    }
    .data-table { width: 100%; border-collapse: collapse; font-size: 13px; }
    .data-table thead tr {
        background: linear-gradient(90deg, rgba(0,114,255,0.3), rgba(0,198,213,0.2));
        border-bottom: 1px solid rgba(0,255,213,0.2);
    }
    .data-table thead th {
        padding: 14px 14px; text-align: center;
        font-weight: 600; color: #00ffd5 !important;
        font-size: 12.5px; letter-spacing: 0.3px;
        white-space: nowrap; background: transparent !important;
    }
    .data-table tbody tr {
        border-bottom: 1px solid rgba(255,255,255,0.05);
        transition: background 0.2s;
    }
    .data-table tbody tr:hover { background: rgba(0,255,213,0.04); }
    .data-table tbody td {
        padding: 13px 14px; text-align: center;
        color: rgba(200,230,255,0.85); vertical-align: middle;
    }
    .data-table tbody img {
        width: 60px; height: 60px; border-radius: 50%;
        border: 2px solid rgba(255,180,0,0.3);
        object-fit: cover; box-shadow: 0 0 10px rgba(255,180,0,0.1);
    }
    .view-link {
        display: inline-flex; align-items: center; gap: 5px;
        color: #ffb400; text-decoration: none; font-weight: 600;
        font-size: 12.5px; padding: 5px 14px;
        background: rgba(255,180,0,0.1);
        border: 1px solid rgba(255,180,0,0.3);
        border-radius: 20px; transition: background 0.2s;
    }
    .view-link:hover { background: rgba(255,180,0,0.2); color: #ffb400; text-decoration: none; }
</style>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $("#<%= txtName.ClientID %>").on("keyup", function () {
            var value = $(this).val().toLowerCase();
            $("#dataTable tbody tr").filter(function () {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
            });
        });
    });
</script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <asp:SqlDataSource ID="sdsPendingUser" runat="server"
        ConnectionString="<%$ ConnectionStrings:PMSConnectionString %>"
        SelectCommand="SELECT [cid], [firstname], [middlename], [lastname], [mobile], [email], [photo] FROM [Registration] WHERE ([status] = 'No') ORDER BY cid DESC">
    </asp:SqlDataSource>

    <div class="page-wrapper">

        <div class="page-header">
            <div class="page-header-icon">⏳</div>
            <div class="page-header-text">
                <h2>Pending Approvals</h2>
                <p>Review and approve new customer registration requests</p>
            </div>
        </div>

        <div class="toolbar">
            <div class="search-bar">
                <i class="fa fa-search"></i>
                <asp:TextBox ID="txtName" runat="server" CssClass="search-input" placeholder="Search pending users..."></asp:TextBox>
            </div>
            <div class="pending-badge">⏳ Awaiting Review</div>
        </div>

        <div class="table-glass">
            <table class="data-table" id="dataTable" width="100%" cellspacing="0">
                <thead>
                    <tr>
                        <th>Action</th>
                        <th>First Name</th>
                        <th>Middle Name</th>
                        <th>Last Name</th>
                        <th>Mobile</th>
                        <th>Email</th>
                        <th>Photo</th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="Repeater1" runat="server" DataSourceID="sdsPendingUser">
                        <ItemTemplate>
                            <tr>
                                <td><a href='show-details.aspx?cid=<%# Eval("cid") %>' class="view-link">👁 Review</a></td>
                                <td><%# Eval("firstname") %></td>
                                <td><%# Eval("middlename") %></td>
                                <td><%# Eval("lastname") %></td>
                                <td><%# Eval("mobile") %></td>
                                <td><%# Eval("email") %></td>
                                <td><img src='../user/Photos/<%# Eval("photo") %>' alt="photo" /></td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>
        </div>

    </div>
</asp:Content>