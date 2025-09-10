<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SkillsSection.ascx.cs" Inherits="MyPortfolio.Admin.Sections.SkillsSection" %>

<!-- Skills Page -->
<div class="page" id="skills-page" style="display: none;">
    <div class="page-header">
        <h1 class="page-title">Skills Management</h1>
        <p class="page-subtitle">Manage your technical skills here.</p>
    </div>
    
    <div class="content-section">
        <div class="section-header">
            <h2 class="section-title">All Skills</h2>
            <div class="header-actions" style="display: flex; gap: 10px;">
                <button type="button" class="btn-outline" id="reorderSkillsBtn" title="Reorder skills to fix display order gaps">
                    <i class="fas fa-sort-numeric-down"></i>
                    <span>Reorder</span>
                </button>
                <button type="button" class="btn" id="addSkillBtn">
                    <i class="fas fa-plus"></i>
                    <span>Add New Skill</span>
                </button>
            </div>
        </div>
        
        <div class="table-responsive">
            <table class="data-table">
                <thead>
                    <tr>
                        <th style="width: 60px;">Icon</th>
                        <th style="width: 200px;">Name</th>
                        <th>Description</th>
                        <th style="width: 180px;">Proficiency</th>
                        <th style="width: 100px;">Actions</th>
                    </tr>
                </thead>
                <tbody id="skillsTableBody">
                    <!-- Skills will be loaded here from server via AJAX -->
                    <tr>
                        <td colspan="5" style="text-align: center; padding: 40px;">
                            <i class="fas fa-spinner fa-spin" style="font-size: 2rem; color: var(--primary);"></i>
                            <div style="margin-top: 10px; color: var(--text-secondary);">Loading skills...</div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    console.log('SkillsSection: DOM loaded');
    
    // Add skill button event with better error handling
    const addSkillBtn = document.getElementById('addSkillBtn');
    if (addSkillBtn) {
        addSkillBtn.addEventListener('click', function(e) {
            e.preventDefault();
            e.stopPropagation();
            console.log('Add skill button clicked');
            
            try {
                if (typeof window.openSkillModal === 'function') {
                    window.openSkillModal();
                } else {
                    console.error('openSkillModal function not found');
                    alert('Modal function not available. Please refresh the page.');
                }
            } catch (error) {
                console.error('Error opening skill modal:', error);
                alert('Error opening modal. Please refresh the page.');
            }
        });
        console.log('Add skill button listener attached');
    } else {
        console.error('Add skill button not found');
    }

    // Reorder skills button event
    const reorderSkillsBtn = document.getElementById('reorderSkillsBtn');
    if (reorderSkillsBtn) {
        reorderSkillsBtn.addEventListener('click', function(e) {
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

function loadSkills() {
    console.log('Loading skills...');
    const tbody = document.getElementById('skillsTableBody');
    if (!tbody) {
        console.error('Skills table body not found');
        return;
    }

    // Show loading state
    tbody.innerHTML = `
        <tr>
            <td colspan="5" style="text-align: center; padding: 40px;">
                <i class="fas fa-spinner fa-spin" style="font-size: 2rem; color: var(--primary);"></i>
                <div style="margin-top: 10px; color: var(--text-secondary);">Loading skills...</div>
            </td>
        </tr>
    `;

    // Make AJAX call to get skills
    fetch('/Admin/Dashboard.aspx/GetAllSkillsData', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=utf-8'
        },
        body: JSON.stringify({})
    })
    .then(response => {
        console.log('Skills response received:', response);
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        return response.json();
    })
    .then(data => {
        console.log('Skills data:', data);
        const result = JSON.parse(data.d);
        
        if (result.success) {
            tbody.innerHTML = result.skillsHtml;
            console.log('Skills loaded successfully');
            
            // Attach event listeners for action buttons
            attachSkillActionListeners();
        } else {
            console.error('Error loading skills:', result.message);
            tbody.innerHTML = `
                <tr>
                    <td colspan="5" style="text-align: center; padding: 40px;">
                        <i class="fas fa-exclamation-triangle" style="font-size: 2rem; color: var(--danger); margin-bottom: 10px;"></i>
                        <div style="color: var(--text-secondary);">Error loading skills: ${result.message}</div>
                    </td>
                </tr>
            `;
        }
    })
    .catch(error => {
        console.error('Error loading skills:', error);
        tbody.innerHTML = `
            <tr>
                <td colspan="5" style="text-align: center; padding: 40px;">
                    <i class="fas fa-exclamation-triangle" style="font-size: 2rem; color: var(--danger); margin-bottom: 10px;"></i>
                    <div style="color: var(--text-secondary);">Error loading skills. Please try again.</div>
                </td>
            </tr>
        `;
    });
}

function attachSkillActionListeners() {
    // Edit skill buttons
    document.querySelectorAll('.edit-skill').forEach(button => {
        button.addEventListener('click', function(e) {
            e.preventDefault();
            e.stopPropagation();
            const skillId = this.getAttribute('data-id');
            if (typeof showToast === 'function') {
                showToast('Edit functionality will be implemented later.', 'info');
            } else {
                alert('Edit functionality will be implemented later.');
            }
        });
    });

    // Delete skill buttons are handled by event delegation in dashboard.js
    // No need for explicit listeners here since the dashboard.js handles .delete-skill clicks
    console.log('Skill action listeners attached');
}

// Load skills when the skills page is shown
function showSkillsPage() {
    console.log('Showing skills page');
    loadSkills();
}

// Export function for dashboard navigation
window.showSkillsPage = showSkillsPage;
window.loadSkills = loadSkills;
</script>

<style>
.proficiency-container {
    display: flex;
    flex-direction: column;
    gap: 5px;
}

.proficiency-bar {
    width: 100%;
    height: 8px;
    background-color: var(--bg-secondary);
    border-radius: 4px;
    overflow: hidden;
}

.proficiency-fill {
    height: 100%;
    background: linear-gradient(90deg, var(--success), var(--primary));
    border-radius: 4px;
    transition: width 0.3s ease;
}

.proficiency-text {
    font-size: 0.85rem;
    color: var(--text-secondary);
    text-align: center;
}

.skill-name {
    font-weight: 600;
    color: var(--text-primary);
}

.skill-category {
    font-size: 0.85rem;
    color: var(--text-secondary);
    margin-top: 2px;
}

.table-responsive {
    overflow-x: auto;
}
</style>