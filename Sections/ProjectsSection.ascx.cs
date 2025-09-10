using System;
using System.Linq;
using System.Text;
using System.Web.UI;
using MyPortfolio.Helpers;

namespace MyPortfolio.Sections
{
    public partial class ProjectsSection : UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Projects will be loaded via GetProjectsHtml() method
        }

        /// <summary>
        /// Generates HTML for all projects from database
        /// </summary>
        /// <returns>HTML string containing project cards</returns>
        protected string GetProjectsHtml()
        {
            try
            {
                // Get projects from database
                var projects = ProjectsHelper.GetAllProjects();
                var html = new StringBuilder();

                if (projects != null && projects.Any())
                {
                    foreach (var project in projects)
                    {
                        // Determine image URL
                        var imageUrl = !string.IsNullOrEmpty(project.ImageUrl) 
                            ? project.ImageUrl 
                            : "https://images.unsplash.com/photo-1555066931-4365d14bab8c?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80";

                        // Generate project tags HTML
                        var tagsHtml = GetProjectTagsHtml(project.Tags);

                        // Generate GitHub link if available
                        var githubLink = !string.IsNullOrEmpty(project.GitHubUrl) 
                            ? $"<a href='{Server.HtmlEncode(project.GitHubUrl)}' target='_blank'><i class='fab fa-github'></i></a>" 
                            : "";

                        // Generate live demo link if available
                        var liveLink = !string.IsNullOrEmpty(project.LiveDemoUrl) 
                            ? $"<a href='{Server.HtmlEncode(project.LiveDemoUrl)}' target='_blank'><i class='fas fa-external-link-alt'></i></a>" 
                            : "";

                        html.AppendFormat(@"
                            <div class='project-card'>
                                <div class='project-image'>
                                    <img src='{0}' alt='{1}' onerror=""this.src='https://images.unsplash.com/photo-1555066931-4365d14bab8c?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80'"">
                                    <div class='project-overlay'>
                                        <div class='project-links'>
                                            {2}
                                            {3}
                                        </div>
                                    </div>
                                </div>
                                <div class='project-info'>
                                    <h3 class='project-title'>{4}</h3>
                                    <p class='project-description'>{5}</p>
                                    <div class='project-tags'>
                                        {6}
                                    </div>
                                </div>
                            </div>",
                            Server.HtmlEncode(imageUrl),
                            Server.HtmlEncode(project.Title),
                            githubLink,
                            liveLink,
                            Server.HtmlEncode(project.Title),
                            Server.HtmlEncode(project.Description),
                            tagsHtml
                        );
                    }
                }
                else
                {
                    // Show empty state
                    html.Append(@"
                        <div class='project-card' style='text-align: center; padding: 60px 30px; min-height: 300px; display: flex; flex-direction: column; justify-content: center;'>
                            <i class='fas fa-folder-open' style='font-size: 4rem; color: var(--text-tertiary); margin-bottom: 25px;'></i>
                            <h3 style='color: var(--text-secondary); font-size: 1.5rem; margin-bottom: 15px;'>No Projects Yet</h3>
                            <p style='color: var(--text-tertiary); font-size: 1rem;'>Projects will be displayed here once they are added to the portfolio.</p>
                        </div>");
                }

                return html.ToString();
            }
            catch (Exception ex)
            {
                // In case of error, show error message
                System.Diagnostics.Debug.WriteLine($"Error loading projects: {ex.Message}");
                return @"
                    <div class='project-card' style='text-align: center; padding: 60px 30px; min-height: 300px; display: flex; flex-direction: column; justify-content: center;'>
                        <i class='fas fa-exclamation-triangle' style='font-size: 4rem; color: var(--accent); margin-bottom: 25px;'></i>
                        <h3 style='color: var(--text-secondary); font-size: 1.5rem; margin-bottom: 15px;'>Unable to Load Projects</h3>
                        <p style='color: var(--text-tertiary); font-size: 1rem;'>Please check your database connection and try again.</p>
                    </div>";
            }
        }

        /// <summary>
        /// Helper method to format project tags as HTML spans
        /// </summary>
        /// <param name="tags">Comma-separated tags string</param>
        /// <returns>HTML formatted tags</returns>
        private string GetProjectTagsHtml(string tags)
        {
            if (string.IsNullOrEmpty(tags))
                return "";

            var tagArray = tags.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
            var tagHtml = new StringBuilder();

            foreach (var tag in tagArray)
            {
                var trimmedTag = tag.Trim();
                if (!string.IsNullOrEmpty(trimmedTag))
                {
                    tagHtml.AppendFormat("<span class='tag'>{0}</span>", Server.HtmlEncode(trimmedTag));
                }
            }

            return tagHtml.ToString();
        }
    }
}