using System;
using System.Linq;
using System.Text;
using System.Web.UI;
using MyPortfolio.Helpers;

namespace MyPortfolio.Sections
{
    public partial class SkillsSection : UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Skills will be loaded via GetSkillsHtml() method
        }

        /// <summary>
        /// Generates HTML for all skills from database
        /// </summary>
        /// <returns>HTML string containing skill cards</returns>
        protected string GetSkillsHtml()
        {
            try
            {
                // Get skills from database
                var skills = SkillsHelper.GetAllSkills();
                var html = new StringBuilder();

                if (skills != null && skills.Any())
                {
                    foreach (var skill in skills)
                    {
                        // Generate skill icon HTML
                        var iconHtml = GetSkillIconHtml(skill.IconClass, skill.IconColor);

                        html.AppendFormat(@"
                            <div class='skill-card'>
                                <div class='skill-icon'>
                                    {0}
                                </div>
                                <h3 class='skill-name'>{1}</h3>
                                <p class='skill-description'>{2}</p>
                                <div class='skill-level'>
                                    <div class='skill-progress' style='width: {3}%;'></div>
                                </div>
                            </div>",
                            iconHtml,
                            Server.HtmlEncode(skill.Name),
                            Server.HtmlEncode(skill.Description ?? ""),
                            skill.ProficiencyPercentage
                        );
                    }
                }
                else
                {
                    // Show empty state
                    html.Append(@"
                        <div class='skill-card' style='text-align: center; padding: 60px 30px; min-height: 300px; display: flex; flex-direction: column; justify-content: center;'>
                            <i class='fas fa-code' style='font-size: 4rem; color: var(--text-tertiary); margin-bottom: 25px;'></i>
                            <h3 style='color: var(--text-secondary); font-size: 1.5rem; margin-bottom: 15px;'>No Skills Yet</h3>
                            <p style='color: var(--text-tertiary); font-size: 1rem;'>Skills will be displayed here once they are added to the portfolio.</p>
                        </div>");
                }

                return html.ToString();
            }
            catch (Exception ex)
            {
                // In case of error, show error message
                System.Diagnostics.Debug.WriteLine($"Error loading skills: {ex.Message}");
                return @"
                    <div class='skill-card' style='text-align: center; padding: 60px 30px; min-height: 300px; display: flex; flex-direction: column; justify-content: center;'>
                        <i class='fas fa-exclamation-triangle' style='font-size: 4rem; color: var(--accent); margin-bottom: 25px;'></i>
                        <h3 style='color: var(--text-secondary); font-size: 1.5rem; margin-bottom: 15px;'>Unable to Load Skills</h3>
                        <p style='color: var(--text-tertiary); font-size: 1rem;'>Please check your database connection and try again.</p>
                    </div>";
            }
        }

        /// <summary>
        /// Helper method to format skill icons with proper styling
        /// </summary>
        /// <param name="iconClass">Font Awesome icon class</param>
        /// <param name="iconColor">Icon color</param>
        /// <returns>HTML formatted icon</returns>
        private string GetSkillIconHtml(string iconClass, string iconColor)
        {
            // Default icon if none specified
            if (string.IsNullOrEmpty(iconClass))
            {
                iconClass = "fas fa-code";
            }

            // Add color styling if specified
            var styleAttribute = "";
            if (!string.IsNullOrEmpty(iconColor))
            {
                styleAttribute = $" style='color: {Server.HtmlEncode(iconColor)};'";
            }

            return $"<i class='{Server.HtmlEncode(iconClass)}'{styleAttribute}></i>";
        }
    }
}