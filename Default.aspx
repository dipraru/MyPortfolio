<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="MyPortfolio.Default" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dipra Datta - Competitive Programmer</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700;800&family=Space+Grotesk:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            /* Dark mode variables */
            --primary: #00d9ff;
            --secondary: #7209b7;
            --accent: #f72585;
            --light: #ffffff;
            --dark: #0a0e27;
            --dark-secondary: #161b3d;
            --text-primary: #ffffff;
            --text-secondary: rgba(255, 255, 255, 0.8);
            --text-tertiary: rgba(255, 255, 255, 0.6);
            --bg-primary: #0a0e27;
            --bg-secondary: rgba(22, 27, 61, 0.7);
            --bg-tertiary: rgba(10, 14, 39, 0.5);
            --card-bg: rgba(22, 27, 61, 0.7);
            --border-color: rgba(0, 217, 255, 0.2);
            --gradient-1: linear-gradient(135deg, #00d9ff, #7209b7);
            --gradient-2: linear-gradient(135deg, #f72585, #b5179e);
            --gradient-3: linear-gradient(135deg, #7209b7, #3a0ca3);
        }

        /* Light mode variables with better colors */
        body.light-mode {
            --primary: #2563eb;
            --secondary: #7c3aed;
            --accent: #dc2626;
            --light: #ffffff;
            --dark: #f8fafc;
            --dark-secondary: #e2e8f0;
            --text-primary: #1e293b;
            --text-secondary: #475569;
            --text-tertiary: #64748b;
            --bg-primary: #ffffff;
            --bg-secondary: #f1f5f9;
            --bg-tertiary: #e2e8f0;
            --card-bg: #ffffff;
            --border-color: rgba(37, 99, 235, 0.15);
            --gradient-1: linear-gradient(135deg, #2563eb, #7c3aed);
            --gradient-2: linear-gradient(135deg, #dc2626, #b91c1c);
            --gradient-3: linear-gradient(135deg, #7c3aed, #6366f1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: var(--bg-primary);
            color: var(--text-primary);
            overflow-x: hidden;
            cursor: none;
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        /* Custom Cursor */
        .cursor {
            width: 20px;
            height: 20px;
            border: 2px solid var(--primary);
            border-radius: 50%;
            position: fixed;
            transform: translate(-50%, -50%);
            pointer-events: none;
            transition: all 0.1s ease;
            z-index: 9999;
            mix-blend-mode: difference;
        }

        .cursor-follower {
            width: 40px;
            height: 40px;
            background: rgba(0, 217, 255, 0.1);
            border-radius: 50%;
            position: fixed;
            transform: translate(-50%, -50%);
            pointer-events: none;
            transition: all 0.3s ease;
            z-index: 9998;
        }

        .cursor.hover {
            transform: translate(-50%, -50%) scale(1.5);
            background: var(--primary);
        }

        .cursor-follower.hover {
            transform: translate(-50%, -50%) scale(2);
            background: rgba(0, 217, 255, 0.2);
        }

        /* Theme Toggle - Integrated in Navbar */
        .theme-toggle {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            background: transparent;
            border: none;
            cursor: pointer;
            margin-left: 20px;
            transition: all 0.3s ease;
            border-radius: 50%;
        }

        .theme-toggle:hover {
            background: rgba(0, 217, 255, 0.1);
            transform: scale(1.1);
        }

        body.light-mode .theme-toggle:hover {
            background: rgba(37, 99, 235, 0.1);
        }

        .theme-toggle i {
            font-size: 1.2rem;
            color: var(--primary);
            transition: all 0.3s ease;
        }

        /* Scroll to Top Button */
        .scroll-top {
            position: fixed;
            bottom: 30px;
            right: 30px;
            width: 50px;
            height: 50px;
            background: var(--gradient-1);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            z-index: 1000;
            opacity: 0;
            visibility: hidden;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(0, 217, 255, 0.3);
        }

        .scroll-top.active {
            opacity: 1;
            visibility: visible;
        }

        .scroll-top:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 217, 255, 0.4);
        }

        .scroll-top i {
            color: var(--light);
            font-size: 1.2rem;
        }

        /* Animated Background */
        .bg-animation {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
            overflow: hidden;
        }

        .gradient-bg {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: radial-gradient(circle at 20% 50%, rgba(0, 217, 255, 0.1) 0%, transparent 50%),
                        radial-gradient(circle at 80% 80%, rgba(247, 37, 133, 0.1) 0%, transparent 50%),
                        radial-gradient(circle at 40% 20%, rgba(114, 9, 183, 0.1) 0%, transparent 50%);
            z-index: -1;
        }

        body.light-mode .gradient-bg {
            background: radial-gradient(circle at 20% 50%, rgba(37, 99, 235, 0.05) 0%, transparent 50%),
                        radial-gradient(circle at 80% 80%, rgba(220, 38, 38, 0.05) 0%, transparent 50%),
                        radial-gradient(circle at 40% 20%, rgba(124, 58, 237, 0.05) 0%, transparent 50%);
        }

        .particles {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
        }

        .particle {
            position: absolute;
            background: var(--primary);
            border-radius: 50%;
            opacity: 0.3;
            animation: float 15s infinite ease-in-out;
        }

        body.light-mode .particle {
            opacity: 0.2;
        }

        @keyframes float {
            0%, 100% {
                transform: translateY(0) translateX(0);
            }
            25% {
                transform: translateY(-20px) translateX(10px);
            }
            50% {
                transform: translateY(0) translateX(20px);
            }
            75% {
                transform: translateY(20px) translateX(10px);
            }
        }

        /* Animated Stickers/Illustrations */
        .illustration {
            position: absolute;
            opacity: 0.15;
            z-index: -1;
        }

        .code-block {
            top: 15%;
            left: 5%;
            width: 200px;
            height: 120px;
            background: rgba(0, 217, 255, 0.1);
            border: 2px solid var(--primary);
            border-radius: 10px;
            padding: 15px;
            font-family: 'Space Grotesk', monospace;
            font-size: 0.8rem;
            animation: floatCode 20s infinite ease-in-out;
        }

        body.light-mode .code-block {
            background: rgba(37, 99, 235, 0.05);
        }

        @keyframes floatCode {
            0%, 100% {
                transform: translateY(0) rotate(0deg);
            }
            25% {
                transform: translateY(-15px) rotate(2deg);
            }
            50% {
                transform: translateY(0) rotate(0deg);
            }
            75% {
                transform: translateY(15px) rotate(-2deg);
            }
        }

        .algorithm-circle {
            top: 65%;
            left: 85%;
            width: 180px;
            height: 180px;
            border: 3px solid var(--accent);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            animation: rotate 30s linear infinite;
        }

        @keyframes rotate {
            from {
                transform: rotate(0deg);
            }
            to {
                transform: rotate(360deg);
            }
        }

        .algorithm-circle::before {
            content: '';
            position: absolute;
            width: 150px;
            height: 150px;
            border: 2px dashed var(--primary);
            border-radius: 50%;
        }

        .algorithm-circle::after {
            content: 'O(log n)';
            font-family: 'Space Grotesk', monospace;
            font-weight: bold;
            color: var(--primary);
            font-size: 1.2rem;
        }

        .binary-tree {
            top: 35%;
            left: 75%;
            width: 150px;
            height: 150px;
            animation: floatTree 25s infinite ease-in-out;
        }

        @keyframes floatTree {
            0%, 100% {
                transform: translateY(0) rotate(0deg);
            }
            50% {
                transform: translateY(-20px) rotate(5deg);
            }
        }

        /* Header */
        header {
            position: fixed;
            top: 0;
            width: 100%;
            padding: 20px 50px;
            background: rgba(10, 14, 39, 0.8);
            backdrop-filter: blur(10px);
            z-index: 1000;
            transition: all 0.3s ease;
        }

        body.light-mode header {
            background: rgba(255, 255, 255, 0.9);
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }

        header.scrolled {
            padding: 15px 50px;
            background: rgba(10, 14, 39, 0.95);
            box-shadow: 0 5px 20px rgba(0, 217, 255, 0.2);
        }

        body.light-mode header.scrolled {
            background: rgba(255, 255, 255, 0.95);
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
        }

        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            max-width: 1200px;
            margin: 0 auto;
        }

        .logo {
            font-size: 1.8rem;
            font-weight: 800;
            background: var(--gradient-1);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 10px;
            font-family: 'Space Grotesk', sans-serif;
        }

        .logo i {
            font-size: 2rem;
            color: var(--primary);
        }

        .nav-container {
            display: flex;
            align-items: center;
        }

        .nav-links {
            display: flex;
            list-style: none;
            gap: 30px;
        }

        .nav-links a {
            color: var(--text-primary);
            text-decoration: none;
            font-weight: 500;
            position: relative;
            transition: color 0.3s ease;
            padding: 5px 0;
        }

        .nav-links a:hover {
            color: var(--primary);
        }

        .nav-links a::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 0;
            height: 2px;
            background: var(--gradient-1);
            transition: width 0.3s ease;
        }

        .nav-links a:hover::after {
            width: 100%;
        }

        .menu-toggle {
            display: none;
            flex-direction: column;
            cursor: pointer;
        }

        .menu-toggle span {
            width: 25px;
            height: 3px;
            background: var(--text-primary);
            margin: 3px 0;
            transition: 0.3s;
        }

        /* Hero Section - Redesigned */
        .hero {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 0 20px;
            position: relative;
            overflow: hidden;
        }

        .hero-container {
            max-width: 900px;
            width: 100%;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
            z-index: 2;
            margin-top: 80px;
            padding-bottom: 60px;
        }

        .profile-image {
            width: 220px;
            height: 220px;
            border-radius: 50%;
            border: 5px solid var(--primary);
            box-shadow: 0 0 30px rgba(0, 217, 255, 0.5);
            margin-bottom: 40px;
            position: relative;
            overflow: hidden;
            animation: pulse 2s infinite;
            z-index: 10;
        }

        @keyframes pulse {
            0% {
                box-shadow: 0 0 0 0 rgba(0, 217, 255, 0.7);
            }
            70% {
                box-shadow: 0 0 0 15px rgba(0, 217, 255, 0);
            }
            100% {
                box-shadow: 0 0 0 0 rgba(0, 217, 255, 0);
            }
        }

        .profile-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .hero-content {
            animation: fadeInUp 1s ease;
            z-index: 5;
        }

        .hero-content h1 {
            font-size: 3.5rem;
            font-weight: 800;
            margin-bottom: 15px;
            background: var(--gradient-1);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            line-height: 1.1;
        }

        .hero-content h2 {
            font-size: 1.8rem;
            font-weight: 600;
            color: var(--primary);
            margin-bottom: 20px;
        }

        .hero-content p {
            font-size: 1.2rem;
            line-height: 1.6;
            color: var(--text-secondary);
            margin-bottom: 40px;
            max-width: 700px;
        }

        .btn-group {
            display: flex;
            gap: 25px;
            justify-content: center;
            flex-wrap: wrap;
            margin-top: 20px;
        }

        /* Redesigned Buttons */
        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
            padding: 16px 36px;
            font-size: 1rem;
            font-weight: 600;
            text-decoration: none;
            border-radius: 50px;
            position: relative;
            overflow: hidden;
            z-index: 1;
            transition: all 0.4s ease;
            border: 2px solid transparent;
            background-clip: padding-box;
            min-width: 200px;
        }

        .btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: var(--gradient-1);
            z-index: -2;
            transition: all 0.4s ease;
        }

        .btn::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: var(--gradient-2);
            border-radius: 50px;
            opacity: 0;
            z-index: -1;
            transition: all 0.4s ease;
        }

        .btn-primary {
            color: var(--light);
            box-shadow: 0 4px 15px rgba(0, 217, 255, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 217, 255, 0.4);
        }

        .btn-primary::after {
            opacity: 1;
        }

        .btn-outline {
            color: var(--text-primary);
            background: transparent;
            border: 2px solid var(--primary);
        }

        .btn-outline::before {
            background: transparent;
        }

        .btn-outline:hover {
            color: var(--light);
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 217, 255, 0.4);
        }

        .btn-outline:hover::after {
            opacity: 1;
        }

        .btn i {
            font-size: 1.1rem;
        }

        /* Sections */
        section {
            padding: 120px 50px;
            max-width: 1200px;
            margin: 0 auto;
            position: relative;
        }

        .section-title {
            font-size: 3rem;
            font-weight: 700;
            margin-bottom: 60px;
            text-align: center;
            position: relative;
            display: inline-block;
            width: 100%;
            font-family: 'Space Grotesk', sans-serif;
        }

        .section-title::after {
            content: '';
            position: absolute;
            bottom: -15px;
            left: 50%;
            transform: translateX(-50%);
            width: 100px;
            height: 4px;
            background: var(--gradient-1);
            border-radius: 2px;
        }

        /* About Section - Redesigned */
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

        /* Skills Section */
        .skills-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 40px;
        }

        .skill-card {
            background: var(--card-bg);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 30px;
            text-align: center;
            transition: all 0.4s ease;
            border: 1px solid var(--border-color);
            position: relative;
            overflow: hidden;
        }

        .skill-card::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(0, 217, 255, 0.1) 0%, transparent 70%);
            opacity: 0;
            transition: opacity 0.5s ease;
        }

        body.light-mode .skill-card::before {
            background: radial-gradient(circle, rgba(37, 99, 235, 0.05) 0%, transparent 70%);
        }

        .skill-card:hover::before {
            opacity: 1;
        }

        .skill-card:hover {
            transform: translateY(-15px);
            box-shadow: 0 20px 40px rgba(0, 217, 255, 0.2);
            border-color: var(--primary);
        }

        .skill-icon {
            font-size: 3.5rem;
            margin-bottom: 20px;
            background: var(--gradient-1);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
        }

        .skill-name {
            font-size: 1.5rem;
            margin-bottom: 15px;
            font-weight: 600;
            font-family: 'Space Grotesk', sans-serif;
        }

        .skill-description {
            margin-bottom: 25px;
            line-height: 1.6;
            color: var(--text-secondary);
        }

        .skill-level {
            height: 10px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 5px;
            overflow: hidden;
            margin-top: 20px;
        }

        body.light-mode .skill-level {
            background: rgba(0, 0, 0, 0.1);
        }

        .skill-progress {
            height: 100%;
            background: var(--gradient-1);
            border-radius: 5px;
            animation: fillProgress 2s ease forwards;
        }

        @keyframes fillProgress {
            from {
                width: 0;
            }
        }

        /* Projects Section */
        .projects-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 40px;
        }

        .project-card {
            background: var(--card-bg);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            overflow: hidden;
            transition: all 0.4s ease;
            border: 1px solid var(--border-color);
            position: relative;
        }

        .project-card:hover {
            transform: translateY(-15px);
            box-shadow: 0 20px 40px rgba(0, 217, 255, 0.2);
        }

        .project-image {
            height: 220px;
            overflow: hidden;
            position: relative;
        }

        .project-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.7s ease;
        }

        .project-card:hover .project-image img {
            transform: scale(1.1);
        }

        .project-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 217, 255, 0.1);
            display: flex;
            align-items: center;
            justify-content: center;
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .project-card:hover .project-overlay {
            opacity: 1;
        }

        .project-links {
            display: flex;
            gap: 20px;
        }

        .project-links a {
            width: 50px;
            height: 50px;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--light);
            font-size: 1.2rem;
            transition: all 0.3s ease;
        }

        body.light-mode .project-links a {
            background: rgba(0, 0, 0, 0.1);
            color: var(--text-primary);
        }

        .project-links a:hover {
            background: var(--primary);
            transform: scale(1.1);
        }

        .project-info {
            padding: 30px;
        }

        .project-title {
            font-size: 1.5rem;
            margin-bottom: 15px;
            color: var(--primary);
            font-weight: 600;
            font-family: 'Space Grotesk', sans-serif;
        }

        .project-description {
            margin-bottom: 25px;
            line-height: 1.6;
            color: var(--text-secondary);
        }

        .project-tags {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-bottom: 25px;
        }

        .tag {
            background: rgba(0, 217, 255, 0.1);
            color: var(--primary);
            padding: 8px 15px;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 500;
        }

        body.light-mode .tag {
            background: rgba(37, 99, 235, 0.1);
        }

        /* Achievements Section */
        .achievements-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 40px;
        }

        .achievement-card {
            background: var(--card-bg);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 40px 30px;
            text-align: center;
            transition: all 0.4s ease;
            border: 1px solid var(--border-color);
            position: relative;
            overflow: hidden;
        }

        .achievement-card::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(247, 37, 133, 0.1) 0%, transparent 70%);
            opacity: 0;
            transition: opacity 0.5s ease;
        }

        body.light-mode .achievement-card::before {
            background: radial-gradient(circle, rgba(220, 38, 38, 0.05) 0%, transparent 70%);
        }

        .achievement-card:hover::before {
            opacity: 1;
        }

        .achievement-card:hover {
            transform: translateY(-15px);
            box-shadow: 0 20px 40px rgba(247, 37, 133, 0.2);
            border-color: var(--accent);
        }

        .achievement-icon {
            font-size: 4rem;
            margin-bottom: 25px;
            background: var(--gradient-2);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
        }

        .achievement-title {
            font-size: 1.5rem;
            margin-bottom: 15px;
            font-weight: 600;
            font-family: 'Space Grotesk', sans-serif;
        }

        .achievement-description {
            line-height: 1.6;
            color: var(--text-secondary);
        }

        /* Contact Section */
        .contact-container {
            display: flex;
            gap: 80px;
        }

        .contact-info {
            flex: 1;
        }

        .contact-item {
            display: flex;
            align-items: flex-start;
            margin-bottom: 30px;
        }

        .contact-icon {
            font-size: 1.8rem;
            margin-right: 20px;
            color: var(--primary);
            width: 50px;
            text-align: center;
        }

        .contact-text h3 {
            font-size: 1.3rem;
            margin-bottom: 5px;
            font-weight: 600;
        }

        .contact-text p {
            color: var(--text-secondary);
            line-height: 1.6;
        }

        .contact-form {
            flex: 1;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-group input,
        .form-group textarea {
            width: 100%;
            padding: 15px 20px;
            background: var(--bg-secondary);
            border: 1px solid var(--border-color);
            border-radius: 10px;
            color: var(--text-primary);
            font-family: 'Poppins', sans-serif;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .form-group input:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 15px rgba(0, 217, 255, 0.2);
        }

        .form-group textarea {
            resize: vertical;
            min-height: 150px;
        }

        .btn-submit {
            background: var(--gradient-1);
            color: white;
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
        }

        .btn-submit:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 217, 255, 0.4);
        }

        /* Footer */
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

        /* Animations */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .fade-in {
            opacity: 0;
            transform: translateY(50px);
            transition: all 0.8s ease;
        }

        .fade-in.visible {
            opacity: 1;
            transform: translateY(0);
        }

        /* Responsive */
        @media (max-width: 992px) {
            .about-container {
                grid-template-columns: 1fr;
            }
            
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }
            
            .achievements-grid {
                grid-template-columns: repeat(2, 1fr);
            }
            .contact-container {
                flex-direction: column;
            }
        }

        @media (max-width: 768px) {
            header {
                padding: 15px 20px;
            }
            .nav-links {
                position: fixed;
                top: 70px;
                left: 0;
                width: 100%;
                background: rgba(10, 14, 39, 0.95);
                backdrop-filter: blur(10px);
                flex-direction: column;
                align-items: center;
                padding: 20px 0;
                gap: 15px;
                transform: translateY(-150%);
                transition: transform 0.3s ease;
                z-index: 100;
            }
            
            body.light-mode .nav-links {
                background: rgba(255, 255, 255, 0.95);
            }
            
            .nav-links.active {
                transform: translateY(0);
            }
            .menu-toggle {
                display: flex;
            }
            .hero-content h1 {
                font-size: 2.5rem;
            }
            .hero-content h2 {
                font-size: 1.4rem;
            }
            .hero-content p {
                font-size: 1rem;
            }
            .profile-image {
                width: 180px;
                height: 180px;
            }
            .stats-grid {
                grid-template-columns: 1fr;
            }
            
            .achievements-grid {
                grid-template-columns: 1fr;
            }
            section {
                padding: 80px 20px;
            }
            .projects-container,
            .achievements-container {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 576px) {
            .hero-content h1 {
                font-size: 2rem;
            }
            .hero-content h2 {
                font-size: 1.2rem;
            }
            .btn-group {
                flex-direction: column;
                gap: 15px;
            }
            .btn {
                width: 100%;
            }
        }

        /* Additional fixes for larger screens */
        @media (min-width: 992px) {
            .hero-container {
                margin-top: 120px;
            }
        }

        @media (min-width: 1200px) {
            .hero-container {
                margin-top: 140px;
            }
        }
    </style>
</head>
<body>
    <!-- Custom Cursor -->
    <div class="cursor"></div>
    <div class="cursor-follower"></div>
    
    <!-- Scroll to Top Button -->
    <div class="scroll-top" id="scrollTop">
        <i class="fas fa-arrow-up"></i>
    </div>
    
    <!-- Animated Background -->
    <div class="bg-animation">
        <div class="gradient-bg"></div>
        <div class="particles" id="particles"></div>
        
        <!-- Custom Illustrations -->
        <div class="illustration code-block">
            <div style="color: var(--primary);">function solve() {</div>
            <div style="color: var(--accent); margin-left: 15px;">return optimal;</div>
            <div style="color: var(--primary);">}</div>
        </div>
        
        <div class="illustration algorithm-circle"></div>
        
        <div class="illustration binary-tree">
            <svg viewBox="0 0 150 150" xmlns="http://www.w3.org/2000/svg">
                <circle cx="75" cy="30" r="15" fill="none" stroke="var(--primary)" stroke-width="2"/>
                <circle cx="45" cy="70" r="15" fill="none" stroke="var(--primary)" stroke-width="2"/>
                <circle cx="105" cy="70" r="15" fill="none" stroke="var(--primary)" stroke-width="2"/>
                <circle cx="30" cy="110" r="15" fill="none" stroke="var(--primary)" stroke-width="2"/>
                <circle cx="60" cy="110" r="15" fill="none" stroke="var(--primary)" stroke-width="2"/>
                <circle cx="90" cy="110" r="15" fill="none" stroke="var(--primary)" stroke-width="2"/>
                <circle cx="120" cy="110" r="15" fill="none" stroke="var(--primary)" stroke-width="2"/>
                
                <line x1="75" y1="45" x2="45" y2="55" stroke="var(--primary)" stroke-width="2"/>
                <line x1="75" y1="45" x2="105" y2="55" stroke="var(--primary)" stroke-width="2"/>
                <line x1="45" y1="85" x2="30" y2="95" stroke="var(--primary)" stroke-width="2"/>
                <line x1="45" y1="85" x2="60" y2="95" stroke="var(--primary)" stroke-width="2"/>
                <line x1="105" y1="85" x2="90" y2="95" stroke="var(--primary)" stroke-width="2"/>
                <line x1="105" y1="85" x2="120" y2="95" stroke="var(--primary)" stroke-width="2"/>
            </svg>
        </div>
    </div>
    
    <!-- Header -->
    <header id="header">
        <div class="navbar">
            <a href="#" class="logo">
                <i class="fas fa-terminal"></i>
                Dipra Datta
            </a>
            <div class="nav-container">
                <ul class="nav-links" id="navLinks">
                    <li><a href="#home">Home</a></li>
                    <li><a href="#about">About</a></li>
                    <li><a href="#skills">Skills</a></li>
                    <li><a href="#projects">Projects</a></li>
                    <li><a href="#achievements">Achievements</a></li>
                    <li><a href="#contact">Contact</a></li>
                </ul>
                <button class="theme-toggle" id="themeToggle">
                    <i class="fas fa-moon" id="themeIcon"></i>
                </button>
            </div>
            <div class="menu-toggle" id="menuToggle">
                <span></span>
                <span></span>
                <span></span>
            </div>
        </div>
    </header>
    
    <!-- Hero Section - Clean and Professional -->
    <section class="hero" id="home">
        <div class="hero-container">
            <div class="profile-image">
                <img src="https://scontent.fdac181-1.fna.fbcdn.net/v/t39.30808-6/512737205_2674645019593706_2103932344706277446_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=6ee11a&_nc_eui2=AeGiw0FoWbNuPKyEV4in58VG1YiIDKq91a7ViIgMqr3VrnBWzdU5skPg64wZvUZJa-0x30_bUq21urc40eJgPnRc&_nc_ohc=08W65sogl0IQ7kNvwGgV38i&_nc_oc=AdnaFsa6g98NYyFwHaVago1tFE3Uukak2FZyHIr37lQZ_wVZaEmuUSl_YQSn9zx1CtU&_nc_zt=23&_nc_ht=scontent.fdac181-1.fna&_nc_gid=jxx4oE6mbIxnx1Y_XM7vKA&oh=00_AfZSDboJaWWaVKFgambkW9xp-VQvQS42tXKAgrglp2D7nA&oe=68BE5F51" alt="Dipra Datta">
            </div>
            <div class="hero-content">
                <h1>Dipra Datta</h1>
                <h2>Competitive Programmer</h2>
                <p>BSc. in CSE at KUET | Algorithm Enthusiast | Problem Solver</p>
                <div class="btn-group">
                    <a href="#projects" class="btn btn-primary">
                        <i class="fas fa-code-branch"></i>
                        View My Work
                    </a>
                    <a href="#contact" class="btn btn-outline">
                        <i class="fas fa-envelope"></i>
                        Get In Touch
                    </a>
                </div>
            </div>
        </div>
    </section>
    
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
    
    <!-- Skills Section -->
    <section id="skills" class="fade-in">
        <h2 class="section-title">Technical Expertise</h2>
        <div class="skills-container">
            <div class="skill-card">
                <div class="skill-icon"><i class="fas fa-code"></i></div>
                <h3 class="skill-name">C++</h3>
                <p class="skill-description">Primary language for competitive programming with deep understanding of STL and advanced features</p>
                <div class="skill-level">
                    <div class="skill-progress" style="width: 95%;"></div>
                </div>
            </div>
            <div class="skill-card">
                <div class="skill-icon"><i class="fab fa-python"></i></div>
                <h3 class="skill-name">Python</h3>
                <p class="skill-description">Proficient in Python for rapid prototyping and scripting solutions</p>
                <div class="skill-level">
                    <div class="skill-progress" style="width: 85%;"></div>
                </div>
            </div>
            <div class="skill-card">
                <div class="skill-icon"><i class="fas fa-project-diagram"></i></div>
                <h3 class="skill-name">Algorithms</h3>
                <p class="skill-description">Strong foundation in graph theory, dynamic programming, and advanced algorithms</p>
                <div class="skill-level">
                    <div class="skill-progress" style="width: 90%;"></div>
                </div>
            </div>
            <div class="skill-card">
                <div class="skill-icon"><i class="fas fa-database"></i></div>
                <h3 class="skill-name">Data Structures</h3>
                <p class="skill-description">Expert implementation and optimization of complex data structures</p>
                <div class="skill-level">
                    <div class="skill-progress" style="width: 92%;"></div>
                </div>
            </div>
            <div class="skill-card">
                <div class="skill-icon"><i class="fas fa-calculator"></i></div>
                <h3 class="skill-name">Mathematics</h3>
                <p class="skill-description">Strong mathematical foundation for solving complex problems</p>
                <div class="skill-level">
                    <div class="skill-progress" style="width: 88%;"></div>
                </div>
            </div>
            <div class="skill-card">
                <div class="skill-icon"><i class="fas fa-code-branch"></i></div>
                <h3 class="skill-name">Version Control</h3>
                <p class="skill-description">Proficient with Git and collaborative development workflows</p>
                <div class="skill-level">
                    <div class="skill-progress" style="width: 80%;"></div>
                </div>
            </div>
        </div>
    </section>
    
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
    
    <!-- Achievements Section -->
    <section id="achievements" class="fade-in">
        <h2 class="section-title">Competitive Achievements</h2>
        <div class="achievements-container">
            <div class="achievement-card">
                <div class="achievement-icon"><i class="fas fa-trophy"></i></div>
                <h3 class="achievement-title">ICPC Dhaka Regional</h3>
                <p class="achievement-description">Achieved 32nd rank in the prestigious ICPC Dhaka Regional contest, competing against top teams from Bangladesh.</p>
            </div>
            <div class="achievement-card">
                <div class="achievement-icon"><i class="fas fa-medal"></i></div>
                <h3 class="achievement-title">UIU IUPC 2025</h3>
                <p class="achievement-description">Secured 7th position in UIU Inter-University Programming Contest 2025, demonstrating strong problem-solving skills.</p>
            </div>
            <div class="achievement-card">
                <div class="achievement-icon"><i class="fas fa-award"></i></div>
                <h3 class="achievement-title">UU IUPC 2025</h3>
                <p class="achievement-description">Achieved 13th rank in UU Inter-University Programming Contest 2025, competing against talented programmers.</p>
            </div>
            <div class="achievement-card">
                <div class="achievement-icon"><i class="fas fa-star"></i></div>
                <h3 class="achievement-title">Codeforces Expert</h3>
                <p class="achievement-description">Reached Expert level on Codeforces with a maximum rating of 1771, solving over 1200 problems on the platform.</p>
            </div>
            <div class="achievement-card">
                <div class="achievement-icon"><i class="fas fa-certificate"></i></div>
                <h3 class="achievement-title">Codechef 4-Star</h3>
                <p class="achievement-description">Achieved 4-star rating on Codechef with a rating of 1913, consistently performing in monthly challenges.</p>
            </div>
            <div class="achievement-card">
                <div class="achievement-icon"><i class="fas fa-puzzle-piece"></i></div>
                <h3 class="achievement-title">Problem Solving Prodigy</h3>
                <p class="achievement-description">Solved over 1676 problems across various online judges including Codeforces, Vjudge, and LightOJ.</p>
            </div>
        </div>
    </section>
    
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
    
    <script>
        // Custom Cursor
        const cursor = document.querySelector('.cursor');
        const cursorFollower = document.querySelector('.cursor-follower');
        document.addEventListener('mousemove', (e) => {
            cursor.style.left = e.clientX + 'px';
            cursor.style.top = e.clientY + 'px';

            setTimeout(() => {
                cursorFollower.style.left = e.clientX + 'px';
                cursorFollower.style.top = e.clientY + 'px';
            }, 100);
        });

        // Cursor hover effects
        const hoverElements = document.querySelectorAll('a, button, .btn, .project-card, .skill-card, .achievement-card, .stat-box, .achievement-box, .about-card, .theme-toggle, .scroll-top');

        hoverElements.forEach(element => {
            element.addEventListener('mouseenter', () => {
                cursor.classList.add('hover');
                cursorFollower.classList.add('hover');
            });

            element.addEventListener('mouseleave', () => {
                cursor.classList.remove('hover');
                cursorFollower.classList.remove('hover');
            });
        });

        // Theme Toggle
        const themeToggle = document.getElementById('themeToggle');
        const themeIcon = document.getElementById('themeIcon');
        const body = document.body;

        // Check for saved theme preference or default to dark mode
        const currentTheme = localStorage.getItem('theme') || 'dark';
        if (currentTheme === 'light') {
            body.classList.add('light-mode');
            themeIcon.classList.remove('fa-moon');
            themeIcon.classList.add('fa-sun');
        }

        themeToggle.addEventListener('click', () => {
            body.classList.toggle('light-mode');

            if (body.classList.contains('light-mode')) {
                themeIcon.classList.remove('fa-moon');
                themeIcon.classList.add('fa-sun');
                localStorage.setItem('theme', 'light');
            } else {
                themeIcon.classList.remove('fa-sun');
                themeIcon.classList.add('fa-moon');
                localStorage.setItem('theme', 'dark');
            }
        });

        // Scroll to Top Button
        const scrollTopBtn = document.getElementById('scrollTop');

        window.addEventListener('scroll', () => {
            if (window.pageYOffset > 300) {
                scrollTopBtn.classList.add('active');
            } else {
                scrollTopBtn.classList.remove('active');
            }
        });

        scrollTopBtn.addEventListener('click', () => {
            window.scrollTo({
                top: 0,
                behavior: 'smooth'
            });
        });

        // Mobile Menu Toggle
        const menuToggle = document.getElementById('menuToggle');
        const navLinks = document.getElementById('navLinks');
        menuToggle.addEventListener('click', () => {
            navLinks.classList.toggle('active');
        });

        // Close mobile menu when clicking on a link
        document.querySelectorAll('.nav-links a').forEach(link => {
            link.addEventListener('click', () => {
                navLinks.classList.remove('active');
            });
        });

        // Header scroll effect
        window.addEventListener('scroll', () => {
            const header = document.getElementById('header');
            if (window.scrollY > 50) {
                header.classList.add('scrolled');
            } else {
                header.classList.remove('scrolled');
            }
        });

        // Smooth scrolling
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                document.querySelector(this.getAttribute('href')).scrollIntoView({
                    behavior: 'smooth'
                });
            });
        });

        // Fade in animation on scroll
        const fadeElements = document.querySelectorAll('.fade-in');
        const fadeInOnScroll = () => {
            fadeElements.forEach(element => {
                const elementTop = element.getBoundingClientRect().top;
                const elementVisible = 150;

                if (elementTop < window.innerHeight - elementVisible) {
                    element.classList.add('visible');
                }
            });
        };
        window.addEventListener('scroll', fadeInOnScroll);
        fadeInOnScroll(); // Check on initial load

        // Form submission
        document.getElementById('contactForm').addEventListener('submit', function (e) {
            e.preventDefault();

            // Create a success message
            const successMessage = document.createElement('div');
            successMessage.style.position = 'fixed';
            successMessage.style.top = '50%';
            successMessage.style.left = '50%';
            successMessage.style.transform = 'translate(-50%, -50%)';
            successMessage.style.background = 'rgba(0, 217, 255, 0.9)';
            successMessage.style.color = 'white';
            successMessage.style.padding = '30px 50px';
            successMessage.style.borderRadius = '15px';
            successMessage.style.zIndex = '10000';
            successMessage.style.boxShadow = '0 15px 35px rgba(0, 217, 255, 0.4)';
            successMessage.style.textAlign = 'center';
            successMessage.style.fontSize = '1.2rem';
            successMessage.style.fontWeight = '600';
            successMessage.innerHTML = '<i class="fas fa-check-circle" style="font-size: 3rem; margin-bottom: 15px; display: block;"></i> Message sent successfully!';

            document.body.appendChild(successMessage);

            // Reset form
            this.reset();

            // Remove success message after 3 seconds
            setTimeout(() => {
                successMessage.style.opacity = '0';
                successMessage.style.transition = 'opacity 0.5s ease';
                setTimeout(() => {
                    document.body.removeChild(successMessage);
                }, 500);
            }, 3000);
        });

        // Counter Animation
        const counters = document.querySelectorAll('.stat-number');
        const speed = 200;
        const countUp = () => {
            counters.forEach(counter => {
                const target = +counter.getAttribute('data-target');
                const count = +counter.innerText;
                const inc = target / speed;
                if (count < target) {
                    counter.innerText = Math.ceil(count + inc);
                    setTimeout(countUp, 10);
                } else {
                    counter.innerText = target;
                }
            });
        };

        // Trigger counter animation when stats section is visible
        const statsSection = document.querySelector('.stats-grid');
        const statsObserver = new IntersectionObserver((entries) => {
            if (entries[0].isIntersecting) {
                countUp();
                statsObserver.unobserve(statsSection);
            }
        }, { threshold: 0.5 });

        if (statsSection) {
            statsObserver.observe(statsSection);
        }

        // Create particles
        const particlesContainer = document.getElementById('particles');
        const particleCount = 30;

        for (let i = 0; i < particleCount; i++) {
            const particle = document.createElement('div');
            particle.classList.add('particle');

            // Random size between 5px and 15px
            const size = Math.random() * 10 + 5;
            particle.style.width = `${size}px`;
            particle.style.height = `${size}px`;

            // Random position
            particle.style.left = `${Math.random() * 100}%`;
            particle.style.top = `${Math.random() * 100}%`;

            // Random animation duration between 10s and 25s
            particle.style.animationDuration = `${Math.random() * 15 + 10}s`;

            // Random animation delay
            particle.style.animationDelay = `${Math.random() * 5}s`;

            particlesContainer.appendChild(particle);
        }
    </script>
</body>
</html>