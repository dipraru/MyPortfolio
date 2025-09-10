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
            <form id="contactForm">
                <div class="form-group">
                    <input type="text" placeholder="Your Name" required>
                </div>
                <div class="form-group">
                    <input type="email" placeholder="Your Email" required>
                </div>
                <div class="form-group">
                    <input type="text" placeholder="Subject">
                </div>
                <div class="form-group">
                    <textarea placeholder="Your Message" required></textarea>
                </div>
                <button type="submit" class="btn-submit">
                    <i class="fas fa-paper-plane"></i>
                    Send Message
                </button>
            </form>
        </div>
    </div>
</section>