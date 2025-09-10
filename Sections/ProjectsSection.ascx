<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProjectsSection.ascx.cs" Inherits="MyPortfolio.Sections.ProjectsSection" %>

<!-- Projects Section -->
<section id="projects" class="fade-in">
    <h2 class="section-title">Featured Projects</h2>
    <div class="projects-container">
        <%= GetProjectsHtml() %>
    </div>
</section>