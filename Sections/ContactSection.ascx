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
                <asp:TextBox ID="txtName" runat="server" placeholder="Your Name" CssClass="form-control" required="required"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName" 
                    ErrorMessage="Name is required" Display="Dynamic" CssClass="validation-error" 
                    ValidationGroup="ContactForm"></asp:RequiredFieldValidator>
            </div>
            <div class="form-group">
                <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" placeholder="Your Email" CssClass="form-control" required="required"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" 
                    ErrorMessage="Email is required" Display="Dynamic" CssClass="validation-error" 
                    ValidationGroup="ContactForm"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail" 
                    ErrorMessage="Please enter a valid email address" Display="Dynamic" CssClass="validation-error" 
                    ValidationExpression="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" 
                    ValidationGroup="ContactForm"></asp:RegularExpressionValidator>
            </div>
            <div class="form-group">
                <asp:TextBox ID="txtSubject" runat="server" placeholder="Subject" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine" placeholder="Your Message" CssClass="form-control" required="required"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvMessage" runat="server" ControlToValidate="txtMessage" 
                    ErrorMessage="Message is required" Display="Dynamic" CssClass="validation-error" 
                    ValidationGroup="ContactForm"></asp:RequiredFieldValidator>
            </div>
            <asp:Button ID="btnSubmit" runat="server" Text="Send Message" CssClass="btn-submit" 
                OnClick="btnSubmit_Click" ValidationGroup="ContactForm" />
            
            <!-- Success/Error Messages -->
            <asp:Panel ID="pnlSuccess" runat="server" Visible="false" CssClass="message-success">
                <i class="fas fa-check-circle"></i>
                <span>Message sent successfully! We'll get back to you soon.</span>
            </asp:Panel>
            <asp:Panel ID="pnlError" runat="server" Visible="false" CssClass="message-error">
                <i class="fas fa-exclamation-triangle"></i>
                <asp:Literal ID="litError" runat="server"></asp:Literal>
            </asp:Panel>
        </div>
    </div>
</section>

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

.form-control[textmode="MultiLine"] {
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

.btn-submit:hover {
    transform: translateY(-5px);
    box-shadow: 0 8px 25px rgba(0, 217, 255, 0.4);
    color: white !important;
}

.btn-submit::before {
    content: '\f1d8';
    font-family: 'Font Awesome 5 Free';
    font-weight: 900;
    margin-right: 8px;
    font-size: 0.9rem;
}
</style>