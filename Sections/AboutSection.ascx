<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AboutSection.ascx.cs" Inherits="MyPortfolio.Sections.AboutSection" %>

<!-- About Section - Redesigned -->
<section id="about" class="fade-in">
    <h2 class="section-title">About Me</h2>
    <div class="about-container">
        <div class="about-card">
            <h3><i class="fas fa-graduation-cap"></i> Education</h3>
            <ul>
                <li>
                    <div class="about-icon">
                        <i class="fas fa-university"></i>
                    </div>
                    <div class="about-info">
                        <h4>BSc. in CSE</h4>
                        <p>KUET (Khulna University of Engineering & Technology)</p>
                    </div>
                </li>
                <li>
                    <div class="about-icon">
                        <i class="fas fa-school"></i>
                    </div>
                    <div class="about-info">
                        <h4>HSC - GPA 5.0</h4>
                        <p>BAF Shaheen College, Kurmitola</p>
                    </div>
                </li>
                <li>
                    <div class="about-icon">
                        <i class="fas fa-school"></i>
                    </div>
                    <div class="about-info">
                        <h4>SSC - GPA 5.0</h4>
                        <p>Sammilani Secondary School, Chalitatola, Narail</p>
                    </div>
                </li>
                <li>
                    <div class="about-icon">
                        <i class="fas fa-certificate"></i>
                    </div>
                    <div class="about-info">
                        <h4>JSC - GPA 5.0</h4>
                        <p>Sammilani Secondary School, Chalitatola, Narail</p>
                    </div>
                </li>
            </ul>
        </div>
        <div class="about-card">
            <h3><i class="fas fa-code"></i> Programming Profile</h3>
            <ul>
                <li>
                    <div class="about-icon">
                        <i class="fas fa-laptop-code"></i>
                    </div>
                    <div class="about-info">
                        <h4>Experience</h4>
                        <p><%= GetExperience() %> years in Competitive Programming</p>
                    </div>
                </li>
                <li>
                    <div class="about-icon">
                        <i class="fab fa-codeforces"></i>
                    </div>
                    <div class="about-info">
                        <h4>Codeforces</h4>
                        <p>Max Rating: <%= GetCodeforcesRating() %> (<%= GetCodeforcesRank() %>)</p>
                    </div>
                </li>
                <li>
                    <div class="about-icon">
                        <i class="fas fa-utensils"></i>
                    </div>
                    <div class="about-info">
                        <h4>Codechef</h4>
                        <p>Rating: <%= GetCodechefRating() %> (<%= GetCodechefRank() %>)</p>
                    </div>
                </li>
                <li>
                    <div class="about-icon">
                        <i class="fas fa-puzzle-piece"></i>
                    </div>
                    <div class="about-info">
                        <h4>Problems Solved</h4>
                        <p><%= GetProblemsSolved() %>+ across multiple platforms</p>
                    </div>
                </li>
            </ul>
        </div>
    </div>
    <div class="about-card">
        <h3><i class="fas fa-trophy"></i> Competition Achievements</h3>
        <div class="achievements-grid">
            <%= GetCompetitionAchievementsHtml() %>
        </div>
    </div>
    
    <!-- Enhanced Stats Section -->
    <div class="stats-section">
        <div class="stats-illustrations">
            <div class="stats-code">
                <div style="color: var(--primary);">int rating =</div>
                <div style="color: var(--accent);"><%= GetCodeforcesRating() %>;</div>
            </div>
            <div class="stats-algo">
                <svg viewBox="0 0 120 120" xmlns="http://www.w3.org/2000/svg">
                    <polygon points="60,10 90,40 90,80 60,110 30,80 30,40" fill="none" stroke="var(--primary)" stroke-width="2"/>
                    <circle cx="60" cy="60" r="25" fill="none" stroke="var(--accent)" stroke-width="2"/>
                    <text x="60" y="65" text-anchor="middle" fill="var(--primary)" font-family="monospace" font-size="12">O(n)</text>
                </svg>
            </div>
        </div>
        <div class="stats-grid">
            <div class="stat-box">
                <div class="stat-icon"><i class="fas fa-trophy"></i></div>
                <div class="stat-number" data-target="<%= GetCodeforcesRating() %>">0</div>
                <div class="stat-label">Codeforces Rating</div>
            </div>
            <div class="stat-box">
                <div class="stat-icon"><i class="fas fa-star"></i></div>
                <div class="stat-number" data-target="<%= GetCodechefRating() %>">0</div>
                <div class="stat-label">Codechef Rating</div>
            </div>
            <div class="stat-box">
                <div class="stat-icon"><i class="fas fa-puzzle-piece"></i></div>
                <div class="stat-number" data-target="<%= GetProblemsSolved() %>">0</div>
                <div class="stat-label">Problems Solved</div>
            </div>
            <div class="stat-box">
                <div class="stat-icon"><i class="fas fa-calendar-alt"></i></div>
                <div class="stat-number" data-target="<%= GetExperience() %>">0</div>
                <div class="stat-label">Years Experience</div>
            </div>
        </div>
    </div>
</section>