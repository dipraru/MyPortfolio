using System;
using System.Web.UI;
using MyPortfolio.Helpers;

namespace MyPortfolio.Admin.Sections
{
    public partial class ProfileSection : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadProfileData();
            }
        }

        private void LoadProfileData()
        {
            try
            {
                var profile = ProfileHelper.GetActiveProfile();
                if (profile != null)
                {
                    // Personal Information
                    fullName.Value = profile.FullName ?? "";
                    title.Value = profile.Title ?? "";
                    email.Value = profile.Email ?? "";
                    phone.Value = profile.Phone ?? "";
                    location.Value = profile.Location ?? "";
                    bio.Value = profile.Bio ?? "";

                    // Programming Profile
                    experience.Value = profile.Experience.ToString();
                    codeforcesRating.Value = profile.CodeforcesRating.ToString();
                    codeforcesRank.Value = profile.CodeforcesRank ?? "";
                    codechefRating.Value = profile.CodechefRating.ToString();
                    codechefRank.Value = profile.CodechefRank ?? "";
                    problemsSolved.Value = profile.ProblemsSolved.ToString();

                    // Social Links
                    github.Value = profile.GitHubUrl ?? "";
                    codeforces.Value = profile.CodeforcesUrl ?? "";
                    linkedin.Value = profile.LinkedInUrl ?? "";
                    twitter.Value = profile.TwitterUrl ?? "";
                    kaggle.Value = profile.KaggleUrl ?? "";

                    // Store profile ID for updates
                    hiddenProfileId.Value = profile.Id.ToString();
                }
                else
                {
                    // Set default values if no profile exists
                    SetDefaultValues();
                }
            }
            catch (Exception ex)
            {
                // Log error and set default values
                System.Diagnostics.Debug.WriteLine($"Error loading profile data: {ex.Message}");
                SetDefaultValues();
            }
        }

        private void SetDefaultValues()
        {
            // Personal Information defaults
            fullName.Value = "Dipra Datta";
            title.Value = "Competitive Programmer";
            email.Value = "dipra.datta@example.com";
            phone.Value = "+880 1XXX-XXXXXX";
            location.Value = "Khulna, Bangladesh";
            bio.Value = "BSc. in CSE at KUET | Algorithm Enthusiast | Problem Solver";

            // Programming Profile defaults
            experience.Value = "3";
            codeforcesRating.Value = "1771";
            codeforcesRank.Value = "Expert";
            codechefRating.Value = "1913";
            codechefRank.Value = "4-star";
            problemsSolved.Value = "1676";

            // Social Links defaults
            github.Value = "https://github.com/dipra-datta";
            codeforces.Value = "https://codeforces.com/profile/dipra_datta";
            linkedin.Value = "https://linkedin.com/in/dipra-datta";
            twitter.Value = "https://twitter.com/dipra_datta";
            kaggle.Value = "https://kaggle.com/dipra-datta";

            hiddenProfileId.Value = "0"; // 0 indicates new profile
        }

        public bool SaveProfile()
        {
            try
            {
                var profile = new Profile
                {
                    Id = int.Parse(hiddenProfileId.Value),
                    FullName = fullName.Value.Trim(),
                    Title = title.Value.Trim(),
                    Email = email.Value.Trim(),
                    Phone = phone.Value.Trim(),
                    Location = location.Value.Trim(),
                    Bio = bio.Value.Trim(),
                    Experience = int.Parse(experience.Value),
                    CodeforcesRating = int.Parse(codeforcesRating.Value),
                    CodeforcesRank = codeforcesRank.Value.Trim(),
                    CodechefRating = int.Parse(codechefRating.Value),
                    CodechefRank = codechefRank.Value.Trim(),
                    ProblemsSolved = int.Parse(problemsSolved.Value),
                    GitHubUrl = github.Value.Trim(),
                    CodeforcesUrl = codeforces.Value.Trim(),
                    LinkedInUrl = linkedin.Value.Trim(),
                    TwitterUrl = twitter.Value.Trim(),
                    KaggleUrl = kaggle.Value.Trim(),
                    IsActive = true
                };

                bool success;
                if (profile.Id == 0)
                {
                    // Insert new profile
                    success = ProfileHelper.InsertProfile(profile);
                }
                else
                {
                    // Update existing profile
                    success = ProfileHelper.UpdateProfile(profile);
                }

                if (success)
                {
                    // Reload data to get updated information
                    LoadProfileData();
                }

                return success;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error saving profile: {ex.Message}");
                return false;
            }
        }
    }
}