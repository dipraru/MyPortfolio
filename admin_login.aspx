<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin_login.aspx.cs" Inherits="MyPortfolio.admin_login" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login - Dipra Datta</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&family=Space+Grotesk:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            /* Dark mode variables */
            --primary: #00d9ff;
            --secondary: #7209b7;
            --accent: #f72585;
            --light: #ffffff;
            --dark: #0a0e27;
            --dark-secondary: #161b3d;
            --text-primary: #ffffff;
            --text-secondary: rgba(255, 255, 255, 0.8);
            --text-tertiary: rgba(255, 255, 255, 0.6);
            --bg-primary: #0a0e27;
            --bg-secondary: rgba(22, 27, 61, 0.7);
            --bg-tertiary: rgba(10, 14, 39, 0.5);
            --card-bg: rgba(22, 27, 61, 0.7);
            --border-color: rgba(0, 217, 255, 0.2);
            --gradient-1: linear-gradient(135deg, #00d9ff, #7209b7);
            --gradient-2: linear-gradient(135deg, #f72585, #b5179e);
            --gradient-3: linear-gradient(135deg, #7209b7, #3a0ca3);
            --error: #ff4d6d;
            --success: #2ecc71;
        }

        /* Light mode variables */
        body.light-mode {
            --primary: #2563eb;
            --secondary: #7c3aed;
            --accent: #dc2626;
            --light: #ffffff;
            --dark: #f8fafc;
            --dark-secondary: #e2e8f0;
            --text-primary: #1e293b;
            --text-secondary: #475569;
            --text-tertiary: #64748b;
            --bg-primary: #ffffff;
            --bg-secondary: #f1f5f9;
            --bg-tertiary: #e2e8f0;
            --card-bg: #ffffff;
            --border-color: rgba(37, 99, 235, 0.15);
            --gradient-1: linear-gradient(135deg, #2563eb, #7c3aed);
            --gradient-2: linear-gradient(135deg, #dc2626, #b91c1c);
            --gradient-3: linear-gradient(135deg, #7c3aed, #6366f1);
            --error: #ef4444;
            --success: #10b981;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: var(--bg-primary);
            color: var(--text-primary);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        /* Header */
        header {
            position: fixed;
            top: 0;
            width: 100%;
            padding: 20px 50px;
            background: rgba(10, 14, 39, 0.8);
            backdrop-filter: blur(10px);
            z-index: 1000;
            transition: all 0.3s ease;
        }

        body.light-mode header {
            background: rgba(255, 255, 255, 0.9);
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }

        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            max-width: 1200px;
            margin: 0 auto;
        }

        .logo {
            font-size: 1.8rem;
            font-weight: 800;
            background: var(--gradient-1);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 10px;
            font-family: 'Space Grotesk', sans-serif;
        }

        .logo i {
            font-size: 2rem;
            color: var(--primary);
        }

        .nav-container {
            display: flex;
            align-items: center;
        }

        .back-link {
            color: var(--text-secondary);
            text-decoration: none;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 8px;
            margin-right: 20px;
            transition: color 0.3s ease;
        }

        .back-link:hover {
            color: var(--primary);
        }

        .theme-toggle {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            background: transparent;
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
            border-radius: 50%;
        }

        .theme-toggle:hover {
            background: rgba(0, 217, 255, 0.1);
            transform: scale(1.1);
        }

        body.light-mode .theme-toggle:hover {
            background: rgba(37, 99, 235, 0.1);
        }

        .theme-toggle i {
            font-size: 1.2rem;
            color: var(--primary);
            transition: all 0.3s ease;
        }

        /* Main Content */
        main {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 120px 20px 50px;
        }

        .login-container {
            width: 100%;
            max-width: 450px;
            background: var(--card-bg);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
            border: 1px solid var(--border-color);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        body.light-mode .login-container {
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
        }

        .login-container::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(0, 217, 255, 0.05) 0%, transparent 70%);
            opacity: 0;
            transition: opacity 0.5s ease;
            z-index: -1;
        }

        body.light-mode .login-container::before {
            background: radial-gradient(circle, rgba(37, 99, 235, 0.03) 0%, transparent 70%);
        }

        .login-container:hover::before {
            opacity: 1;
        }

        .login-header {
            text-align: center;
            margin-bottom: 40px;
        }

        .login-header h1 {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 10px;
            background: var(--gradient-1);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            font-family: 'Space Grotesk', sans-serif;
        }

        .login-header p {
            color: var(--text-secondary);
            font-size: 1rem;
        }

        .form-group {
            margin-bottom: 25px;
            position: relative;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--text-secondary);
        }

        .form-group input {
            width: 100%;
            padding: 15px 20px;
            background: var(--bg-tertiary);
            border: 1px solid var(--border-color);
            border-radius: 10px;
            color: var(--text-primary);
            font-family: 'Poppins', sans-serif;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .form-group input:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 15px rgba(0, 217, 255, 0.2);
        }

        .form-group i {
            position: absolute;
            right: 15px;
            top: 43px;
            color: var(--text-tertiary);
            transition: color 0.3s ease;
            pointer-events: none;
        }

        .form-group input:focus + i {
            color: var(--primary);
        }

        .form-options {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .remember-me {
            display: flex;
            align-items: center;
        }

        .remember-me input {
            width: 18px;
            height: 18px;
            margin-right: 8px;
            accent-color: var(--primary);
        }

        .remember-me label {
            font-size: 0.9rem;
            color: var(--text-secondary);
            cursor: pointer;
        }

        .forgot-password {
            font-size: 0.9rem;
            color: var(--primary);
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .forgot-password:hover {
            color: var(--accent);
            text-decoration: underline;
        }

        .btn-login {
            width: 100%;
            padding: 16px;
            background: var(--gradient-1);
            color: white;
            border: none;
            border-radius: 10px;
            font-weight: 600;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .btn-login:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(0, 217, 255, 0.3);
        }

        .btn-login:active {
            transform: translateY(1px);
        }

        .btn-login:disabled {
            opacity: 0.7;
            cursor: not-allowed;
            transform: none !important;
        }

        .btn-login i {
            font-size: 1.2rem;
        }

        .error-message {
            color: var(--error);
            font-size: 0.9rem;
            margin-top: 15px;
            text-align: center;
            display: none;
            padding: 10px;
            background: rgba(255, 77, 109, 0.1);
            border-radius: 8px;
            border: 1px solid rgba(255, 77, 109, 0.2);
        }

        .success-message {
            color: var(--success);
            font-size: 0.9rem;
            margin-top: 15px;
            text-align: center;
            display: none;
            padding: 10px;
            background: rgba(46, 204, 113, 0.1);
            border-radius: 8px;
            border: 1px solid rgba(46, 204, 113, 0.2);
        }

        /* Footer */
        footer {
            background: var(--bg-secondary);
            padding: 30px;
            text-align: center;
            border-top: 1px solid var(--border-color);
        }

        .copyright {
            font-size: 1rem;
            color: var(--text-tertiary);
        }

        /* Responsive */
        @media (max-width: 768px) {
            header {
                padding: 15px 20px;
            }
            
            .back-link span {
                display: none;
            }
            
            .login-container {
                padding: 30px 20px;
            }
            
            .login-header h1 {
                font-size: 1.8rem;
            }
        }

        @media (max-width: 576px) {
            .login-container {
                padding: 25px 15px;
            }
            
            .login-header h1 {
                font-size: 1.6rem;
            }
            
            .form-options {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }
        }

        /* Animations */
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .login-container {
            animation: fadeIn 0.8s ease forwards;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" method="post">
        <!-- Header -->
        <header>
            <div class="navbar">
                <a href="Default.aspx" class="logo">
                    <i class="fas fa-terminal"></i>
                    Dipra Datta
                </a>
                <div class="nav-container">
                    <a href="Default.aspx" class="back-link">
                        <i class="fas fa-arrow-left"></i>
                        <span>Back to Portfolio</span>
                    </a>
                    <button type="button" class="theme-toggle" id="themeToggle">
                        <i class="fas fa-moon" id="themeIcon"></i>
                    </button>
                </div>
            </div>
        </header>

        <!-- Main Content -->
        <main>
            <div class="login-container">
                <div class="login-header">
                    <h1>Admin Login</h1>
                    <p>Enter your credentials to access the admin panel</p>
                </div>
                
                <div class="form-group">
                    <label for="<%=txtUsername.ClientID%>">Username</label>
                    <asp:TextBox ID="txtUsername" runat="server" placeholder="Enter username" />
                    <i class="fas fa-user"></i>
                </div>
                
                <div class="form-group">
                    <label for="<%=txtPassword.ClientID%>">Password</label>
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="••••••••" />
                    <i class="fas fa-lock"></i>
                </div>
                
                <div class="form-options">
                    <div class="remember-me">
                        <asp:CheckBox ID="chkRememberMe" runat="server" />
                        <label for="<%=chkRememberMe.ClientID%>">Remember Me</label>
                    </div>
                    <a href="#" class="forgot-password" onclick="alert('Please contact administrator'); return false;">Forgot Password?</a>
                </div>
                
                <!-- WORKING LOGIN BUTTON -->
                <input type="button" 
                       id="btnLoginFixed" 
                       value="🔑 Sign In" 
                       class="btn-login"
                       onclick="doLogin();" />
                
                <!-- Hidden ASP.NET button for server-side event -->
                <asp:Button ID="btnLogin" runat="server" OnClick="btnLogin_Click" style="display: none;" />
                
                <asp:Label ID="lblMessage" runat="server" CssClass="error-message" Visible="false"></asp:Label>
            </div>
        </main>

        <!-- Footer -->
        <footer>
            <p class="copyright">&copy; 2023 Dipra Datta. All rights reserved.</p>
        </footer>
    </form>

    <script>
        // Theme Toggle
        const themeToggle = document.getElementById('themeToggle');
        const themeIcon = document.getElementById('themeIcon');
        const body = document.body;
        
        // Check for saved theme preference or default to dark mode
        const currentTheme = localStorage.getItem('theme') || 'dark';
        if (currentTheme === 'light') {
            body.classList.add('light-mode');
            themeIcon.classList.remove('fa-moon');
            themeIcon.classList.add('fa-sun');
        }
        
        themeToggle.addEventListener('click', () => {
            body.classList.toggle('light-mode');
            
            if (body.classList.contains('light-mode')) {
                themeIcon.classList.remove('fa-moon');
                themeIcon.classList.add('fa-sun');
                localStorage.setItem('theme', 'light');
            } else {
                themeIcon.classList.remove('fa-sun');
                themeIcon.classList.add('fa-moon');
                localStorage.setItem('theme', 'dark');
            }
        });
        
        // Login function - triggers server-side authentication
        function doLogin() {
            const loginBtn = document.getElementById('btnLoginFixed');
            const username = document.getElementById('<%=txtUsername.ClientID%>').value.trim();
            const password = document.getElementById('<%=txtPassword.ClientID%>').value.trim();
            
            // Validate input
            if (!username || !password) {
                alert('Please enter both username and password');
                return false;
            }
            
            // Show loading state
            loginBtn.value = '⏳ Signing In...';
            loginBtn.disabled = true;
            
            // Trigger the server-side login event
            __doPostBack('<%=btnLogin.UniqueID%>', '');
        }
        
        // Reset button function (called from server-side if login fails)
        function resetLoginButton() {
            const loginBtn = document.getElementById('btnLoginFixed');
            loginBtn.value = '🔑 Sign In';
            loginBtn.disabled = false;
        }
    </script>
</body>
</html>