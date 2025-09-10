<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProjectsSection.ascx.cs" Inherits="MyPortfolio.Admin.Sections.ProjectsSection" %>

<!-- Projects Page -->
<div class="page" id="projects-page" style="display: none;">
    <div class="page-header">
        <h1 class="page-title">Projects Management</h1>
        <p class="page-subtitle">Manage your portfolio projects here.</p>
    </div>
    
    <div class="content-section">
        <div class="section-header">
            <h2 class="section-title">All Projects</h2>
            <div class="header-actions" style="display: flex; gap: 10px;">
                <button class="btn-outline" id="reorderProjectsBtn" title="Reorder projects to fix display order gaps">
                    <i class="fas fa-sort-numeric-down"></i>
                    <span>Reorder</span>
                </button>
                <button class="btn" id="addProjectPageBtn">
                    <i class="fas fa-plus"></i>
                    <span>Add New Project</span>
                </button>
            </div>
        </div>
        
        <div class="table-responsive">
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Image</th>
                        <th>Title</th>
                        <th>Description</th>
                        <th>Tags</th>
                        <th>Date Added</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Projects will be loaded here from server via AJAX -->
                    <tr>
                        <td colspan="6" style="text-align: center; padding: 40px;">
                            <i class="fas fa-spinner fa-spin" style="font-size: 2rem; color: var(--primary);"></i>
                            <div style="margin-top: 10px; color: var(--text-secondary);">Loading projects...</div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>