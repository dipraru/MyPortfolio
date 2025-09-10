<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="setup_messages.aspx.cs" Inherits="MyPortfolio.setup_messages" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Messages Database Setup</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .setup-container {
            max-width: 900px;
            margin: 50px auto;
            background: white;
            border-radius: 15px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        .setup-header {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
            padding: 40px;
            text-align: center;
        }
        .setup-content {
            padding: 40px;
        }
        .success { color: #28a745; background: #d4edda; padding: 15px; border-radius: 8px; margin: 20px 0; }
        .error { color: #dc3545; background: #f8d7da; padding: 15px; border-radius: 8px; margin: 20px 0; }
        .info { color: #17a2b8; background: #d1ecf1; padding: 15px; border-radius: 8px; margin: 20px 0; }
        .btn-custom {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            border: none;
            color: white;
            padding: 12px 30px;
            border-radius: 8px;
            margin: 10px 5px;
            transition: all 0.3s ease;
        }
        .btn-custom:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(79, 172, 254, 0.4);
            color: white;
        }
        .step-card {
            border: 1px solid #e9ecef;
            border-radius: 10px;
            padding: 25px;
            margin: 20px 0;
            transition: all 0.3s ease;
        }
        .step-card:hover {
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
            transform: translateY(-2px);
        }
        .connection-status {
            padding: 20px;
            border-radius: 10px;
            margin: 20px 0;
            text-align: center;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="setup-container">
            <div class="setup-header">
                <h1><i class="fas fa-envelope"></i> Messages Database Setup</h1>
                <p class="mb-0">Set up the Messages table for contact form functionality</p>
            </div>
            
            <div class="setup-content">
                <div class="step-card">
                    <h3><i class="fas fa-database text-primary"></i> Step 1: Test Connection</h3>
                    <p>First, let's test if we can connect to your database.</p>
                    <asp:Button ID="btnTestConnection" runat="server" Text="?? Test Connection" 
                        CssClass="btn btn-custom" OnClick="btnTestConnection_Click" />
                </div>

                <div class="step-card">
                    <h3><i class="fas fa-table text-success"></i> Step 2: Create Messages Table</h3>
                    <p>Create the Messages table with all necessary columns for contact form data.</p>
                    <asp:Button ID="btnCreateTable" runat="server" Text="?? Create Messages Table" 
                        CssClass="btn btn-custom" OnClick="btnCreateTable_Click" />
                </div>

                <div class="step-card">
                    <h3><i class="fas fa-plus-circle text-info"></i> Step 3: Add Sample Data</h3>
                    <p>Add some sample messages for testing purposes.</p>
                    <asp:Button ID="btnAddSampleData" runat="server" Text="? Add Sample Messages" 
                        CssClass="btn btn-custom" OnClick="btnAddSampleData_Click" />
                </div>

                <div class="step-card">
                    <h3><i class="fas fa-check-circle text-warning"></i> Step 4: Verify Setup</h3>
                    <p>Verify that everything is working correctly.</p>
                    <asp:Button ID="btnVerifySetup" runat="server" Text="? Verify Setup" 
                        CssClass="btn btn-custom" OnClick="btnVerifySetup_Click" />
                </div>

                <div class="step-card">
                    <h3><i class="fas fa-cog text-secondary"></i> Actions</h3>
                    <p>Additional actions and navigation.</p>
                    <asp:Button ID="btnDropTable" runat="server" Text="??? Drop Messages Table" 
                        CssClass="btn btn-outline-danger" OnClick="btnDropTable_Click" 
                        OnClientClick="return confirm('Are you sure you want to drop the Messages table? This will delete all data!');" />
                    <a href="Admin/Dashboard.aspx" class="btn btn-success">?? Go to Dashboard</a>
                    <a href="Default.aspx" class="btn btn-outline-primary">?? Go to Home</a>
                </div>

                <div class="connection-status">
                    <asp:Label ID="lblResult" runat="server" Text="Ready to set up Messages database..." />
                </div>
            </div>
        </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>