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
            <button class="btn" id="updateProfileBtn" type="button">
                <i class="fas fa-save"></i>
                <span>Save Changes</span>
            </button>
        </div>
        
        <div class="form-grid">
            <div class="form-group">
                <label>Full Name</label>
                <input type="text" class="form-control" runat="server" id="fullName" required>
            </div>
            
            <div class="form-group">
                <label>Professional Title</label>
                <input type="text" class="form-control" runat="server" id="title" required>
            </div>
            
            <div class="form-group">
                <label>Email</label>
                <input type="email" class="form-control" runat="server" id="email" required>
            </div>
            
            <div class="form-group">
                <label>Phone</label>
                <input type="tel" class="form-control" runat="server" id="phone">
            </div>
            
            <div class="form-group">
                <label>Location</label>
                <input type="text" class="form-control" runat="server" id="location">
            </div>
            
            <div class="form-group">
                <label>Bio</label>
                <textarea class="form-control" rows="3" runat="server" id="bio"></textarea>
            </div>
        </div>
    </div>
    
    <div class="content-section">
        <div class="section-header">
            <h2 class="section-title">Programming Profile</h2>
            <button class="btn" id="updateProgrammingProfileBtn" type="button">
                <i class="fas fa-save"></i>
                <span>Save Changes</span>
            </button>
        </div>
        
        <div class="form-grid">
            <div class="form-group">
                <label>Experience (Years)</label>
                <input type="number" class="form-control" runat="server" id="experience" min="0" required>
            </div>
            
            <div class="form-group">
                <label>Codeforces Rating</label>
                <input type="number" class="form-control" runat="server" id="codeforcesRating" min="0" required>
            </div>
            
            <div class="form-group">
                <label>Codeforces Rank</label>
                <input type="text" class="form-control" runat="server" id="codeforcesRank" required>
            </div>
            
            <div class="form-group">
                <label>Codechef Rating</label>
                <input type="number" class="form-control" runat="server" id="codechefRating" min="0" required>
            </div>
            
            <div class="form-group">
                <label>Codechef Rank</label>
                <input type="text" class="form-control" runat="server" id="codechefRank" required>
            </div>
            
            <div class="form-group">
                <label>Problems Solved</label>
                <input type="number" class="form-control" runat="server" id="problemsSolved" min="0" required>
            </div>
        </div>
    </div>
    
    <div class="content-section">
        <div class="section-header">
            <h2 class="section-title">Social Links</h2>
            <button class="btn" id="updateSocialLinksBtn" type="button">
                <i class="fas fa-save"></i>
                <span>Save Changes</span>
            </button>
        </div>
        
        <div class="form-grid">
            <div class="form-group">
                <label>GitHub</label>
                <input type="text" class="form-control" runat="server" id="github">
            </div>
            
            <div class="form-group">
                <label>Codeforces</label>
                <input type="text" class="form-control" runat="server" id="codeforces">
            </div>
            
            <div class="form-group">
                <label>LinkedIn</label>
                <input type="text" class="form-control" runat="server" id="linkedin">
            </div>
            
            <div class="form-group">
                <label>Twitter</label>
                <input type="text" class="form-control" runat="server" id="twitter">
            </div>
            
            <div class="form-group">
                <label>Kaggle</label>
                <input type="text" class="form-control" runat="server" id="kaggle">
            </div>
        </div>
    </div>
    
    <!-- Hidden field for profile ID -->
    <asp:HiddenField ID="hiddenProfileId" runat="server" />
</div>

<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function() {
    // Wait a bit for the page to fully load
    setTimeout(function() {
        initializeProfileSaveButtons();
    }, 500);
});

function initializeProfileSaveButtons() {
    console.log('Initializing profile save buttons...');
    
    // Personal Information Save Button
    const updateProfileBtn = document.getElementById('updateProfileBtn');
    if (updateProfileBtn) {
        updateProfileBtn.addEventListener('click', function(e) {
            e.preventDefault();
            saveProfileData('personal');
        });
        console.log('Personal Information save button initialized');
    }

    // Programming Profile Save Button
    const updateProgrammingProfileBtn = document.getElementById('updateProgrammingProfileBtn');
    if (updateProgrammingProfileBtn) {
        updateProgrammingProfileBtn.addEventListener('click', function(e) {
            e.preventDefault();
            saveProfileData('programming');
        });
        console.log('Programming Profile save button initialized');
    }

    // Social Links Save Button
    const updateSocialLinksBtn = document.getElementById('updateSocialLinksBtn');
    if (updateSocialLinksBtn) {
        updateSocialLinksBtn.addEventListener('click', function(e) {
            e.preventDefault();
            saveProfileData('social');
        });
        console.log('Social Links save button initialized');
    }

    console.log('All profile save buttons initialized');
}

function saveProfileData(section) {
    console.log('Saving profile section:', section);
    
    // Collect all form data
    const profileData = collectProfileFormData();
    
    if (!profileData) {
        showProfileToast('Please fill in all required fields', 'error');
        return;
    }
    
    // Show loading toast
    showProfileToast('Saving profile changes...', 'info');
    
    // Call server-side method to save profile
    $.ajax({
        type: "POST",
        url: "Dashboard.aspx/SaveProfileData",
        data: JSON.stringify(profileData),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function(response) {
            try {
                const result = JSON.parse(response.d);
                if (result.success) {
                    showProfileToast(result.message, 'success');
                    // Update the hidden profile ID if this was a new profile
                    if (result.profileId) {
                        const hiddenProfileId = document.getElementById('<%=hiddenProfileId.ClientID%>');
                        if (hiddenProfileId) {
                            hiddenProfileId.value = result.profileId;
                        }
                    }
                } else {
                    showProfileToast(result.message, 'error');
                }
            } catch (e) {
                console.error('Error parsing save profile response:', e);
                showProfileToast('Error parsing response', 'error');
            }
        },
        error: function(xhr, status, error) {
            console.error('Error saving profile:', error, xhr.responseText);
            showProfileToast('Error saving profile: ' + error, 'error');
        }
    });
}

function collectProfileFormData() {
    try {
        // Get form elements using their client IDs (generated by ASP.NET)
        const fullName = document.getElementById('<%=fullName.ClientID%>');
        const title = document.getElementById('<%=title.ClientID%>');
        const email = document.getElementById('<%=email.ClientID%>');
        const phone = document.getElementById('<%=phone.ClientID%>');
        const location = document.getElementById('<%=location.ClientID%>');
        const bio = document.getElementById('<%=bio.ClientID%>');
        const experience = document.getElementById('<%=experience.ClientID%>');
        const codeforcesRating = document.getElementById('<%=codeforcesRating.ClientID%>');
        const codeforcesRank = document.getElementById('<%=codeforcesRank.ClientID%>');
        const codechefRating = document.getElementById('<%=codechefRating.ClientID%>');
        const codechefRank = document.getElementById('<%=codechefRank.ClientID%>');
        const problemsSolved = document.getElementById('<%=problemsSolved.ClientID%>');
        const github = document.getElementById('<%=github.ClientID%>');
        const codeforces = document.getElementById('<%=codeforces.ClientID%>');
        const linkedin = document.getElementById('<%=linkedin.ClientID%>');
        const twitter = document.getElementById('<%=twitter.ClientID%>');
        const kaggle = document.getElementById('<%=kaggle.ClientID%>');
        const hiddenProfileId = document.getElementById('<%=hiddenProfileId.ClientID%>');

        console.log('Found elements:', {
            fullName: fullName ? 'OK' : 'MISSING',
            title: title ? 'OK' : 'MISSING',
            email: email ? 'OK' : 'MISSING'
        });

        // Validate required fields
        if (!fullName || !fullName.value.trim()) {
            showProfileToast('Full Name is required', 'error');
            return null;
        }
        if (!title || !title.value.trim()) {
            showProfileToast('Professional Title is required', 'error');
            return null;
        }
        if (!email || !email.value.trim()) {
            showProfileToast('Email is required', 'error');
            return null;
        }

        // Collect all data
        const profileData = {
            id: hiddenProfileId ? parseInt(hiddenProfileId.value) || 0 : 0,
            fullName: fullName.value.trim(),
            title: title.value.trim(),
            email: email.value.trim(),
            phone: phone ? phone.value.trim() : '',
            location: location ? location.value.trim() : '',
            bio: bio ? bio.value.trim() : '',
            experience: experience ? parseInt(experience.value) || 0 : 0,
            codeforcesRating: codeforcesRating ? parseInt(codeforcesRating.value) || 0 : 0,
            codeforcesRank: codeforcesRank ? codeforcesRank.value.trim() : '',
            codechefRating: codechefRating ? parseInt(codechefRating.value) || 0 : 0,
            codechefRank: codechefRank ? codechefRank.value.trim() : '',
            problemsSolved: problemsSolved ? parseInt(problemsSolved.value) || 0 : 0,
            githubUrl: github ? github.value.trim() : '',
            codeforcesUrl: codeforces ? codeforces.value.trim() : '',
            linkedinUrl: linkedin ? linkedin.value.trim() : '',
            twitterUrl: twitter ? twitter.value.trim() : '',
            kaggleUrl: kaggle ? kaggle.value.trim() : ''
        };

        console.log('Collected profile data:', profileData);
        return profileData;
    } catch (error) {
        console.error('Error collecting profile data:', error);
        showProfileToast('Error collecting form data', 'error');
        return null;
    }
}

// Fallback toast function if showToast is not available
function showProfileToast(message, type) {
    // Try to use the global showToast function first
    if (typeof showToast === 'function') {
        showToast(message, type);
        return;
    }
    
    // Fallback to alert or console
    if (type === 'error') {
        alert('Error: ' + message);
        console.error('Profile Error:', message);
    } else if (type === 'success') {
        alert('Success: ' + message);
        console.log('Profile Success:', message);
    } else {
        console.log('Profile Info:', message);
    }
}
</script>