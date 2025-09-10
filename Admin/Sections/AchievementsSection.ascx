<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AchievementsSection.ascx.cs" Inherits="MyPortfolio.Admin.Sections.AchievementsSection" %>

<!-- Achievements Page -->
<div class="page" id="achievements-page" style="display: none;">
    <div class="page-header">
        <h1 class="page-title">Achievements Management</h1>
        <p class="page-subtitle">Manage your competitive programming achievements here.</p>
    </div>
    
    <div class="content-section">
        <div class="section-header">
            <h2 class="section-title">All Achievements</h2>
            <div class="header-actions" style="display: flex; gap: 10px;">
                <button type="button" class="btn-outline" id="reorderAchievementsBtn" title="Reorder achievements to fix display order gaps">
                    <i class="fas fa-sort-numeric-down"></i>
                    <span>Reorder</span>
                </button>
                <button type="button" class="btn" id="addAchievementBtn">
                    <i class="fas fa-plus"></i>
                    <span>Add New Achievement</span>
                </button>
            </div>
        </div>
        
        <div class="achievements-container" id="achievementsContainer">
            <!-- Achievements will be loaded here from server via AJAX -->
            <div class="achievement-card" style="text-align: center; padding: 40px; min-height: 200px; display: flex; flex-direction: column; justify-content: center;">
                <i class="fas fa-spinner fa-spin" style="font-size: 2rem; color: var(--primary);"></i>
                <div style="margin-top: 10px; color: var(--text-secondary);">Loading achievements...</div>
            </div>
        </div>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    console.log('AchievementsSection: DOM loaded');
    
    // Add achievement button event with better error handling
    const addAchievementBtn = document.getElementById('addAchievementBtn');
    if (addAchievementBtn) {
        addAchievementBtn.addEventListener('click', function(e) {
            e.preventDefault();
            e.stopPropagation();
            console.log('Add achievement button clicked');
            
            try {
                if (typeof window.openAchievementModal === 'function') {
                    window.openAchievementModal();
                } else {
                    console.error('openAchievementModal function not found');
                    alert('Modal function not available. Please refresh the page.');
                }
            } catch (error) {
                console.error('Error opening achievement modal:', error);
                alert('Error opening modal. Please refresh the page.');
            }
        });
        console.log('Add achievement button listener attached');
    } else {
        console.error('Add achievement button not found');
    }

    // Reorder achievements button event
    const reorderAchievementsBtn = document.getElementById('reorderAchievementsBtn');
    if (reorderAchievementsBtn) {
        reorderAchievementsBtn.addEventListener('click', function(e) {
            e.preventDefault();
            e.stopPropagation();
            
            if (typeof showToast === 'function') {
                showToast('Reorder functionality will be implemented later.', 'info');
            } else {
                alert('Reorder functionality will be implemented later.');
            }
        });
    }
});

function loadAchievements() {
    console.log('Loading achievements...');
    const container = document.getElementById('achievementsContainer');
    if (!container) {
        console.error('Achievements container not found');
        return;
    }

    // Show loading state
    container.innerHTML = `
        <div class="achievement-card" style="text-align: center; padding: 40px; min-height: 200px; display: flex; flex-direction: column; justify-content: center;">
            <i class="fas fa-spinner fa-spin" style="font-size: 2rem; color: var(--primary);"></i>
            <div style="margin-top: 10px; color: var(--text-secondary);">Loading achievements...</div>
        </div>
    `;

    // Make AJAX call to get achievements
    fetch('/Admin/Dashboard.aspx/GetAllAchievementsData', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=utf-8'
        },
        body: JSON.stringify({})
    })
    .then(response => {
        console.log('Achievements response received:', response);
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        return response.json();
    })
    .then(data => {
        console.log('Achievements data:', data);
        const result = JSON.parse(data.d);
        
        if (result.success) {
            container.innerHTML = result.achievementsHtml;
            console.log('Achievements loaded successfully');
            
            // Attach event listeners for action buttons
            attachAchievementActionListeners();
        } else {
            console.error('Error loading achievements:', result.message);
            container.innerHTML = `
                <div class="achievement-card" style="text-align: center; padding: 40px; min-height: 200px; display: flex; flex-direction: column; justify-content: center;">
                    <i class="fas fa-exclamation-triangle" style="font-size: 2rem; color: var(--danger); margin-bottom: 10px;"></i>
                    <div style="color: var(--text-secondary);">Error loading achievements: ${result.message}</div>
                </div>
            `;
        }
    })
    .catch(error => {
        console.error('Error loading achievements:', error);
        container.innerHTML = `
            <div class="achievement-card" style="text-align: center; padding: 40px; min-height: 200px; display: flex; flex-direction: column; justify-content: center;">
                <i class="fas fa-exclamation-triangle" style="font-size: 2rem; color: var(--danger); margin-bottom: 10px;"></i>
                <div style="color: var(--text-secondary);">Error loading achievements. Please try again.</div>
            </div>
        `;
    });
}

function attachAchievementActionListeners() {
    // Edit achievement buttons
    document.querySelectorAll('.edit-achievement').forEach(button => {
        button.addEventListener('click', function(e) {
            e.preventDefault();
            e.stopPropagation();
            const achievementId = this.getAttribute('data-id');
            if (typeof showToast === 'function') {
                showToast('Edit functionality will be implemented later.', 'info');
            } else {
                alert('Edit functionality will be implemented later.');
            }
        });
    });

    // Delete achievement buttons are handled by event delegation in dashboard.js
    // No need for explicit listeners here since the dashboard.js handles .delete-achievement clicks
    console.log('Achievement action listeners attached');
}

// Load achievements when the achievements page is shown
function showAchievementsPage() {
    console.log('Showing achievements page');
    loadAchievements();
}

// Export function for dashboard navigation
window.showAchievementsPage = showAchievementsPage;
window.loadAchievements = loadAchievements;
</script>

<style>
.achievements-container {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(400px, 1fr));
    gap: 20px;
    margin-top: 20px;
}

.achievement-card {
    background: var(--card-bg);
    border: 1px solid var(--border-color);
    border-radius: 12px;
    padding: 20px;
    transition: all 0.3s ease;
    position: relative;
}

.achievement-card:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
    border-color: var(--primary);
}

.achievement-header {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    margin-bottom: 15px;
}

.achievement-title {
    font-size: 1.1rem;
    font-weight: 600;
    color: var(--text-primary);
    margin-bottom: 5px;
}

.achievement-organization {
    font-size: 0.9rem;
    color: var(--text-secondary);
    margin-bottom: 3px;
}

.achievement-date {
    font-size: 0.85rem;
    color: var(--text-tertiary);
}

.achievement-category {
    text-align: right;
}

.category-badge {
    background: var(--primary);
    color: white;
    padding: 4px 8px;
    border-radius: 6px;
    font-size: 0.75rem;
    font-weight: 500;
}

.achievement-description {
    color: var(--text-secondary);
    line-height: 1.5;
    margin-bottom: 15px;
}

.achievement-links {
    margin-bottom: 15px;
}

.certificate-link {
    color: var(--primary);
    text-decoration: none;
    font-size: 0.9rem;
    display: inline-flex;
    align-items: center;
    gap: 5px;
}

.certificate-link:hover {
    text-decoration: underline;
}

.actions {
    display: flex;
    gap: 8px;
    justify-content: flex-end;
}

@media (max-width: 768px) {
    .achievements-container {
        grid-template-columns: 1fr;
    }
    
    .achievement-header {
        flex-direction: column;
        gap: 10px;
    }
    
    .achievement-category {
        text-align: left;
    }
}
</style>