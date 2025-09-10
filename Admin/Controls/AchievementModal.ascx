<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AchievementModal.ascx.cs" Inherits="MyPortfolio.Admin.Controls.AchievementModal" %>

<!-- Modern Professional Achievement Modal -->
<div class="modern-modal" id="achievementModal">
    <div class="modern-modal-backdrop"></div>
    <div class="modern-modal-container">
        <div class="modern-modal-content">
            <!-- Header -->
            <div class="modern-modal-header">
                <div class="modal-header-content">
                    <div class="modal-icon">
                        <i class="fas fa-trophy"></i>
                    </div>
                    <div class="modal-title-section">
                        <h2 class="modal-title" id="achievementModalTitle">Add New Achievement</h2>
                        <p class="modal-subtitle">Showcase your accomplishments and awards</p>
                    </div>
                </div>
                <button class="modern-modal-close" id="closeAchievementModal" type="button" aria-label="Close">
                    <i class="fas fa-times"></i>
                </button>
            </div>

            <!-- Body -->
            <div class="modern-modal-body">
                <form id="achievementForm" novalidate>
                    <!-- Alert Section for Validation Messages -->
                    <div class="validation-alert" id="achievementValidationAlert" style="display: none;">
                        <div class="alert-icon">
                            <i class="fas fa-exclamation-triangle"></i>
                        </div>
                        <div class="alert-content">
                            <h4>Please complete the required fields:</h4>
                            <ul id="achievementValidationList"></ul>
                        </div>
                    </div>

                    <!-- Form Grid -->
                    <div class="modern-form-grid">
                        <!-- Achievement Title -->
                        <div class="modern-form-group required full-width">
                            <label for="achievementTitle" class="modern-label">
                                <i class="fas fa-award label-icon"></i>
                                Achievement Title
                            </label>
                            <div class="modern-input-wrapper">
                                <input type="text" id="achievementTitle" class="modern-input" placeholder="e.g., ICPC Regional Programming Contest" required maxlength="200">
                                <div class="input-border"></div>
                            </div>
                            <div class="field-error" id="achievementTitleError"></div>
                        </div>

                        <!-- Category -->
                        <div class="modern-form-group required">
                            <label for="achievementCategory" class="modern-label">
                                <i class="fas fa-tags label-icon"></i>
                                Category
                            </label>
                            <div class="modern-select-wrapper">
                                <select id="achievementCategory" class="modern-select" required>
                                    <option value="">Choose a category</option>
                                    <option value="Competition">?? Programming Competition</option>
                                    <option value="Award">?? Award & Recognition</option>
                                    <option value="Certification">?? Certification</option>
                                    <option value="Publication">?? Publication</option>
                                    <option value="Hackathon">?? Hackathon</option>
                                    <option value="Scholarship">?? Scholarship</option>
                                    <option value="Other">?? Other</option>
                                </select>
                                <div class="select-arrow">
                                    <i class="fas fa-chevron-down"></i>
                                </div>
                            </div>
                            <div class="field-error" id="achievementCategoryError"></div>
                        </div>

                        <!-- Date Achieved -->
                        <div class="modern-form-group required">
                            <label for="achievementDate" class="modern-label">
                                <i class="fas fa-calendar-check label-icon"></i>
                                Date Achieved
                            </label>
                            <div class="modern-input-wrapper">
                                <input type="date" id="achievementDate" class="modern-input modern-date" required>
                                <div class="input-border"></div>
                            </div>
                            <div class="field-error" id="achievementDateError"></div>
                        </div>

                        <!-- Organization -->
                        <div class="modern-form-group">
                            <label for="achievementOrganization" class="modern-label">
                                <i class="fas fa-building label-icon"></i>
                                Organization/Platform
                            </label>
                            <div class="modern-input-wrapper">
                                <input type="text" id="achievementOrganization" class="modern-input" placeholder="e.g., ICPC, Codeforces, HackerRank" maxlength="200">
                                <div class="input-border"></div>
                            </div>
                            <small class="field-help">The organization or platform that issued this achievement</small>
                        </div>

                        <!-- Position/Rank -->
                        <div class="modern-form-group">
                            <label for="achievementPosition" class="modern-label">
                                <i class="fas fa-medal label-icon"></i>
                                Position/Rank
                            </label>
                            <div class="modern-input-wrapper">
                                <input type="text" id="achievementPosition" class="modern-input" placeholder="e.g., 1st Place, Top 10%, 25th Rank" maxlength="100">
                                <div class="input-border"></div>
                            </div>
                            <small class="field-help">Your position or ranking in this achievement</small>
                        </div>

                        <!-- Description -->
                        <div class="modern-form-group required full-width">
                            <label for="achievementDescription" class="modern-label">
                                <i class="fas fa-align-left label-icon"></i>
                                Description
                            </label>
                            <div class="modern-textarea-wrapper">
                                <textarea id="achievementDescription" class="modern-textarea" rows="4" maxlength="1000" placeholder="Describe the achievement, what you accomplished, the impact it had, and any notable details..." required></textarea>
                                <div class="textarea-counter">
                                    <span id="achievementDescriptionCounter">0</span>/1000
                                </div>
                                <div class="input-border"></div>
                            </div>
                            <div class="field-error" id="achievementDescriptionError"></div>
                        </div>

                        <!-- Certificate URL -->
                        <div class="modern-form-group">
                            <label for="achievementCertificate" class="modern-label">
                                <i class="fas fa-link label-icon"></i>
                                Certificate/Proof URL
                            </label>
                            <div class="url-input-group">
                                <div class="modern-input-wrapper">
                                    <input type="url" id="achievementCertificate" class="modern-input" placeholder="https://example.com/certificate" maxlength="500">
                                    <div class="input-border"></div>
                                </div>
                                <button type="button" class="url-preview-btn" id="certificatePreviewBtn" style="display: none;" title="Preview URL">
                                    <i class="fas fa-external-link-alt"></i>
                                </button>
                            </div>
                            <small class="field-help">Link to your certificate, badge, or proof of achievement</small>
                        </div>

                        <!-- Badge URL -->
                        <div class="modern-form-group">
                            <label for="achievementBadge" class="modern-label">
                                <i class="fas fa-image label-icon"></i>
                                Badge Image URL
                            </label>
                            <div class="url-input-group">
                                <div class="modern-input-wrapper">
                                    <input type="url" id="achievementBadge" class="modern-input" placeholder="https://example.com/badge.png" maxlength="500">
                                    <div class="input-border"></div>
                                </div>
                                <div class="badge-preview" id="badgePreview" style="display: none;">
                                    <img id="badgePreviewImg" src="" alt="Badge preview" />
                                </div>
                            </div>
                            <small class="field-help">Direct link to the achievement badge or logo image</small>
                        </div>

                        <!-- Verification Status -->
                        <div class="modern-form-group">
                            <div class="verification-toggle">
                                <label class="toggle-switch">
                                    <input type="checkbox" id="achievementVerified">
                                    <span class="toggle-slider"></span>
                                </label>
                                <div class="toggle-content">
                                    <span class="toggle-label">Verified Achievement</span>
                                    <small class="toggle-help">Mark this achievement as verified if you have official documentation</small>
                                </div>
                            </div>
                        </div>

                        <!-- Tags/Skills -->
                        <div class="modern-form-group">
                            <label for="achievementTags" class="modern-label">
                                <i class="fas fa-hashtag label-icon"></i>
                                Related Skills/Tags
                            </label>
                            <div class="modern-input-wrapper">
                                <input type="text" id="achievementTags" class="modern-input" placeholder="e.g., C++, Algorithms, Problem Solving" maxlength="300">
                                <div class="input-border"></div>
                            </div>
                            <small class="field-help">Comma-separated skills or technologies related to this achievement</small>
                        </div>
                    </div>
                </form>
            </div>

            <!-- Footer -->
            <div class="modern-modal-footer">
                <div class="footer-actions">
                    <button class="modern-btn-secondary" id="cancelAchievementBtn" type="button">
                        <i class="fas fa-times"></i>
                        Cancel
                    </button>
                    <button class="modern-btn-primary" id="saveAchievementBtn" type="button">
                        <span class="btn-content">
                            <i class="fas fa-plus btn-icon"></i>
                            <span class="btn-text">Add Achievement</span>
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
document.addEventListener('DOMContentLoaded', function() {
    initializeAchievementModal();
});

function initializeAchievementModal() {
    const modal = document.getElementById('achievementModal');
    const form = document.getElementById('achievementForm');
    const saveBtn = document.getElementById('saveAchievementBtn');
    const cancelBtn = document.getElementById('cancelAchievementBtn');
    const closeBtn = document.getElementById('closeAchievementModal');

    // Initialize form interactions
    initializeAchievementFormInteractions();
    
    // Close modal events
    [cancelBtn, closeBtn].forEach(btn => {
        if (btn) {
            btn.addEventListener('click', (e) => {
                e.preventDefault();
                closeAchievementModalHandler();
            });
        }
    });

    // Click outside to close
    if (modal) {
        modal.addEventListener('click', (e) => {
            if (e.target === modal || e.target.classList.contains('modern-modal-backdrop')) {
                closeAchievementModalHandler();
            }
        });
    }

    // Save button
    if (saveBtn) {
        saveBtn.addEventListener('click', (e) => {
            e.preventDefault();
            saveAchievement();
        });
    }

    // ESC key
    document.addEventListener('keydown', (e) => {
        if (e.key === 'Escape' && modal && modal.classList.contains('active')) {
            closeAchievementModalHandler();
        }
    });
}

function initializeAchievementFormInteractions() {
    // Description counter
    const descriptionTextarea = document.getElementById('achievementDescription');
    const descriptionCounter = document.getElementById('achievementDescriptionCounter');

    descriptionTextarea.addEventListener('input', () => {
        const length = descriptionTextarea.value.length;
        descriptionCounter.textContent = length;
        descriptionCounter.style.color = length > 900 ? '#ef4444' : length > 800 ? '#f59e0b' : '#6b7280';
    });

    // URL previews
    const certificateInput = document.getElementById('achievementCertificate');
    const certificatePreviewBtn = document.getElementById('certificatePreviewBtn');
    
    certificateInput.addEventListener('input', () => {
        const url = certificateInput.value.trim();
        if (url && isValidUrl(url)) {
            certificatePreviewBtn.style.display = 'flex';
            certificatePreviewBtn.onclick = () => window.open(url, '_blank');
        } else {
            certificatePreviewBtn.style.display = 'none';
        }
    });

    // Badge image preview
    const badgeInput = document.getElementById('achievementBadge');
    const badgePreview = document.getElementById('badgePreview');
    const badgePreviewImg = document.getElementById('badgePreviewImg');
    
    badgeInput.addEventListener('input', () => {
        const url = badgeInput.value.trim();
        if (url && isValidUrl(url) && isImageUrl(url)) {
            badgePreviewImg.src = url;
            badgePreview.style.display = 'block';
            badgePreviewImg.onload = () => {
                badgePreview.style.display = 'block';
            };
            badgePreviewImg.onerror = () => {
                badgePreview.style.display = 'none';
            };
        } else {
            badgePreview.style.display = 'none';
        }
    });

    // Set max date to today
    const dateInput = document.getElementById('achievementDate');
    const today = new Date().toISOString().split('T')[0];
    dateInput.setAttribute('max', today);

    // Real-time validation
    const form = document.getElementById('achievementForm');
    const requiredFields = form.querySelectorAll('[required]');
    requiredFields.forEach(field => {
        field.addEventListener('blur', () => validateAchievementField(field));
        field.addEventListener('input', () => clearAchievementFieldError(field));
    });
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

function validateAchievementField(field) {
    const fieldId = field.id;
    const value = field.value.trim();
    const errorElement = document.getElementById(fieldId + 'Error');
    
    let isValid = true;
    let errorMessage = '';

    switch(fieldId) {
        case 'achievementTitle':
            if (!value) {
                errorMessage = 'Achievement title is required';
                isValid = false;
            } else if (value.length < 3) {
                errorMessage = 'Title must be at least 3 characters';
                isValid = false;
            }
            break;
        case 'achievementCategory':
            if (!value) {
                errorMessage = 'Please select a category';
                isValid = false;
            }
            break;
        case 'achievementDescription':
            if (!value) {
                errorMessage = 'Description is required';
                isValid = false;
            } else if (value.length < 10) {
                errorMessage = 'Description must be at least 10 characters';
                isValid = false;
            }
            break;
        case 'achievementDate':
            if (!value) {
                errorMessage = 'Date achieved is required';
                isValid = false;
            } else {
                const selectedDate = new Date(value);
                const today = new Date();
                if (selectedDate > today) {
                    errorMessage = 'Date cannot be in the future';
                    isValid = false;
                }
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

function clearAchievementFieldError(field) {
    const errorElement = document.getElementById(field.id + 'Error');
    if (errorElement) {
        errorElement.style.display = 'none';
    }
    field.classList.remove('error');
}

function validateAchievementForm() {
    const form = document.getElementById('achievementForm');
    const requiredFields = form.querySelectorAll('[required]');
    const validationAlert = document.getElementById('achievementValidationAlert');
    const validationList = document.getElementById('achievementValidationList');
    
    let isValid = true;
    const errors = [];

    requiredFields.forEach(field => {
        if (!validateAchievementField(field)) {
            isValid = false;
            const label = form.querySelector(`label[for="${field.id}"]`);
            const fieldName = label ? label.textContent.replace(/[^\w\s]/gi, '').trim() : field.placeholder;
            errors.push(fieldName);
        }
    });

    if (!isValid) {
        validationList.innerHTML = errors.map(error => `<li>${error}</li>`).join('');
        validationAlert.style.display = 'block';
        validationAlert.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
    } else {
        validationAlert.style.display = 'none';
    }

    return isValid;
}

function openAchievementModal() {
    console.log('Opening modern achievement modal...');
    const modal = document.getElementById('achievementModal');
    const title = document.getElementById('achievementModalTitle');
    
    if (!modal) {
        console.error('Achievement modal not found!');
        return;
    }
    
    // Reset form
    resetAchievementForm();
    
    title.textContent = 'Add New Achievement';
    modal.classList.add('active');
    document.body.classList.add('modal-open');
    
    // Focus on first input with delay for animation
    setTimeout(() => {
        const firstInput = document.getElementById('achievementTitle');
        if (firstInput) {
            firstInput.focus();
        }
    }, 300);
    
    console.log('Modern achievement modal opened successfully');
}

function closeAchievementModalHandler() {
    console.log('Closing modern achievement modal...');
    const modal = document.getElementById('achievementModal');
    if (modal) {
        modal.classList.remove('active');
        document.body.classList.remove('modal-open');
        
        // Reset form after animation
        setTimeout(() => {
            resetAchievementForm();
        }, 300);
        
        console.log('Modern achievement modal closed successfully');
    }
}

function resetAchievementForm() {
    const form = document.getElementById('achievementForm');
    if (form) {
        form.reset();
    }
    
    // Reset specific elements
    document.getElementById('achievementDescriptionCounter').textContent = '0';
    document.getElementById('certificatePreviewBtn').style.display = 'none';
    document.getElementById('badgePreview').style.display = 'none';
    
    // Clear validation
    document.getElementById('achievementValidationAlert').style.display = 'none';
    form.querySelectorAll('.error').forEach(el => el.classList.remove('error'));
    form.querySelectorAll('.field-error').forEach(el => el.style.display = 'none');
}

function saveAchievement() {
    console.log('Saving modern achievement...');
    
    if (!validateAchievementForm()) {
        return;
    }

    const saveBtn = document.getElementById('saveAchievementBtn');
    const btnContent = saveBtn.querySelector('.btn-content');
    const btnLoading = saveBtn.querySelector('.btn-loading');
    
    // Show loading state
    saveBtn.disabled = true;
    btnContent.style.display = 'none';
    btnLoading.style.display = 'flex';

    const achievementData = {
        title: document.getElementById('achievementTitle').value.trim(),
        description: document.getElementById('achievementDescription').value.trim(),
        category: document.getElementById('achievementCategory').value,
        organization: document.getElementById('achievementOrganization').value.trim(),
        dateAchieved: document.getElementById('achievementDate').value,
        certificateUrl: document.getElementById('achievementCertificate').value.trim(),
        badgeUrl: document.getElementById('achievementBadge').value.trim()
    };

    console.log('Modern achievement data:', achievementData);

    // Make AJAX call to add achievement
    fetch('/Admin/Dashboard.aspx/AddAchievement', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=utf-8'
        },
        body: JSON.stringify(achievementData)
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
            closeAchievementModalHandler();
            
            // Reload achievements container
            if (typeof loadAchievements === 'function') {
                loadAchievements();
            }
        } else {
            if (typeof showToast === 'function') {
                showToast(result.message, 'error');
            }
        }
    })
    .catch(error => {
        console.error('Error adding achievement:', error);
        if (typeof showToast === 'function') {
            showToast('Error adding achievement. Please try again.', 'error');
        }
    })
    .finally(() => {
        // Reset loading state
        saveBtn.disabled = false;
        btnContent.style.display = 'flex';
        btnLoading.style.display = 'none';
    });
}

// Global function to open achievement modal
window.openAchievementModal = openAchievementModal;
</script>

<style>
/* Additional styles specific to Achievement Modal */
.modern-date {
    cursor: pointer;
}

.modern-date::-webkit-calendar-picker-indicator {
    background: transparent;
    cursor: pointer;
    padding: 4px;
    border-radius: 4px;
    transition: background-color 0.2s ease;
}

.modern-date::-webkit-calendar-picker-indicator:hover {
    background-color: rgba(var(--primary-rgb), 0.1);
}

/* URL Input Group */
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

/* Badge Preview */
.badge-preview {
    width: 52px;
    height: 52px;
    border: 2px solid var(--border-color);
    border-radius: 12px;
    background: var(--bg-tertiary);
    display: flex;
    align-items: center;
    justify-content: center;
    overflow: hidden;
    flex-shrink: 0;
}

.badge-preview img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    border-radius: 8px;
}

/* Verification Toggle */
.verification-toggle {
    display: flex;
    align-items: flex-start;
    gap: 16px;
    padding: 16px;
    background: var(--bg-tertiary);
    border-radius: 12px;
    border: 2px solid var(--border-color);
    transition: all 0.3s ease;
}

.verification-toggle:hover {
    border-color: var(--primary);
    background: rgba(var(--primary-rgb), 0.05);
}

.toggle-switch {
    position: relative;
    display: inline-block;
    width: 52px;
    height: 28px;
    flex-shrink: 0;
}

.toggle-switch input {
    opacity: 0;
    width: 0;
    height: 0;
}

.toggle-slider {
    position: absolute;
    cursor: pointer;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background-color: #ccc;
    transition: 0.4s;
    border-radius: 28px;
}

.toggle-slider:before {
    position: absolute;
    content: "";
    height: 20px;
    width: 20px;
    left: 4px;
    bottom: 4px;
    background-color: white;
    transition: 0.4s;
    border-radius: 50%;
    box-shadow: 0 2px 4px rgba(0,0,0,0.2);
}

input:checked + .toggle-slider {
    background-color: var(--primary);
}

input:checked + .toggle-slider:before {
    transform: translateX(24px);
}

.toggle-content {
    flex: 1;
}

.toggle-label {
    font-weight: 600;
    color: var(--text-primary);
    display: block;
    margin-bottom: 4px;
}

.toggle-help {
    color: var(--text-tertiary);
    font-size: 13px;
    line-height: 1.4;
}

/* Achievement specific header colors */
.modern-modal#achievementModal .modern-modal-header {
    background: linear-gradient(135deg, #f59e0b 0%, #d97706 50%, #92400e 100%);
}

/* Position input special styling */
#achievementPosition {
    font-weight: 600;
    text-align: center;
}

/* Tags input styling */
#achievementTags {
    font-family: 'Courier New', monospace;
    font-size: 14px;
}

/* Responsive adjustments */
@media (max-width: 768px) {
    .url-input-group {
        flex-direction: column;
    }
    
    .url-preview-btn,
    .badge-preview {
        width: 100%;
        height: 48px;
    }
    
    .verification-toggle {
        flex-direction: column;
        gap: 12px;
    }
    
    .toggle-switch {
        align-self: flex-start;
    }
}
</style>