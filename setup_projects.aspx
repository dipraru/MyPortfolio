<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="setup_projects.aspx.cs" Inherits="MyPortfolio.setup_projects" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Portfolio Database Setup</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 900px;
            margin: 0 auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .header {
            background: linear-gradient(135deg, #00d9ff, #7209b7);
            color: white;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 30px;
            text-align: center;
        }
        .section {
            background: #f8f9fa;
            padding: 20px;
            margin: 20px 0;
            border-radius: 8px;
            border-left: 4px solid #007bff;
        }
        .btn {
            background: #007bff;
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin: 5px;
            font-size: 14px;
            display: inline-block;
        }
        .btn:hover {
            background: #0056b3;
        }
        .btn-success {
            background: #28a745;
        }
        .btn-success:hover {
            background: #1e7e34;
        }
        .btn-warning {
            background: #ffc107;
            color: #212529;
        }
        .btn-warning:hover {
            background: #e0a800;
        }
        .success {
            background: #d4edda;
            color: #155724;
            padding: 15px;
            border-radius: 5px;
            margin: 10px 0;
            border: 1px solid #c3e6cb;
        }
        .error {
            background: #f8d7da;
            color: #721c24;
            padding: 15px;
            border-radius: 5px;
            margin: 10px 0;
            border: 1px solid #f5c6cb;
        }
        .info {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 5px;
            margin: 10px 0;
            font-family: monospace;
            white-space: pre-wrap;
            font-size: 12px;
        }
        h4 {
            color: #495057;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="header">
                <h1>?? Portfolio Database Setup</h1>
                <p>Complete database setup for portfolio management system</p>
            </div>

            <div class="section">
                <h4>?? Database Connection</h4>
                <asp:Button ID="btnTestConnection" runat="server" Text="Test Database Connection" 
                           CssClass="btn" OnClick="btnTestConnection_Click" />
            </div>

            <div class="section">
                <h4>?? Projects Management</h4>
                <asp:Button ID="btnCreateProjectsTable" runat="server" Text="Create Projects Table" 
                           CssClass="btn" OnClick="btnCreateProjectsTable_Click" />
                
                <asp:Button ID="btnInsertProjectsData" runat="server" Text="Insert Sample Projects" 
                           CssClass="btn" OnClick="btnInsertProjectsData_Click" />
                           
                <asp:Button ID="btnFixColumnSizes" runat="server" Text="Fix Column Sizes" 
                           CssClass="btn btn-warning" OnClick="btnFixColumnSizes_Click" />
            </div>

            <div class="section">
                <h4>??? Skills Management</h4>
                <asp:Button ID="btnCreateSkillsTable" runat="server" Text="Create Skills Table" 
                           CssClass="btn" OnClick="btnCreateSkillsTable_Click" />
                
                <asp:Button ID="btnInsertSkillsData" runat="server" Text="Insert Sample Skills" 
                           CssClass="btn" OnClick="btnInsertSkillsData_Click" />
                           
                <asp:Button ID="btnUpdateSkillsProficiency" runat="server" Text="Update to Percentage Proficiency" 
                           CssClass="btn btn-warning" OnClick="btnUpdateSkillsProficiency_Click" />
            </div>

            <div class="section">
                <h4>?? Achievements Management</h4>
                <asp:Button ID="btnCreateAchievementsTable" runat="server" Text="Create Achievements Table" 
                           CssClass="btn" OnClick="btnCreateAchievementsTable_Click" />
                
                <asp:Button ID="btnInsertAchievementsData" runat="server" Text="Insert Sample Achievements" 
                           CssClass="btn" OnClick="btnInsertAchievementsData_Click" />
            </div>

            <div class="section">
                <h4>?? Profile Management</h4>
                <asp:Button ID="btnCreateProfileTable" runat="server" Text="Create Profile Table" 
                           CssClass="btn" OnClick="btnCreateProfileTable_Click" />
                
                <asp:Button ID="btnInsertProfileData" runat="server" Text="Insert Default Profile" 
                           CssClass="btn" OnClick="btnInsertProfileData_Click" />
            </div>

            <div class="section">
                <h4>?? Messages Management</h4>
                <asp:Button ID="btnCreateMessagesTable" runat="server" Text="Create Messages Table" 
                           CssClass="btn" OnClick="btnCreateMessagesTable_Click" />
                
                <asp:Button ID="btnInsertMessagesData" runat="server" Text="Insert Sample Messages" 
                           CssClass="btn" OnClick="btnInsertMessagesData_Click" />
            </div>

            <div class="section">
                <h4>? Verification & Cleanup</h4>
                <asp:Button ID="btnVerifyAllTables" runat="server" Text="Verify All Tables" 
                           CssClass="btn btn-success" OnClick="btnVerifyAllTables_Click" />
                
                <asp:Button ID="btnCreateAllTables" runat="server" Text="Create All Tables (One Click)" 
                           CssClass="btn btn-success" OnClick="btnCreateAllTables_Click" />
            </div>

            <div style="margin-top: 30px;">
                <asp:Label ID="lblResult" runat="server"></asp:Label>
            </div>

            <div style="margin-top: 20px;">
                <h4>?? Current Status:</h4>
                <asp:Label ID="lblStatus" runat="server"></asp:Label>
            </div>
        </div>
    </form>
</body>
</html>