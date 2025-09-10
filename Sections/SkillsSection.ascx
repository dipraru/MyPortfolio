<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SkillsSection.ascx.cs" Inherits="MyPortfolio.Sections.SkillsSection" %>

<!-- Skills Section -->
<section id="skills" class="fade-in">
    <h2 class="section-title">Technical Expertise</h2>
    <div class="skills-container">
        <%= GetSkillsHtml() %>
    </div>
</section>