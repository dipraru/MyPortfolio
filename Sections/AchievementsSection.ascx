<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AchievementsSection.ascx.cs" Inherits="MyPortfolio.Sections.AchievementsSection" %>

<!-- Achievements Section -->
<section id="achievements" class="fade-in">
    <h2 class="section-title">Achievements</h2>
    <div class="achievements-container">
        <%= GetAchievementsHtml() %>
    </div>
</section>