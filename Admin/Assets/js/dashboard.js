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

    // Tab functionality for messages
    initializeTabFunctionality();

    // Load projects data from server
    loadProjectsFromServer();

    // Check if all modal elements exist
    checkModalElements();

    console.log('Dashboard loaded successfully!');
}

// Function to check if all required modal elements exist
function checkModalElements() {
    const requiredElements = [
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

    const missingElements = [];
    
    requiredElements.forEach(elementId => {
        const element = document.getElementById(elementId);
        if (!element) {
            missingElements.push(elementId);
        }
    });

    if (missingElements.length > 0) {
        console.warn('Missing modal elements:', missingElements);
    } else {
        console.log('All modal elements found successfully');
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
                    </button>
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

function initializeNavigation() {
    const navLinks = document.querySelectorAll('.nav-link');
    const pages = document.querySelectorAll('.page');

    navLinks.forEach(link => {
        link.addEventListener('click', (e) => {
            e.preventDefault();

            // Remove active class from all links and pages
            navLinks.forEach(l => l.classList.remove('active'));
            pages.forEach(p => p.style.display = 'none');

            // Add active class to clicked link
            link.classList.add('active');

            // Show corresponding page
            const pageId = link.getAttribute('data-page') + '-page';
            const targetPage = document.getElementById(pageId);
            if (targetPage) {
                targetPage.style.display = 'block';
                
                // Load data for specific pages
                const pageName = link.getAttribute('data-page');
                switch(pageName) {
                    case 'skills':
                        if (typeof showSkillsPage === 'function') {
                            showSkillsPage();
                        }
                        break;
                    case 'achievements':
                        if (typeof showAchievementsPage === 'function') {
                            showAchievementsPage();
                        }
                        break;
                }
            }

            // Close sidebar on mobile
            if (window.innerWidth <= 992) {
                document.getElementById('sidebar').classList.remove('active');
            }
        });
    });
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
    
    // Get modal elements - update for modern modal structure
    const closeProjectModalBtn = document.getElementById('closeProjectModal');
    const cancelProjectBtn = document.getElementById('cancelProjectBtn');
    const saveProjectBtn = document.getElementById('saveProjectBtn');
    const projectModalTitle = document.getElementById('projectModalTitle');

    // Get add project buttons
    const addProjectBtn = document.getElementById('addProjectBtn');
    const addProjectPageBtn = document.getElementById('addProjectPageBtn');

    // Flag to prevent duplicate submissions
    let isSubmitting = false;

    // Project modal functions
    function openProjectModal(isEdit = false, projectId = null) {
        console.log('Opening modern project modal. Edit:', isEdit, 'Project ID:', projectId);
        
        if (!projectModal) {
            console.error('Project modal not found!');
            return;
        }
        
        currentProjectId = projectId;
        isSubmitting = false; // Reset submission flag
        
        // Use modern modal classes
        projectModal.classList.add('active');
        document.body.classList.add('modal-open');
        
        // Update title and button text
        if (projectModalTitle) {
            projectModalTitle.textContent = isEdit ? 'Edit Project' : 'Add New Project';
        }
        
        const saveBtn = document.getElementById('saveProjectBtn');
        const btnText = saveBtn?.querySelector('.btn-text');
        if (btnText) {
            btnText.textContent = isEdit ? 'Update Project' : 'Add Project';
        }
        
        if (isEdit && projectId) {
            // Load project data from server
            loadProjectData(projectId);
        } else {
            // Reset form for new project
            resetProjectForm();
        }
        
        // Focus on first input with delay for animation
        setTimeout(() => {
            const firstInput = document.getElementById('projectTitle');
            if (firstInput) {
                firstInput.focus();
            }
        }, 300);
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
        
        // Update character counter for description
        const descriptionCounter = document.getElementById('projectDescriptionCounter');
        if (descriptionCounter && projectDescription) {
            descriptionCounter.textContent = projectDescription.value.length;
        }
        
        // Trigger input events to update previews
        if (projectImage) projectImage.dispatchEvent(new Event('input'));
        if (projectTags) projectTags.dispatchEvent(new Event('input'));
        if (projectGithub) projectGithub.dispatchEvent(new Event('input'));
        if (projectLive) projectLive.dispatchEvent(new Event('input'));
        
        console.log('Form populated with values');
    }

    function resetProjectForm() {
        const form = document.getElementById('projectForm');
        if (form) {
            form.reset();
        }
        
        // Reset specific elements for modern modal
        const descriptionCounter = document.getElementById('projectDescriptionCounter');
        if (descriptionCounter) descriptionCounter.textContent = '0';
        
        const imagePreview = document.getElementById('projectImagePreview');
        if (imagePreview) imagePreview.style.display = 'none';
        
        const tagsPreview = document.getElementById('projectTagsPreview');
        if (tagsPreview) tagsPreview.innerHTML = '';
        
        const githubPreviewBtn = document.getElementById('githubPreviewBtn');
        if (githubPreviewBtn) githubPreviewBtn.style.display = 'none';
        
        const livePreviewBtn = document.getElementById('livePreviewBtn');
        if (livePreviewBtn) livePreviewBtn.style.display = 'none';
        
        // Clear validation
        const validationAlert = document.getElementById('projectValidationAlert');
        if (validationAlert) validationAlert.style.display = 'none';
        
        if (form) {
            form.querySelectorAll('.error').forEach(el => el.classList.remove('error'));
            form.querySelectorAll('.field-error').forEach(el => el.style.display = 'none');
        }
    }

    function closeProjectModal() {
        console.log('Closing modern project modal...');
        if (projectModal) {
            projectModal.classList.remove('active');
            document.body.classList.remove('modal-open');
            currentProjectId = null;
            isSubmitting = false; // Reset submission flag
            
            // Reset form after animation
            setTimeout(() => {
                resetProjectForm();
            }, 300);
        }
    }

    function saveProject() {
        console.log('Saving modern project...');
        
        // Prevent duplicate submissions
        if (isSubmitting) {
            console.log('Already submitting, ignoring duplicate save request');
            return;
        }
        
        const title = document.getElementById('projectTitle')?.value?.trim();
        const description = document.getElementById('projectDescription')?.value?.trim();
        
        // Use modern validation system
        if (!validateProjectForm()) {
            return;
        }

        // Set submission flag to prevent duplicates
        isSubmitting = true;

        const saveBtn = document.getElementById('saveProjectBtn');
        const btnContent = saveBtn?.querySelector('.btn-content');
        const btnLoading = saveBtn?.querySelector('.btn-loading');
        
        // Show loading state for modern button
        if (saveBtn) saveBtn.disabled = true;
        if (btnContent) btnContent.style.display = 'none';
        if (btnLoading) btnLoading.style.display = 'flex';

        const imageUrl = document.getElementById('projectImage')?.value?.trim() || '';
        const tags = document.getElementById('projectTags')?.value?.trim() || '';
        const githubUrl = document.getElementById('projectGithub')?.value?.trim() || '';
        const liveUrl = document.getElementById('projectLive')?.value?.trim() || '';

        if (currentProjectId) {
            // Update existing project
            updateProject(currentProjectId, title, description, imageUrl, tags, githubUrl, liveUrl);
        } else {
            // Add new project
            addProject(title, description, imageUrl, tags, githubUrl, liveUrl);
        }
    }

    function validateProjectForm() {
        const form = document.getElementById('projectForm');
        if (!form) return false;
        
        const requiredFields = form.querySelectorAll('[required]');
        const validationAlert = document.getElementById('projectValidationAlert');
        const validationList = document.getElementById('projectValidationList');
        
        let isValid = true;
        const errors = [];

        requiredFields.forEach(field => {
            const fieldId = field.id;
            const value = field.value.trim();
            const errorElement = document.getElementById(fieldId + 'Error');
            
            let fieldValid = true;
            let errorMessage = '';

            switch(fieldId) {
                case 'projectTitle':
                    if (!value) {
                        errorMessage = 'Project title is required';
                        fieldValid = false;
                    } else if (value.length < 3) {
                        errorMessage = 'Title must be at least 3 characters';
                        fieldValid = false;
                    }
                    break;
                case 'projectDescription':
                    if (!value) {
                        errorMessage = 'Project description is required';
                        fieldValid = false;
                    } else if (value.length < 10) {
                        errorMessage = 'Description must be at least 10 characters';
                        fieldValid = false;
                    }
                    break;
            }

            if (errorElement) {
                errorElement.textContent = errorMessage;
                errorElement.style.display = fieldValid ? 'none' : 'block';
            }

            field.classList.toggle('error', !fieldValid);
            
            if (!fieldValid) {
                isValid = false;
                const label = form.querySelector(`label[for="${field.id}"]`);
                const fieldName = label ? label.textContent.replace(/[^\w\s]/gi, '').trim() : field.placeholder;
                errors.push(fieldName);
            }
        });

        if (!isValid && validationAlert && validationList) {
            validationList.innerHTML = errors.map(error => `<li>${error}</li>`).join('');
            validationAlert.style.display = 'block';
            validationAlert.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
        } else if (validationAlert) {
            validationAlert.style.display = 'none';
        }

        return isValid;
    }

    function resetButtonLoadingState() {
        const saveBtn = document.getElementById('saveProjectBtn');
        const btnContent = saveBtn?.querySelector('.btn-content');
        const btnLoading = saveBtn?.querySelector('.btn-loading');
        
        if (saveBtn) saveBtn.disabled = false;
        if (btnContent) btnContent.style.display = 'flex';
        if (btnLoading) btnLoading.style.display = 'none';
        
        // Reset submission flag
        isSubmitting = false;
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
            },
            complete: function() {
                resetButtonLoadingState();
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
            },
            complete: function() {
                resetButtonLoadingState();
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

    // Global functions for the modal scripts to access
    window.loadProjectData = loadProjectData;
    window.closeProjectModalHandler = closeProjectModal;

    // Event Listeners for modal - use modern event handling with duplicate prevention
    if (addProjectBtn) {
        addProjectBtn.removeEventListener('click', handleAddProject); // Remove existing if any
        addProjectBtn.addEventListener('click', handleAddProject);
    }

    if (addProjectPageBtn) {
        addProjectPageBtn.removeEventListener('click', handleAddProject); // Remove existing if any
        addProjectPageBtn.addEventListener('click', handleAddProject);
    }

    function handleAddProject(e) {
        e.preventDefault();
        e.stopPropagation();
        openProjectModal(false);
    }

    // Add event listener for reorder button
    const reorderProjectsBtn = document.getElementById('reorderProjectsBtn');
    if (reorderProjectsBtn) {
        reorderProjectsBtn.removeEventListener('click', handleReorderProjects); // Remove existing if any
        reorderProjectsBtn.addEventListener('click', handleReorderProjects);
    }

    function handleReorderProjects(e) {
        e.preventDefault();
        e.stopPropagation();
        reorderProjects();
    }

    // Modern modal event handling with duplicate prevention
    if (closeProjectModalBtn) {
        closeProjectModalBtn.removeEventListener('click', handleCloseModal); // Remove existing if any
        closeProjectModalBtn.addEventListener('click', handleCloseModal);
    }

    if (cancelProjectBtn) {
        cancelProjectBtn.removeEventListener('click', handleCloseModal); // Remove existing if any
        cancelProjectBtn.addEventListener('click', handleCloseModal);
    }

    function handleCloseModal(e) {
        e.preventDefault();
        e.stopPropagation();
        closeProjectModal();
    }

    if (saveProjectBtn) {
        saveProjectBtn.removeEventListener('click', handleSaveProject); // Remove existing if any
        saveProjectBtn.addEventListener('click', handleSaveProject);
    }

    function handleSaveProject(e) {
        e.preventDefault();
        e.stopPropagation();
        saveProject();
    }

    // Close modal when clicking outside or on backdrop
    if (projectModal) {
        projectModal.removeEventListener('click', handleModalBackdropClick); // Remove existing if any
        projectModal.addEventListener('click', handleModalBackdropClick);
    }

    function handleModalBackdropClick(e) {
        if (e.target === projectModal || e.target.classList.contains('modern-modal-backdrop')) {
            closeProjectModal();
        }
    }

    // ESC key support
    document.removeEventListener('keydown', handleEscapeKey); // Remove existing if any
    document.addEventListener('keydown', handleEscapeKey);

    function handleEscapeKey(e) {
        if (e.key === 'Escape' && projectModal && projectModal.classList.contains('active')) {
            closeProjectModal();
        }
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