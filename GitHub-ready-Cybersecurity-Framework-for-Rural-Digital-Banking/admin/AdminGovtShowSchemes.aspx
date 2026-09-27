<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin-masterpage.Master" AutoEventWireup="true" CodeBehind="AdminGovtShowSchemes.aspx.cs" Inherits="Cybersecurity_Framework_for_Rural_Digital_Banking.admin.AdminGovtShowSchemes" %>

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
        background: rgba(0,255,213,0.12);
        border: 1px solid rgba(0,255,213,0.3);
        border-radius: 16px;
        display: flex; align-items: center; justify-content: center;
        font-size: 26px; box-shadow: 0 0 16px rgba(0,255,213,0.15);
    }

    .page-header-text h2 {
        font-size: 22px; font-weight: 700; color: #00ffd5; margin: 0;
        text-shadow: 0 0 10px rgba(0,255,213,0.4);
    }

    .page-header-text p { font-size: 13px; color: rgba(200,230,255,0.6); margin: 4px 0 0; }

    /* Add Button */
    .btn-add {
        background: linear-gradient(90deg, #00c6ff, #0072ff);
        border: none; color: #fff; font-weight: 600;
        padding: 10px 22px; border-radius: 22px;
        font-size: 13px; cursor: pointer;
        font-family: 'Poppins', sans-serif;
        text-decoration: none; display: inline-flex; align-items: center; gap: 6px;
        transition: transform 0.2s, box-shadow 0.2s;
    }

    .btn-add:hover { transform: translateY(-1px); box-shadow: 0 0 16px rgba(0,198,255,0.5); color: #fff; text-decoration: none; }

    /* Search Bar */
    .search-bar {
        display: flex; align-items: center; gap: 10px;
        background: rgba(255,255,255,0.06);
        border: 1px solid rgba(0,255,213,0.2);
        border-radius: 12px; padding: 8px 16px;
        max-width: 320px;
    }

    .search-bar i { color: rgba(0,255,213,0.5); font-size: 13px; }

    .search-input {
        background: transparent !important;
        border: none !important;
        color: #fff !important;
        font-family: 'Poppins', sans-serif !important;
        font-size: 13.5px !important;
        outline: none !important;
        width: 100%;
    }

    .search-input::placeholder { color: rgba(255,255,255,0.3) !important; }

    /* Toolbar */
    .toolbar {
        display: flex; justify-content: space-between; align-items: center;
        margin-bottom: 22px; flex-wrap: wrap; gap: 14px;
    }

    /* Table Container */
    .table-glass {
        background: rgba(255,255,255,0.05);
        backdrop-filter: blur(12px);
        border: 1px solid rgba(0,255,213,0.12);
        border-radius: 16px;
        overflow: hidden;
        box-shadow: 0 12px 35px rgba(0,0,0,0.4);
    }

    /* Table */
    .data-table {
        width: 100%; border-collapse: collapse;
        font-size: 13px;
    }

    .data-table thead tr {
        background: linear-gradient(90deg, rgba(0,114,255,0.3), rgba(0,198,213,0.2));
        border-bottom: 1px solid rgba(0,255,213,0.2);
    }

    .data-table thead th {
        padding: 14px 14px;
        text-align: center;
        font-weight: 600;
        color: #00ffd5 !important;
        font-size: 12.5px;
        letter-spacing: 0.3px;
        white-space: nowrap;
        background: transparent !important;
    }

    .data-table tbody tr {
        border-bottom: 1px solid rgba(255,255,255,0.05);
        transition: background 0.2s;
    }

    .data-table tbody tr:hover { background: rgba(0,255,213,0.05); }

    .data-table tbody td {
        padding: 12px 14px;
        text-align: center;
        color: rgba(200,230,255,0.85);
        vertical-align: middle;
    }

    .data-table tbody img {
        width: 70px; height: 52px;
        border-radius: 8px;
        border: 1px solid rgba(0,255,213,0.2);
        object-fit: cover;
    }

    /* Action Buttons */
    .btn-icon {
        display: inline-flex; align-items: center; justify-content: center;
        width: 34px; height: 34px; border-radius: 8px;
        font-size: 14px; margin: 2px;
        text-decoration: none; cursor: pointer;
        transition: opacity 0.2s, transform 0.2s;
        border: none;
    }

    .btn-icon:hover { opacity: 0.85; transform: scale(1.08); }

    .btn-edit { background: rgba(56,239,125,0.2); border: 1px solid rgba(56,239,125,0.4) !important; color: #38ef7d !important; }
    .btn-delete { background: rgba(231,76,60,0.2); border: 1px solid rgba(231,76,60,0.4) !important; color: #e74c3c !important; }

    /* Empty State */
    .empty-state {
        text-align: center; padding: 50px 20px;
        color: rgba(200,230,255,0.4); font-size: 14px;
    }

    .empty-state span { font-size: 40px; display: block; margin-bottom: 12px; }
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

    function confirmDelete() {
        return confirm("Are you sure you want to delete this scheme?");
    }
</script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="page-wrapper">

    <div class="page-header">
        <div class="page-header-icon">🏛</div>
        <div class="page-header-text">
            <h2>Government Schemes</h2>
            <p>Manage and review all registered government welfare schemes</p>
        </div>
    </div>

    <div class="toolbar">
        <div class="search-bar">
            <i class="fa fa-search"></i>
            <asp:TextBox ID="txtName" runat="server" CssClass="search-input" placeholder="Search schemes..."></asp:TextBox>
        </div>
        <a href="AddGovtSchemes.aspx" class="btn-add">➕ Add New Scheme</a>
    </div>

    <div class="table-glass">
        <table id="tableid" class="data-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Scheme Name</th>
                    <th>Type</th>
                    <th>Description</th>
                    <th>Benefit (₹)</th>
                    <th>Start Date</th>
                    <th>End Date</th>
                    <th>Photo</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
                    <ItemTemplate>
                        <tr>
                            <td><%# Eval("s_id") %></td>
                            <td><%# Eval("schemename") %></td>
                            <td><%# Eval("schemetype") %></td>
                            <td><%# Eval("description") %></td>
                            <td>₹<%# Eval("benefitamt") %></td>
                            <td><%# Eval("appstartdate") %></td>
                            <td><%# Eval("appenddate") %></td>
                            <td><img src="Photos/<%# Eval("photo") %>" alt="scheme" /></td>
                            <td>
                                <a href="UpdateGovtScheme.aspx?id=<%# Eval("s_id") %>" class="btn-icon btn-edit" title="Edit">
                                    <i class="fa fa-edit"></i>
                                </a>
                                <asp:LinkButton ID="Button1" runat="server" CssClass="btn-icon btn-delete"
                                    CommandArgument='<%# Eval("s_id") %>'
                                    OnCommand="Button1_Command"
                                    OnClientClick="return confirmDelete()"
                                    title="Delete">
                                    <i class="fa fa-trash"></i>
                                </asp:LinkButton>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>
    </div>

</div>

<asp:SqlDataSource ID="SqlDataSource1" runat="server"
    ConnectionString="<%$ ConnectionStrings:PMSConnectionString %>"
    SelectCommand="SELECT * FROM [SchemesData] ORDER BY s_id DESC">
</asp:SqlDataSource>

</asp:Content>


