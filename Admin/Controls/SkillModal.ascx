<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SkillModal.ascx.cs" Inherits="MyPortfolio.Admin.Controls.SkillModal" %>

<!-- Modern Professional Skill Modal -->
<div class="modern-modal" id="skillModal">
    <div class="modern-modal-backdrop"></div>
    <div class="modern-modal-container">
        <div class="modern-modal-content">
            <!-- Header -->
            <div class="modern-modal-header">
                <div class="modal-header-content">
                    <div class="modal-icon">
                        <i class="fas fa-code"></i>
                    </div>
                    <div class="modal-title-section">
                        <h2 class="modal-title" id="skillModalTitle">Add New Skill</h2>
                        <p class="modal-subtitle">Showcase your technical expertise</p>
                    </div>
                </div>
                <button class="modern-modal-close" id="closeSkillModal" type="button" aria-label="Close">
                    <i class="fas fa-times"></i>
                </button>
            </div>

            <!-- Body -->
            <div class="modern-modal-body">
                <form id="skillForm" novalidate>
                    <!-- Alert Section for Validation Messages -->
                    <div class="validation-alert" id="skillValidationAlert" style="display: none;">
                        <div class="alert-icon">
                            <i class="fas fa-exclamation-triangle"></i>
                        </div>
                        <div class="alert-content">
                            <h4>Please complete the required fields:</h4>
                            <ul id="skillValidationList"></ul>
                        </div>
                    </div>

                    <!-- Form Grid -->
                    <div class="modern-form-grid">
                        <!-- Skill Name -->
                        <div class="modern-form-group required">
                            <label for="skillName" class="modern-label">
                                <i class="fas fa-tag label-icon"></i>
                                Skill Name
                            </label>
                            <div class="modern-input-wrapper">
                                <input type="text" id="skillName" class="modern-input" placeholder="e.g., React, Python, Node.js" required maxlength="100">
                                <div class="input-border"></div>
                            </div>
                            <div class="field-error" id="skillNameError"></div>
                        </div>

                        <!-- Category -->
                        <div class="modern-form-group required">
                            <label for="skillCategory" class="modern-label">
                                <i class="fas fa-layer-group label-icon"></i>
                                Category
                            </label>
                            <div class="modern-select-wrapper">
                                <select id="skillCategory" class="modern-select" required>
                                    <option value="">Choose a category</option>
                                    <option value="Programming">?? Programming Language</option>
                                    <option value="Framework">? Framework & Library</option>
                                    <option value="Database">??? Database</option>
                                    <option value="Tool">??? Development Tool</option>
                                    <option value="Cloud">?? Cloud Platform</option>
                                    <option value="DevOps">?? DevOps</option>
                                    <option value="Design">?? Design</option>
                                    <option value="Other">?? Other</option>
                                </select>
                                <div class="select-arrow">
                                    <i class="fas fa-chevron-down"></i>
                                </div>
                            </div>
                            <div class="field-error" id="skillCategoryError"></div>
                        </div>

                        <!-- Proficiency -->
                        <div class="modern-form-group required">
                            <label for="skillProficiency" class="modern-label">
                                <i class="fas fa-chart-line label-icon"></i>
                                Proficiency Level
                            </label>
                            <div class="proficiency-input-group">
                                <div class="modern-input-wrapper">
                                    <input type="range" id="skillProficiencyRange" class="modern-range" min="0" max="100" value="50">
                                    <input type="number" id="skillProficiency" class="modern-input proficiency-number" min="0" max="100" placeholder="0" required>
                                    <span class="input-suffix">%</span>
                                    <div class="input-border"></div>
                                </div>
                                <div class="proficiency-display">
                                    <div class="proficiency-bar">
                                        <div class="proficiency-fill" id="skillProficiencyFill"></div>
                                    </div>
                                    <span class="proficiency-text" id="skillProficiencyText">Beginner</span>
                                </div>
                            </div>
                            <div class="field-error" id="skillProficiencyError"></div>
                        </div>

                        <!-- Years of Experience -->
                        <div class="modern-form-group">
                            <label for="skillExperience" class="modern-label">
                                <i class="fas fa-calendar-alt label-icon"></i>
                                Years of Experience
                            </label>
                            <div class="modern-input-wrapper">
                                <input type="number" id="skillExperience" class="modern-input" min="0" step="0.5" max="50" placeholder="2.5">
                                <span class="input-suffix">years</span>
                                <div class="input-border"></div>
                            </div>
                            <small class="field-help">How long have you been working with this skill?</small>
                        </div>

                        <!-- Description -->
                        <div class="modern-form-group full-width">
                            <label for="skillDescription" class="modern-label">
                                <i class="fas fa-align-left label-icon"></i>
                                Description
                            </label>
                            <div class="modern-textarea-wrapper">
                                <textarea id="skillDescription" class="modern-textarea" rows="3" maxlength="500" placeholder="Describe your experience and projects with this skill..."></textarea>
                                <div class="textarea-counter">
                                    <span id="skillDescriptionCounter">0</span>/500
                                </div>
                                <div class="input-border"></div>
                            </div>
                        </div>

                        <!-- Icon Configuration -->
                        <div class="modern-form-group">
                            <label for="skillIcon" class="modern-label">
                                <i class="fas fa-icons label-icon"></i>
                                Icon (Font Awesome)
                            </label>
                            <div class="icon-input-group">
                                <div class="modern-input-wrapper">
                                    <input type="text" id="skillIcon" class="modern-input" placeholder="fab fa-react" maxlength="50">
                                    <div class="input-border"></div>
                                </div>
                                <div class="icon-preview" id="skillIconPreview">
                                    <i class="fas fa-code"></i>
                                </div>
                            </div>
                            <small class="field-help">e.g., fab fa-react, fab fa-python, fas fa-database</small>
                        </div>

                        <!-- Icon Color -->
                        <div class="modern-form-group">
                            <label for="skillIconColor" class="modern-label">
                                <i class="fas fa-palette label-icon"></i>
                                Icon Color
                            </label>
                            <div class="color-input-group">
                                <div class="modern-input-wrapper">
                                    <input type="text" id="skillIconColor" class="modern-input" placeholder="#61DAFB" maxlength="20">
                                    <div class="input-border"></div>
                                </div>
                                <input type="color" id="skillIconColorPicker" class="color-picker" value="#61DAFB">
                            </div>
                            <small class="field-help">Choose a color that represents this technology</small>
                        </div>
                    </div>
                </form>
            </div>

            <!-- Footer -->
            <div class="modern-modal-footer">
                <div class="footer-actions">
                    <button class="modern-btn-secondary" id="cancelSkillBtn" type="button">
                        <i class="fas fa-times"></i>
                        Cancel
                    </button>
                    <button class="modern-btn-primary" id="saveSkillBtn" type="button">
                        <span class="btn-content">
                            <i class="fas fa-plus btn-icon"></i>
                            <span class="btn-text">Add Skill</span>
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
// Ensure the skills modal functions are properly defined
(function() {
    'use strict';
    
    let skillModalInitialized = false;

    function initializeSkillModal() {
        if (skillModalInitialized) return;
        
        console.log('Initializing Skills Modal...');
        
        const modal = document.getElementById('skillModal');
        const form = document.getElementById('skillForm');
        const saveBtn = document.getElementById('saveSkillBtn');
        const cancelBtn = document.getElementById('cancelSkillBtn');
        const closeBtn = document.getElementById('closeSkillModal');

        if (!modal || !form || !saveBtn || !cancelBtn || !closeBtn) {
            console.error('Skills modal elements not found');
            return;
        }

        // Initialize form interactions
        initializeSkillFormInteractions();
        
        // Close modal events with proper event handling
        function handleCloseModal(e) {
            e.preventDefault();
            e.stopPropagation();
            console.log('Closing skills modal via button');
            closeSkillModalHandler();
        }
        
        cancelBtn.removeEventListener('click', handleCloseModal);
        closeBtn.removeEventListener('click', handleCloseModal);
        
        cancelBtn.addEventListener('click', handleCloseModal);
        closeBtn.addEventListener('click', handleCloseModal);

        // Click outside to close
        modal.addEventListener('click', function(e) {
            if (e.target === modal || e.target.classList.contains('modern-modal-backdrop')) {
                console.log('Closing skills modal via backdrop click');
                closeSkillModalHandler();
            }
        });

        // Save button
        saveBtn.addEventListener('click', function(e) {
            e.preventDefault();
            e.stopPropagation();
            console.log('Save skills button clicked');
            saveSkill();
        });

        // ESC key
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape' && modal && modal.classList.contains('active')) {
                console.log('Closing skills modal via ESC key');
                closeSkillModalHandler();
            }
        });

        skillModalInitialized = true;
        console.log('Skills modal initialized successfully');
    }

    function initializeSkillFormInteractions() {
        // Proficiency slider sync
        const proficiencyRange = document.getElementById('skillProficiencyRange');
        const proficiencyInput = document.getElementById('skillProficiency');
        const proficiencyFill = document.getElementById('skillProficiencyFill');
        const proficiencyText = document.getElementById('skillProficiencyText');

        function updateProficiency(value) {
            value = Math.max(0, Math.min(100, value));
            if (proficiencyRange) proficiencyRange.value = value;
            if (proficiencyInput) proficiencyInput.value = value;
            if (proficiencyFill) proficiencyFill.style.width = value + '%';
            
            // Update proficiency text
            if (proficiencyText) {
                if (value >= 90) proficiencyText.textContent = 'Expert';
                else if (value >= 75) proficiencyText.textContent = 'Advanced';
                else if (value >= 60) proficiencyText.textContent = 'Intermediate';
                else if (value >= 40) proficiencyText.textContent = 'Basic';
                else proficiencyText.textContent = 'Beginner';
            }

            // Update color
            if (proficiencyFill) {
                const hue = (value / 100) * 120; // Red to green
                proficiencyFill.style.background = `hsl(${hue}, 70%, 50%)`;
            }
        }

        if (proficiencyRange) {
            proficiencyRange.addEventListener('input', (e) => updateProficiency(e.target.value));
        }
        if (proficiencyInput) {
            proficiencyInput.addEventListener('input', (e) => updateProficiency(e.target.value));
        }

        // Icon preview
        const iconInput = document.getElementById('skillIcon');
        const iconPreview = document.getElementById('skillIconPreview');
        const iconColorInput = document.getElementById('skillIconColor');
        const iconColorPicker = document.getElementById('skillIconColorPicker');

        function updateIconPreview() {
            const iconClass = iconInput?.value?.trim() || 'fas fa-code';
            const iconColor = iconColorInput?.value?.trim() || '#61DAFB';
            if (iconPreview) {
                iconPreview.innerHTML = `<i class="${iconClass}" style="color: ${iconColor}"></i>`;
            }
        }

        if (iconInput) iconInput.addEventListener('input', updateIconPreview);
        if (iconColorInput) {
            iconColorInput.addEventListener('input', (e) => {
                if (iconColorPicker) iconColorPicker.value = e.target.value || '#61DAFB';
                updateIconPreview();
            });
        }
        if (iconColorPicker) {
            iconColorPicker.addEventListener('input', (e) => {
                if (iconColorInput) iconColorInput.value = e.target.value;
                updateIconPreview();
            });
        }

        // Description counter
        const descriptionTextarea = document.getElementById('skillDescription');
        const descriptionCounter = document.getElementById('skillDescriptionCounter');

        if (descriptionTextarea && descriptionCounter) {
            descriptionTextarea.addEventListener('input', () => {
                const length = descriptionTextarea.value.length;
                descriptionCounter.textContent = length;
                descriptionCounter.style.color = length > 450 ? '#ef4444' : length > 400 ? '#f59e0b' : '#6b7280';
            });
        }

        // Real-time validation
        const form = document.getElementById('skillForm');
        if (form) {
            const requiredFields = form.querySelectorAll('[required]');
            requiredFields.forEach(field => {
                field.addEventListener('blur', () => validateSkillField(field));
                field.addEventListener('input', () => clearSkillFieldError(field));
            });
        }

        // Initialize
        updateProficiency(50);
        updateIconPreview();
    }

    function validateSkillField(field) {
        const fieldId = field.id;
        const value = field.value.trim();
        const errorElement = document.getElementById(fieldId + 'Error');
        
        let isValid = true;
        let errorMessage = '';

        switch(fieldId) {
            case 'skillName':
                if (!value) {
                    errorMessage = 'Skill name is required';
                    isValid = false;
                } else if (value.length < 2) {
                    errorMessage = 'Skill name must be at least 2 characters';
                    isValid = false;
                }
                break;
            case 'skillCategory':
                if (!value) {
                    errorMessage = 'Please select a category';
                    isValid = false;
                }
                break;
            case 'skillProficiency':
                const proficiency = parseInt(value);
                if (!value) {
                    errorMessage = 'Proficiency level is required';
                    isValid = false;
                } else if (isNaN(proficiency) || proficiency < 0 || proficiency > 100) {
                    errorMessage = 'Proficiency must be between 0 and 100';
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

    function clearSkillFieldError(field) {
        const errorElement = document.getElementById(field.id + 'Error');
        if (errorElement) {
            errorElement.style.display = 'none';
        }
        field.classList.remove('error');
    }

    function validateSkillForm() {
        const form = document.getElementById('skillForm');
        if (!form) return false;
        
        const requiredFields = form.querySelectorAll('[required]');
        const validationAlert = document.getElementById('skillValidationAlert');
        const validationList = document.getElementById('skillValidationList');
        
        let isValid = true;
        const errors = [];

        requiredFields.forEach(field => {
            if (!validateSkillField(field)) {
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

    function openSkillModal() {
        console.log('Opening modern skill modal...');
        const modal = document.getElementById('skillModal');
        const title = document.getElementById('skillModalTitle');
        
        if (!modal) {
            console.error('Skill modal not found!');
            return;
        }
        
        // Initialize if not already done
        initializeSkillModal();
        
        // Reset form
        resetSkillForm();
        
        if (title) title.textContent = 'Add New Skill';
        modal.classList.add('active');
        document.body.classList.add('modal-open');
        
        // Focus on first input with delay for animation
        setTimeout(() => {
            const firstInput = document.getElementById('skillName');
            if (firstInput) {
                firstInput.focus();
            }
        }, 300);
        
        console.log('Modern skill modal opened successfully');
    }

    function closeSkillModalHandler() {
        console.log('Closing modern skill modal...');
        const modal = document.getElementById('skillModal');
        if (modal) {
            modal.classList.remove('active');
            document.body.classList.remove('modal-open');
            
            // Reset form after animation
            setTimeout(() => {
                resetSkillForm();
            }, 300);
            
            console.log('Modern skill modal closed successfully');
        }
    }

    function resetSkillForm() {
        const form = document.getElementById('skillForm');
        if (form) {
            form.reset();
        }
        
        // Reset specific elements
        const elements = {
            skillProficiencyRange: '50',
            skillProficiency: '50',
            skillIconColorPicker: '#61DAFB',
            skillIconColor: '#61DAFB',
            skillDescriptionCounter: '0'
        };
        
        Object.keys(elements).forEach(id => {
            const element = document.getElementById(id);
            if (element) {
                if (element.tagName === 'INPUT') {
                    element.value = elements[id];
                } else {
                    element.textContent = elements[id];
                }
            }
        });
        
        // Clear validation
        const validationAlert = document.getElementById('skillValidationAlert');
        if (validationAlert) validationAlert.style.display = 'none';
        
        if (form) {
            form.querySelectorAll('.error').forEach(el => el.classList.remove('error'));
            form.querySelectorAll('.field-error').forEach(el => el.style.display = 'none');
        }
        
        // Reset proficiency display
        const proficiencyFill = document.getElementById('skillProficiencyFill');
        const proficiencyText = document.getElementById('skillProficiencyText');
        if (proficiencyFill) {
            proficiencyFill.style.width = '50%';
            proficiencyFill.style.background = 'hsl(60, 70%, 50%)';
        }
        if (proficiencyText) {
            proficiencyText.textContent = 'Intermediate';
        }
        
        // Reset icon preview
        const iconPreview = document.getElementById('skillIconPreview');
        if (iconPreview) {
            iconPreview.innerHTML = '<i class="fas fa-code" style="color: #61DAFB"></i>';
        }
    }

    function saveSkill() {
        console.log('Saving modern skill...');
        
        if (!validateSkillForm()) {
            return;
        }

        const saveBtn = document.getElementById('saveSkillBtn');
        const btnContent = saveBtn?.querySelector('.btn-content');
        const btnLoading = saveBtn?.querySelector('.btn-loading');
        
        // Show loading state
        if (saveBtn) saveBtn.disabled = true;
        if (btnContent) btnContent.style.display = 'none';
        if (btnLoading) btnLoading.style.display = 'flex';

        const skillData = {
            name: document.getElementById('skillName')?.value?.trim() || '',
            description: document.getElementById('skillDescription')?.value?.trim() || '',
            category: document.getElementById('skillCategory')?.value || '',
            proficiencyLevel: parseInt(document.getElementById('skillProficiency')?.value) || 0,
            yearsOfExperience: parseFloat(document.getElementById('skillExperience')?.value) || 0,
            iconClass: document.getElementById('skillIcon')?.value?.trim() || '',
            iconColor: document.getElementById('skillIconColor')?.value?.trim() || ''
        };

        console.log('Modern skill data:', skillData);

        // Make AJAX call to add skill
        fetch('/Admin/Dashboard.aspx/AddSkill', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=utf-8'
            },
            body: JSON.stringify(skillData)
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
                closeSkillModalHandler();
                
                // Reload skills table
                if (typeof loadSkills === 'function') {
                    loadSkills();
                }
            } else {
                if (typeof showToast === 'function') {
                    showToast(result.message, 'error');
                }
            }
        })
        .catch(error => {
            console.error('Error adding skill:', error);
            if (typeof showToast === 'function') {
                showToast('Error adding skill. Please try again.', 'error');
            }
        })
        .finally(() => {
            // Reset loading state
            if (saveBtn) saveBtn.disabled = false;
            if (btnContent) btnContent.style.display = 'flex';
            if (btnLoading) btnLoading.style.display = 'none';
        });
    }

    // Initialize when DOM is ready
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initializeSkillModal);
    } else {
        initializeSkillModal();
    }

    // Global function to open skill modal
    window.openSkillModal = openSkillModal;
    window.closeSkillModalHandler = closeSkillModalHandler;
    window.saveSkill = saveSkill;
    
    console.log('Skills modal script loaded');
})();
</script>

<style>
/* Modern Professional Modal Styles */
.modern-modal {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    z-index: 9999;
    opacity: 0;
    visibility: hidden;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.modern-modal.active {
    opacity: 1;
    visibility: visible;
}

.modern-modal-backdrop {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.6);
    backdrop-filter: blur(8px);
    -webkit-backdrop-filter: blur(8px);
}

.modern-modal-container {
    position: relative;
    width: 100%;
    height: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 20px;
    overflow-y: auto;
}

.modern-modal-content {
    background: var(--card-bg);
    border-radius: 24px;
    width: 100%;
    max-width: 800px;
    max-height: 90vh;
    overflow: hidden;
    box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25), 0 0 0 1px rgba(255, 255, 255, 0.05);
    border: 1px solid var(--border-color);
    transform: scale(0.9) translateY(20px);
    transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.modern-modal.active .modern-modal-content {
    transform: scale(1) translateY(0);
}

/* Header */
.modern-modal-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 32px 32px 24px;
    border-bottom: 1px solid var(--border-color);
    background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
    background-size: 200% 200%;
    animation: gradientShift 8s ease infinite;
    color: white;
}

@keyframes gradientShift {
    0% { background-position: 0% 50%; }
    50% { background-position: 100% 50%; }
    100% { background-position: 0% 50%; }
}

.modal-header-content {
    display: flex;
    align-items: center;
    gap: 16px;
}

.modal-icon {
    width: 56px;
    height: 56px;
    border-radius: 16px;
    background: rgba(255, 255, 255, 0.2);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 24px;
    backdrop-filter: blur(10px);
}

.modal-title-section .modal-title {
    font-size: 28px;
    font-weight: 700;
    margin: 0 0 4px 0;
    color: white;
}

.modal-title-section .modal-subtitle {
    font-size: 16px;
    margin: 0;
    opacity: 0.9;
    color: rgba(255, 255, 255, 0.8);
}

.modern-modal-close {
    width: 44px;
    height: 44px;
    border-radius: 12px;
    background: rgba(255, 255, 255, 0.1);
    border: none;
    color: white;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 18px;
    transition: all 0.2s ease;
    backdrop-filter: blur(10px);
}

.modern-modal-close:hover {
    background: rgba(255, 255, 255, 0.2);
    transform: scale(1.05);
}

/* Body */
.modern-modal-body {
    padding: 32px;
    max-height: calc(90vh - 200px);
    overflow-y: auto;
}

/* Validation Alert */
.validation-alert {
    background: linear-gradient(135deg, #fef2f2 0%, #fdf2f8 100%);
    border: 1px solid #fecaca;
    border-radius: 16px;
    padding: 20px;
    margin-bottom: 24px;
    display: flex;
    gap: 16px;
    animation: slideIn 0.3s ease;
}

.alert-icon {
    flex-shrink: 0;
    width: 24px;
    height: 24px;
    color: #dc2626;
    font-size: 20px;
}

.alert-content h4 {
    margin: 0 0 12px 0;
    color: #dc2626;
    font-size: 16px;
    font-weight: 600;
}

.alert-content ul {
    margin: 0;
    padding-left: 20px;
    color: #7f1d1d;
}

.alert-content li {
    margin: 4px 0;
}

/* Form Grid */
.modern-form-grid {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 24px;
}

.modern-form-group {
    display: flex;
    flex-direction: column;
}

.modern-form-group.full-width {
    grid-column: 1 / -1;
}

.modern-form-group.required .modern-label::after {
    content: '*';
    color: #ef4444;
    margin-left: 4px;
}

/* Labels */
.modern-label {
    display: flex;
    align-items: center;
    gap: 8px;
    font-weight: 600;
    font-size: 14px;
    color: var(--text-primary);
    margin-bottom: 8px;
}

.label-icon {
    font-size: 14px;
    color: var(--primary);
    width: 16px;
}

/* Input Styles */
.modern-input-wrapper {
    position: relative;
}

.modern-input {
    width: 100%;
    padding: 16px 16px 16px 16px;
    border: 2px solid var(--border-color);
    border-radius: 12px;
    background: var(--bg-tertiary);
    color: var(--text-primary);
    font-size: 15px;
    transition: all 0.3s ease;
    outline: none;
}

.modern-input:focus {
    border-color: var(--primary);
    background: var(--card-bg);
    box-shadow: 0 0 0 4px rgba(var(--primary-rgb), 0.1);
}

.modern-input.error {
    border-color: #ef4444;
    background: #fef2f2;
}

.input-suffix {
    position: absolute;
    right: 16px;
    top: 50%;
    transform: translateY(-50%);
    color: var(--text-secondary);
    font-size: 14px;
    font-weight: 500;
    pointer-events: none;
}

.input-border {
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    height: 2px;
    background: linear-gradient(90deg, var(--primary), var(--secondary));
    transform: scaleX(0);
    transition: transform 0.3s ease;
}

.modern-input:focus + .input-border {
    transform: scaleX(1);
}

/* Select Styles */
.modern-select-wrapper {
    position: relative;
}

.modern-select {
    width: 100%;
    padding: 16px 48px 16px 16px;
    border: 2px solid var(--border-color);
    border-radius: 12px;
    background: var(--bg-tertiary);
    color: var(--text-primary);
    font-size: 15px;
    cursor: pointer;
    outline: none;
    appearance: none;
    transition: all 0.3s ease;
}

.modern-select:focus {
    border-color: var(--primary);
    background: var(--card-bg);
    box-shadow: 0 0 0 4px rgba(var(--primary-rgb), 0.1);
}

.select-arrow {
    position: absolute;
    right: 16px;
    top: 50%;
    transform: translateY(-50%);
    color: var(--text-secondary);
    pointer-events: none;
    transition: transform 0.3s ease;
}

.modern-select:focus + .select-arrow {
    transform: translateY(-50%) rotate(180deg);
}

/* Textarea */
.modern-textarea-wrapper {
    position: relative;
}

.modern-textarea {
    width: 100%;
    padding: 16px;
    border: 2px solid var(--border-color);
    border-radius: 12px;
    background: var(--bg-tertiary);
    color: var(--text-primary);
    font-size: 15px;
    line-height: 1.5;
    resize: vertical;
    min-height: 100px;
    outline: none;
    transition: all 0.3s ease;
    font-family: inherit;
}

.modern-textarea:focus {
    border-color: var(--primary);
    background: var(--card-bg);
    box-shadow: 0 0 0 4px rgba(var(--primary-rgb), 0.1);
}

.textarea-counter {
    position: absolute;
    bottom: 8px;
    right: 12px;
    font-size: 12px;
    color: var(--text-tertiary);
    background: var(--card-bg);
    padding: 2px 6px;
    border-radius: 4px;
}

/* Proficiency Styles */
.proficiency-input-group {
    display: flex;
    flex-direction: column;
    gap: 12px;
}

.proficiency-input-group .modern-input-wrapper {
    display: flex;
    align-items: center;
    gap: 12px;
}

.modern-range {
    flex: 1;
    height: 6px;
    border-radius: 3px;
    background: var(--bg-secondary);
    outline: none;
    appearance: none;
    cursor: pointer;
}

.modern-range::-webkit-slider-thumb {
    appearance: none;
    width: 20px;
    height: 20px;
    border-radius: 50%;
    background: var(--primary);
    cursor: pointer;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
    transition: transform 0.2s ease;
}

.modern-range::-webkit-slider-thumb:hover {
    transform: scale(1.1);
}

.proficiency-number {
    width: 80px;
    text-align: center;
}

.proficiency-display {
    display: flex;
    align-items: center;
    gap: 12px;
}

.proficiency-bar {
    flex: 1;
    height: 8px;
    background: var(--bg-secondary);
    border-radius: 4px;
    overflow: hidden;
}

.proficiency-fill {
    height: 100%;
    background: var(--primary);
    border-radius: 4px;
    transition: all 0.3s ease;
}

.proficiency-text {
    font-size: 14px;
    font-weight: 600;
    color: var(--text-primary);
    min-width: 80px;
}

/* Icon Input */
.icon-input-group {
    display: flex;
    gap: 12px;
    align-items: flex-start;
}

.icon-input-group .modern-input-wrapper {
    flex: 1;
}

.icon-preview {
    width: 52px;
    height: 52px;
    border: 2px solid var(--border-color);
    border-radius: 12px;
    background: var(--bg-tertiary);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 20px;
    flex-shrink: 0;
}

/* Color Input */
.color-input-group {
    display: flex;
    gap: 12px;
    align-items: flex-start;
}

.color-input-group .modern-input-wrapper {
    flex: 1;
}

.color-picker {
    width: 52px;
    height: 52px;
    border: 2px solid var(--border-color);
    border-radius: 12px;
    background: none;
    cursor: pointer;
    outline: none;
}

.color-picker::-webkit-color-swatch-wrapper {
    padding: 0;
}

.color-picker::-webkit-color-swatch {
    border: none;
    border-radius: 8px;
}

/* Field Error */
.field-error {
    color: #ef4444;
    font-size: 13px;
    margin-top: 6px;
    display: none;
    animation: slideIn 0.2s ease;
}

/* Field Help */
.field-help {
    color: var(--text-tertiary);
    font-size: 13px;
    margin-top: 6px;
    line-height: 1.4;
}

/* Footer */
.modern-modal-footer {
    padding: 24px 32px 32px;
    border-top: 1px solid var(--border-color);
    background: var(--bg-secondary);
}

.footer-actions {
    display: flex;
    gap: 16px;
    justify-content: flex-end;
}

/* Buttons */
.modern-btn-secondary {
    padding: 12px 24px;
    border: 2px solid var(--border-color);
    border-radius: 12px;
    background: transparent;
    color: var(--text-primary);
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s ease;
    display: flex;
    align-items: center;
    gap: 8px;
    font-size: 15px;
}

.modern-btn-secondary:hover {
    border-color: var(--primary);
    color: var(--primary);
    transform: translateY(-2px);
}

.modern-btn-primary {
    padding: 12px 24px;
    border: none;
    border-radius: 12px;
    background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
    color: white;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s ease;
    font-size: 15px;
    position: relative;
    overflow: hidden;
}

.modern-btn-primary:hover:not(:disabled) {
    transform: translateY(-2px);
    box-shadow: 0 10px 25px rgba(var(--primary-rgb), 0.3);
}

.modern-btn-primary:disabled {
    opacity: 0.7;
    cursor: not-allowed;
}

.btn-content,
.btn-loading {
    display: flex;
    align-items: center;
    gap: 8px;
}

.btn-loading {
    display: none;
}

/* Animations */
@keyframes slideIn {
    from {
        opacity: 0;
        transform: translateY(-10px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

/* Responsive */
@media (max-width: 768px) {
    .modern-modal-container {
        padding: 10px;
        align-items: flex-start;
    }
    
    .modern-modal-content {
        max-height: 95vh;
        border-radius: 16px;
        margin-top: 20px;
    }
    
    .modern-modal-header {
        padding: 20px 20px 16px;
    }
    
    .modal-icon {
        width: 48px;
        height: 48px;
        font-size: 20px;
    }
    
    .modal-title-section .modal-title {
        font-size: 24px;
    }
    
    .modern-modal_body {
        padding: 20px;
    }
    
    .modern-form-grid {
        grid-template-columns: 1fr;
        gap: 20px;
    }
    
    .modern-modal-footer {
        padding: 16px 20px 20px;
    }
    
    .footer-actions {
        flex-direction: column-reverse;
    }
    
    .modern-btn-secondary,
    .modern-btn-primary {
        width: 100%;
        justify-content: center;
    }
}

/* Light mode adjustments */
body.light-mode .modern-modal-backdrop {
    background: rgba(0, 0, 0, 0.4);
}

body.light-mode .validation-alert {
    background: linear-gradient(135deg, #fef2f2 0%, #fdf2f8 100%);
}

/* Custom scrollbar for modal body */
.modern-modal-body::-webkit-scrollbar {
    width: 6px;
}

.modern-modal-body::-webkit-scrollbar-track {
    background: var(--bg-secondary);
    border-radius: 3px;
}

.modern-modal-body::-webkit-scrollbar-thumb {
    background: var(--border-color);
    border-radius: 3px;
}

.modern-modal-body::-webkit-scrollbar-thumb:hover {
    background: var(--text-tertiary);
}
</style>