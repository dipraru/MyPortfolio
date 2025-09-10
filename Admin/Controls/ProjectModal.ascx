<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProjectModal.ascx.cs" Inherits="MyPortfolio.Admin.Controls.ProjectModal" %>

<!-- Modern Professional Project Modal -->
<div class="modern-modal" id="projectModal">
    <div class="modern-modal-backdrop"></div>
    <div class="modern-modal-container">
        <div class="modern-modal-content">
            <!-- Header -->
            <div class="modern-modal-header">
                <div class="modal-header-content">
                    <div class="modal-icon">
                        <i class="fas fa-project-diagram"></i>
                    </div>
                    <div class="modal-title-section">
                        <h2 class="modal-title" id="projectModalTitle">Add New Project</h2>
                        <p class="modal-subtitle">Showcase your development projects</p>
                    </div>
                </div>
                <button class="modern-modal-close" id="closeProjectModal" type="button" aria-label="Close">
                    <i class="fas fa-times"></i>
                </button>
            </div>

            <!-- Body -->
            <div class="modern-modal-body">
                <form id="projectForm" novalidate>
                    <!-- Alert Section for Validation Messages -->
                    <div class="validation-alert" id="projectValidationAlert" style="display: none;">
                        <div class="alert-icon">
                            <i class="fas fa-exclamation-triangle"></i>
                        </div>
                        <div class="alert-content">
                            <h4>Please complete the required fields:</h4>
                            <ul id="projectValidationList"></ul>
                        </div>
                    </div>

                    <!-- Form Grid -->
                    <div class="modern-form-grid">
                        <!-- Project Title -->
                        <div class="modern-form-group required full-width">
                            <label for="projectTitle" class="modern-label">
                                <i class="fas fa-heading label-icon"></i>
                                Project Title
                            </label>
                            <div class="modern-input-wrapper">
                                <input type="text" id="projectTitle" class="modern-input" placeholder="e.g., E-commerce Platform, Portfolio Website" required maxlength="200">
                                <div class="input-border"></div>
                            </div>
                            <div class="field-error" id="projectTitleError"></div>
                        </div>

                        <!-- Description -->
                        <div class="modern-form-group required full-width">
                            <label for="projectDescription" class="modern-label">
                                <i class="fas fa-align-left label-icon"></i>
                                Description
                            </label>
                            <div class="modern-textarea-wrapper">
                                <textarea id="projectDescription" class="modern-textarea" rows="4" maxlength="2000" placeholder="Describe what this project does, the technologies used, and any notable features..." required></textarea>
                                <div class="textarea-counter">
                                    <span id="projectDescriptionCounter">0</span>/2000
                                </div>
                                <div class="input-border"></div>
                            </div>
                            <div class="field-error" id="projectDescriptionError"></div>
                        </div>

                        <!-- Image URL -->
                        <div class="modern-form-group full-width">
                            <label for="projectImage" class="modern-label">
                                <i class="fas fa-image label-icon"></i>
                                Project Image URL
                            </label>
                            <div class="image-input-group">
                                <div class="modern-input-wrapper">
                                    <input type="url" id="projectImage" class="modern-input" placeholder="https://example.com/project-screenshot.jpg" maxlength="1000">
                                    <div class="input-border"></div>
                                </div>
                                <div class="image-preview" id="projectImagePreview" style="display: none;">
                                    <img id="projectImagePreviewImg" src="" alt="Project preview" />
                                    <div class="preview-overlay">
                                        <i class="fas fa-eye"></i>
                                    </div>
                                </div>
                            </div>
                            <small class="field-help">Direct link to a screenshot or image of your project</small>
                        </div>

                        <!-- Tags -->
                        <div class="modern-form-group">
                            <label for="projectTags" class="modern-label">
                                <i class="fas fa-tags label-icon"></i>
                                Technologies/Tags
                            </label>
                            <div class="modern-input-wrapper">
                                <input type="text" id="projectTags" class="modern-input" placeholder="JavaScript, React, Node.js, MongoDB" maxlength="500">
                                <div class="input-border"></div>
                            </div>
                            <div class="tags-preview" id="projectTagsPreview"></div>
                            <small class="field-help">Comma-separated list of technologies and frameworks used</small>
                        </div>

                        <!-- GitHub URL -->
                        <div class="modern-form-group">
                            <label for="projectGithub" class="modern-label">
                                <i class="fab fa-github label-icon"></i>
                                GitHub Repository
                            </label>
                            <div class="url-input-group">
                                <div class="modern-input-wrapper">
                                    <input type="url" id="projectGithub" class="modern-input" placeholder="https://github.com/username/repository" maxlength="1000">
                                    <div class="input-border"></div>
                                </div>
                                <button type="button" class="url-preview-btn" id="githubPreviewBtn" style="display: none;" title="Open GitHub Repository">
                                    <i class="fab fa-github"></i>
                                </button>
                            </div>
                            <small class="field-help">Link to your project's source code repository</small>
                        </div>

                        <!-- Live Demo URL -->
                        <div class="modern-form-group">
                            <label for="projectLive" class="modern-label">
                                <i class="fas fa-external-link-alt label-icon"></i>
                                Live Demo URL
                            </label>
                            <div class="url-input-group">
                                <div class="modern-input-wrapper">
                                    <input type="url" id="projectLive" class="modern-input" placeholder="https://myproject.netlify.app" maxlength="1000">
                                    <div class="input-border"></div>
                                </div>
                                <button type="button" class="url-preview-btn" id="livePreviewBtn" style="display: none;" title="Open Live Demo">
                                    <i class="fas fa-external-link-alt"></i>
                                </button>
                            </div>
                            <small class="field-help">Link to the live, deployed version of your project</small>
                        </div>
                    </div>
                </form>
            </div>

            <!-- Footer -->
            <div class="modern-modal-footer">
                <div class="footer-actions">
                    <button class="modern-btn-secondary" id="cancelProjectBtn" type="button">
                        <i class="fas fa-times"></i>
                        Cancel
                    </button>
                    <button class="modern-btn-primary" id="saveProjectBtn" type="button">
                        <span class="btn-content">
                            <i class="fas fa-plus btn-icon"></i>
                            <span class="btn-text">Add Project</span>
                        </span>
                        <div class="btn-loading" style="display: none;">
                            <i class="fas fa-spinner fa-spin"></i>
                            <span>Adding...</span>
                        </div>
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
// Ensure the projects modal functions are properly defined
(function() {
    'use strict';
    
    let projectModalInitialized = false;

    function initializeProjectModal() {
        if (projectModalInitialized) return;
        
        console.log('Initializing Projects Modal...');
        
        const modal = document.getElementById('projectModal');
        const form = document.getElementById('projectForm');
        const saveBtn = document.getElementById('saveProjectBtn');
        const cancelBtn = document.getElementById('cancelProjectBtn');
        const closeBtn = document.getElementById('closeProjectModal');

        if (!modal || !form || !saveBtn || !cancelBtn || !closeBtn) {
            console.error('Projects modal elements not found');
            return;
        }

        // Initialize form interactions
        initializeProjectFormInteractions();
        
        // Close modal events with proper event handling
        function handleCloseModal(e) {
            e.preventDefault();
            e.stopPropagation();
            console.log('Closing projects modal via button');
            closeProjectModalHandler();
        }
        
        cancelBtn.removeEventListener('click', handleCloseModal);
        closeBtn.removeEventListener('click', handleCloseModal);
        
        cancelBtn.addEventListener('click', handleCloseModal);
        closeBtn.addEventListener('click', handleCloseModal);

        // Click outside to close
        modal.addEventListener('click', function(e) {
            if (e.target === modal || e.target.classList.contains('modern-modal-backdrop')) {
                console.log('Closing projects modal via backdrop click');
                closeProjectModalHandler();
            }
        });

        // Save button
        saveBtn.addEventListener('click', function(e) {
            e.preventDefault();
            e.stopPropagation();
            console.log('Save project button clicked');
            saveProject();
        });

        // ESC key
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape' && modal && modal.classList.contains('active')) {
                console.log('Closing projects modal via ESC key');
                closeProjectModalHandler();
            }
        });

        projectModalInitialized = true;
        console.log('Projects modal initialized successfully');
    }

    function initializeProjectFormInteractions() {
        // Description counter
        const descriptionTextarea = document.getElementById('projectDescription');
        const descriptionCounter = document.getElementById('projectDescriptionCounter');

        if (descriptionTextarea && descriptionCounter) {
            descriptionTextarea.addEventListener('input', () => {
                const length = descriptionTextarea.value.length;
                descriptionCounter.textContent = length;
                descriptionCounter.style.color = length > 1800 ? '#ef4444' : length > 1600 ? '#f59e0b' : '#6b7280';
            });
        }

        // Image preview
        const imageInput = document.getElementById('projectImage');
        const imagePreview = document.getElementById('projectImagePreview');
        const imagePreviewImg = document.getElementById('projectImagePreviewImg');
        
        if (imageInput && imagePreview && imagePreviewImg) {
            imageInput.addEventListener('input', () => {
                const url = imageInput.value.trim();
                if (url && isValidUrl(url) && isImageUrl(url)) {
                    imagePreviewImg.src = url;
                    imagePreview.style.display = 'block';
                    imagePreviewImg.onload = () => {
                        imagePreview.style.display = 'block';
                    };
                    imagePreviewImg.onerror = () => {
                        imagePreview.style.display = 'none';
                    };
                } else {
                    imagePreview.style.display = 'none';
                }
            });
        }

        // Tags preview
        const tagsInput = document.getElementById('projectTags');
        const tagsPreview = document.getElementById('projectTagsPreview');
        
        if (tagsInput && tagsPreview) {
            tagsInput.addEventListener('input', () => {
                const tags = tagsInput.value.split(',').map(tag => tag.trim()).filter(tag => tag);
                tagsPreview.innerHTML = tags.map(tag => `<span class="tag-preview">${tag}</span>`).join('');
            });
        }

        // URL previews
        const githubInput = document.getElementById('projectGithub');
        const githubPreviewBtn = document.getElementById('githubPreviewBtn');
        
        if (githubInput && githubPreviewBtn) {
            githubInput.addEventListener('input', () => {
                const url = githubInput.value.trim();
                if (url && isValidUrl(url)) {
                    githubPreviewBtn.style.display = 'flex';
                    githubPreviewBtn.onclick = () => window.open(url, '_blank');
                } else {
                    githubPreviewBtn.style.display = 'none';
                }
            });
        }

        const liveInput = document.getElementById('projectLive');
        const livePreviewBtn = document.getElementById('livePreviewBtn');
        
        if (liveInput && livePreviewBtn) {
            liveInput.addEventListener('input', () => {
                const url = liveInput.value.trim();
                if (url && isValidUrl(url)) {
                    livePreviewBtn.style.display = 'flex';
                    livePreviewBtn.onclick = () => window.open(url, '_blank');
                } else {
                    livePreviewBtn.style.display = 'none';
                }
            });
        }

        // Real-time validation
        const form = document.getElementById('projectForm');
        if (form) {
            const requiredFields = form.querySelectorAll('[required]');
            requiredFields.forEach(field => {
                field.addEventListener('blur', () => validateProjectField(field));
                field.addEventListener('input', () => clearProjectFieldError(field));
            });
        }
    }

    function isValidUrl(string) {
        try {
            new URL(string);
            return true;
        } catch (_) {
            return false;
        }
    }

    function isImageUrl(url) {
        return /\.(jpg|jpeg|png|gif|svg|webp)$/i.test(url);
    }

    function validateProjectField(field) {
        const fieldId = field.id;
        const value = field.value.trim();
        const errorElement = document.getElementById(fieldId + 'Error');
        
        let isValid = true;
        let errorMessage = '';

        switch(fieldId) {
            case 'projectTitle':
                if (!value) {
                    errorMessage = 'Project title is required';
                    isValid = false;
                } else if (value.length < 3) {
                    errorMessage = 'Title must be at least 3 characters';
                    isValid = false;
                }
                break;
            case 'projectDescription':
                if (!value) {
                    errorMessage = 'Project description is required';
                    isValid = false;
                } else if (value.length < 10) {
                    errorMessage = 'Description must be at least 10 characters';
                    isValid = false;
                }
                break;
        }

        if (errorElement) {
            errorElement.textContent = errorMessage;
            errorElement.style.display = isValid ? 'none' : 'block';
        }

        field.classList.toggle('error', !isValid);
        return isValid;
    }

    function clearProjectFieldError(field) {
        const errorElement = document.getElementById(field.id + 'Error');
        if (errorElement) {
            errorElement.style.display = 'none';
        }
        field.classList.remove('error');
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
            if (!validateProjectField(field)) {
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

    function openProjectModal(isEdit = false, projectId = null) {
        console.log('Opening modern project modal...', { isEdit, projectId });
        const modal = document.getElementById('projectModal');
        const title = document.getElementById('projectModalTitle');
        const saveBtn = document.getElementById('saveProjectBtn');
        const btnText = saveBtn?.querySelector('.btn-text');
        
        if (!modal) {
            console.error('Project modal not found!');
            return;
        }
        
        // Initialize if not already done
        initializeProjectModal();
        
        // Set current project ID for editing
        window.currentProjectId = projectId;
        
        // Reset form
        resetProjectForm();
        
        if (title) {
            title.textContent = isEdit ? 'Edit Project' : 'Add New Project';
        }
        
        if (btnText) {
            btnText.textContent = isEdit ? 'Update Project' : 'Add Project';
        }
        
        modal.classList.add('active');
        document.body.classList.add('modal-open');
        
        if (isEdit && projectId) {
            // Load project data for editing (this function should exist in dashboard.js)
            if (typeof loadProjectData === 'function') {
                loadProjectData(projectId);
            }
        }
        
        // Focus on first input with delay for animation
        setTimeout(() => {
            const firstInput = document.getElementById('projectTitle');
            if (firstInput) {
                firstInput.focus();
            }
        }, 300);
        
        console.log('Modern project modal opened successfully');
    }

    function closeProjectModalHandler() {
        console.log('Closing modern project modal...');
        const modal = document.getElementById('projectModal');
        if (modal) {
            modal.classList.remove('active');
            document.body.classList.remove('modal-open');
            
            // Clear current project ID
            window.currentProjectId = null;
            
            // Reset form after animation
            setTimeout(() => {
                resetProjectForm();
            }, 300);
            
            console.log('Modern project modal closed successfully');
        }
    }

    function resetProjectForm() {
        const form = document.getElementById('projectForm');
        if (form) {
            form.reset();
        }
        
        // Reset specific elements
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

    function saveProject() {
        console.log('Saving modern project...');
        
        if (!validateProjectForm()) {
            return;
        }

        const saveBtn = document.getElementById('saveProjectBtn');
        const btnContent = saveBtn?.querySelector('.btn-content');
        const btnLoading = saveBtn?.querySelector('.btn-loading');
        
        // Show loading state
        if (saveBtn) saveBtn.disabled = true;
        if (btnContent) btnContent.style.display = 'none';
        if (btnLoading) btnLoading.style.display = 'flex';

        const title = document.getElementById('projectTitle')?.value?.trim() || '';
        const description = document.getElementById('projectDescription')?.value?.trim() || '';
        const imageUrl = document.getElementById('projectImage')?.value?.trim() || '';
        const tags = document.getElementById('projectTags')?.value?.trim() || '';
        const githubUrl = document.getElementById('projectGithub')?.value?.trim() || '';
        const liveUrl = document.getElementById('projectLive')?.value?.trim() || '';

        console.log('Modern project data:', { title, description, imageUrl, tags, githubUrl, liveUrl });

        const currentProjectId = window.currentProjectId;
        
        if (currentProjectId) {
            // Update existing project
            updateProject(currentProjectId, title, description, imageUrl, tags, githubUrl, liveUrl);
        } else {
            // Add new project
            addProject(title, description, imageUrl, tags, githubUrl, liveUrl);
        }
    }

    function addProject(title, description, imageUrl, tags, githubUrl, liveUrl) {
        fetch('/Admin/Dashboard.aspx/AddProject', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=utf-8'
            },
            body: JSON.stringify({
                title: title,
                description: description,
                imageUrl: imageUrl,
                tags: tags,
                githubUrl: githubUrl,
                liveUrl: liveUrl
            })
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        })
        .then(data => {
            const result = JSON.parse(data.d);
            
            if (result.success) {
                if (typeof showToast === 'function') {
                    showToast(result.message, 'success');
                }
                closeProjectModalHandler();
                
                // Reload projects data
                if (typeof loadProjectsFromServer === 'function') {
                    setTimeout(() => {
                        loadProjectsFromServer();
                    }, 1000);
                }
            } else {
                if (typeof showToast === 'function') {
                    showToast(result.message, 'error');
                }
            }
        })
        .catch(error => {
            console.error('Error adding project:', error);
            if (typeof showToast === 'function') {
                showToast('Error adding project. Please try again.', 'error');
            }
        })
        .finally(() => {
            // Reset loading state
            const saveBtn = document.getElementById('saveProjectBtn');
            const btnContent = saveBtn?.querySelector('.btn-content');
            const btnLoading = saveBtn?.querySelector('.btn-loading');
            
            if (saveBtn) saveBtn.disabled = false;
            if (btnContent) btnContent.style.display = 'flex';
            if (btnLoading) btnLoading.style.display = 'none';
        });
    }

    function updateProject(id, title, description, imageUrl, tags, githubUrl, liveUrl) {
        fetch('/Admin/Dashboard.aspx/UpdateProject', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=utf-8'
            },
            body: JSON.stringify({
                id: parseInt(id),
                title: title,
                description: description,
                imageUrl: imageUrl,
                tags: tags,
                githubUrl: githubUrl,
                liveUrl: liveUrl
            })
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        })
        .then(data => {
            const result = JSON.parse(data.d);
            
            if (result.success) {
                if (typeof showToast === 'function') {
                    showToast(result.message, 'success');
                }
                closeProjectModalHandler();
                
                // Reload projects data
                if (typeof loadProjectsFromServer === 'function') {
                    setTimeout(() => {
                        loadProjectsFromServer();
                    }, 1000);
                }
            } else {
                if (typeof showToast === 'function') {
                    showToast(result.message, 'error');
                }
            }
        })
        .catch(error => {
            console.error('Error updating project:', error);
            if (typeof showToast === 'function') {
                showToast('Error updating project. Please try again.', 'error');
            }
        })
        .finally(() => {
            // Reset loading state
            const saveBtn = document.getElementById('saveProjectBtn');
            const btnContent = saveBtn?.querySelector('.btn-content');
            const btnLoading = saveBtn?.querySelector('.btn-loading');
            
            if (saveBtn) saveBtn.disabled = false;
            if (btnContent) btnContent.style.display = 'flex';
            if (btnLoading) btnLoading.style.display = 'none';
        });
    }

    // Initialize when DOM is ready
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initializeProjectModal);
    } else {
        initializeProjectModal();
    }

    // Global functions to open project modal
    window.openProjectModal = openProjectModal;
    window.closeProjectModalHandler = closeProjectModalHandler;
    window.saveProject = saveProject;
    
    console.log('Projects modal script loaded');
})();
</script>

<style>
/* Additional styles specific to Project Modal */
.modern-modal#projectModal .modern-modal-header {
    background: linear-gradient(135deg, #3b82f6 0%, #1d4ed8 50%, #1e40af 100%);
}

/* Image Preview */
.image-input-group {
    display: flex;
    gap: 16px;
    align-items: flex-start;
}

.image-input-group .modern-input-wrapper {
    flex: 1;
}

.image-preview {
    width: 120px;
    height: 80px;
    border: 2px solid var(--border-color);
    border-radius: 12px;
    background: var(--bg-tertiary);
    display: flex;
    align-items: center;
    justify-content: center;
    overflow: hidden;
    flex-shrink: 0;
    position: relative;
}

.image-preview img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    border-radius: 8px;
}

.preview-overlay {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(0, 0, 0, 0.7);
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    opacity: 0;
    transition: opacity 0.3s ease;
}

.image-preview:hover .preview-overlay {
    opacity: 1;
}

/* Tags Preview */
.tags-preview {
    display: flex;
    flex-wrap: wrap;
    gap: 8px;
    margin-top: 8px;
    min-height: 24px;
}

.tag-preview {
    background: rgba(var(--primary-rgb), 0.1);
    color: var(--primary);
    padding: 4px 12px;
    border-radius: 20px;
    font-size: 13px;
    font-weight: 500;
    border: 1px solid rgba(var(--primary-rgb), 0.2);
    animation: tagFadeIn 0.3s ease;
}

@keyframes tagFadeIn {
    from {
        opacity: 0;
        transform: scale(0.8);
    }
    to {
        opacity: 1;
        transform: scale(1);
    }
}

/* URL Preview Buttons */
.url-input-group {
    display: flex;
    gap: 12px;
    align-items: flex-start;
}

.url-input-group .modern-input-wrapper {
    flex: 1;
}

.url-preview-btn {
    width: 52px;
    height: 52px;
    border: 2px solid var(--primary);
    border-radius: 12px;
    background: rgba(var(--primary-rgb), 0.1);
    color: var(--primary);
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 16px;
    transition: all 0.3s ease;
    flex-shrink: 0;
}

.url-preview-btn:hover {
    background: var(--primary);
    color: white;
    transform: scale(1.05);
}

/* GitHub specific styling */
#githubPreviewBtn {
    border-color: #333;
    background: rgba(51, 51, 51, 0.1);
    color: #333;
}

#githubPreviewBtn:hover {
    background: #333;
    color: white;
}

body.light-mode #githubPreviewBtn {
    border-color: #24292e;
    color: #24292e;
}

body.light-mode #githubPreviewBtn:hover {
    background: #24292e;
}

/* Responsive adjustments */
@media (max-width: 768px) {
    .image-input-group {
        flex-direction: column;
    }
    
    .image-preview {
        width: 100%;
        height: 120px;
    }
    
    .url-input-group {
        flex-direction: column;
    }
    
    .url-preview-btn {
        width: 100%;
        height: 48px;
    }
}
</style>