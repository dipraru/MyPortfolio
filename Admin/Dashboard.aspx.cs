using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using MyPortfolio.Helpers;
using System.Collections.Generic;
using System.Linq;
using System.Web.Services;
using System.Web.Script.Serialization;

namespace MyPortfolio.Admin
{
    public partial class Dashboard : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Handle logout request
            if (Request.QueryString["logout"] == "true")
            {
                // Clear the session and redirect to login
                AuthHelper.Logout();
                Response.Redirect("~/admin_login.aspx?logout=true", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            // Check authentication
            if (!AuthHelper.IsAuthenticated())
            {
                Response.Redirect("~/admin_login.aspx");
                return;
            }

            // No need to load projects data here anymore - it's loaded via AJAX
        }

        // AJAX Methods for project operations
        [System.Web.Services.WebMethod]
        public static string AddProject(string title, string description, string imageUrl, string tags, string githubUrl, string liveUrl)
        {
            try
            {
                var project = new Project
                {
                    Title = title,
                    Description = description,
                    ImageUrl = imageUrl,
                    Tags = tags,
                    GitHubUrl = githubUrl,
                    LiveDemoUrl = liveUrl,
                    DisplayOrder = ProjectsHelper.GetNextDisplayOrder() // Use proper next display order
                };

                int newId = ProjectsHelper.AddProject(project);
                return $"{{\"success\": true, \"message\": \"Project added successfully!\", \"id\": {newId}}}";
            }
            catch (Exception ex)
            {
                return $"{{\"success\": false, \"message\": \"Error adding project: {EscapeJsonString(ex.Message)}\"}}";
            }
        }

        [System.Web.Services.WebMethod]
        public static string UpdateProject(int id, string title, string description, string imageUrl, string tags, string githubUrl, string liveUrl)
        {
            try
            {
                var project = ProjectsHelper.GetProjectById(id);
                if (project == null)
                {
                    return "{\"success\": false, \"message\": \"Project not found.\"}";
                }

                project.Title = title;
                project.Description = description;
                project.ImageUrl = imageUrl;
                project.Tags = tags;
                project.GitHubUrl = githubUrl;
                project.LiveDemoUrl = liveUrl;

                bool success = ProjectsHelper.UpdateProject(project);
                if (success)
                {
                    return "{\"success\": true, \"message\": \"Project updated successfully!\"}";
                }
                else
                {
                    return "{\"success\": false, \"message\": \"Failed to update project.\"}";
                }
            }
            catch (Exception ex)
            {
                return $"{{\"success\": false, \"message\": \"Error updating project: {EscapeJsonString(ex.Message)}\"}}";
            }
        }

        [System.Web.Services.WebMethod]
        public static string DeleteProject(int id)
        {
            try
            {
                bool success = ProjectsHelper.DeleteProject(id);
                if (success)
                {
                    return "{\"success\": true, \"message\": \"Project deleted successfully!\"}";
                }
                else
                {
                    return "{\"success\": false, \"message\": \"Failed to delete project.\"}";
                }
            }
            catch (Exception ex)
            {
                return $"{{\"success\": false, \"message\": \"Error deleting project: {EscapeJsonString(ex.Message)}\"}}";
            }
        }

        [WebMethod]
        public static string GetProject(int id)
        {
            try
            {
                var project = ProjectsHelper.GetProjectById(id);
                if (project == null)
                {
                    return "{\"success\": false, \"message\": \"Project not found.\"}";
                }

                // Escape quotes in strings to prevent JSON parsing errors
                string title = EscapeJsonString(project.Title);
                string description = EscapeJsonString(project.Description);
                string imageUrl = EscapeJsonString(project.ImageUrl ?? "");
                string tags = EscapeJsonString(project.Tags ?? "");
                string githubUrl = EscapeJsonString(project.GitHubUrl ?? "");
                string liveUrl = EscapeJsonString(project.LiveDemoUrl ?? "");

                return $@"{{
                    ""success"": true,
                    ""project"": {{
                        ""id"": {project.Id},
                        ""title"": ""{title}"",
                        ""description"": ""{description}"",
                        ""imageUrl"": ""{imageUrl}"",
                        ""tags"": ""{tags}"",
                        ""githubUrl"": ""{githubUrl}"",
                        ""liveUrl"": ""{liveUrl}""
                    }}
                }}";
            }
            catch (Exception ex)
            {
                return $"{{\"success\": false, \"message\": \"Error getting project: {EscapeJsonString(ex.Message)}\"}}";
            }
        }

        [WebMethod]
        public static string GetAllProjectsData()
        {
            try
            {
                // Get projects from database
                var projects = ProjectsHelper.GetAllProjects();
                
                // Generate HTML for recent projects table in dashboard
                string recentProjectsHtml = "";
                if (projects.Any())
                {
                    var recentProjects = projects.Take(3).ToList();
                    foreach (var project in recentProjects)
                    {
                        string tags = "";
                        if (!string.IsNullOrEmpty(project.Tags))
                        {
                            var tagArray = project.GetTagsArray();
                            foreach (var tag in tagArray)
                            {
                                tags += $"<span class='tag'>{System.Web.HttpUtility.HtmlEncode(tag.Trim())}</span>";
                            }
                        }

                        string encodedTitle = System.Web.HttpUtility.HtmlEncode(project.Title);

                        recentProjectsHtml += $@"
                            <tr data-project-id='{project.Id}'>
                                <td>
                                    <div class='project-title'>{encodedTitle}</div>
                                </td>
                                <td>
                                    <div class='project-tags'>
                                        {tags}
                                    </div>
                                </td>
                                <td>{project.DateAdded:MMM dd, yyyy}</td>
                                <td>
                                    <div class='actions'>
                                        <button class='action-btn edit-project' title='Edit' onclick='return editProject({project.Id});'>
                                            <i class='fas fa-edit'></i>
                                        </button>
                                        <button class='action-btn delete' title='Delete' onclick='return deleteProject({project.Id});'>
                                            <i class='fas fa-trash'></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>";
                    }
                }

                // Generate HTML for all projects page
                string allProjectsHtml = "";
                foreach (var project in projects)
                {
                    string tags = "";
                    if (!string.IsNullOrEmpty(project.Tags))
                    {
                        var tagArray = project.GetTagsArray();
                        foreach (var tag in tagArray)
                        {
                            tags += $"<span class='tag'>{System.Web.HttpUtility.HtmlEncode(tag.Trim())}</span>";
                        }
                    }

                    string imageUrl = string.IsNullOrEmpty(project.ImageUrl) 
                        ? "https://images.unsplash.com/photo-1555066931-4365d14bab8c?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" 
                        : project.ImageUrl;

                    string encodedTitle = System.Web.HttpUtility.HtmlEncode(project.Title);
                    string encodedDescription = System.Web.HttpUtility.HtmlEncode(project.Description);
                    string encodedImageUrl = System.Web.HttpUtility.HtmlEncode(imageUrl);

                    allProjectsHtml += $@"
                        <tr data-project-id='{project.Id}'>
                            <td>
                                <img src='{encodedImageUrl}' alt='{encodedTitle}' class='project-image' onerror='this.src=""https://images.unsplash.com/photo-1555066931-4365d14bab8c?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80""'>
                            </td>
                            <td>
                                <div class='project-title'>{encodedTitle}</div>
                            </td>
                            <td>{encodedDescription}</td>
                            <td>
                                <div class='project-tags'>
                                    {tags}
                                </div>
                            </td>
                            <td>{project.DateAdded:MMM dd, yyyy}</td>
                            <td>
                                <div class='actions'>
                                    <button class='action-btn edit-project' title='Edit' onclick='return editProject({project.Id});'>
                                        <i class='fas fa-edit'></i>
                                    </button>
                                    <button class='action-btn delete' title='Delete' onclick='return deleteProject({project.Id});'>
                                        <i class='fas fa-trash'></i>
                                    </button>
                                </div>
                            </td>
                        </tr>";
                }

                // If no projects found, show empty state
                if (!projects.Any())
                {
                    allProjectsHtml = @"
                        <tr>
                            <td colspan='6' style='text-align: center; padding: 40px;'>
                                <i class='fas fa-folder-open' style='font-size: 3rem; color: var(--text-tertiary); margin-bottom: 15px;'></i>
                                <div style='color: var(--text-secondary); font-size: 1.1rem; margin-bottom: 10px;'>No projects found</div>
                                <div style='color: var(--text-tertiary); font-size: 0.9rem;'>Click 'Add New Project' to create your first project</div>
                            </td>
                        </tr>";

                    recentProjectsHtml = @"
                        <tr>
                            <td colspan='4' style='text-align: center; padding: 40px;'>
                                <i class='fas fa-folder-open' style='font-size: 2rem; color: var(--text-tertiary); margin-bottom: 10px;'></i>
                                <div style='color: var(--text-secondary);'>No projects yet</div>
                            </td>
                        </tr>";
                }

                // Escape the HTML for JSON
                string escapedRecentHtml = EscapeJsonString(recentProjectsHtml);
                string escapedAllHtml = EscapeJsonString(allProjectsHtml);

                return $@"{{
                    ""success"": true,
                    ""projectsCount"": {projects.Count},
                    ""recentProjectsHtml"": ""{escapedRecentHtml}"",
                    ""allProjectsHtml"": ""{escapedAllHtml}""
                }}";
            }
            catch (Exception ex)
            {
                return $"{{\"success\": false, \"message\": \"Error loading projects: {EscapeJsonString(ex.Message)}\"}}";
            }
        }

        [WebMethod]
        public static string ReorderProjects()
        {
            try
            {
                bool success = ProjectsHelper.ReorderDisplayOrders();
                if (success)
                {
                    return "{\"success\": true, \"message\": \"Projects reordered successfully! Display orders have been reset to sequential numbers.\"}";
                }
                else
                {
                    return "{\"success\": false, \"message\": \"Failed to reorder projects.\"}";
                }
            }
            catch (Exception ex)
            {
                return $"{{\"success\": false, \"message\": \"Error reordering projects: {EscapeJsonString(ex.Message)}\"}}";
            }
        }

        // AJAX Methods for Skills operations
        [System.Web.Services.WebMethod]
        public static string AddSkill(string name, string description, string category, int proficiencyLevel, 
                                    decimal yearsOfExperience, string iconClass, string iconColor)
        {
            try
            {
                var skill = new Skill
                {
                    Name = name,
                    Description = description,
                    Category = category,
                    ProficiencyPercentage = proficiencyLevel,
                    YearsOfExperience = yearsOfExperience > 0 ? yearsOfExperience : (decimal?)null,
                    IconClass = iconClass,
                    IconColor = iconColor,
                    DisplayOrder = SkillsHelper.GetNextDisplayOrder()
                };

                int newId = SkillsHelper.AddSkill(skill);
                return $"{{\"success\": true, \"message\": \"Skill added successfully!\", \"id\": {newId}}}";
            }
            catch (Exception ex)
            {
                return $"{{\"success\": false, \"message\": \"Error adding skill: {EscapeJsonString(ex.Message)}\"}}";
            }
        }

        [System.Web.Services.WebMethod]
        public static string GetAllSkillsData()
        {
            try
            {
                var skills = SkillsHelper.GetAllSkills();
                
                string skillsHtml = "";
                foreach (var skill in skills)
                {
                    string iconHtml = "";
                    if (!string.IsNullOrEmpty(skill.IconClass))
                    {
                        string iconStyle = !string.IsNullOrEmpty(skill.IconColor) ? $"color: {skill.IconColor};" : "";
                        iconHtml = $"<i class='{System.Web.HttpUtility.HtmlEncode(skill.IconClass)}' style='{iconStyle}'></i>";
                    }
                    else
                    {
                        iconHtml = "<i class='fas fa-code'></i>";
                    }

                    string encodedName = System.Web.HttpUtility.HtmlEncode(skill.Name);
                    string encodedDescription = System.Web.HttpUtility.HtmlEncode(skill.Description ?? "");
                    string proficiencyDisplay = skill.ProficiencyDisplay;
                    string proficiencyLevel = skill.ProficiencyLevelName;

                    skillsHtml += $@"
                        <tr data-skill-id='{skill.Id}'>
                            <td style='text-align: center; font-size: 1.5rem;'>{iconHtml}</td>
                            <td>
                                <div class='skill-name'>{encodedName}</div>
                                <div class='skill-category'>{System.Web.HttpUtility.HtmlEncode(skill.Category)}</div>
                            </td>
                            <td>{encodedDescription}</td>
                            <td>
                                <div class='proficiency-container'>
                                    <div class='proficiency-bar'>
                                        <div class='proficiency-fill' style='width: {skill.ProficiencyPercentage}%'></div>
                                    </div>
                                    <div class='proficiency-text'>{proficiencyDisplay} ({proficiencyLevel})</div>
                                </div>
                            </td>
                            <td>
                                <div class='actions'>
                                    <button class='action-btn edit-skill' title='Edit' data-id='{skill.Id}'>
                                        <i class='fas fa-edit'></i>
                                    </button>
                                    <button class='action-btn delete' title='Delete' data-id='{skill.Id}'>
                                        <i class='fas fa-trash'></i>
                                    </button>
                                </div>
                            </td>
                        </tr>";
                }

                if (!skills.Any())
                {
                    skillsHtml = @"
                        <tr>
                            <td colspan='5' style='text-align: center; padding: 40px;'>
                                <i class='fas fa-code' style='font-size: 3rem; color: var(--text-tertiary); margin-bottom: 15px;'></i>
                                <div style='color: var(--text-secondary); font-size: 1.1rem; margin-bottom: 10px;'>No skills found</div>
                                <div style='color: var(--text-tertiary); font-size: 0.9rem;'>Click 'Add New Skill' to create your first skill</div>
                            </td>
                        </tr>";
                }

                string escapedHtml = EscapeJsonString(skillsHtml);
                return $@"{{
                    ""success"": true,
                    ""skillsCount"": {skills.Count},
                    ""skillsHtml"": ""{escapedHtml}""
                }}";
            }
            catch (Exception ex)
            {
                return $"{{\"success\": false, \"message\": \"Error loading skills: {EscapeJsonString(ex.Message)}\"}}";
            }
        }

        // AJAX Methods for Achievements operations
        [System.Web.Services.WebMethod]
        public static string AddAchievement(string title, string description, string category, string organization, 
                                          string dateAchieved, string certificateUrl, string badgeUrl)
        {
            try
            {
                DateTime achievedDate;
                if (!DateTime.TryParse(dateAchieved, out achievedDate))
                {
                    return "{\"success\": false, \"message\": \"Invalid date format.\"}";
                }

                var achievement = new Achievement
                {
                    Title = title,
                    Description = description,
                    Category = category,
                    Organization = organization,
                    DateAchieved = achievedDate,
                    CertificateUrl = certificateUrl,
                    BadgeUrl = badgeUrl,
                    DisplayOrder = AchievementsHelper.GetNextDisplayOrder()
                };

                int newId = AchievementsHelper.AddAchievement(achievement);
                return $"{{\"success\": true, \"message\": \"Achievement added successfully!\", \"id\": {newId}}}";
            }
            catch (Exception ex)
            {
                return $"{{\"success\": false, \"message\": \"Error adding achievement: {EscapeJsonString(ex.Message)}\"}}";
            }
        }

        [System.Web.Services.WebMethod]
        public static string GetAllAchievementsData()
        {
            try
            {
                var achievements = AchievementsHelper.GetAllAchievements();
                
                string achievementsHtml = "";
                foreach (var achievement in achievements)
                {
                    string encodedTitle = System.Web.HttpUtility.HtmlEncode(achievement.Title);
                    string encodedDescription = System.Web.HttpUtility.HtmlEncode(achievement.Description);
                    string encodedOrganization = System.Web.HttpUtility.HtmlEncode(achievement.Organization ?? "");
                    string encodedCategory = System.Web.HttpUtility.HtmlEncode(achievement.Category);
                    string formattedDate = achievement.DateAchieved.ToString("MMM dd, yyyy");

                    string certificateLink = "";
                    if (!string.IsNullOrEmpty(achievement.CertificateUrl))
                    {
                        certificateLink = $"<a href='{System.Web.HttpUtility.HtmlEncode(achievement.CertificateUrl)}' target='_blank' class='certificate-link'><i class='fas fa-external-link-alt'></i> Certificate</a>";
                    }

                    achievementsHtml += $@"
                        <div class='achievement-card' data-achievement-id='{achievement.Id}'>
                            <div class='achievement-header'>
                                <div>
                                    <div class='achievement-title'>{encodedTitle}</div>
                                    <div class='achievement-organization'>{encodedOrganization}</div>
                                    <div class='achievement-date'>{formattedDate}</div>
                                </div>
                                <div class='achievement-category'>
                                    <span class='category-badge'>{encodedCategory}</span>
                                </div>
                            </div>
                            <div class='achievement-description'>
                                {encodedDescription}
                            </div>
                            {(certificateLink != "" ? $"<div class='achievement-links'>{certificateLink}</div>" : "")}
                            <div class='actions'>
                                <button class='action-btn edit-achievement' title='Edit' data-id='{achievement.Id}'>
                                    <i class='fas fa-edit'></i>
                                </button>
                                <button class='action-btn delete' title='Delete' data-id='{achievement.Id}'>
                                    <i class='fas fa-trash'></i>
                                </button>
                            </div>
                        </div>";
                }

                if (!achievements.Any())
                {
                    achievementsHtml = @"
                        <div class='achievement-card' style='text-align: center; padding: 40px; min-height: 200px; display: flex; flex-direction: column; justify-content: center;'>
                            <i class='fas fa-trophy' style='font-size: 3rem; color: var(--text-tertiary); margin-bottom: 15px;'></i>
                            <div style='color: var(--text-secondary); font-size: 1.1rem; margin-bottom: 10px;'>No achievements found</div>
                            <div style='color: var(--text-tertiary); font-size: 0.9rem;'>Click 'Add New Achievement' to create your first achievement</div>
                        </div>";
                }

                string escapedHtml = EscapeJsonString(achievementsHtml);
                return $@"{{
                    ""success"": true,
                    ""achievementsCount"": {achievements.Count},
                    ""achievementsHtml"": ""{escapedHtml}""
                }}";
            }
            catch (Exception ex)
            {
                return $"{{\"success\": false, \"message\": \"Error loading achievements: {EscapeJsonString(ex.Message)}\"}}";
            }
        }

        // AJAX Methods for Messages operations
        [System.Web.Services.WebMethod]
        public static string TestMessagesConnection()
        {
            try
            {
                // Test the messages helper connection
                var messages = MessagesHelper.GetAllMessages();
                return "{\"success\": true, \"message\": \"Messages database connection successful!\"}";
            }
            catch (Exception ex)
            {
                string errorMessage = ex.Message;
                
                // Check if it's a table not found error
                if (errorMessage.Contains("Invalid object name 'Messages'") || 
                    errorMessage.Contains("Table 'Messages' doesn't exist"))
                {
                    return "{\"success\": false, \"message\": \"Messages table not found. Please create the Messages table first using the setup script.\"}";
                }
                
                return $"{{\"success\": false, \"message\": \"Database connection error: {EscapeJsonString(errorMessage)}\"}}";
            }
        }

        [System.Web.Services.WebMethod]
        public static string GetAllMessagesData()
        {
            try
            {
                var messages = MessagesHelper.GetAllMessages();
                
                string messagesHtml = "";
                foreach (var message in messages)
                {
                    string encodedName = System.Web.HttpUtility.HtmlEncode(message.Name);
                    string encodedEmail = System.Web.HttpUtility.HtmlEncode(message.Email);
                    string encodedSubject = System.Web.HttpUtility.HtmlEncode(message.Subject);
                    string encodedMessage = System.Web.HttpUtility.HtmlEncode(message.MessageText);
                    
                    // Truncate message for display
                    string truncatedMessage = encodedMessage.Length > 100 
                        ? encodedMessage.Substring(0, 100) + "..." 
                        : encodedMessage;

                    // Format date
                    string formattedDate = message.DateReceived.ToString("MMM dd, yyyy HH:mm");
                    
                    // Status display
                    string statusClass = message.IsRead ? "status-read" : "status-unread";
                    string statusIcon = message.IsRead ? "fas fa-envelope-open" : "fas fa-envelope";
                    string statusText = message.IsRead ? "Read" : "Unread";
                    
                    // Priority display
                    string priorityClass = "";
                    switch (message.Priority?.ToLower())
                    {
                        case "high":
                            priorityClass = "priority-high";
                            break;
                        case "low":
                            priorityClass = "priority-low";
                            break;
                        default:
                            priorityClass = "priority-normal";
                            break;
                    }

                    messagesHtml += $@"
                        <tr data-message-id='{message.Id}' class='{(message.IsRead ? "message-read" : "message-unread")}'>
                            <td>
                                <div class='message-sender'>
                                    <div class='sender-name'>{encodedName}</div>
                                    <div class='sender-email'>{encodedEmail}</div>
                                </div>
                            </td>
                            <td>
                                <div class='message-subject {priorityClass}'>
                                    {encodedSubject}
                                    {(message.Priority?.ToLower() == "high" ? "<span class='priority-indicator'>!</span>" : "")}
                                </div>
                            </td>
                            <td>
                                <div class='message-preview' title='{encodedMessage}'>
                                    {truncatedMessage}
                                </div>
                            </td>
                            <td>
                                <span class='message-status {statusClass}'>
                                    <i class='{statusIcon}'></i>
                                    {statusText}
                                </span>
                            </td>
                            <td>
                                <div class='message-date'>{formattedDate}</div>
                            </td>
                            <td>
                                <div class='actions'>
                                    <button class='action-btn view-message' title='View Message' data-id='{message.Id}'>
                                        <i class='fas fa-eye'></i>
                                    </button>
                                    {(!message.IsRead ? $"<button class='action-btn mark-read' title='Mark as Read' data-id='{message.Id}'><i class='fas fa-check'></i></button>" : "")}
                                    <button class='action-btn reply-message' title='Reply' data-id='{message.Id}'>
                                        <i class='fas fa-reply'></i>
                                    </button>
                                    <button class='action-btn delete' title='Delete' data-id='{message.Id}'>
                                        <i class='fas fa-trash'></i>
                                    </button>
                                </div>
                            </td>
                        </tr>";
                }

                if (!messages.Any())
                {
                    messagesHtml = @"
                        <tr>
                            <td colspan='6' style='text-align: center; padding: 40px;'>
                                <i class='fas fa-envelope' style='font-size: 3rem; color: var(--text-tertiary); margin-bottom: 15px;'></i>
                                <div style='color: var(--text-secondary); font-size: 1.1rem; margin-bottom: 10px;'>No messages found</div>
                                <div style='color: var(--text-tertiary); font-size: 0.9rem;'>Messages from your contact form will appear here</div>
                            </td>
                        </tr>";
                }

                string escapedHtml = EscapeJsonString(messagesHtml);
                return $@"{{
                    ""success"": true,
                    ""messagesCount"": {messages.Count},
                    ""messagesHtml"": ""{escapedHtml}""
                }}";
            }
            catch (Exception ex)
            {
                return $"{{\"success\": false, \"message\": \"Error loading messages: {EscapeJsonString(ex.Message)}\"}}";
            }
        }

        [System.Web.Services.WebMethod]
        public static string MarkMessageAsRead(int messageId)
        {
            try
            {
                bool success = MessagesHelper.MarkAsRead(messageId);
                if (success)
                {
                    return "{\"success\": true, \"message\": \"Message marked as read successfully!\"}";
                }
                else
                {
                    return "{\"success\": false, \"message\": \"Failed to mark message as read.\"}";
                }
            }
            catch (Exception ex)
            {
                return $"{{\"success\": false, \"message\": \"Error marking message as read: {EscapeJsonString(ex.Message)}\"}}";
            }
        }

        [System.Web.Services.WebMethod]
        public static string DeleteMessage(int messageId)
        {
            try
            {
                bool success = MessagesHelper.DeleteMessage(messageId);
                if (success)
                {
                    return "{\"success\": true, \"message\": \"Message deleted successfully!\"}";
                }
                else
                {
                    return "{\"success\": false, \"message\": \"Failed to delete message.\"}";
                }
            }
            catch (Exception ex)
            {
                return $"{{\"success\": false, \"message\": \"Error deleting message: {EscapeJsonString(ex.Message)}\"}}";
            }
        }

        [System.Web.Services.WebMethod]
        public static string GetMessage(int messageId)
        {
            try
            {
                var message = MessagesHelper.GetMessageById(messageId);
                if (message == null)
                {
                    return "{\"success\": false, \"message\": \"Message not found.\"}";
                }

                // Escape strings for JSON
                string name = EscapeJsonString(message.Name);
                string email = EscapeJsonString(message.Email);
                string subject = EscapeJsonString(message.Subject);
                string messageText = EscapeJsonString(message.MessageText);
                string priority = EscapeJsonString(message.Priority ?? "Normal");
                string ipAddress = EscapeJsonString(message.IpAddress ?? "");
                string userAgent = EscapeJsonString(message.UserAgent ?? "");
                string adminNotes = EscapeJsonString(message.AdminNotes ?? "");

                return $@"{{
                    ""success"": true,
                    ""message"": {{
                        ""id"": {message.Id},
                        ""name"": ""{name}"",
                        ""email"": ""{email}"",
                        ""subject"": ""{subject}"",
                        ""messageText"": ""{messageText}"",
                        ""isRead"": {message.IsRead.ToString().ToLower()},
                        ""isReplied"": {message.IsReplied.ToString().ToLower()},
                        ""priority"": ""{priority}"",
                        ""ipAddress"": ""{ipAddress}"",
                        ""userAgent"": ""{userAgent}"",
                        ""dateReceived"": ""{message.DateReceived:yyyy-MM-dd HH:mm:ss}"",
                        ""dateRead"": ""{(message.DateRead?.ToString("yyyy-MM-dd HH:mm:ss") ?? "")}"",
                        ""dateReplied"": ""{(message.DateReplied?.ToString("yyyy-MM-dd HH:mm:ss") ?? "")}"",
                        ""adminNotes"": ""{adminNotes}""
                    }}
                }}";
            }
            catch (Exception ex)
            {
                return $"{{\"success\": false, \"message\": \"Error getting message: {EscapeJsonString(ex.Message)}\"}}";
            }
        }

        private static string EscapeJsonString(string input)
        {
            if (string.IsNullOrEmpty(input))
                return "";
            
            return input.Replace("\\", "\\\\")
                       .Replace("\"", "\\\"")
                       .Replace("\r", "\\r")
                       .Replace("\n", "\\n")
                       .Replace("\t", "\\t");
        }
    }
}