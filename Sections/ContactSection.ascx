<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ContactSection.ascx.cs" Inherits="MyPortfolio.Sections.ContactSection" %>

<!-- Contact Section -->
<section id="contact" class="fade-in">
    <h2 class="section-title">Get In Touch</h2>
    <div class="contact-container">
        <div class="contact-info">
            <div class="contact-item">
                <div class="contact-icon"><i class="fas fa-map-marker-alt"></i></div>
                <div class="contact-text">
                    <h3>Location</h3>
                    <p>Khulna, Bangladesh</p>
                </div>
            </div>
            <div class="contact-item">
                <div class="contact-icon"><i class="fas fa-envelope"></i></div>
                <div class="contact-text">
                    <h3>Email</h3>
                    <p>dipra.datta@example.com</p>
                </div>
            </div>
            <div class="contact-item">
                <div class="contact-icon"><i class="fas fa-phone-alt"></i></div>
                <div class="contact-text">
                    <h3>Phone</h3>
                    <p>+880 1XXX-XXXXXX</p>
                </div>
            </div>
            <div class="contact-item">
                <div class="contact-icon"><i class="fas fa-code"></i></div>
                <div class="contact-text">
                    <h3>Codeforces</h3>
                    <p>codeforces.com/profile/dipra_datta</p>
                </div>
            </div>
        </div>
        <div class="contact-form">
            <div class="form-group">
                <input type="text" id="txtName" placeholder="Your Name" class="form-control" required>
                <div class="validation-error" id="nameError" style="display: none;"></div>
            </div>
            <div class="form-group">
                <input type="email" id="txtEmail" placeholder="Your Email" class="form-control" required>
                <div class="validation-error" id="emailError" style="display: none;"></div>
            </div>
            <div class="form-group">
                <input type="text" id="txtSubject" placeholder="Subject" class="form-control">
            </div>
            <div class="form-group">
                <textarea id="txtMessage" placeholder="Your Message" class="form-control" rows="6" required></textarea>
                <div class="validation-error" id="messageError" style="display: none;"></div>
            </div>
            <button type="button" id="btnSubmit" class="btn-submit">
                <i class="fas fa-paper-plane"></i>
                <span id="btnText">Send Message</span>
                <i class="fas fa-spinner fa-spin" id="btnSpinner" style="display: none;"></i>
            </button>
            
            <!-- Success/Error Messages -->
            <div id="messageSuccess" class="message-success" style="display: none;">
                <i class="fas fa-check-circle"></i>
                <span>Message sent successfully! We'll get back to you soon.</span>
            </div>
            <div id="messageError" class="message-error" style="display: none;">
                <i class="fas fa-exclamation-triangle"></i>
                <span id="errorText"></span>
            </div>
        </div>
    </div>
</section>

<script>
document.addEventListener('DOMContentLoaded', function() {
    const btnSubmit = document.getElementById('btnSubmit');
    const btnText = document.getElementById('btnText');
    const btnSpinner = document.getElementById('btnSpinner');
    const messageSuccess = document.getElementById('messageSuccess');
    const messageError = document.getElementById('messageError');
    const errorText = document.getElementById('errorText');
    
    // Form fields
    const txtName = document.getElementById('txtName');
    const txtEmail = document.getElementById('txtEmail');
    const txtSubject = document.getElementById('txtSubject');
    const txtMessage = document.getElementById('txtMessage');
    
    // Error elements
    const nameError = document.getElementById('nameError');
    const emailError = document.getElementById('emailError');
    const messageErrorField = document.getElementById('messageError');

    btnSubmit.addEventListener('click', function(e) {
        e.preventDefault();
        
        // Hide previous messages
        hideAllMessages();
        
        // Validate form
        if (!validateForm()) {
            return;
        }
        
        // Show loading state
        setLoadingState(true);
        
        // Prepare form data
        const formData = {
            name: txtName.value.trim(),
            email: txtEmail.value.trim(),
            subject: txtSubject.value.trim() || 'Contact Form Submission',
            message: txtMessage.value.trim()
        };
        
        // Send AJAX request
        fetch('/Default.aspx/SendContactMessage', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=utf-8'
            },
            body: JSON.stringify(formData)
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        })
        .then(data => {
            setLoadingState(false);
            
            const result = JSON.parse(data.d);
            
            if (result.success) {
                showSuccess();
                clearForm();
            } else {
                showError(result.message || 'Failed to send message. Please try again.');
            }
        })
        .catch(error => {
            setLoadingState(false);
            console.error('Error:', error);
            showError('An error occurred while sending your message. Please try again.');
        });
    });
    
    function validateForm() {
        let isValid = true;
        
        // Reset previous errors
        hideFieldErrors();
        
        // Validate name
        if (!txtName.value.trim()) {
            showFieldError(nameError, 'Name is required');
            isValid = false;
        }
        
        // Validate email
        if (!txtEmail.value.trim()) {
            showFieldError(emailError, 'Email is required');
            isValid = false;
        } else if (!isValidEmail(txtEmail.value.trim())) {
            showFieldError(emailError, 'Please enter a valid email address');
            isValid = false;
        }
        
        // Validate message
        if (!txtMessage.value.trim()) {
            showFieldError(messageErrorField, 'Message is required');
            isValid = false;
        }
        
        return isValid;
    }
    
    function isValidEmail(email) {
        const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        return emailRegex.test(email);
    }
    
    function setLoadingState(loading) {
        if (loading) {
            btnText.style.display = 'none';
            btnSpinner.style.display = 'inline-block';
            btnSubmit.disabled = true;
            btnSubmit.style.opacity = '0.7';
        } else {
            btnText.style.display = 'inline-block';
            btnSpinner.style.display = 'none';
            btnSubmit.disabled = false;
            btnSubmit.style.opacity = '1';
        }
    }
    
    function hideAllMessages() {
        messageSuccess.style.display = 'none';
        messageError.style.display = 'none';
        hideFieldErrors();
    }
    
    function hideFieldErrors() {
        nameError.style.display = 'none';
        emailError.style.display = 'none';
        messageErrorField.style.display = 'none';
    }
    
    function showFieldError(element, message) {
        element.textContent = message;
        element.style.display = 'block';
    }
    
    function showSuccess() {
        messageSuccess.style.display = 'flex';
        messageSuccess.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
    }
    
    function showError(message) {
        errorText.textContent = message;
        messageError.style.display = 'flex';
        messageError.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
    }
    
    function clearForm() {
        txtName.value = '';
        txtEmail.value = '';
        txtSubject.value = '';
        txtMessage.value = '';
    }
});
</script>

<style>
/* Additional styles for form validation and messages */
.form-group {
    margin-bottom: 25px;
}

.form-control {
    width: 100%;
    padding: 15px 20px;
    background: var(--bg-secondary);
    border: 1px solid var(--border-color);
    border-radius: 10px;
    color: var(--text-primary);
    font-family: 'Poppins', sans-serif;
    font-size: 1rem;
    transition: all 0.3s ease;
    box-sizing: border-box;
}

.form-control:focus {
    outline: none;
    border-color: var(--primary);
    box-shadow: 0 0 15px rgba(0, 217, 255, 0.2);
}

.form-control[rows] {
    resize: vertical;
    min-height: 150px;
}

.validation-error {
    color: var(--accent);
    font-size: 0.85rem;
    margin-top: 5px;
    display: block;
}

.message-success, .message-error {
    margin-top: 20px;
    padding: 15px 20px;
    border-radius: 10px;
    display: flex;
    align-items: center;
    gap: 10px;
    font-weight: 500;
    animation: slideInFromBottom 0.5s ease-out;
}

@keyframes slideInFromBottom {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.message-success {
    background: rgba(34, 197, 94, 0.1);
    border: 1px solid rgba(34, 197, 94, 0.3);
    color: #22c55e;
}

.message-error {
    background: rgba(239, 68, 68, 0.1);
    border: 1px solid rgba(239, 68, 68, 0.3);
    color: #ef4444;
}

/* Button styling to match the original design */
.btn-submit {
    background: var(--gradient-1);
    color: white !important;
    border: none;
    padding: 16px 36px;
    border-radius: 50px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s ease;
    font-size: 1rem;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    gap: 12px;
    min-width: 200px;
    box-shadow: 0 4px 15px rgba(0, 217, 255, 0.3);
    text-decoration: none;
    font-family: 'Poppins', sans-serif;
    margin-top: 10px;
    position: relative;
}

.btn-submit:hover:not(:disabled) {
    transform: translateY(-5px);
    box-shadow: 0 8px 25px rgba(0, 217, 255, 0.4);
    color: white !important;
}

.btn-submit:disabled {
    cursor: not-allowed;
}

/* Smooth scroll behavior for the entire page */
html {
    scroll-behavior: smooth;
}

/* Ensure contact section is properly positioned for scroll targeting */
#contact {
    scroll-margin-top: 80px; /* Account for fixed header height */
}
</style>