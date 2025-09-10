<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProjectsSection.ascx.cs" Inherits="MyPortfolio.Sections.ProjectsSection" %>

<!-- Projects Section -->
<section id="projects" class="fade-in">
    <h2 class="section-title">Featured Projects</h2>
    <div class="projects-container">
        <div class="project-card">
            <div class="project-image">
                <img src="https://images.unsplash.com/photo-1555066931-4365d14bab8c?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="Algorithm Visualizer">
                <div class="project-overlay">
                    <div class="project-links">
                        <a href="#"><i class="fab fa-github"></i></a>
                        <a href="#"><i class="fas fa-external-link-alt"></i></a>
                    </div>
                </div>
            </div>
            <div class="project-info">
                <h3 class="project-title">Algorithm Visualizer</h3>
                <p class="project-description">An interactive web application that visualizes common algorithms and data structures to help students understand complex concepts.</p>
                <div class="project-tags">
                    <span class="tag">JavaScript</span>
                    <span class="tag">D3.js</span>
                    <span class="tag">Algorithms</span>
                </div>
            </div>
        </div>
        <div class="project-card">
            <div class="project-image">
                <img src="https://images.unsplash.com/photo-1551288049-bebda4e38f71?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="Competitive Programming Platform">
                <div class="project-overlay">
                    <div class="project-links">
                        <a href="#"><i class="fab fa-github"></i></a>
                        <a href="#"><i class="fas fa-external-link-alt"></i></a>
                    </div>
                </div>
            </div>
            <div class="project-info">
                <h3 class="project-title">CP Practice Platform</h3>
                <p class="project-description">A custom platform for competitive programmers to practice problems, track progress, and participate in virtual contests.</p>
                <div class="project-tags">
                    <span class="tag">React</span>
                    <span class="tag">Node.js</span>
                    <span class="tag">MongoDB</span>
                </div>
            </div>
        </div>
        <div class="project-card">
            <div class="project-image">
                <img src="https://images.unsplash.com/photo-1558494949-ef010cbdcc31?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="Code Analysis Tool">
                <div class="project-overlay">
                    <div class="project-links">
                        <a href="#"><i class="fab fa-github"></i></a>
                        <a href="#"><i class="fas fa-external-link-alt"></i></a>
                    </div>
                </div>
            </div>
            <div class="project-info">
                <h3 class="project-title">Code Complexity Analyzer</h3>
                <p class="project-description">A tool that analyzes code complexity, suggests optimizations, and helps improve algorithm efficiency.</p>
                <div class="project-tags">
                    <span class="tag">Python</span>
                    <span class="tag">AST</span>
                    <span class="tag">Machine Learning</span>
                </div>
            </div>
        </div>
    </div>
</section>