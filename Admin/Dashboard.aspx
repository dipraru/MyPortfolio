<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="MyPortfolio.Admin.Dashboard" %>
<%@ Register Src="~/Admin/Sections/DashboardOverview.ascx" TagPrefix="uc" TagName="DashboardOverview" %>
<%@ Register Src="~/Admin/Sections/ProjectsSection.ascx" TagPrefix="uc" TagName="ProjectsSection" %>
<%@ Register Src="~/Admin/Sections/SkillsSection.ascx" TagPrefix="uc" TagName="SkillsSection" %>
<%@ Register Src="~/Admin/Sections/AchievementsSection.ascx" TagPrefix="uc" TagName="AchievementsSection" %>
<%@ Register Src="~/Admin/Sections/ProfileSection.ascx" TagPrefix="uc" TagName="ProfileSection" %>
<%@ Register Src="~/Admin/Sections/MessagesSection.ascx" TagPrefix="uc" TagName="MessagesSection" %>
<%@ Register Src="~/Admin/Controls/ProjectModal.ascx" TagPrefix="uc" TagName="ProjectModal" %>
<%@ Register Src="~/Admin/Controls/SkillModal.ascx" TagPrefix="uc" TagName="SkillModal" %>
<%@ Register Src="~/Admin/Controls/AchievementModal.ascx" TagPrefix="uc" TagName="AchievementModal" %>
<%@ Register Src="~/Admin/Controls/Toast.ascx" TagPrefix="uc" TagName="Toast" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Dipra Datta</title>
    
    <!-- External Fonts and Libraries -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&family=Space+Grotesk:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <!-- External Dashboard CSS -->
    <link rel="stylesheet" href="Assets/css/dashboard.css">
</head>
<body>
    <form id="form1" runat="server">
        <div class="dashboard-container">
            <!-- Sidebar -->
            <aside class="sidebar" id="sidebar">
                <div class="sidebar-header">
                    <a href="index.html" class="sidebar-logo">
                        <i class="fas fa-terminal"></i>
                        <span>Admin</span>
                    </a>
                </div>
                
                <nav class="sidebar-nav">
                    <div class="nav-item">
                        <a href="#" class="nav-link active" data-page="dashboard">
                            <i class="fas fa-tachometer-alt"></i>
                            <span>Dashboard</span>
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="#" class="nav-link" data-page="projects">
                            <i class="fas fa-project-diagram"></i>
                            <span>Projects</span>
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="#" class="nav-link" data-page="skills">
                            <i class="fas fa-code"></i>
                            <span>Skills</span>
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="#" class="nav-link" data-page="achievements">
                            <i class="fas fa-trophy"></i>
                            <span>Achievements</span>
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="#" class="nav-link" data-page="profile">
                            <i class="fas fa-user"></i>
                            <span>Profile</span>
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="#" class="nav-link" data-page="messages">
                            <i class="fas fa-envelope"></i>
                            <span>Messages</span>
                        </a>
                    </div>
                </nav>
                
                <div class="sidebar-footer">
                    <button class="logout-btn" id="logoutBtn">
                        <i class="fas fa-sign-out-alt"></i>
                        <span>Logout</span>
                    </button>
                </div>
            </aside>
            
            <!-- Main Content -->
            <main class="main-content">
                <!-- Header -->
                <header class="header">
                    <button class="menu-toggle" id="menuToggle">
                        <i class="fas fa-bars"></i>
                    </button>
                    
                    <div class="header-actions">
                        <button class="theme-toggle" id="themeToggle">
                            <i class="fas fa-moon" id="themeIcon"></i>
                        </button>
                        
                        <div class="user-menu">
                            <button class="user-btn" id="userBtn">
                                <img src="https://scontent.fdac181-1.fna.fbcdn.net/v/t39.30808-6/512737205_2674645019593706_2103932344706277446_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=6ee11a&_nc_eui2=AeGiw0FoWbNuPKyEV4in58VG1YiIDKq91a7ViIgMqr3VrnBWzdU5skPg64wZvUZJa-0x30_bUq21urc40eJgPnRc&_nc_ohc=LgyNWKDGEFAQ7kNvwF-dhYU&_nc_oc=AdmaoHU686cCRUTp59Jz7uB0orMeIoRL6aME_u7U-JgQmCfDFOj-nChn6hMtzB7f38Y&_nc_zt=23&_nc_ht=scontent.fdac181-1.fna&_nc_gid=RFBJDU6WSSAM3hNTIzv3JA&oh=00_AfaCNafRpI84pgmoQq2d6RSHovXxHQwU2PN7k8CAIzut8Q&oe=68C76191" alt="Admin" class="user-avatar">
                                <span>Admin</span>
                                <i class="fas fa-chevron-down"></i>
                            </button>
                            
                            <div class="user-dropdown" id="userDropdown">
                                <a href="#" class="dropdown-item">
                                    <i class="fas fa-user"></i>
                                    <span>Profile</span>
                                </a>
                                <a href="#" class="dropdown-item">
                                    <i class="fas fa-cog"></i>
                                    <span>Settings</span>
                                </a>
                                <a href="#" class="dropdown-item" id="logoutDropdown">
                                    <i class="fas fa-sign-out-alt"></i>
                                    <span>Logout</span>
                                </a>
                            </div>
                        </div>
                    </div>
                </header>
                
                <!-- Page Content -->
                <div class="page-content">
                    <!-- Dashboard Sections - each section from separate files -->
                    <uc:DashboardOverview ID="DashboardOverview1" runat="server" />
                    <uc:ProjectsSection ID="ProjectsSection1" runat="server" />
                    <uc:SkillsSection ID="SkillsSection1" runat="server" />
                    <uc:AchievementsSection ID="AchievementsSection1" runat="server" />
                    <uc:ProfileSection ID="ProfileSection1" runat="server" />
                    <uc:MessagesSection ID="MessagesSection1" runat="server" />
                </div>
            </main>
        </div>
        
        <!-- Shared Components -->
        <uc:ProjectModal ID="ProjectModal1" runat="server" />
        <uc:SkillModal ID="SkillModal1" runat="server" />
        <uc:AchievementModal ID="AchievementModal1" runat="server" />
        <uc:Toast ID="Toast1" runat="server" />
    </form>
    
    <!-- External Dashboard JavaScript -->
    <script src="Assets/js/dashboard.js"></script>
</body>
</html>