<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DashboardOverview.ascx.cs" Inherits="MyPortfolio.Admin.Sections.DashboardOverview" %>

<!-- Dashboard Page -->
<div class="page" id="dashboard-page">
    <div class="page-header">
        <h1 class="page-title">Dashboard</h1>
        <p class="page-subtitle">Welcome back! Here's what's happening with your portfolio today.</p>
    </div>
    
    <!-- Stats Cards -->
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-header">
                <div class="stat-title">Total Projects</div>
                <div class="stat-icon projects">
                    <i class="fas fa-project-diagram"></i>
                </div>
            </div>
            <div class="stat-value">12</div>
            <div class="stat-change positive">
                <i class="fas fa-arrow-up"></i>
                <span>12% from last month</span>
            </div>
        </div>
        
        <div class="stat-card">
            <div class="stat-header">
                <div class="stat-title">Total Skills</div>
                <div class="stat-icon skills">
                    <i class="fas fa-code"></i>
                </div>
            </div>
            <div class="stat-value">8</div>
            <div class="stat-change positive">
                <i class="fas fa-arrow-up"></i>
                <span>Added 2 new skills</span>
            </div>
        </div>
        
        <div class="stat-card">
            <div class="stat-header">
                <div class="stat-title">Achievements</div>
                <div class="stat-icon achievements">
                    <i class="fas fa-trophy"></i>
                </div>
            </div>
            <div class="stat-value">6</div>
            <div class="stat-change positive">
                <i class="fas fa-arrow-up"></i>
                <span>2 new achievements</span>
            </div>
        </div>
        
        <div class="stat-card">
            <div class="stat-header">
                <div class="stat-title">Unread Messages</div>
                <div class="stat-icon messages">
                    <i class="fas fa-envelope-open-text"></i>
                </div>
            </div>
            <div class="stat-value">5</div>
            <div class="stat-change negative">
                <i class="fas fa-arrow-up"></i>
                <span>Needs attention</span>
            </div>
        </div>
    </div>
    
    <!-- Recent Projects -->
    <div class="content-section">
        <div class="section-header">
            <h2 class="section-title">Recent Projects</h2>
            <button class="btn" id="addProjectBtn">
                <i class="fas fa-plus"></i>
                <span>Add Project</span>
            </button>
        </div>
        
        <div class="table-responsive">
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Project</th>
                        <th>Tags</th>
                        <th>Date Added</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Recent projects will be loaded here from server via AJAX -->
                    <tr>
                        <td colspan="4" style="text-align: center; padding: 40px;">
                            <i class="fas fa-spinner fa-spin" style="font-size: 2rem; color: var(--primary);"></i>
                            <div style="margin-top: 10px; color: var(--text-secondary);">Loading recent projects...</div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    
    <!-- Recent Messages -->
    <div class="content-section">
        <div class="section-header">
            <h2 class="section-title">Recent Messages</h2>
            <button class="btn-outline" id="viewAllMessagesBtn">
                <span>View All</span>
                <i class="fas fa-arrow-right"></i>
            </button>
        </div>
        
        <div class="table-responsive">
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Subject</th>
                        <th>Status</th>
                        <th>Date</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>John Doe</td>
                        <td>john@example.com</td>
                        <td>Project Collaboration</td>
                        <td>
                            <span class="message-status status-unread">
                                <i class="fas fa-circle"></i>
                                Unread
                            </span>
                        </td>
                        <td>Oct 18, 2023</td>
                        <td>
                            <div class="actions">
                                <button class="action-btn view-message" title="View">
                                    <i class="fas fa-eye"></i>
                                </button>
                                <button class="action-btn delete" title="Delete">
                                    <i class="fas fa-trash"></i>
                                </button>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>Jane Smith</td>
                        <td>jane@example.com</td>
                        <td>Job Opportunity</td>
                        <td>
                            <span class="message-status status-read">
                                <i class="fas fa-circle"></i>
                                Read
                            </span>
                        </td>
                        <td>Oct 16, 2023</td>
                        <td>
                            <div class="actions">
                                <button class="action-btn view-message" title="View">
                                    <i class="fas fa-eye"></i>
                                </button>
                                <button class="action-btn delete" title="Delete">
                                    <i class="fas fa-trash"></i>
                                </button>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>Robert Johnson</td>
                        <td>robert@example.com</td>
                        <td>Feedback on Portfolio</td>
                        <td>
                            <span class="message-status status-read">
                                <i class="fas fa-circle"></i>
                                Read
                            </span>
                        </td>
                        <td>Oct 14, 2023</td>
                        <td>
                            <div class="actions">
                                <button class="action-btn view-message" title="View">
                                    <i class="fas fa-eye"></i>
                                </button>
                                <button class="action-btn delete" title="Delete">
                                    <i class="fas fa-trash"></i>
                                </button>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>