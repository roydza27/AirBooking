<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AirBooking - Your Journey Begins Here</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        /* Landing Page Specific Styles */
        .landing-page {
            min-height: 100vh;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            overflow-x: hidden;
        }

        /* Hero Section */
        .hero-section {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            position: relative;
            padding: 20px;
        }

        .hero-content {
            position: relative;
            z-index: 10;
            animation: fadeInUp 1s ease-out;
        }

        .hero-title {
            font-size: 4rem;
            color: white;
            font-weight: 800;
            margin-bottom: 20px;
            text-shadow: 0 4px 20px rgba(0,0,0,0.3);
            line-height: 1.2;
        }

        .hero-title .highlight {
            color: #ffd700;
            display: inline-block;
            animation: pulse 2s infinite;
        }

        .hero-subtitle {
            font-size: 1.5rem;
            color: rgba(255, 255, 255, 0.95);
            margin-bottom: 40px;
            font-weight: 300;
        }

        .cta-buttons {
            display: flex;
            gap: 20px;
            justify-content: center;
            flex-wrap: wrap;
        }

        .cta-btn {
            padding: 18px 40px;
            font-size: 1.1rem;
            border: none;
            border-radius: 50px;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 10px;
        }

        .cta-primary {
            background: white;
            color: #667eea;
            box-shadow: 0 8px 20px rgba(0,0,0,0.2);
        }

        .cta-primary:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 30px rgba(0,0,0,0.3);
        }

        .cta-secondary {
            background: transparent;
            color: white;
            border: 2px solid white;
        }

        .cta-secondary:hover {
            background: white;
            color: #667eea;
            transform: translateY(-5px);
        }

        /* Animated Background Elements */
        .floating-planes {
            position: absolute;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            pointer-events: none;
            overflow: hidden;
        }

        .plane {
            position: absolute;
            font-size: 3rem;
            opacity: 0.1;
            animation: float 20s infinite ease-in-out;
        }

        .plane:nth-child(1) { top: 10%; left: -10%; animation-delay: 0s; }
        .plane:nth-child(2) { top: 30%; left: -10%; animation-delay: 5s; }
        .plane:nth-child(3) { top: 50%; left: -10%; animation-delay: 10s; }
        .plane:nth-child(4) { top: 70%; left: -10%; animation-delay: 15s; }

        /* Features Section */
        .features-section {
            padding: 80px 20px;
            background: white;
        }

        .section-title {
            text-align: center;
            font-size: 2.5rem;
            color: #333;
            margin-bottom: 20px;
            font-weight: 700;
        }

        .section-subtitle {
            text-align: center;
            font-size: 1.2rem;
            color: #666;
            margin-bottom: 60px;
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 40px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .feature-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 40px 30px;
            border-radius: 20px;
            text-align: center;
            transition: all 0.3s ease;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            position: relative;
            overflow: hidden;
        }

        .feature-card::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
            transform: scale(0);
            transition: transform 0.6s ease;
        }

        .feature-card:hover::before {
            transform: scale(1);
        }

        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 40px rgba(102, 126, 234, 0.4);
        }

        .feature-icon {
            font-size: 4rem;
            margin-bottom: 20px;
            display: inline-block;
            animation: bounce 2s infinite;
        }

        .feature-title {
            font-size: 1.5rem;
            color: white;
            margin-bottom: 15px;
            font-weight: 600;
        }

        .feature-description {
            color: rgba(255, 255, 255, 0.9);
            line-height: 1.6;
            font-size: 1rem;
        }

        /* Stats Section */
        .stats-section {
            padding: 80px 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 40px;
            max-width: 1000px;
            margin: 0 auto;
            text-align: center;
        }

        .stat-item {
            padding: 20px;
        }

        .stat-number {
            font-size: 3.5rem;
            font-weight: 800;
            color: #ffd700;
            margin-bottom: 10px;
            display: block;
        }

        .stat-label {
            font-size: 1.2rem;
            color: rgba(255, 255, 255, 0.9);
        }

        /* How It Works Section */
        .how-it-works {
            padding: 80px 20px;
            background: #f8f9fa;
        }

        .steps-container {
            max-width: 1000px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 30px;
        }

        .step {
            flex: 1;
            min-width: 220px;
            text-align: center;
            position: relative;
        }

        .step-number {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            font-weight: 700;
            margin: 0 auto 20px;
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
        }

        .step-title {
            font-size: 1.3rem;
            color: #333;
            margin-bottom: 10px;
            font-weight: 600;
        }

        .step-description {
            color: #666;
            line-height: 1.6;
        }

        /* Footer CTA */
        .footer-cta {
            padding: 80px 20px;
            background: linear-gradient(135deg, #764ba2 0%, #667eea 100%);
            text-align: center;
            color: white;
        }

        .footer-cta h2 {
            font-size: 2.5rem;
            margin-bottom: 20px;
            font-weight: 700;
        }

        .footer-cta p {
            font-size: 1.2rem;
            margin-bottom: 40px;
            color: rgba(255, 255, 255, 0.9);
        }

        /* Animations */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }

        @keyframes float {
            0% {
                transform: translateX(-10%) translateY(0) rotate(0deg);
                opacity: 0;
            }
            50% {
                opacity: 0.15;
            }
            100% {
                transform: translateX(110%) translateY(-50px) rotate(360deg);
                opacity: 0;
            }
        }

        @keyframes bounce {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .hero-title {
                font-size: 2.5rem;
            }

            .hero-subtitle {
                font-size: 1.2rem;
            }

            .cta-buttons {
                flex-direction: column;
                align-items: center;
            }

            .cta-btn {
                width: 100%;
                max-width: 300px;
            }

            .section-title {
                font-size: 2rem;
            }

            .stat-number {
                font-size: 2.5rem;
            }
        }

        /* Smooth Scroll */
        html {
            scroll-behavior: smooth;
        }
    </style>
</head>
<body class="landing-page">
    <!-- Hero Section -->
    <section class="hero-section">
        <div class="floating-planes">
            <div class="plane">✈️</div>
            <div class="plane">✈️</div>
            <div class="plane">✈️</div>
            <div class="plane">✈️</div>
        </div>

        <div class="hero-content">
            <h1 class="hero-title">
                Welcome to <span class="highlight">AirBooking</span>
            </h1>
            <p class="hero-subtitle">
                Your Journey to the Skies Starts Here<br>
                Book. Fly. Explore. ✨
            </p>
            <div class="cta-buttons">
                <a href="login.jsp" class="cta-btn cta-primary">
                    🚀 Get Started
                </a>
                <a href="register.jsp" class="cta-btn cta-secondary">
                    📝 Sign Up Free
                </a>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section class="features-section">
        <h2 class="section-title">Why Choose AirBooking?</h2>
        <p class="section-subtitle">Experience the future of flight booking</p>

        <div class="features-grid">
            <div class="feature-card">
                <div class="feature-icon">🔍</div>
                <h3 class="feature-title">Smart Search</h3>
                <p class="feature-description">
                    Find the perfect flight with our intelligent search system. 
                    Filter by date, route, and price instantly.
                </p>
            </div>

            <div class="feature-card">
                <div class="feature-icon">⚡</div>
                <h3 class="feature-title">Instant Booking</h3>
                <p class="feature-description">
                    Book your flight in seconds with our streamlined checkout process. 
                    No hassle, no delays.
                </p>
            </div>

            <div class="feature-card">
                <div class="feature-icon">🎫</div>
                <h3 class="feature-title">Digital Tickets</h3>
                <p class="feature-description">
                    Get instant digital tickets with unique booking IDs. 
                    Download and manage all your bookings easily.
                </p>
            </div>

            <div class="feature-card">
                <div class="feature-icon">💰</div>
                <h3 class="feature-title">Best Prices</h3>
                <p class="feature-description">
                    Enjoy competitive pricing with exclusive promo codes. 
                    Save up to 10% on your bookings!
                </p>
            </div>

            <div class="feature-card">
                <div class="feature-icon">🛡️</div>
                <h3 class="feature-title">Secure Booking</h3>
                <p class="feature-description">
                    Your data is protected with enterprise-grade security. 
                    Book with confidence and peace of mind.
                </p>
            </div>

            <div class="feature-card">
                <div class="feature-icon">📱</div>
                <h3 class="feature-title">Easy Management</h3>
                <p class="feature-description">
                    View, modify, and cancel bookings anytime. 
                    Complete control at your fingertips.
                </p>
            </div>
        </div>
    </section>

    <!-- Stats Section -->
    <section class="stats-section">
        <h2 class="section-title">Trusted by Thousands</h2>
        <div class="stats-grid">
            <div class="stat-item">
                <span class="stat-number">10K+</span>
                <span class="stat-label">Happy Travelers</span>
            </div>
            <div class="stat-item">
                <span class="stat-number">50+</span>
                <span class="stat-label">Destinations</span>
            </div>
            <div class="stat-item">
                <span class="stat-number">100+</span>
                <span class="stat-label">Daily Flights</span>
            </div>
            <div class="stat-item">
                <span class="stat-number">4.9★</span>
                <span class="stat-label">User Rating</span>
            </div>
        </div>
    </section>

    <!-- How It Works Section -->
    <section class="how-it-works">
        <h2 class="section-title">How It Works</h2>
        <p class="section-subtitle">Book your flight in 3 simple steps</p>

        <div class="steps-container">
            <div class="step">
                <div class="step-number">1</div>
                <h3 class="step-title">Search Flights</h3>
                <p class="step-description">
                    Enter your departure city, destination, and travel date 
                    to find available flights.
                </p>
            </div>

            <div class="step">
                <div class="step-number">2</div>
                <h3 class="step-title">Select & Book</h3>
                <p class="step-description">
                    Choose your preferred flight, select the number of seats, 
                    and confirm your booking.
                </p>
            </div>

            <div class="step">
                <div class="step-number">3</div>
                <h3 class="step-title">Get Your Ticket</h3>
                <p class="step-description">
                    Receive instant confirmation with your unique booking ID 
                    and downloadable ticket.
                </p>
            </div>
        </div>
    </section>

    <!-- Footer CTA -->
    <section class="footer-cta">
        <h2>Ready to Take Off?</h2>
        <p>Join thousands of travelers who trust AirBooking for their journeys</p>
        <div class="cta-buttons">
            <a href="register.jsp" class="cta-btn cta-primary">
                ✨ Create Free Account
            </a>
            <a href="login.jsp" class="cta-btn cta-secondary">
                🔐 Login Now
            </a>
        </div>
    </section>

    <script>
        // Smooth scroll for anchor links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });

        // Add animation on scroll
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -100px 0px'
        };

        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.style.animation = 'fadeInUp 0.6s ease-out';
                    entry.target.style.opacity = '1';
                }
            });
        }, observerOptions);

        document.querySelectorAll('.feature-card, .stat-item, .step').forEach(el => {
            el.style.opacity = '0';
            observer.observe(el);
        });
    </script>
</body>
</html>
