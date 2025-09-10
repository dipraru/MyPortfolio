using System;
using System.Linq;
using System.Text;
using System.Web.UI;
using MyPortfolio.Helpers;

namespace MyPortfolio.Sections
{
    public partial class AchievementsSection : UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Achievements will be loaded via GetAchievementsHtml() method
        }

        /// <summary>
        /// Generates HTML for all achievements from database
        /// </summary>
        /// <returns>HTML string containing achievement cards</returns>
        protected string GetAchievementsHtml()
        {
            try
            {
                // Get achievements from database
                var achievements = AchievementsHelper.GetAllAchievements();
                var html = new StringBuilder();

                if (achievements != null && achievements.Any())
                {
                    foreach (var achievement in achievements)
                    {
                        // Generate achievement icon based on category
                        var iconClass = GetAchievementIcon(achievement.Category);

                        html.AppendFormat(@"
                            <div class='achievement-card'>
                                <div class='achievement-icon'><i class='{0}'></i></div>
                                <h3 class='achievement-title'>{1}</h3>
                                <p class='achievement-description'>{2}</p>
                            </div>",
                            iconClass,
                            Server.HtmlEncode(achievement.Title),
                            Server.HtmlEncode(achievement.Description)
                        );
                    }
                }
                else
                {
                    // Show empty state
                    html.Append(@"
                        <div class='achievement-card' style='text-align: center; padding: 60px 30px; min-height: 300px; display: flex; flex-direction: column; justify-content: center;'>
                            <i class='fas fa-trophy' style='font-size: 4rem; color: var(--text-tertiary); margin-bottom: 25px;'></i>
                            <h3 style='color: var(--text-secondary); font-size: 1.5rem; margin-bottom: 15px;'>No Achievements Yet</h3>
                            <p style='color: var(--text-tertiary); font-size: 1rem;'>Achievements will be displayed here once they are added to the portfolio.</p>
                        </div>");
                }

                return html.ToString();
            }
            catch (Exception ex)
            {
                // In case of error, show error message
                System.Diagnostics.Debug.WriteLine($"Error loading achievements: {ex.Message}");
                return @"
                    <div class='achievement-card' style='text-align: center; padding: 60px 30px; min-height: 300px; display: flex; flex-direction: column; justify-content: center;'>
                        <i class='fas fa-exclamation-triangle' style='font-size: 4rem; color: var(--accent); margin-bottom: 25px;'></i>
                        <h3 style='color: var(--text-secondary); font-size: 1.5rem; margin-bottom: 15px;'>Unable to Load Achievements</h3>
                        <p style='color: var(--text-tertiary); font-size: 1rem;'>Please check your database connection and try again.</p>
                    </div>";
            }
        }

        /// <summary>
        /// Helper method to get appropriate icon based on achievement category
        /// </summary>
        /// <param name="category">Achievement category</param>
        /// <returns>Font Awesome icon class</returns>
        private string GetAchievementIcon(string category)
        {
            if (string.IsNullOrEmpty(category))
                return "fas fa-trophy";

            switch (category.ToLower())
            {
                case "competition":
                    return "fas fa-trophy";
                case "award":
                    return "fas fa-medal";
                case "certification":
                    return "fas fa-certificate";
                case "publication":
                    return "fas fa-book";
                default:
                    return "fas fa-star";
            }
        }
    }
}