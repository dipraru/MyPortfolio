// Theme and UI Management
class ThemeManager {
    constructor() {
        this.themeToggle = document.getElementById('themeToggle');
        this.themeIcon = document.getElementById('themeIcon');
        this.body = document.body;
        this.init();
    }

    init() {
        // Check for saved theme preference or default to dark mode
        const currentTheme = localStorage.getItem('theme') || 'dark';
        if (currentTheme === 'light') {
            this.body.classList.add('light-mode');
            this.themeIcon.classList.remove('fa-moon');
            this.themeIcon.classList.add('fa-sun');
        }

        this.themeToggle.addEventListener('click', () => this.toggleTheme());
    }

    toggleTheme() {
        this.body.classList.toggle('light-mode');

        if (this.body.classList.contains('light-mode')) {
            this.themeIcon.classList.remove('fa-moon');
            this.themeIcon.classList.add('fa-sun');
            localStorage.setItem('theme', 'light');
        } else {
            this.themeIcon.classList.remove('fa-sun');
            this.themeIcon.classList.add('fa-moon');
            localStorage.setItem('theme', 'dark');
        }
    }
}

// Custom Cursor Management
class CursorManager {
    constructor() {
        this.cursor = document.querySelector('.cursor');
        this.cursorFollower = document.querySelector('.cursor-follower');
        this.init();
    }

    init() {
        document.addEventListener('mousemove', (e) => this.updateCursorPosition(e));
        this.addHoverEffects();
    }

    updateCursorPosition(e) {
        this.cursor.style.left = e.clientX + 'px';
        this.cursor.style.top = e.clientY + 'px';

        setTimeout(() => {
            this.cursorFollower.style.left = e.clientX + 'px';
            this.cursorFollower.style.top = e.clientY + 'px';
        }, 100);
    }

    addHoverEffects() {
        const hoverElements = document.querySelectorAll(
            'a, button, .btn, .project-card, .skill-card, .achievement-card, ' +
            '.stat-box, .achievement-box, .about-card, .theme-toggle, .scroll-top'
        );

        hoverElements.forEach(element => {
            element.addEventListener('mouseenter', () => {
                this.cursor.classList.add('hover');
                this.cursorFollower.classList.add('hover');
            });

            element.addEventListener('mouseleave', () => {
                this.cursor.classList.remove('hover');
                this.cursorFollower.classList.remove('hover');
            });
        });
    }
}

// Navigation Management
class NavigationManager {
    constructor() {
        this.menuToggle = document.getElementById('menuToggle');
        this.navLinks = document.getElementById('navLinks');
        this.header = document.getElementById('header');
        this.init();
    }

    init() {
        this.menuToggle.addEventListener('click', () => this.toggleMobileMenu());
        this.addScrollEffect();
        this.addSmoothScrolling();
        this.closeMobileMenuOnLinkClick();
    }

    toggleMobileMenu() {
        this.navLinks.classList.toggle('active');
    }

    closeMobileMenuOnLinkClick() {
        document.querySelectorAll('.nav-links a').forEach(link => {
            link.addEventListener('click', () => {
                this.navLinks.classList.remove('active');
            });
        });
    }

    addScrollEffect() {
        window.addEventListener('scroll', () => {
            if (window.scrollY > 50) {
                this.header.classList.add('scrolled');
            } else {
                this.header.classList.remove('scrolled');
            }
        });
    }

    addSmoothScrolling() {
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth'
                    });
                }
            });
        });
    }
}

// Scroll to Top Button
class ScrollTopManager {
    constructor() {
        this.scrollTopBtn = document.getElementById('scrollTop');
        this.init();
    }

    init() {
        window.addEventListener('scroll', () => this.handleScroll());
        this.scrollTopBtn.addEventListener('click', () => this.scrollToTop());
    }

    handleScroll() {
        if (window.pageYOffset > 300) {
            this.scrollTopBtn.classList.add('active');
        } else {
            this.scrollTopBtn.classList.remove('active');
        }
    }

    scrollToTop() {
        window.scrollTo({
            top: 0,
            behavior: 'smooth'
        });
    }
}

// Initialize all managers when DOM is loaded
document.addEventListener('DOMContentLoaded', () => {
    new ThemeManager();
    new CursorManager();
    new NavigationManager();
    new ScrollTopManager();
});