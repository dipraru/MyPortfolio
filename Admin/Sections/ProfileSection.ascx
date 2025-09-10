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
                    <input type="text" id="fullName" class="form-control" value="Dipra Datta" required>
                </div>
                
                <div class="form-group">
                    <label for="title">Professional Title</label>
                    <input type="text" id="title" class="form-control" value="Competitive Programmer" required>
                </div>
                
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" class="form-control" value="dipra.datta@example.com" required>
                </div>
                
                <div class="form-group">
                    <label for="phone">Phone</label>
                    <input type="tel" id="phone" class="form-control" value="+880 1XXX-XXXXXX">
                </div>
                
                <div class="form-group">
                    <label for="location">Location</label>
                    <input type="text" id="location" class="form-control" value="Khulna, Bangladesh">
                </div>
                
                <div class="form-group">
                    <label for="bio">Bio</label>
                    <textarea id="bio" class="form-control" rows="3">BSc. in CSE at KUET | Algorithm Enthusiast | Problem Solver</textarea>
                </div>
            </div>
        </form>
    </div>
    
    <div class="content-section">
        <div class="section-header">
            <h2 class="section-title">Education</h2>
            <button class="btn" id="addEducationBtn">
                <i class="fas fa-plus"></i>
                <span>Add Education</span>
            </button>
        </div>
        
        <div class="profile-section">
            <div class="profile-item">
                <div class="profile-item-icon">
                    <i class="fas fa-university"></i>
                </div>
                <div class="profile-item-content">
                    <div class="profile-item-title">BSc. in CSE</div>
                    <div class="profile-item-subtitle">KUET (Khulna University of Engineering & Technology)</div>
                </div>
                <div class="profile-item-actions">
                    <button class="action-btn edit-education" title="Edit">
                        <i class="fas fa-edit"></i>
                    </button>
                    <button class="action-btn delete" title="Delete">
                        <i class="fas fa-trash"></i>
                    </button>
                </div>
            </div>
            
            <div class="profile-item">
                <div class="profile-item-icon">
                    <i class="fas fa-school"></i>
                </div>
                <div class="profile-item-content">
                    <div class="profile-item-title">HSC - GPA 5.0</div>
                    <div class="profile-item-subtitle">BAF Shaheen College, Kurmitola</div>
                </div>
                <div class="profile-item-actions">
                    <button class="action-btn edit-education" title="Edit">
                        <i class="fas fa-edit"></i>
                    </button>
                    <button class="action-btn delete" title="Delete">
                        <i class="fas fa-trash"></i>
                    </button>
                </div>
            </div>
            
            <div class="profile-item">
                <div class="profile-item-icon">
                    <i class="fas fa-school"></i>
                </div>
                <div class="profile-item-content">
                    <div class="profile-item-title">SSC - GPA 5.0</div>
                    <div class="profile-item-subtitle">Sammilani Secondary School, Chalitatola, Narail</div>
                </div>
                <div class="profile-item-actions">
                    <button class="action-btn edit-education" title="Edit">
                        <i class="fas fa-edit"></i>
                    </button>
                    <button class="action-btn delete" title="Delete">
                        <i class="fas fa-trash"></i>
                    </button>
                </div>
            </div>
            
            <div class="profile-item">
                <div class="profile-item-icon">
                    <i class="fas fa-certificate"></i>
                </div>
                <div class="profile-item-content">
                    <div class="profile-item-title">JSC - GPA 5.0</div>
                    <div class="profile-item-subtitle">Sammilani Secondary School, Chalitatola, Narail</div>
                </div>
                <div class="profile-item-actions">
                    <button class="action-btn edit-education" title="Edit">
                        <i class="fas fa-edit"></i>
                    </button>
                    <button class="action-btn delete" title="Delete">
                        <i class="fas fa-trash"></i>
                    </button>
                </div>
            </div>
        </div>
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
                    <input type="number" id="experience" class="form-control" value="3" min="0" required>
                </div>
                
                <div class="form-group">
                    <label for="codeforcesRating">Codeforces Rating</label>
                    <input type="number" id="codeforcesRating" class="form-control" value="1771" min="0" required>
                </div>
                
                <div class="form-group">
                    <label for="codeforcesRank">Codeforces Rank</label>
                    <input type="text" id="codeforcesRank" class="form-control" value="Expert" required>
                </div>
                
                <div class="form-group">
                    <label for="codechefRating">Codechef Rating</label>
                    <input type="number" id="codechefRating" class="form-control" value="1913" min="0" required>
                </div>
                
                <div class="form-group">
                    <label for="codechefRank">Codechef Rank</label>
                    <input type="text" id="codechefRank" class="form-control" value="4-star" required>
                </div>
                
                <div class="form-group">
                    <label for="problemsSolved">Problems Solved</label>
                    <input type="number" id="problemsSolved" class="form-control" value="1676" min="0" required>
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
                    <input type="text" id="github" class="form-control" value="https://github.com/dipra-datta">
                </div>
                
                <div class="form-group">
                    <label for="codeforces">Codeforces</label>
                    <input type="text" id="codeforces" class="form-control" value="https://codeforces.com/profile/dipra_datta">
                </div>
                
                <div class="form-group">
                    <label for="linkedin">LinkedIn</label>
                    <input type="text" id="linkedin" class="form-control" value="https://linkedin.com/in/dipra-datta">
                </div>
                
                <div class="form-group">
                    <label for="twitter">Twitter</label>
                    <input type="text" id="twitter" class="form-control" value="https://twitter.com/dipra_datta">
                </div>
                
                <div class="form-group">
                    <label for="kaggle">Kaggle</label>
                    <input type="text" id="kaggle" class="form-control" value="https://kaggle.com/dipra-datta">
                </div>
            </div>
        </form>
    </div>
</div>