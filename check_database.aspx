<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="check_database.aspx.cs" Inherits="MyPortfolio.check_database" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Database Check - MyPortfolio</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 1000px;
            margin: 20px auto;
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
        .alert {
            padding: 15px;
            margin: 15px 0;
            border-radius: 5px;
        }
        .alert-success { background: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .alert-danger { background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
        .alert-info { background: #d1ecf1; color: #0c5460; border: 1px solid #bee5eb; }
        .alert-warning { background: #fff3cd; color: #856404; border: 1px solid #ffeaa7; }
        pre { background: #f8f9fa; padding: 15px; border-radius: 5px; overflow-x: auto; }
        table { width: 100%; border-collapse: collapse; margin: 10px 0; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h1>?? Database Detective</h1>
            <p>Let's find out exactly what's happening with your database...</p>
            
            <div style="margin: 20px 0;">
                <asp:Button ID="btnCheckAll" runat="server" Text="?? Check Everything" CssClass="btn" OnClick="btnCheckAll_Click" />
                <asp:Button ID="btnListAllDatabases" runat="server" Text="?? List All Databases" CssClass="btn" OnClick="btnListAllDatabases_Click" />
                <asp:Button ID="btnCheckSpecific" runat="server" Text="?? Check Specific Databases" CssClass="btn" OnClick="btnCheckSpecific_Click" />
                <asp:Button ID="btnShowConnections" runat="server" Text="?? Show Connection Strings" CssClass="btn" OnClick="btnShowConnections_Click" />
            </div>
            
            <hr />
            
            <div id="results">
                <asp:Label ID="lblResults" runat="server" Text="Click a button above to start investigation..." />
            </div>
            
            <hr />
            
            <h3>Quick Actions:</h3>
            <a href="setup_database.aspx" class="btn">Setup Database</a>
            <a href="admin_login.aspx" class="btn">Test Login</a>
            <a href="DatabaseDiagnostic.aspx" class="btn">Database Diagnostic</a>
        </div>
    </form>
</body>
</html>