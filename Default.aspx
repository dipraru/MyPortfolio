<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="MyPortfolio.Default" %>
<%@ Register Src="~/Components/Header.ascx" TagName="Header" TagPrefix="uc" %>
<%@ Register Src="~/Components/Footer.ascx" TagName="Footer" TagPrefix="uc" %>
<%@ Register Src="~/Sections/HeroSection.ascx" TagName="HeroSection" TagPrefix="uc" %>
<%@ Register Src="~/Sections/AboutSection.ascx" TagName="AboutSection" TagPrefix="uc" %>
<%@ Register Src="~/Sections/SkillsSection.ascx" TagName="SkillsSection" TagPrefix="uc" %>
<%@ Register Src="~/Sections/ProjectsSection.ascx" TagName="ProjectsSection" TagPrefix="uc" %>
<%@ Register Src="~/Sections/AchievementsSection.ascx" TagName="AchievementsSection" TagPrefix="uc" %>
<%@ Register Src="~/Sections/ContactSection.ascx" TagName="ContactSection" TagPrefix="uc" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dipra Datta - Competitive Programmer</title>
    
    <!-- External Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700;800&family=Space+Grotesk:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- CSS Files -->
    <link rel="stylesheet" href="Assets/css/variables.css">
    <link rel="stylesheet" href="Assets/css/components.css">
    <link rel="stylesheet" href="Assets/css/animations.css">
    <link rel="stylesheet" href="Assets/css/header.css">
    <link rel="stylesheet" href="Assets/css/sections.css">
    <link rel="stylesheet" href="Assets/css/responsive.css">
</head>
<body>
    <form id="form1" runat="server">
        <!-- Custom Cursor -->
        <div class="cursor"></div>
        <div class="cursor-follower"></div>
        
        <!-- Scroll to Top Button -->
        <div class="scroll-top" id="scrollTop">
            <i class="fas fa-arrow-up"></i>
        </div>
        
        <!-- Animated Background -->
        <div class="bg-animation">
            <div class="gradient-bg"></div>
            <div class="particles" id="particles"></div>
            
            <!-- Custom Illustrations -->
            <div class="illustration code-block">
                <div style="color: var(--primary);">function solve() {</div>
                <div style="color: var(--accent); margin-left: 15px;">return optimal;</div>
                <div style="color: var(--primary);">}</div>
            </div>
            
            <div class="illustration algorithm-circle"></div>
            
            <div class="illustration binary-tree">
                <svg viewBox="0 0 150 150" xmlns="http://www.w3.org/2000/svg">
                    <circle cx="75" cy="30" r="15" fill="none" stroke="var(--primary)" stroke-width="2"/>
                    <circle cx="45" cy="70" r="15" fill="none" stroke="var(--primary)" stroke-width="2"/>
                    <circle cx="105" cy="70" r="15" fill="none" stroke="var(--primary)" stroke-width="2"/>
                    <circle cx="30" cy="110" r="15" fill="none" stroke="var(--primary)" stroke-width="2"/>
                    <circle cx="60" cy="110" r="15" fill="none" stroke="var(--primary)" stroke-width="2"/>
                    <circle cx="90" cy="110" r="15" fill="none" stroke="var(--primary)" stroke-width="2"/>
                    <circle cx="120" cy="110" r="15" fill="none" stroke="var(--primary)" stroke-width="2"/>
                    
                    <line x1="75" y1="45" x2="45" y2="55" stroke="var(--primary)" stroke-width="2"/>
                    <line x1="75" y1="45" x2="105" y2="55" stroke="var(--primary)" stroke-width="2"/>
                    <line x1="45" y1="85" x2="30" y2="95" stroke="var(--primary)" stroke-width="2"/>
                    <line x1="45" y1="85" x2="60" y2="95" stroke="var(--primary)" stroke-width="2"/>
                    <line x1="105" y1="85" x2="90" y2="95" stroke="var(--primary)" stroke-width="2"/>
                    <line x1="105" y1="85" x2="120" y2="95" stroke="var(--primary)" stroke-width="2"/>
                </svg>
            </div>
        </div>
        
        <!-- Header Component -->
        <uc:Header ID="headerControl" runat="server" />
        
        <!-- Hero Section Component -->
        <uc:HeroSection ID="heroSectionControl" runat="server" />
        
        <!-- About Section Component -->
        <uc:AboutSection ID="aboutSectionControl" runat="server" />
        
        <!-- Skills Section Component -->
        <uc:SkillsSection ID="skillsSectionControl" runat="server" />
        
        <!-- Projects Section Component -->
        <uc:ProjectsSection ID="projectsSectionControl" runat="server" />
        
        <!-- Achievements Section Component -->
        <uc:AchievementsSection ID="achievementsSectionControl" runat="server" />
        
        <!-- Contact Section Component -->
        <uc:ContactSection ID="contactSectionControl" runat="server" />
        
        <!-- Footer Component -->
        <uc:Footer ID="footerControl" runat="server" />
    </form>
    
    <!-- JavaScript Files -->
    <script src="Assets/js/theme-ui.js"></script>
    <script src="Assets/js/animations.js"></script>
</body>
</html>