<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin-masterpage.Master" AutoEventWireup="true" CodeBehind="search-by-name.aspx.cs" Inherits="Cybersecurity_Framework_for_Rural_Digital_Banking.admin.search_by_name" %>

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
    .search-card {
        background: rgba(255,255,255,0.06);
        backdrop-filter: blur(14px);
        border: 1px solid rgba(0,255,213,0.15);
        border-radius: 18px; padding: 28px 30px;
        box-shadow: 0 12px 35px rgba(0,0,0,0.4);
        margin-bottom: 28px; max-width: 560px;
    }
    .section-header {
        background: rgba(0,198,213,0.1);
        border-left: 4px solid #00ffd5;
        padding: 9px 16px; border-radius: 8px;
        font-weight: 600; color: #00ffd5;
        margin: 0 0 22px; font-size: 13.5px;
    }
    label {
        font-size: 12.5px !important; font-weight: 500 !important;
        color: #cce8ff !important; margin-bottom: 6px !important;
        display: block !important; font-family: 'Poppins', sans-serif !important;
    }
    .form-control {
        background: rgba(255,255,255,0.08) !important;
        border: 1px solid rgba(0,255,213,0.35) !important;
        color: #fff !important; height: 46px !important;
        border-radius: 12px !important; font-size: 13.5px !important;
        font-family: 'Poppins', sans-serif !important;
        padding: 0 14px !important; width: 100% !important;
        transition: border-color 0.3s, box-shadow 0.3s; box-sizing: border-box;
    }
    .form-control:focus {
        outline: none !important; border-color: #00ffd5 !important;
        box-shadow: 0 0 14px rgba(0,255,213,0.3) !important;
        background: rgba(255,255,255,0.12) !important;
    }
    .form-control::placeholder { color: rgba(255,255,255,0.3) !important; }
    .field-group { margin-bottom: 18px; }
    .btn-search {
        background: linear-gradient(90deg, #00c6ff, #0072ff) !important;
        border: none !important; color: #fff !important;
        font-weight: 600 !important; padding: 13px 36px !important;
        border-radius: 30px !important; font-size: 14px !important;
        font-family: 'Poppins', sans-serif !important; cursor: pointer;
        transition: transform 0.25s, box-shadow 0.25s !important;
        width: 100%; margin-top: 8px !important;
    }
    .btn-search:hover { transform: translateY(-2px) !important; box-shadow: 0 0 22px rgba(0,198,255,0.5) !important; }
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
        font-size: 12.5px; white-space: nowrap; background: transparent !important;
    }
    .data-table tbody tr { border-bottom: 1px solid rgba(255,255,255,0.05); transition: background 0.2s; }
    .data-table tbody tr:hover { background: rgba(0,255,213,0.04); }
    .data-table tbody td {
        padding: 13px 14px; text-align: center;
        color: rgba(200,230,255,0.85); vertical-align: middle;
    }
    .data-table tbody img {
        width: 60px; height: 60px; border-radius: 50%;
        border: 2px solid rgba(0,255,213,0.3); object-fit: cover;
    }
</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <asp:SqlDataSource ID="sdsSearchByName" runat="server"
        ConnectionString="<%$ ConnectionStrings:PMSConnectionString %>"
        SelectCommand="SELECT [accountno], [firstname], [middlename], [lastname], [mobile], [email], [photo] FROM [Registration] WHERE (([firstname] = @firstname) OR ([lastname] = @lastname))">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtFirstName" Name="firstname" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtLastName" Name="lastname" PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <div class="page-wrapper">

        <div class="page-header">
            <div class="page-header-icon">🔍</div>
            <div class="page-header-text">
                <h2>Search By Name</h2>
                <p>Find a customer by their first or last name</p>
            </div>
        </div>

        <div class="search-card">
            <div class="section-header">👤 Enter Name</div>
            <div class="field-group">
                <label>First Name</label>
                <asp:TextBox ID="txtFirstName" CssClass="form-control" runat="server" placeholder="Enter first name"></asp:TextBox>
            </div>
            <div class="field-group">
                <label>Last Name</label>
                <asp:TextBox ID="txtLastName" CssClass="form-control" runat="server" placeholder="Enter last name"></asp:TextBox>
            </div>
            <asp:Button ID="btnSearch" runat="server" Text="🔍 Search" CssClass="btn-search" Width="100%" OnClick="btnSearch_Click" />
        </div>

        <div class="section-header">📋 Search Results</div>
        <div class="table-glass">
            <table class="data-table" id="dataTable" width="100%" cellspacing="0">
                <thead>
                    <tr>
                        <th>Account Number</th>
                        <th>First Name</th>
                        <th>Middle Name</th>
                        <th>Last Name</th>
                        <th>Mobile</th>
                        <th>Email</th>
                        <th>Photo</th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="Repeater1" runat="server" DataSourceID="sdsSearchByName">
                        <ItemTemplate>
                            <tr>
                                <td><%# Eval("accountno") %></td>
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
