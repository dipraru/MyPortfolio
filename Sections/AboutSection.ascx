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
                        <p>3 years in Competitive Programming</p>
                    </div>
                </li>
                <li>
                    <div class="about-icon">
                        <i class="fab fa-codeforces"></i>
                    </div>
                    <div class="about-info">
                        <h4>Codeforces</h4>
                        <p>Max Rating: 1771 (Expert)</p>
                    </div>
                </li>
                <li>
                    <div class="about-icon">
                        <i class="fas fa-utensils"></i>
                    </div>
                    <div class="about-info">
                        <h4>Codechef</h4>
                        <p>Rating: 1913 (4-star)</p>
                    </div>
                </li>
                <li>
                    <div class="about-icon">
                        <i class="fas fa-puzzle-piece"></i>
                    </div>
                    <div class="about-info">
                        <h4>Problems Solved</h4>
                        <p>1676+ across multiple platforms</p>
                    </div>
                </li>
            </ul>
        </div>
    </div>
    <div class="about-card">
        <h3><i class="fas fa-trophy"></i> Competition Achievements</h3>
        <div class="achievements-grid">
            <div class="achievement-box">
                <div class="achievement-position">32</div>
                <div class="achievement-info">
                    <h4>ICPC Dhaka Regional</h4>
                    <p>Regional Contest</p>
                </div>
            </div>
            <div class="achievement-box">
                <div class="achievement-position">7</div>
                <div class="achievement-info">
                    <h4>UIU IUPC 2025</h4>
                    <p>Inter University Programming Contest</p>
                </div>
            </div>
            <div class="achievement-box">
                <div class="achievement-position">13</div>
                <div class="achievement-info">
                    <h4>UU IUPC 2025</h4>
                    <p>Inter University Programming Contest</p>
                </div>
            </div>
            <div class="achievement-box">
                <div class="achievement-position">28</div>
                <div class="achievement-info">
                    <h4>BUET IUPC 2024</h4>
                    <p>Inter University Programming Contest</p>
                </div>
            </div>
            <div class="achievement-box">
                <div class="achievement-position">41</div>
                <div class="achievement-info">
                    <h4>CUET IUPC 2024</h4>
                    <p>Inter University Programming Contest</p>
                </div>
            </div>
            <div class="achievement-box">
                <div class="achievement-position">28</div>
                <div class="achievement-info">
                    <h4>KUET IUPC 2025</h4>
                    <p>Inter University Programming Contest</p>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Enhanced Stats Section -->
    <div class="stats-section">
        <div class="stats-illustrations">
            <div class="stats-code">
                <div style="color: var(--primary);">int rating =</div>
                <div style="color: var(--accent);">1771;</div>
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
                <div class="stat-number" data-target="1771">0</div>
                <div class="stat-label">Codeforces Rating</div>
            </div>
            <div class="stat-box">
                <div class="stat-icon"><i class="fas fa-star"></i></div>
                <div class="stat-number" data-target="1913">0</div>
                <div class="stat-label">Codechef Rating</div>
            </div>
            <div class="stat-box">
                <div class="stat-icon"><i class="fas fa-puzzle-piece"></i></div>
                <div class="stat-number" data-target="1676">0</div>
                <div class="stat-label">Problems Solved</div>
            </div>
            <div class="stat-box">
                <div class="stat-icon"><i class="fas fa-calendar-alt"></i></div>
                <div class="stat-number" data-target="3">0</div>
                <div class="stat-label">Years Experience</div>
            </div>
        </div>
    </div>
</section>

<style>
/* About Section Styles */
.about-container {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 50px;
    margin-bottom: 50px;
}

.about-card {
    background: var(--card-bg);
    backdrop-filter: blur(10px);
    border-radius: 20px;
    padding: 30px;
    border: 1px solid var(--border-color);
    transition: all 0.3s ease;
}

.about-card:hover {
    transform: translateY(-10px);
    box-shadow: 0 15px 30px rgba(0, 217, 255, 0.2);
    border-color: var(--primary);
}

.about-card h3 {
    font-size: 1.5rem;
    margin-bottom: 20px;
    color: var(--primary);
    display: flex;
    align-items: center;
    gap: 10px;
}

.about-card ul {
    list-style: none;
}

.about-card li {
    display: flex;
    align-items: center;
    gap: 15px;
    padding: 12px 0;
    border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

body.light-mode .about-card li {
    border-bottom: 1px solid rgba(0, 0, 0, 0.1);
}

.about-card li:last-child {
    border-bottom: none;
}

.about-icon {
    width: 40px;
    height: 40px;
    background: rgba(0, 217, 255, 0.1);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    color: var(--primary);
}

body.light-mode .about-icon {
    background: rgba(37, 99, 235, 0.1);
}

.about-info h4 {
    font-size: 1.1rem;
    margin-bottom: 5px;
}

.about-info p {
    font-size: 0.9rem;
    color: var(--text-tertiary);
}

/* Enhanced Stats Grid */
.stats-section {
    position: relative;
    padding: 80px 0;
    margin-top: 50px;
}

.stats-illustrations {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    pointer-events: none;
    z-index: -1;
}

.stats-code {
    position: absolute;
    top: 10%;
    left: 5%;
    width: 180px;
    height: 100px;
    background: rgba(0, 217, 255, 0.05);
    border: 1px solid var(--primary);
    border-radius: 8px;
    padding: 10px;
    font-family: 'Space Grotesk', monospace;
    font-size: 0.7rem;
    animation: floatStats 15s infinite ease-in-out;
}

body.light-mode .stats-code {
    background: rgba(37, 99, 235, 0.05);
}

@keyframes floatStats {
    0%, 100% {
        transform: translateY(0) rotate(-1deg);
    }
    50% {
        transform: translateY(-15px) rotate(1deg);
    }
}

.stats-algo {
    position: absolute;
    top: 60%;
    right: 5%;
    width: 120px;
    height: 120px;
    animation: rotateStats 25s linear infinite;
}

@keyframes rotateStats {
    from {
        transform: rotate(0deg);
    }
    to {
        transform: rotate(360deg);
    }
}

.stats-algo svg {
    width: 100%;
    height: 100%;
}

.stats-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 30px;
    position: relative;
    z-index: 1;
}

.stat-box {
    background: var(--bg-tertiary);
    border-radius: 20px;
    padding: 30px;
    text-align: center;
    transition: all 0.4s ease;
    border: 1px solid var(--border-color);
    position: relative;
    overflow: hidden;
}

.stat-box::before {
    content: '';
    position: absolute;
    top: -50%;
    left: -50%;
    width: 200%;
    height: 200%;
    background: radial-gradient(circle, rgba(0, 217, 255, 0.05) 0%, transparent 70%);
    opacity: 0;
    transition: opacity 0.5s ease;
}

body.light-mode .stat-box::before {
    background: radial-gradient(circle, rgba(37, 99, 235, 0.03) 0%, transparent 70%);
}

.stat-box:hover::before {
    opacity: 1;
}

.stat-box:hover {
    transform: translateY(-10px) scale(1.02);
    box-shadow: 0 15px 35px rgba(0, 217, 255, 0.15);
    border-color: var(--primary);
}

.stat-icon {
    font-size: 2.5rem;
    margin-bottom: 20px;
    background: var(--gradient-1);
    -webkit-background-clip: text;
    background-clip: text;
    color: transparent;
    display: inline-block;
    animation: iconPulse 2s infinite;
}

@keyframes iconPulse {
    0%, 100% {
        transform: scale(1);
    }
    50% {
        transform: scale(1.1);
    }
}

.stat-number {
    font-size: 3rem;
    font-weight: 800;
    background: var(--gradient-1);
    -webkit-background-clip: text;
    background-clip: text;
    color: transparent;
    margin-bottom: 10px;
    line-height: 1;
}

.stat-label {
    font-size: 1.1rem;
    color: var(--text-secondary);
    font-weight: 500;
}

.achievements-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 20px;
}

.achievement-box {
    background: var(--bg-tertiary);
    border-radius: 15px;
    padding: 20px;
    display: flex;
    align-items: center;
    gap: 15px;
    transition: all 0.3s ease;
    border: 1px solid rgba(255, 255, 255, 0.1);
}

body.light-mode .achievement-box {
    border: 1px solid rgba(0, 0, 0, 0.1);
}

.achievement-box:hover {
    transform: translateY(-5px);
    border-color: var(--primary);
}

.achievement-position {
    width: 50px;
    height: 50px;
    background: var(--gradient-1);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: 700;
    font-size: 1.2rem;
}

.achievement-info h4 {
    font-size: 1rem;
    margin-bottom: 5px;
}

.achievement-info p {
    font-size: 0.8rem;
    color: var(--text-tertiary);
}
</style>