<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProfileSection.ascx.cs" Inherits="MyPortfolio.Admin.Sections.ProfileSection" %>

<!-- Profile Page -->
<div class="page" id="profile-page" style="display: none;">
    <div class="page-header">
        <h1 class="page-title">Profile Management</h1>
        <p class="page-subtitle">Update your personal information and professional details.</p>
    </div>
    
    <div class="content-section">
        <div class="section-header">
            <h2 class="section-title">Personal Information</h2>
            <button class="btn" id="updateProfileBtn">
                <i class="fas fa-save"></i>
                <span>Save Changes</span>
            </button>
        </div>
        
        <form id="profileForm">
            <div class="form-grid">
                <div class="form-group">
                    <label for="fullName">Full Name</label>
                    <input type="text" id="fullName" class="form-control" runat="server" required>
                </div>
                
                <div class="form-group">
                    <label for="title">Professional Title</label>
                    <input type="text" id="title" class="form-control" runat="server" required>
                </div>
                
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" class="form-control" runat="server" required>
                </div>
                
                <div class="form-group">
                    <label for="phone">Phone</label>
                    <input type="tel" id="phone" class="form-control" runat="server">
                </div>
                
                <div class="form-group">
                    <label for="location">Location</label>
                    <input type="text" id="location" class="form-control" runat="server">
                </div>
                
                <div class="form-group">
                    <label for="bio">Bio</label>
                    <textarea id="bio" class="form-control" rows="3" runat="server"></textarea>
                </div>
            </div>
        </form>
    </div>
    
    <div class="content-section">
        <div class="section-header">
            <h2 class="section-title">Programming Profile</h2>
            <button class="btn" id="updateProgrammingProfileBtn">
                <i class="fas fa-save"></i>
                <span>Save Changes</span>
            </button>
        </div>
        
        <form id="programmingProfileForm">
            <div class="form-grid">
                <div class="form-group">
                    <label for="experience">Experience (Years)</label>
                    <input type="number" id="experience" class="form-control" runat="server" min="0" required>
                </div>
                
                <div class="form-group">
                    <label for="codeforcesRating">Codeforces Rating</label>
                    <input type="number" id="codeforcesRating" class="form-control" runat="server" min="0" required>
                </div>
                
                <div class="form-group">
                    <label for="codeforcesRank">Codeforces Rank</label>
                    <input type="text" id="codeforcesRank" class="form-control" runat="server" required>
                </div>
                
                <div class="form-group">
                    <label for="codechefRating">Codechef Rating</label>
                    <input type="number" id="codechefRating" class="form-control" runat="server" min="0" required>
                </div>
                
                <div class="form-group">
                    <label for="codechefRank">Codechef Rank</label>
                    <input type="text" id="codechefRank" class="form-control" runat="server" required>
                </div>
                
                <div class="form-group">
                    <label for="problemsSolved">Problems Solved</label>
                    <input type="number" id="problemsSolved" class="form-control" runat="server" min="0" required>
                </div>
            </div>
        </form>
    </div>
    
    <div class="content-section">
        <div class="section-header">
            <h2 class="section-title">Social Links</h2>
            <button class="btn" id="updateSocialLinksBtn">
                <i class="fas fa-save"></i>
                <span>Save Changes</span>
            </button>
        </div>
        
        <form id="socialLinksForm">
            <div class="form-grid">
                <div class="form-group">
                    <label for="github">GitHub</label>
                    <input type="text" id="github" class="form-control" runat="server">
                </div>
                
                <div class="form-group">
                    <label for="codeforces">Codeforces</label>
                    <input type="text" id="codeforces" class="form-control" runat="server">
                </div>
                
                <div class="form-group">
                    <label for="linkedin">LinkedIn</label>
                    <input type="text" id="linkedin" class="form-control" runat="server">
                </div>
                
                <div class="form-group">
                    <label for="twitter">Twitter</label>
                    <input type="text" id="twitter" class="form-control" runat="server">
                </div>
                
                <div class="form-group">
                    <label for="kaggle">Kaggle</label>
                    <input type="text" id="kaggle" class="form-control" runat="server">
                </div>
            </div>
        </form>
    </div>
    
    <!-- Hidden field for profile ID -->
    <asp:HiddenField ID="hiddenProfileId" runat="server" />
</div>