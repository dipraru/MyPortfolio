using System;
using System.Linq;
using System.Text;
using System.Web.UI;
using MyPortfolio.Helpers;
using System.Text.RegularExpressions;

namespace MyPortfolio.Sections
{
    public partial class AboutSection : UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // About section loads profile and achievement data dynamically
        }

        /// <summary>
        /// Gets the years of experience from profile database
        /// </summary>
        /// <returns>Experience years or default value</returns>
        protected string GetExperience()
        {
            try
            {
                var profile = ProfileHelper.GetActiveProfile();
                return profile?.Experience.ToString() ?? "3";
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error loading experience: {ex.Message}");
                return "3";
            }
        }

        /// <summary>
        /// Gets the Codeforces rating from profile database
        /// </summary>
        /// <returns>Codeforces rating or default value</returns>
        protected string GetCodeforcesRating()
        {
            try
            {
                var profile = ProfileHelper.GetActiveProfile();
                return profile?.CodeforcesRating.ToString() ?? "1771";
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error loading Codeforces rating: {ex.Message}");
                return "1771";
            }
        }

        /// <summary>
        /// Gets the Codeforces rank from profile database
        /// </summary>
        /// <returns>Codeforces rank or default value</returns>
        protected string GetCodeforcesRank()
        {
            try
            {
                var profile = ProfileHelper.GetActiveProfile();
                return profile?.CodeforcesRank ?? "Expert";
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error loading Codeforces rank: {ex.Message}");
                return "Expert";
            }
        }

        /// <summary>
        /// Gets the Codechef rating from profile database
        /// </summary>
        /// <returns>Codechef rating or default value</returns>
        protected string GetCodechefRating()
        {
            try
            {
                var profile = ProfileHelper.GetActiveProfile();
                return profile?.CodechefRating.ToString() ?? "1913";
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error loading Codechef rating: {ex.Message}");
                return "1913";
            }
        }

        /// <summary>
        /// Gets the Codechef rank from profile database
        /// </summary>
        /// <returns>Codechef rank or default value</returns>
        protected string GetCodechefRank()
        {
            try
            {
                var profile = ProfileHelper.GetActiveProfile();
                return profile?.CodechefRank ?? "4-star";
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error loading Codechef rank: {ex.Message}");
                return "4-star";
            }
        }

        /// <summary>
        /// Gets the problems solved count from profile database
        /// </summary>
        /// <returns>Problems solved count or default value</returns>
        protected string GetProblemsSolved()
        {
            try
            {
                var profile = ProfileHelper.GetActiveProfile();
                return profile?.ProblemsSolved.ToString() ?? "1676";
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error loading problems solved: {ex.Message}");
                return "1676";
            }
        }

        /// <summary>
        /// Gets the Codeforces profile URL from profile database
        /// </summary>
        /// <returns>Codeforces URL or default value</returns>
        protected string GetCodeforcesUrl()
        {
            try
            {
                var profile = ProfileHelper.GetActiveProfile();
                return profile?.CodeforcesUrl ?? "codeforces.com/profile/dipra_datta";
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error loading Codeforces URL: {ex.Message}");
                return "codeforces.com/profile/dipra_datta";
            }
        }

        /// <summary>
        /// Generates HTML for competition achievements from database
        /// This method creates the compact achievement boxes with position numbers
        /// </summary>
        /// <returns>HTML string containing achievement boxes</returns>
        protected string GetCompetitionAchievementsHtml()
        {
            try
            {
                // Get achievements from database, filter for competition category
                var achievements = AchievementsHelper.GetAllAchievements();
                var html = new StringBuilder();

                if (achievements != null && achievements.Any())
                {
                    // Filter for competition achievements and take first 6 for the grid
                    var competitionAchievements = achievements
                        .Where(a => a.Category != null && a.Category.ToLower().Contains("competition"))
                        .Take(6)
                        .ToList();

                    if (competitionAchievements.Any())
                    {
                        foreach (var achievement in competitionAchievements)
                        {
                            // Extract position number from title or description
                            var position = ExtractPositionFromAchievement(achievement);

                            // Generate short description for competition type
                            var shortDescription = GetShortDescription(achievement);

                            html.AppendFormat(@"
                                <div class='achievement-box'>
                                    <div class='achievement-position'>{0}</div>
                                    <div class='achievement-info'>
                                        <h4>{1}</h4>
                                        <p>{2}</p>
                                    </div>
                                </div>",
                                position,
                                Server.HtmlEncode(achievement.Title),
                                Server.HtmlEncode(shortDescription)
                            );
                        }
                    }
                    else
                    {
                        // If no competition achievements, show all achievements but limit to 6
                        var limitedAchievements = achievements.Take(6).ToList();
                        foreach (var achievement in limitedAchievements)
                        {
                            var position = ExtractPositionFromAchievement(achievement);
                            var shortDescription = GetShortDescription(achievement);

                            html.AppendFormat(@"
                                <div class='achievement-box'>
                                    <div class='achievement-position'>{0}</div>
                                    <div class='achievement-info'>
                                        <h4>{1}</h4>
                                        <p>{2}</p>
                                    </div>
                                </div>",
                                position,
                                Server.HtmlEncode(achievement.Title),
                                Server.HtmlEncode(shortDescription)
                            );
                        }
                    }
                }

                // If we have less than 6 achievements, we still return what we have
                // If no achievements at all, show a single empty state
                if (html.Length == 0)
                {
                    html.Append(@"
                        <div class='achievement-box' style='grid-column: 1 / -1; text-align: center; padding: 40px;'>
                            <div style='width: 100%; display: flex; flex-direction: column; align-items: center;'>
                                <i class='fas fa-trophy' style='font-size: 2rem; color: var(--text-tertiary); margin-bottom: 15px;'></i>
                                <h4 style='color: var(--text-secondary); margin-bottom: 5px;'>No Achievements Yet</h4>
                                <p style='color: var(--text-tertiary);'>Competition achievements will appear here</p>
                            </div>
                        </div>");
                }

                return html.ToString();
            }
            catch (Exception ex)
            {
                // In case of error, show error state
                System.Diagnostics.Debug.WriteLine($"Error loading competition achievements: {ex.Message}");
                return @"
                    <div class='achievement-box' style='grid-column: 1 / -1; text-align: center; padding: 40px;'>
                        <div style='width: 100%; display: flex; flex-direction: column; align-items: center;'>
                            <i class='fas fa-exclamation-triangle' style='font-size: 2rem; color: var(--accent); margin-bottom: 15px;'></i>
                            <h4 style='color: var(--text-secondary); margin-bottom: 5px;'>Unable to Load</h4>
                            <p style='color: var(--text-tertiary);'>Please check database connection</p>
                        </div>
                    </div>";
            }
        }

        /// <summary>
        /// Extracts position number from achievement title or description
        /// </summary>
        /// <param name="achievement">Achievement object</param>
        /// <returns>Position string or "?" if not found</returns>
        private string ExtractPositionFromAchievement(Achievement achievement)
        {
            // Try to extract position from title first
            var position = ExtractPositionFromText(achievement.Title);
            
            // If not found in title, try description
            if (position == "?")
            {
                position = ExtractPositionFromText(achievement.Description);
            }

            return position;
        }

        /// <summary>
        /// Extracts position number from text using regex
        /// </summary>
        /// <param name="text">Text to search in</param>
        /// <returns>Position string or "?" if not found</returns>
        private string ExtractPositionFromText(string text)
        {
            if (string.IsNullOrEmpty(text))
                return "?";

            // Look for patterns like "32nd", "7th", "13th", "1st", "2nd", "3rd", etc.
            var positionMatch = Regex.Match(text, @"\b(\d+)(?:st|nd|rd|th)\b", RegexOptions.IgnoreCase);
            if (positionMatch.Success)
            {
                return positionMatch.Groups[1].Value;
            }

            // Look for patterns like "position 32", "rank 7", "placed 13", etc.
            var rankMatch = Regex.Match(text, @"\b(?:position|rank|placed|achieved)\s+(\d+)\b", RegexOptions.IgnoreCase);
            if (rankMatch.Success)
            {
                return rankMatch.Groups[1].Value;
            }

            // Look for just numbers at the beginning
            var numberMatch = Regex.Match(text, @"^\d+");
            if (numberMatch.Success)
            {
                return numberMatch.Value;
            }

            return "?";
        }

        /// <summary>
        /// Generates a short description for the achievement box
        /// </summary>
        /// <param name="achievement">Achievement object</param>
        /// <returns>Short description string</returns>
        private string GetShortDescription(Achievement achievement)
        {
            // If organization is available, use it
            if (!string.IsNullOrEmpty(achievement.Organization))
            {
                return achievement.Organization;
            }

            // Otherwise, try to extract contest type from title
            var title = achievement.Title.ToLower();
            if (title.Contains("iupc"))
                return "Inter University Programming Contest";
            if (title.Contains("icpc"))
                return "Regional Contest";
            if (title.Contains("national"))
                return "National Contest";
            if (title.Contains("contest") || title.Contains("competition"))
                return "Programming Contest";

            // Fallback to category or first few words of description
            if (!string.IsNullOrEmpty(achievement.Category))
            {
                return achievement.Category;
            }

            // Last resort: truncate description
            if (!string.IsNullOrEmpty(achievement.Description))
            {
                var words = achievement.Description.Split(' ');
                if (words.Length > 3)
                {
                    return string.Join(" ", words.Take(3)) + "...";
                }
                return achievement.Description;
            }

            return "Achievement";
        }
    }
}