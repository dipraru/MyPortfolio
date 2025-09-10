<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Footer.ascx.cs" Inherits="MyPortfolio.Components.Footer" %>

<!-- Footer -->
<footer>
    <div class="social-links">
        <a href="#"><i class="fab fa-github"></i></a>
        <a href="#"><i class="fab fa-codeforces"></i></a>
        <a href="#"><i class="fab fa-linkedin"></i></a>
        <a href="#"><i class="fab fa-twitter"></i></a>
        <a href="#"><i class="fab fa-kaggle"></i></a>
    </div>
    <p class="copyright">&copy; 2023 Dipra Datta. All rights reserved.</p>
</footer>

<style>
/* Footer Styles */
footer {
    background: var(--bg-secondary);
    padding: 50px;
    text-align: center;
    border-top: 1px solid var(--border-color);
}

.social-links {
    display: flex;
    justify-content: center;
    gap: 25px;
    margin-bottom: 30px;
}

.social-links a {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    width: 60px;
    height: 60px;
    background: var(--bg-tertiary);
    color: var(--text-primary);
    border-radius: 50%;
    font-size: 1.5rem;
    transition: all 0.3s ease;
    border: 1px solid var(--border-color);
}

.social-links a:hover {
    background: var(--gradient-1);
    transform: translateY(-8px);
    box-shadow: 0 10px 20px rgba(0, 217, 255, 0.3);
    color: var(--light);
}

.copyright {
    font-size: 1rem;
    opacity: 0.7;
    margin-top: 20px;
    color: var(--text-tertiary);
}
</style>