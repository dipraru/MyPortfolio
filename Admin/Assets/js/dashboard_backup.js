// Admin Dashboard JavaScript - Extracted from Dashboard.aspx
// All functionality preserved exactly as it was

// Global variables
let currentProjectId = null;

// Wait for DOM to be fully loaded before attaching event listeners
document.addEventListener('DOMContentLoaded', function() {
    initializeDashboard();
});

function initializeDashboard() {
    // Theme Toggle
    const themeToggle = document.getElementById('themeToggle');
    const themeIcon = document.getElementById('themeIcon');
    const body = document.body;

    // Check for saved theme preference or default to dark mode
    const currentTheme = localStorage.getItem('theme') || 'dark';
    if (currentTheme === 'light') {
        body.classList.add('light-mode');
        themeIcon.classList.remove('fa-moon');
        themeIcon.classList.add('fa-sun');
    }

    themeToggle.addEventListener('click', () => {
        body.classList.toggle('light-mode');

        if (body.classList.contains('light-mode')) {
            themeIcon.classList.remove('fa-moon');
            themeIcon.classList.add('fa-sun');
            localStorage.setItem('theme', 'light');
        } else {
            themeIcon.classList.remove('fa-sun');
            themeIcon.classList.add('fa-moon');
            localStorage.setItem('theme', 'dark');
        }
    });

    // Sidebar Toggle
    const menuToggle = document.getElementById('menuToggle');
    const sidebar = document.getElementById('sidebar');

    menuToggle.addEventListener('click', () => {
        sidebar.classList.toggle('active');
    });

    // Page Navigation
    initializeNavigation();

    // User Dropdown
    initializeUserDropdown();

    // Logout functionality
    initializeLogout();

    // Project functionality
    initializeProjectFunctionality();

    // Skills functionality
    initializeSkillsFunctionality();

    // Achievements functionality
    initializeAchievementsFunctionality();

    // Tab functionality for messages
    initializeTabFunctionality();

    // Load projects data from server
    loadProjectsFromServer();

    // Load skills data from server
    loadSkillsFromServer();

    // Load achievements data from server
    loadAchievementsFromServer();

    // Check if all modal elements exist
    checkModalElements();

    console.log('Dashboard loaded successfully!');
}

// Function to check if all required modal elements exist
function checkModalElements() {
    console.log('?? Checking for modal elements...');
    
    const requiredProjectElements = [
        'projectModal',
        'projectModalTitle',
        'closeProjectModal',
        'cancelProjectBtn',
        'saveProjectBtn',
        'projectTitle',
        'projectDescription',
        'projectImage',
        'projectTags',
        'projectGithub',
        'projectLive'
    ];

    const requiredSkillElements = [
        'skillModal',
        'skillModalTitle',
        'closeSkillModal',
        'cancelSkillBtn',
        'saveSkillBtn',
        'skillName',
        'skillDescription',
        'skillIcon',
        'skillProficiency',
        'skillCategory'
    ];

    const requiredAchievementElements = [
        'achievementModal',
        'achievementModalTitle',
        'closeAchievementModal',
        'cancelAchievementBtn',
        'saveAchievementBtn',
        'achievementName',
        'achievementDescription',
        'achievementIcon',
        'achievementDate'
    ];

    const missingElements = [];
    
    // Check project modal elements
    requiredProjectElements.forEach(elementId => {
        const element = document.getElementById(elementId);
        if (!element) {
            missingElements.push(`Project: ${elementId}`);
        }
    });

    // Check skill modal elements
    requiredSkillElements.forEach(elementId => {
        const element = document.getElementById(elementId);
        if (!element) {
            missingElements.push(`Skill: ${elementId}`);
            console.error(`? Missing skill element: ${elementId}`);
        } else {
            console.log(`? Found skill element: ${elementId}`);
        }
    });

    // Check achievement modal elements
    requiredAchievementElements.forEach(elementId => {
        const element = document.getElementById(elementId);
        if (!element) {
            missingElements.push(`Achievement: ${elementId}`);
            console.error(`? Missing achievement element: ${elementId}`);
        } else {
            console.log(`? Found achievement element: ${elementId}`);
        }
    });

    if (missingElements.length > 0) {
        console.warn('?? Missing modal elements:', missingElements);
    } else {
        console.log('? All modal elements found successfully');
    }
}

// Load projects data from server
function loadProjectsFromServer() {
    // Show loading state first
    showLoadingState();
    
    // Make AJAX call to load projects
    $.ajax({
        type: "POST",
        url: "Dashboard.aspx/GetAllProjectsData",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function(response) {
            try {
                const result = JSON.parse(response.d);
                if (result.success) {
                    // Update projects count
                    updateProjectsCount(result.projectsCount);
                    
                    // Load recent projects data
                    loadRecentProjectsData(result.recentProjectsHtml);
                    
                    // Load all projects data
                    loadAllProjectsData(result.allProjectsHtml);
                } else {
                    showErrorState(result.message);
                }
            } catch (e) {
                showErrorState('Error parsing projects data');
            }
        },
        error: function(xhr, status, error) {
            showErrorState('Error loading projects: ' + error);
        }
    });
}

function showLoadingState() {
    // Show loading in projects table
    const allProjectsTable = document.querySelector('#projects-page .data-table tbody');
    if (allProjectsTable) {
        allProjectsTable.innerHTML = `
            <tr>
                <td colspan="6" style="text-align: center; padding: 40px;">
                    <i class="fas fa-spinner fa-spin" style="font-size: 2rem; color: var(--primary);"></i>
                    <div style="margin-top: 10px;">Loading projects...</div>
                </td>
            </tr>
        `;
    }

    // Show loading in recent projects
    const recentProjectsTable = document.querySelector('#dashboard-page .data-table tbody');
    if (recentProjectsTable) {
        recentProjectsTable.innerHTML = `
            <tr>
                <td colspan="4" style="text-align: center; padding: 40px;">
                    <i class="fas fa-spinner fa-spin" style="font-size: 2rem; color: var(--primary);"></i>
                    <div style="margin-top: 10px;">Loading recent projects...</div>
                </td>
            </tr>
        `;
    }
}

function showErrorState(message) {
    // Show error in projects table
    const allProjectsTable = document.querySelector('#projects-page .data-table tbody');
    if (allProjectsTable) {
        allProjectsTable.innerHTML = `
            <tr>
                <td colspan="6" style="text-align: center; padding: 40px;">
                    <i class="fas fa-exclamation-triangle" style="font-size: 2rem; color: var(--error);"></i>
                    <div style="margin-top: 10px; color: var(--error);">${message}</div>
                    <button class="btn" onclick="loadProjectsFromServer()" style="margin-top: 15px;">
                        <i class="fas fa-refresh"></i> Retry
                    </td>
            </tr>
        `;
    }

    // Show error in recent projects
    const recentProjectsTable = document.querySelector('#dashboard-page .data-table tbody');
    if (recentProjectsTable) {
        recentProjectsTable.innerHTML = `
            <tr>
                <td colspan="4" style="text-align: center; padding: 40px;">
                    <i class="fas fa-exclamation-triangle" style="font-size: 2rem; color: var(--error);"></i>
                    <div style="margin-top: 10px; color: var(--error);">${message}</div>
                </td>
            </tr>
        `;
    }
}

// Load skills data from server
function loadSkillsFromServer() {
    console.log('?? Starting to load skills from server...');
    
    // Show loading state first
    showSkillsLoadingState();
    
    // Make AJAX call to load skills
    $.ajax({
        type: "POST",
        url: "Dashboard.aspx/GetAllSkillsData",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function(response) {
            console.log('? Skills AJAX success response:', response);
            try {
                const result = JSON.parse(response.d);
                console.log('?? Parsed skills result:', result);
                if (result.success) {
                    console.log(`?? Found ${result.skillsCount} skills`);
                    
                    // Update skills count in dashboard stats
                    updateSkillsCount(result.skillsCount);
                    
                    // Load skills data
                    loadSkillsData(result.skillsHtml);
                    console.log('? Skills data loaded successfully');
                } else {
                    console.error('? Skills loading failed:', result.message);
                    showSkillsErrorState(result.message);
                }
            } catch (e) {
                console.error('? Error parsing skills data:', e);
                showSkillsErrorState('Error parsing skills data: ' + e.message);
            }
        },
        error: function(xhr, status, error) {
            console.error('? Skills AJAX error:', {
                status: status,
                error: error,
                responseText: xhr.responseText,
                statusCode: xhr.status
            });
            showSkillsErrorState('Error loading skills: ' + error + ' (Status: ' + xhr.status + ')');
        }
    });
}

function showSkillsLoadingState() {
    // Show loading in skills table
    const skillsTable = document.querySelector('#skills-page .data-table tbody');
    if (skillsTable) {
        skillsTable.innerHTML = `
            <tr>
                <td colspan="5" style="text-align: center; padding: 40px;">
                    <i class="fas fa-spinner fa-spin" style="font-size: 2rem; color: var(--primary);"></i>
                    <div style="margin-top: 10px;">Loading skills...</div>
                </td>
            </tr>
        `;
    }
}

function showSkillsErrorState(message) {
    // Show error in skills table
    const skillsTable = document.querySelector('#skills-page .data-table tbody');
    if (skillsTable) {
        skillsTable.innerHTML = `
            <tr>
                <td colspan="5" style="text-align: center; padding: 40px;">
                    <i class="fas fa-exclamation-triangle" style="font-size: 2rem; color: var(--error);"></i>
                    <div style="margin-top: 10px; color: var(--error);">${message}</div>
                    <button class="btn" onclick="loadSkillsFromServer()" style="margin-top: 15px;">
                        <i class="fas fa-refresh"></i> Retry
                    </td>
            </tr>
        `;
    }
}

function loadSkillsData(html) {
    // Update skills table
    const skillsTable = document.querySelector('#skills-page .data-table tbody');
    if (skillsTable) {
        skillsTable.innerHTML = html;
    }
}

function initializeNavigation() {
    const navLinks = document.querySelectorAll('.nav-link');
    const pages = document.querySelectorAll('.page');

    // Check for saved active page from localStorage
    const savedPage = localStorage.getItem('activeAdminPage') || 'dashboard';
    console.log(`?? Restoring saved page: ${savedPage}`);

    // Set initial active page
    setActivePage(savedPage);

    navLinks.forEach(link => {
        link.addEventListener('click', (e) => {
            e.preventDefault();

            const pageId = link.getAttribute('data-page');
            setActivePage(pageId);
            
            // Save current page to localStorage
            localStorage.setItem('activeAdminPage', pageId);
            console.log(`?? Saved active page: ${pageId}`);

            // Close sidebar on mobile
            if (window.innerWidth <= 992) {
                document.getElementById('sidebar').classList.remove('active');
            }
        });
    });

    // Function to set active page
    function setActivePage(pageId) {
        // Remove active class from all links and pages
        navLinks.forEach(l => l.classList.remove('active'));
        pages.forEach(p => p.style.display = 'none');

        // Find and activate the correct nav link
        const activeLink = document.querySelector(`.nav-link[data-page="${pageId}"]`);
        if (activeLink) {
            activeLink.classList.add('active');
        }

        // Show corresponding page
        const targetPageId = pageId + '-page';
        const targetPage = document.getElementById(targetPageId);
        if (targetPage) {
            targetPage.style.display = 'block';
            console.log(`? Activated page: ${targetPageId}`);
        } else {
            // Fallback to dashboard if page not found
            console.warn(`?? Page not found: ${targetPageId}, falling back to dashboard`);
            const dashboardPage = document.getElementById('dashboard-page');
            const dashboardLink = document.querySelector('.nav-link[data-page="dashboard"]');
            if (dashboardPage && dashboardLink) {
                dashboardPage.style.display = 'block';
                dashboardLink.classList.add('active');
                localStorage.setItem('activeAdminPage', 'dashboard');
            }
        }
    }
}

function initializeUserDropdown() {
    const userBtn = document.getElementById('userBtn');
    const userDropdown = document.getElementById('userDropdown');

    if (userBtn && userDropdown) {
        userBtn.addEventListener('click', () => {
            userDropdown.classList.toggle('active');
        });

        // Close dropdown when clicking outside
        document.addEventListener('click', (e) => {
            if (!userBtn.contains(e.target) && !userDropdown.contains(e.target)) {
                userDropdown.classList.remove('active');
            }
        });
    }
}

function initializeLogout() {
    const logoutBtn = document.getElementById('logoutBtn');
    const logoutDropdown = document.getElementById('logoutDropdown');

    const handleLogout = () => {
        if (confirm('Are you sure you want to logout?')) {
            window.location.href = '../admin_login.aspx?logout=true';
        }
    };

    if (logoutBtn) logoutBtn.addEventListener('click', handleLogout);
    if (logoutDropdown) logoutDropdown.addEventListener('click', handleLogout);
}

function initializeProjectFunctionality() {
    // Project Modal Functions
    const projectModal = document.getElementById('projectModal');
    
    // Get modal elements
    const closeProjectModalBtn = document.getElementById('closeProjectModal');
    const cancelProjectBtn = document.getElementById('cancelProjectBtn');
    const saveProjectBtn = document.getElementById('saveProjectBtn');
    const projectModalTitle = document.getElementById('projectModalTitle');

    // Get add project buttons
    const addProjectBtn = document.getElementById('addProjectBtn');
    const addProjectPageBtn = document.getElementById('addProjectPageBtn');

    // Project modal functions
    function openProjectModal(isEdit = false, projectId = null) {
        console.log('Opening project modal. Edit:', isEdit, 'Project ID:', projectId);
        
        if (!projectModal) {
            console.error('Project modal not found!');
            return;
        }
        
        currentProjectId = projectId;
        projectModal.classList.add('active');
        
        if (projectModalTitle) {
            projectModalTitle.textContent = isEdit ? 'Edit Project' : 'Add New Project';
        }
        
        if (isEdit && projectId) {
            // Load project data from server
            loadProjectData(projectId);
        } else {
            // Reset form for new project
            resetProjectForm();
        }
    }

    function loadProjectData(projectId) {
        console.log('Loading project data for ID:', projectId);
        
        // Show loading state
        showToast('Loading project data...', 'info');
        
        // Make AJAX call to get project data
        $.ajax({
            type: "POST",
            url: "Dashboard.aspx/GetProject",
            data: JSON.stringify({ id: parseInt(projectId) }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(response) {
                console.log('Project data response:', response);
                try {
                    const result = JSON.parse(response.d);
                    if (result.success) {
                        const project = result.project;
                        populateProjectForm(project);
                        console.log('Project form populated successfully');
                    } else {
                        console.error('Failed to get project:', result.message);
                        showToast(result.message, 'error');
                    }
                } catch (e) {
                    console.error('Error parsing project data:', e);
                    showToast('Error parsing project data', 'error');
                }
            },
            error: function(xhr, status, error) {
                console.error('AJAX error loading project:', error, xhr.responseText);
                showToast('Error loading project data: ' + error, 'error');
            }
        });
    }

    function populateProjectForm(project) {
        console.log('Populating form with project:', project);
        
        const projectTitle = document.getElementById('projectTitle');
        const projectDescription = document.getElementById('projectDescription');
        const projectImage = document.getElementById('projectImage');
        const projectTags = document.getElementById('projectTags');
        const projectGithub = document.getElementById('projectGithub');
        const projectLive = document.getElementById('projectLive');

        if (projectTitle) projectTitle.value = project.title || '';
        if (projectDescription) projectDescription.value = project.description || '';
        if (projectImage) projectImage.value = project.imageUrl || '';
        if (projectTags) projectTags.value = project.tags || '';
        if (projectGithub) projectGithub.value = project.githubUrl || '';
        if (projectLive) projectLive.value = project.liveUrl || '';
        
        console.log('Form populated with values');
    }

    function resetProjectForm() {
        const projectTitle = document.getElementById('projectTitle');
        const projectDescription = document.getElementById('projectDescription');
        const projectImage = document.getElementById('projectImage');
        const projectTags = document.getElementById('projectTags');
        const projectGithub = document.getElementById('projectGithub');
        const projectLive = document.getElementById('projectLive');

        if (projectTitle) projectTitle.value = '';
        if (projectDescription) projectDescription.value = '';
        if (projectImage) projectImage.value = '';
        if (projectTags) projectTags.value = '';
        if (projectGithub) projectGithub.value = '';
        if (projectLive) projectLive.value = '';
    }

    function closeProjectModal() {
        if (projectModal) {
            projectModal.classList.remove('active');
            currentProjectId = null;
        }
    }

    function saveProject() {
        const title = document.getElementById('projectTitle')?.value?.trim();
        const description = document.getElementById('projectDescription')?.value?.trim();
        
        if (!title || !description) {
            showToast('Please fill in the required fields (Title and Description)', 'error');
            return;
        }

        const imageUrl = document.getElementById('projectImage')?.value?.trim() || '';
        const tags = document.getElementById('projectTags')?.value?.trim() || '';
        const githubUrl = document.getElementById('projectGithub')?.value?.trim() || '';
        const liveUrl = document.getElementById('projectLive')?.value?.trim() || '';

        // Show saving state
        showToast('Saving project...', 'info');

        if (currentProjectId) {
            // Update existing project
            updateProject(currentProjectId, title, description, imageUrl, tags, githubUrl, liveUrl);
        } else {
            // Add new project
            addProject(title, description, imageUrl, tags, githubUrl, liveUrl);
        }
    }

    function addProject(title, description, imageUrl, tags, githubUrl, liveUrl) {
        $.ajax({
            type: "POST",
            url: "Dashboard.aspx/AddProject",
            data: JSON.stringify({
                title: title,
                description: description,
                imageUrl: imageUrl,
                tags: tags,
                githubUrl: githubUrl,
                liveUrl: liveUrl
            }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(response) {
                try {
                    const result = JSON.parse(response.d);
                    if (result.success) {
                        showToast(result.message, 'success');
                        closeProjectModal();
                        // Reload projects data
                        setTimeout(() => {
                            loadProjectsFromServer();
                        }, 1000);
                    } else {
                        showToast(result.message, 'error');
                    }
                } catch (e) {
                    showToast('Error parsing response', 'error');
                }
            },
            error: function(xhr, status, error) {
                showToast('Error adding project: ' + error, 'error');
            }
        });
    }

    function updateProject(id, title, description, imageUrl, tags, githubUrl, liveUrl) {
        console.log('Updating project ID:', id);
        
        $.ajax({
            type: "POST",
            url: "Dashboard.aspx/UpdateProject",
            data: JSON.stringify({
                id: parseInt(id),
                title: title,
                description: description,
                imageUrl: imageUrl,
                tags: tags,
                githubUrl: githubUrl,
                liveUrl: liveUrl
            }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(response) {
                console.log('Update response:', response);
                try {
                    const result = JSON.parse(response.d);
                    if (result.success) {
                        showToast(result.message, 'success');
                        closeProjectModal();
                        // Reload projects data
                        setTimeout(() => {
                            loadProjectsFromServer();
                        }, 1000);
                    } else {
                        showToast(result.message, 'error');
                    }
                } catch (e) {
                    console.error('Error parsing update response:', e);
                    showToast('Error parsing response', 'error');
                }
            },
            error: function(xhr, status, error) {
                console.error('Error updating project:', error, xhr.responseText);
                showToast('Error updating project: ' + error, 'error');
            }
        });
    }

    function deleteProjectById(projectId) {
        if (confirm('Are you sure you want to delete this project?')) {
            showToast('Deleting project...', 'info');
            
            $.ajax({
                type: "POST",
                url: "Dashboard.aspx/DeleteProject",
                data: JSON.stringify({ id: parseInt(projectId) }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(response) {
                    try {
                        const result = JSON.parse(response.d);
                        if (result.success) {
                            showToast(result.message, 'success');
                            // Reload projects data
                            setTimeout(() => {
                                loadProjectsFromServer();
                            }, 1000);
                        } else {
                            showToast(result.message, 'error');
                        }
                    } catch (e) {
                        showToast('Error parsing response', 'error');
                    }
                },
                error: function(xhr, status, error) {
                    showToast('Error deleting project: ' + error, 'error');
                }
            });
        }
    }

    function reorderProjects() {
        if (confirm('This will reorder all projects to fix display order gaps. Are you sure you want to continue?')) {
            showToast('Reordering projects...', 'info');
            
            $.ajax({
                type: "POST",
                url: "Dashboard.aspx/ReorderProjects",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(response) {
                    try {
                        const result = JSON.parse(response.d);
                        if (result.success) {
                            showToast(result.message, 'success');
                            // Reload projects data to show new order
                            setTimeout(() => {
                                loadProjectsFromServer();
                            }, 1000);
                        } else {
                            showToast(result.message, 'error');
                        }
                    } catch (e) {
                        console.error('Error parsing reorder response:', e);
                        showToast('Error parsing response', 'error');
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Error reordering projects:', error, xhr.responseText);
                    showToast('Error reordering projects: ' + error, 'error');
                }
            });
        }
    }

    // Global functions for onclick events - with better error handling
    window.editProject = function(projectId) {
        console.log('Edit project called with ID:', projectId);
        try {
            // Safely prevent any default behavior
            if (typeof event !== 'undefined' && event) {
                event.preventDefault();
                event.stopPropagation();
            }
            
            if (!projectId) {
                console.error('No project ID provided');
                showToast('Invalid project ID', 'error');
                return false;
            }
            
            openProjectModal(true, projectId);
            return false; // Prevent any form submission or page refresh
        } catch (error) {
            console.error('Error in editProject:', error);
            showToast('Error opening edit modal: ' + error.message, 'error');
            return false;
        }
    };

    window.deleteProject = function(projectId) {
        console.log('Delete project called with ID:', projectId);
        try {
            // Safely prevent any default behavior
            if (typeof event !== 'undefined' && event) {
                event.preventDefault();
                event.stopPropagation();
            }
            
            if (!projectId) {
                console.error('No project ID provided');
                showToast('Invalid project ID', 'error');
                return false;
            }
            
            deleteProjectById(projectId);
            return false; // Prevent any form submission or page refresh
        } catch (error) {
            console.error('Error in deleteProject:', error);
            showToast('Error deleting project: ' + error.message, 'error');
            return false;
        }
    };

    // Event Listeners for modal
    if (addProjectBtn) {
        addProjectBtn.addEventListener('click', (e) => {
            e.preventDefault();
            openProjectModal(false);
        });
    }

    if (addProjectPageBtn) {
        addProjectPageBtn.addEventListener('click', (e) => {
            e.preventDefault();
            openProjectModal(false);
        });
    }

    // Add event listener for reorder button
    const reorderProjectsBtn = document.getElementById('reorderProjectsBtn');
    if (reorderProjectsBtn) {
        reorderProjectsBtn.addEventListener('click', (e) => {
            e.preventDefault();
            reorderProjects();
        });
    }

    if (closeProjectModalBtn) {
        closeProjectModalBtn.addEventListener('click', closeProjectModal);
    }

    if (cancelProjectBtn) {
        cancelProjectBtn.addEventListener('click', closeProjectModal);
    }

    if (saveProjectBtn) {
        saveProjectBtn.addEventListener('click', saveProject);
    }

    // Close modal when clicking outside
    if (projectModal) {
        projectModal.addEventListener('click', (e) => {
            if (e.target === projectModal) {
                closeProjectModal();
            }
        });
    }

    // Alternative event delegation approach for edit/delete buttons
    // This ensures the handlers work even for dynamically generated content
    document.addEventListener('click', function(e) {
        if (e.target.closest('.edit-project')) {
            e.preventDefault();
            e.stopPropagation();
            
            const button = e.target.closest('.edit-project');
            const row = button.closest('tr');
            const projectId = row ? row.getAttribute('data-project-id') : null;
            
            if (projectId) {
                console.log('Edit button clicked via event delegation, Project ID:', projectId);
                openProjectModal(true, projectId);
            } else {
                console.error('Could not find project ID for edit button');
                showToast('Could not find project ID', 'error');
            }
            
            return false;
        }
        
        if (e.target.closest('.action-btn.delete')) {
            e.preventDefault();
            e.stopPropagation();
            
            const button = e.target.closest('.action-btn.delete');
            const row = button.closest('tr');
            const projectId = row ? row.getAttribute('data-project-id') : null;
            
            if (projectId) {
                console.log('Delete button clicked via event delegation, Project ID:', projectId);
                deleteProjectById(projectId);
            } else {
                console.error('Could not find project ID for delete button');
                showToast('Could not find project ID', 'error');
            }
            
            return false;
        }
    });
}

function initializeSkillsFunctionality() {
    console.log('?? Initializing Skills functionality...');
    
    // Skills Modal Functions
    const skillModal = document.getElementById('skillModal');
    console.log('?? Skill modal element:', skillModal);
    
    // Get modal elements
    const closeSkillModalBtn = document.getElementById('closeSkillModal');
    const cancelSkillBtn = document.getElementById('cancelSkillBtn');
    const saveSkillBtn = document.getElementById('saveSkillBtn');
    const skillModalTitle = document.getElementById('skillModalTitle');

    // Get add skill button
    const addSkillBtn = document.getElementById('addSkillBtn');
    console.log('? Add skill button:', addSkillBtn);

    // Get reorder button
    const reorderSkillsBtn = document.getElementById('reorderSkillsBtn');
    console.log('?? Reorder skills button:', reorderSkillsBtn);

    // Proficiency range slider
    const skillProficiency = document.getElementById('skillProficiency');
    const proficiencyValue = document.getElementById('proficiencyValue');

    // Update proficiency display when slider changes
    if (skillProficiency && proficiencyValue) {
        skillProficiency.addEventListener('input', function() {
            proficiencyValue.textContent = this.value;
        });
        console.log('? Proficiency slider initialized');
    } else {
        console.warn('?? Proficiency slider elements not found');
    }

    let currentSkillId = null;

    // Skill modal functions
    function openSkillModal(isEdit = false, skillId = null) {
        console.log('Opening skill modal. Edit:', isEdit, 'Skill ID:', skillId);
        
        if (!skillModal) {
            console.error('Skill modal not found!');
            return;
        }
        
        currentSkillId = skillId;
        skillModal.classList.add('active');
        
        if (skillModalTitle) {
            skillModalTitle.textContent = isEdit ? 'Edit Skill' : 'Add New Skill';
        }
        
        if (isEdit && skillId) {
            // Load skill data from server
            loadSkillData(skillId);
        } else {
            // Reset form for new skill
            resetSkillForm();
        }
    }

    function loadSkillData(skillId) {
        console.log('Loading skill data for ID:', skillId);
        
        // Show loading state
        showToast('Loading skill data...', 'info');
        
        // Make AJAX call to get skill data
        $.ajax({
            type: "POST",
            url: "Dashboard.aspx/GetSkill",
            data: JSON.stringify({ id: parseInt(skillId) }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(response) {
                console.log('Skill data response:', response);
                try {
                    const result = JSON.parse(response.d);
                    if (result.success) {
                        const skill = result.skill;
                        populateSkillForm(skill);
                        console.log('Skill form populated successfully');
                    } else {
                        console.error('Failed to get skill:', result.message);
                        showToast(result.message, 'error');
                    }
                } catch (e) {
                    console.error('Error parsing skill data:', e);
                    showToast('Error parsing skill data', 'error');
                }
            },
            error: function(xhr, status, error) {
                console.error('AJAX error loading skill:', error, xhr.responseText);
                showToast('Error loading skill data: ' + error, 'error');
            }
        });
    }

    function populateSkillForm(skill) {
        console.log('Populating form with skill:', skill);
        
        const skillName = document.getElementById('skillName');
        const skillDescription = document.getElementById('skillDescription');
        const skillIcon = document.getElementById('skillIcon');
        const skillProficiency = document.getElementById('skillProficiency');
        const skillCategory = document.getElementById('skillCategory');
        const proficiencyValue = document.getElementById('proficiencyValue');

        if (skillName) skillName.value = skill.name || '';
        if (skillDescription) skillDescription.value = skill.description || '';
        if (skillIcon) skillIcon.value = skill.iconClass || '';
        if (skillProficiency) {
            skillProficiency.value = skill.proficiencyLevel || 50;
            if (proficiencyValue) proficiencyValue.textContent = skill.proficiencyLevel || 50;
        }
        if (skillCategory) skillCategory.value = skill.category || '';
        
        console.log('Form populated with values');
    }

    function resetSkillForm() {
        const skillName = document.getElementById('skillName');
        const skillDescription = document.getElementById('skillDescription');
        const skillIcon = document.getElementById('skillIcon');
        const skillProficiency = document.getElementById('skillProficiency');
        const skillCategory = document.getElementById('skillCategory');
        const proficiencyValue = document.getElementById('proficiencyValue');

        if (skillName) skillName.value = '';
        if (skillDescription) skillDescription.value = '';
        if (skillIcon) skillIcon.value = '';
        if (skillProficiency) {
            skillProficiency.value = 50;
            if (proficiencyValue) proficiencyValue.textContent = 50;
        }
        if (skillCategory) skillCategory.value = '';
    }

    function closeSkillModal() {
        if (skillModal) {
            skillModal.classList.remove('active');
            currentSkillId = null;
        }
    }

    function saveSkill() {
        const name = document.getElementById('skillName')?.value?.trim();
        const description = document.getElementById('skillDescription')?.value?.trim();
        
        if (!name || !description) {
            showToast('Please fill in the required fields (Name and Description)', 'error');
            return;
        }

        const iconClass = document.getElementById('skillIcon')?.value?.trim() || '';
        const proficiencyLevel = parseInt(document.getElementById('skillProficiency')?.value) || 50;
        const category = document.getElementById('skillCategory')?.value?.trim() || '';

        // Show saving state
        showToast('Saving skill...', 'info');

        if (currentSkillId) {
            // Update existing skill
            updateSkill(currentSkillId, name, description, iconClass, proficiencyLevel, category);
        } else {
            // Add new skill
            addSkill(name, description, iconClass, proficiencyLevel, category);
        }
    }

    function addSkill(name, description, iconClass, proficiencyLevel, category) {
        $.ajax({
            type: "POST",
            url: "Dashboard.aspx/AddSkill",
            data: JSON.stringify({
                name: name,
                description: description,
                iconClass: iconClass,
                proficiencyLevel: proficiencyLevel,
                category: category
            }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(response) {
                try {
                    const result = JSON.parse(response.d);
                    if (result.success) {
                        showToast(result.message, 'success');
                        closeSkillModal();
                        // Reload skills data and update count
                        setTimeout(() => {
                            loadSkillsFromServer();
                        }, 1000);
                    } else {
                        showToast(result.message, 'error');
                    }
                } catch (e) {
                    showToast('Error parsing response', 'error');
                }
            },
            error: function(xhr, status, error) {
                showToast('Error adding skill: ' + error, 'error');
            }
        });
    }

    function updateSkill(id, name, description, iconClass, proficiencyLevel, category) {
        console.log('Updating skill ID:', id);
        
        $.ajax({
            type: "POST",
            url: "Dashboard.aspx/UpdateSkill",
            data: JSON.stringify({
                id: parseInt(id),
                name: name,
                description: description,
                iconClass: iconClass,
                proficiencyLevel: proficiencyLevel,
                category: category
            }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(response) {
                console.log('Update response:', response);
                try {
                    const result = JSON.parse(response.d);
                    if (result.success) {
                        showToast(result.message, 'success');
                        closeSkillModal();
                        // Reload skills data
                        setTimeout(() => {
                            loadSkillsFromServer();
                        }, 1000);
                    } else {
                        showToast(result.message, 'error');
                    }
                } catch (e) {
                    console.error('Error parsing update response:', e);
                    showToast('Error parsing response', 'error');
                }
            },
            error: function(xhr, status, error) {
                console.error('Error updating skill:', error, xhr.responseText);
                showToast('Error updating skill: ' + error, 'error');
            }
        });
    }

    function deleteSkillById(skillId) {
        if (confirm('Are you sure you want to delete this skill?')) {
            showToast('Deleting skill...', 'info');
            
            $.ajax({
                type: "POST",
                url: "Dashboard.aspx/DeleteSkill",
                data: JSON.stringify({ id: parseInt(skillId) }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(response) {
                    try {
                        const result = JSON.parse(response.d);
                        if (result.success) {
                            showToast(result.message, 'success');
                            // Reload skills data and update count
                            setTimeout(() => {
                                loadSkillsFromServer();
                            }, 1000);
                        } else {
                            showToast(result.message, 'error');
                        }
                    } catch (e) {
                        showToast('Error parsing response', 'error');
                    }
                },
                error: function(xhr, status, error) {
                    showToast('Error deleting skill: ' + error, 'error');
                }
            });
        }
    }

    function reorderSkills() {
        if (confirm('This will reorder all skills to fix display order gaps. Are you sure you want to continue?')) {
            showToast('Reordering skills...', 'info');
            
            $.ajax({
                type: "POST",
                url: "Dashboard.aspx/ReorderSkills",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(response) {
                    try {
                        const result = JSON.parse(response.d);
                        if (result.success) {
                            showToast(result.message, 'success');
                            // Reload skills data to show new order
                            setTimeout(() => {
                                loadSkillsFromServer();
                            }, 1000);
                        } else {
                            showToast(result.message, 'error');
                        }
                    } catch (e) {
                        console.error('Error parsing reorder response:', e);
                        showToast('Error parsing response', 'error');
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Error reordering skills:', error, xhr.responseText);
                    showToast('Error reordering skills: ' + error, 'error');
                }
            });
        }
    }

    // Global functions for onclick events - with better error handling
    window.editSkill = function(skillId) {
        console.log('Edit skill called with ID:', skillId);
        try {
            // Safely prevent any default behavior
            if (typeof event !== 'undefined' && event) {
                event.preventDefault();
                event.stopPropagation();
            }
            
            if (!skillId) {
                console.error('No skill ID provided');
                showToast('Invalid skill ID', 'error');
                return false;
            }
            
            openSkillModal(true, skillId);
            return false; // Prevent any form submission or page refresh
        } catch (error) {
            console.error('Error in editSkill:', error);
            showToast('Error opening edit modal: ' + error.message, 'error');
            return false;
        }
    };

    window.deleteSkill = function(skillId) {
        console.log('Delete skill called with ID:', skillId);
        try {
            // Safely prevent any default behavior
            if (typeof event !== 'undefined' && event) {
                event.preventDefault();
                event.stopPropagation();
            }
            
            if (!skillId) {
                console.error('No skill ID provided');
                showToast('Invalid skill ID', 'error');
                return false;
            }
            
            deleteSkillById(skillId);
            return false; // Prevent any form submission or page refresh
        } catch (error) {
            console.error('Error in deleteSkill:', error);
            showToast('Error deleting skill: ' + error.message, 'error');
            return false;
        }
    };

    // Event Listeners for modal
    if (addSkillBtn) {
        addSkillBtn.addEventListener('click', (e) => {
            e.preventDefault();
            openSkillModal(false);
        });
    }

    // Add event listener for reorder button
    const reorderSkillsBtn = document.getElementById('reorderSkillsBtn');
    if (reorderSkillsBtn) {
        reorderSkillsBtn.addEventListener('click', (e) => {
            e.preventDefault();
            reorderSkills();
        });
    }

    if (closeSkillModalBtn) {
        closeSkillModalBtn.addEventListener('click', closeSkillModal);
    }

    if (cancelSkillBtn) {
        cancelSkillBtn.addEventListener('click', closeSkillModal);
    }

    if (saveSkillBtn) {
        saveSkillBtn.addEventListener('click', saveSkill);
    }

    // Close modal when clicking outside
    if (skillModal) {
        skillModal.addEventListener('click', (e) => {
            if (e.target === skillModal) {
                closeSkillModal();
            }
        });
    }

    // Alternative event delegation approach for edit/delete buttons
    // This ensures the handlers work even for dynamically generated content
    document.addEventListener('click', function(e) {
        if (e.target.closest('.edit-skill')) {
            e.preventDefault();
            e.stopPropagation();
            
            const button = e.target.closest('.edit-skill');
            const row = button.closest('tr');
            const skillId = row ? row.getAttribute('data-skill-id') : null;
            
            if (skillId) {
                console.log('Edit button clicked via event delegation, Skill ID:', skillId);
                openSkillModal(true, skillId);
            } else {
                console.error('Could not find skill ID for edit button');
                showToast('Could not find skill ID', 'error');
            }
            
            return false;
        }
        
        if (e.target.closest('.action-btn.delete') && e.target.closest('#skills-page')) {
            e.preventDefault();
            e.stopPropagation();
            
            const button = e.target.closest('.action-btn.delete');
            const row = button.closest('tr');
            const skillId = row ? row.getAttribute('data-skill-id') : null;
            
            if (skillId) {
                console.log('Delete button clicked via event delegation, Skill ID:', skillId);
                deleteSkillById(skillId);
            } else {
                console.error('Could not find skill ID for delete button');
                showToast('Could not find skill ID', 'error');
            }
            
            return false;
        }
    });
}

function initializeAchievementsFunctionality() {
    console.log('?? Initializing Achievements functionality...');
    
    // Achievements Modal Functions
    const achievementModal = document.getElementById('achievementModal');
    console.log('?? Achievement modal element:', achievementModal);
    
    // Get modal elements
    const closeAchievementModalBtn = document.getElementById('closeAchievementModal');
    const cancelAchievementBtn = document.getElementById('cancelAchievementBtn');
    const saveAchievementBtn = document.getElementById('saveAchievementBtn');
    const achievementModalTitle = document.getElementById('achievementModalTitle');

    // Get add achievement button
    const addAchievementBtn = document.getElementById('addAchievementBtn');
    console.log('? Add achievement button:', addAchievementBtn);

    // Get reorder button
    const reorderAchievementsBtn = document.getElementById('reorderAchievementsBtn');
    console.log('?? Reorder achievements button:', reorderAchievementsBtn);

    let currentAchievementId = null;

    // Achievement modal functions
    function openAchievementModal(isEdit = false, achievementId = null) {
        console.log('Opening achievement modal. Edit:', isEdit, 'Achievement ID:', achievementId);
        
        if (!achievementModal) {
            console.error('Achievement modal not found!');
            return;
        }
        
        currentAchievementId = achievementId;
        achievementModal.classList.add('active');
        
        if (achievementModalTitle) {
            achievementModalTitle.textContent = isEdit ? 'Edit Achievement' : 'Add New Achievement';
        }
        
        if (isEdit && achievementId) {
            // Load achievement data from server
            loadAchievementData(achievementId);
        } else {
            // Reset form for new achievement
            resetAchievementForm();
        }
    }

    function loadAchievementData(achievementId) {
        console.log('Loading achievement data for ID:', achievementId);
        
        // Show loading state
        showToast('Loading achievement data...', 'info');
        
        // Make AJAX call to get achievement data
        $.ajax({
            type: "POST",
            url: "Dashboard.aspx/GetAchievement",
            data: JSON.stringify({ id: parseInt(achievementId) }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(response) {
                console.log('Achievement data response:', response);
                try {
                    const result = JSON.parse(response.d);
                    if (result.success) {
                        const achievement = result.achievement;
                        populateAchievementForm(achievement);
                        console.log('Achievement form populated successfully');
                    } else {
                        console.error('Failed to get achievement:', result.message);
                        showToast(result.message, 'error');
                    }
                } catch (e) {
                    console.error('Error parsing achievement data:', e);
                    showToast('Error parsing achievement data', 'error');
                }
            },
            error: function(xhr, status, error) {
                console.error('AJAX error loading achievement:', error, xhr.responseText);
                showToast('Error loading achievement data: ' + error, 'error');
            }
        });
    }

    function populateAchievementForm(achievement) {
        console.log('Populating form with achievement:', achievement);
        
        const achievementTitle = document.getElementById('achievementTitle');
        const achievementDescription = document.getElementById('achievementDescription');
        const achievementPosition = document.getElementById('achievementPosition');
        const achievementDate = document.getElementById('achievementDate');
        const achievementCategory = document.getElementById('achievementCategory');
        const achievementEventUrl = document.getElementById('achievementEventUrl');

        if (achievementTitle) achievementTitle.value = achievement.title || '';
        if (achievementDescription) achievementDescription.value = achievement.description || '';
        if (achievementPosition) achievementPosition.value = achievement.position || '';
        if (achievementDate) achievementDate.value = achievement.achievementDate || '';
        if (achievementCategory) achievementCategory.value = achievement.category || '';
        if (achievementEventUrl) achievementEventUrl.value = achievement.eventUrl || '';
        
        console.log('Form populated with values');
    }

    function resetAchievementForm() {
        const achievementTitle = document.getElementById('achievementTitle');
        const achievementDescription = document.getElementById('achievementDescription');
        const achievementPosition = document.getElementById('achievementPosition');
        const achievementDate = document.getElementById('achievementDate');
        const achievementCategory = document.getElementById('achievementCategory');
        const achievementEventUrl = document.getElementById('achievementEventUrl');

        if (achievementTitle) achievementTitle.value = '';
        if (achievementDescription) achievementDescription.value = '';
        if (achievementPosition) achievementPosition.value = '';
        if (achievementDate) achievementDate.value = '';
        if (achievementCategory) achievementCategory.value = '';
        if (achievementEventUrl) achievementEventUrl.value = '';
    }

    function closeAchievementModal() {
        if (achievementModal) {
            achievementModal.classList.remove('active');
            currentAchievementId = null;
        }
    }

    function saveAchievement() {
        const title = document.getElementById('achievementTitle')?.value?.trim();
        const description = document.getElementById('achievementDescription')?.value?.trim();
        const position = parseInt(document.getElementById('achievementPosition')?.value?.trim());
        const achievementDate = document.getElementById('achievementDate')?.value?.trim();
        
        if (!title || !description || !position || !achievementDate) {
            showToast('Please fill in the required fields (Title, Description, Position, and Date)', 'error');
            return;
        }

        if (position < 1) {
            showToast('Position must be a positive number', 'error');
            return;
        }

        const category = document.getElementById('achievementCategory')?.value?.trim() || '';
        const eventUrl = document.getElementById('achievementEventUrl')?.value?.trim() || '';

        // Show saving state
        showToast('Saving achievement...', 'info');

        if (currentAchievementId) {
            // Update existing achievement
            updateAchievement(currentAchievementId, title, description, position, achievementDate, category, eventUrl);
        } else {
            // Add new achievement
            addAchievement(title, description, position, achievementDate, category, eventUrl);
        }
    }

    function addAchievement(title, description, position, achievementDate, category, eventUrl) {
        $.ajax({
            type: "POST",
            url: "Dashboard.aspx/AddAchievement",
            data: JSON.stringify({
                title: title,
                description: description,
                position: position,
                achievementDate: achievementDate,
                category: category,
                eventUrl: eventUrl
            }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(response) {
                try {
                    const result = JSON.parse(response.d);
                    if (result.success) {
                        showToast(result.message, 'success');
                        closeAchievementModal();
                        // Reload achievements data
                        setTimeout(() => {
                            loadAchievementsFromServer();
                        }, 1000);
                    } else {
                        showToast(result.message, 'error');
                    }
                } catch (e) {
                    showToast('Error parsing response', 'error');
                }
            },
            error: function(xhr, status, error) {
                showToast('Error adding achievement: ' + error, 'error');
            }
        });
    }

    function updateAchievement(id, title, description, position, achievementDate, category, eventUrl) {
        console.log('Updating achievement ID:', id);
        
        $.ajax({
            type: "POST",
            url: "Dashboard.aspx/UpdateAchievement",
            data: JSON.stringify({
                id: parseInt(id),
                title: title,
                description: description,
                position: position,
                achievementDate: achievementDate,
                category: category,
                eventUrl: eventUrl
            }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(response) {
                console.log('Update response:', response);
                try {
                    const result = JSON.parse(response.d);
                    if (result.success) {
                        showToast(result.message, 'success');
                        closeAchievementModal();
                        // Reload achievements data
                        setTimeout(() => {
                            loadAchievementsFromServer();
                        }, 1000);
                    } else {
                        showToast(result.message, 'error');
                    }
                } catch (e) {
                    console.error('Error parsing update response:', e);
                    showToast('Error parsing response', 'error');
                }
            },
            error: function(xhr, status, error) {
                console.error('Error updating achievement:', error, xhr.responseText);
                showToast('Error updating achievement: ' + error, 'error');
            }
        });
    }

    function deleteAchievementById(achievementId) {
        if (confirm('Are you sure you want to delete this achievement?')) {
            showToast('Deleting achievement...', 'info');
            
            $.ajax({
                type: "POST",
                url: "Dashboard.aspx/DeleteAchievement",
                data: JSON.stringify({ id: parseInt(achievementId) }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(response) {
                    try {
                        const result = JSON.parse(response.d);
                        if (result.success) {
                            showToast(result.message, 'success');
                            // Reload achievements data
                            setTimeout(() => {
                                loadAchievementsFromServer();
                            }, 1000);
                        } else {
                            showToast(result.message, 'error');
                        }
                    } catch (e) {
                        showToast('Error parsing response', 'error');
                    }
                },
                error: function(xhr, status, error) {
                    showToast('Error deleting achievement: ' + error, 'error');
                }
            });
        }
    }

    function reorderAchievements() {
        if (confirm('This will reorder all achievements to fix display order gaps. Are you sure you want to continue?')) {
            showToast('Reordering achievements...', 'info');
            
            $.ajax({
                type: "POST",
                url: "Dashboard.aspx/ReorderAchievements",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(response) {
                    try {
                        const result = JSON.parse(response.d);
                        if (result.success) {
                            showToast(result.message, 'success');
                            // Reload achievements data to show new order
                            setTimeout(() => {
                                loadAchievementsFromServer();
                            }, 1000);
                        } else {
                            showToast(result.message, 'error');
                        }
                    } catch (e) {
                        console.error('Error parsing reorder response:', e);
                        showToast('Error parsing response', 'error');
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Error reordering achievements:', error, xhr.responseText);
                    showToast('Error reordering achievements: ' + error, 'error');
                }
            });
        }
    }

    // Global functions for onclick events - with better error handling
    window.editAchievement = function(achievementId) {
        console.log('Edit achievement called with ID:', achievementId);
        try {
            // Safely prevent any default behavior
            if (typeof event !== 'undefined' && event) {
                event.preventDefault();
                event.stopPropagation();
            }
            
            if (!achievementId) {
                console.error('No achievement ID provided');
                showToast('Invalid achievement ID', 'error');
                return false;
            }
            
            openAchievementModal(true, achievementId);
            return false; // Prevent any form submission or page refresh
        } catch (error) {
            console.error('Error in editAchievement:', error);
            showToast('Error opening edit modal: ' + error.message, 'error');
            return false;
        }
    };

    window.deleteAchievement = function(achievementId) {
        console.log('Delete achievement called with ID:', achievementId);
        try {
            // Safely prevent any default behavior
            if (typeof event !== 'undefined' && event) {
                event.preventDefault();
                event.stopPropagation();
            }
            
            if (!achievementId) {
                console.error('No achievement ID provided');
                showToast('Invalid achievement ID', 'error');
                return false;
            }
            
            deleteAchievementById(achievementId);
            return false; // Prevent any form submission or page refresh
        } catch (error) {
            console.error('Error in deleteAchievement:', error);
            showToast('Error deleting achievement: ' + error.message, 'error');
            return false;
        }
    };

    // Event Listeners for modal
    if (addAchievementBtn) {
        addAchievementBtn.addEventListener('click', (e) => {
            e.preventDefault();
            openAchievementModal(false);
        });
    }

    // Add event listener for reorder button
    if (reorderAchievementsBtn) {
        reorderAchievementsBtn.addEventListener('click', (e) => {
            e.preventDefault();
            reorderAchievements();
        });
    }

    if (closeAchievementModalBtn) {
        closeAchievementModalBtn.addEventListener('click', closeAchievementModal);
    }

    if (cancelAchievementBtn) {
        cancelAchievementBtn.addEventListener('click', closeAchievementModal);
    }

    if (saveAchievementBtn) {
        saveAchievementBtn.addEventListener('click', saveAchievement);
    }

    // Close modal when clicking outside
    if (achievementModal) {
        achievementModal.addEventListener('click', (e) => {
            if (e.target === achievementModal) {
                closeAchievementModal();
            }
        });
    }

    // Alternative event delegation approach for edit/delete buttons
    // This ensures the handlers work even for dynamically generated content
    document.addEventListener('click', function(e) {
        if (e.target.closest('.edit-achievement')) {
            e.preventDefault();
            e.stopPropagation();
            
            const button = e.target.closest('.edit-achievement');
            const card = button.closest('.achievement-card');
            const achievementId = card ? card.getAttribute('data-achievement-id') : null;
            
            if (achievementId) {
                console.log('Edit button clicked via event delegation, Achievement ID:', achievementId);
                openAchievementModal(true, achievementId);
            } else {
                console.error('Could not find achievement ID for edit button');
                showToast('Could not find achievement ID', 'error');
            }
            
            return false;
        }
        
        if (e.target.closest('.action-btn.delete') && e.target.closest('#achievements-page')) {
            e.preventDefault();
            e.stopPropagation();
            
            const button = e.target.closest('.action-btn.delete');
            const card = button.closest('.achievement-card');
            const achievementId = card ? card.getAttribute('data-achievement-id') : null;
            
            if (achievementId) {
                console.log('Delete button clicked via event delegation, Achievement ID:', achievementId);
                deleteAchievementById(achievementId);
            } else {
                console.error('Could not find achievement ID for delete button');
                showToast('Could not find achievement ID', 'error');
            }
            
            return false;
        }
    });
}

function initializeTabFunctionality() {
    // Tab functionality for messages section
    document.addEventListener('click', function(e) {
        if (e.target.classList.contains('tab')) {
            e.preventDefault();
            
            // Remove active class from all tabs and tab contents
            document.querySelectorAll('.tab').forEach(tab => tab.classList.remove('active'));
            document.querySelectorAll('.tab-content').forEach(content => content.classList.remove('active'));
            
            // Add active class to clicked tab
            e.target.classList.add('active');
            
            // Show corresponding tab content
            const tabId = e.target.getAttribute('data-tab') + '-tab';
            const targetContent = document.getElementById(tabId);
            if (targetContent) {
                targetContent.classList.add('active');
            }
        }
    });
}

// Helper functions for updating data
function updateProjectsCount(count) {
    // Update the projects count in dashboard stats
    const projectsCountElement = document.querySelector('.stat-card .stat-value');
    if (projectsCountElement) {
        projectsCountElement.textContent = count;
    }
}

function updateSkillsCount(count) {
    // Update the skills count in dashboard stats (second stat card)
    const statCards = document.querySelectorAll('.stat-card');
    if (statCards.length >= 2) {
        const skillsCountElement = statCards[1].querySelector('.stat-value');
        if (skillsCountElement) {
            skillsCountElement.textContent = count;
            console.log(`?? Updated skills count to: ${count}`);
        }
    }
}

function updateAchievementsCount(count) {
    // Update the achievements count in dashboard stats (third stat card)
    const statCards = document.querySelectorAll('.stat-card');
    if (statCards.length >= 3) {
        const achievementsCountElement = statCards[2].querySelector('.stat-value');
        if (achievementsCountElement) {
            achievementsCountElement.textContent = count;
            console.log(`?? Updated achievements count to: ${count}`);
        }
    }
}

function loadRecentProjectsData(html) {
    // Update recent projects table in dashboard
    const recentProjectsTable = document.querySelector('#dashboard-page .data-table tbody');
    if (recentProjectsTable) {
        recentProjectsTable.innerHTML = html;
    }
}

function loadAllProjectsData(html) {
    // Update all projects table in projects page
    const allProjectsTable = document.querySelector('#projects-page .data-table tbody');
    if (allProjectsTable) {
        allProjectsTable.innerHTML = html;
    }
}

function showToast(message, type = 'success') {
    const toast = document.getElementById('toast');
    if (!toast) {
        console.warn('Toast element not found');
        return;
    }

    console.log(`Showing toast: ${type} - ${message}`);

    const icon = toast.querySelector('.toast-icon i');
    const title = toast.querySelector('.toast-title');
    const description = toast.querySelector('.toast-description');
    
    // Clear any existing timeout
    if (toast.hideTimeout) {
        clearTimeout(toast.hideTimeout);
    }

    // Reset classes first
    toast.className = 'toast';
    
    // Update content
    if (title) {
        switch(type) {
            case 'success':
                title.textContent = 'Success';
                break;
            case 'error':
                title.textContent = 'Error';
                break;
            case 'info':
                title.textContent = 'Info';
                break;
            default:
                title.textContent = 'Notification';
        }
    }
    if (description) description.textContent = message;
    
    // Update icon and add proper classes
    if (icon) {
        switch(type) {
            case 'success':
                icon.className = 'fas fa-check-circle';
                toast.className = `toast ${type} show`;
                break;
            case 'error':
                icon.className = 'fas fa-exclamation-circle';
                toast.className = `toast ${type} show`;
                break;
            case 'info':
                icon.className = 'fas fa-info-circle';
                toast.className = `toast ${type} show`;
                break;
            default:
                icon.className = 'fas fa-check-circle';
                toast.className = `toast success show`;
        }
    } else {
        // Fallback if icon not found
        toast.className = `toast ${type} show`;
    }
    
    // Set auto-hide timeout based on type
    const hideDelay = type === 'info' ? 2000 : (type === 'error' ? 5000 : 3000);
    toast.hideTimeout = setTimeout(() => {
        hideToast();
    }, hideDelay);
    
    console.log(`Toast shown with classes: ${toast.className}`);
}

// New function to properly hide toast
function hideToast() {
    const toast = document.getElementById('toast');
    if (!toast) return;
    
    console.log('Hiding toast');
    
    // Remove show class and clear timeout
    toast.classList.remove('show');
    
    if (toast.hideTimeout) {
        clearTimeout(toast.hideTimeout);
        toast.hideTimeout = null;
    }
    
    console.log(`Toast hidden, classes: ${toast.className}`);
}

// Close toast functionality
document.addEventListener('click', function(e) {
    if (e.target.classList.contains('toast-close') || e.target.closest('.toast-close')) {
        console.log('Toast close button clicked');
        e.preventDefault();
        e.stopPropagation();
        hideToast();
    }
});

// Also add keyboard support for closing toast (ESC key)
document.addEventListener('keydown', function(e) {
    if (e.key === 'Escape') {
        const toast = document.getElementById('toast');
        if (toast && toast.classList.contains('show')) {
            console.log('Toast closed with ESC key');
            hideToast();
        }
    }
});