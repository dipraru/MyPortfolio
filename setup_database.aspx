<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="setup_database.aspx.cs" Inherits="MyPortfolio.setup_database" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Database Setup - MyPortfolio</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .btn {
            background: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin: 5px;
        }
        .btn:hover { background: #0056b3; }
        .btn-success { background: #28a745; }
        .btn-success:hover { background: #1e7e34; }
        .btn-danger { background: #dc3545; }
        .btn-danger:hover { background: #c82333; }
        .alert {
            padding: 15px;
            margin: 15px 0;
            border-radius: 5px;
        }
        .alert-success { background: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .alert-danger { background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
        .alert-info { background: #d1ecf1; color: #0c5460; border: 1px solid #bee5eb; }
        pre { background: #f8f9fa; padding: 15px; border-radius: 5px; overflow-x: auto; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h1>?? MyPortfolio Database Setup</h1>
            <p>This page will help you set up the database for your portfolio admin system.</p>
            
            <h3>Step 1: Test Database Connection</h3>
            <asp:Button ID="btnTestConnection" runat="server" Text="Test Connection" CssClass="btn" OnClick="btnTestConnection_Click" />
            
            <h3>Step 2: Create Database & Tables</h3>
            <asp:Button ID="btnCreateDatabase" runat="server" Text="Create Database & Tables" CssClass="btn btn-success" OnClick="btnCreateDatabase_Click" />
            
            <h3>Step 3: Verify Setup</h3>
            <asp:Button ID="btnVerifySetup" runat="server" Text="Verify Setup" CssClass="btn btn-info" OnClick="btnVerifySetup_Click" />
            
            <hr style="margin: 30px 0;" />
            
            <h3>Results:</h3>
            <asp:Label ID="lblResults" runat="server" Text="Click a button above to start..." />
            
            <hr style="margin: 30px 0;" />
            
            <h3>Quick Links:</h3>
            <a href="admin_login.aspx" class="btn">Go to Admin Login</a>
            <a href="DatabaseDiagnostic.aspx" class="btn">Database Diagnostic</a>
            <a href="Default.aspx" class="btn">Back to Portfolio</a>
        </div>
    </form>
</body>
</html>