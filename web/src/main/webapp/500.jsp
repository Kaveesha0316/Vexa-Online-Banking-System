<%@page contentType="text/html; charset=UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Server Error | SecureBank</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background: linear-gradient(135deg, #f0f4f8 0%, #dfe7f0 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            color: #1a2a3a;
        }

        .container {
            max-width: 900px;
            width: 100%;
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 30, 84, 0.15);
            overflow: hidden;
            display: flex;
            flex-direction: column;
            animation: fadeIn 0.8s ease-out;
        }

        .header {
            background: linear-gradient(90deg, #001f3f 0%, #003366 100%);
            color: white;
            padding: 25px 40px;
            display: flex;
            align-items: center;
            gap: 15px;
            position: relative;
            overflow: hidden;
        }

        .header::before {
            content: "";
            position: absolute;
            top: -50%;
            right: -50%;
            width: 200px;
            height: 200px;
            background: rgba(255, 255, 255, 0.05);
            border-radius: 50%;
        }

        .header::after {
            content: "";
            position: absolute;
            bottom: -30px;
            left: -30px;
            width: 100px;
            height: 100px;
            background: rgba(77, 157, 224, 0.1);
            border-radius: 50%;
        }

        .header-content {
            position: relative;
            z-index: 2;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .header i {
            font-size: 32px;
            color: #4d9de0;
        }

        .header h1 {
            font-weight: 600;
            font-size: 24px;
            letter-spacing: 0.5px;
        }

        .main-content {
            padding: 50px 40px;
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
            position: relative;
        }

        .error-graphic {
            position: absolute;
            top: 0;
            right: 40px;
            opacity: 0.05;
            font-size: 250px;
            color: #003366;
        }

        .bank-logo {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 40px;
            z-index: 2;
        }

        .bank-logo i {
            font-size: 36px;
            color: #003366;
        }

        .bank-logo span {
            font-size: 24px;
            font-weight: 700;
            color: #003366;
        }

        .error-code {
            font-size: 120px;
            font-weight: 800;
            background: linear-gradient(135deg, #990000 0%, #cc0000 100%);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            line-height: 1;
            margin-bottom: 20px;
            z-index: 2;
        }

        .error-title {
            font-size: 32px;
            font-weight: 700;
            color: #001f3f;
            margin-bottom: 15px;
            z-index: 2;
        }

        .error-description {
            font-size: 18px;
            color: #4a5568;
            max-width: 700px;
            line-height: 1.6;
            margin-bottom: 30px;
            z-index: 2;
        }

        .status-update {
            background: #fff8f8;
            border: 1px solid #ffe0e0;
            border-radius: 12px;
            padding: 20px;
            width: 100%;
            max-width: 600px;
            margin: 20px 0;
            text-align: left;
            z-index: 2;
        }

        .status-header {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 15px;
        }

        .status-header i {
            color: #cc0000;
            font-size: 20px;
        }

        .status-header h3 {
            color: #990000;
            font-size: 18px;
        }

        .status-content {
            color: #663333;
            font-size: 15px;
            line-height: 1.5;
        }

        .status-content ul {
            padding-left: 20px;
            margin-top: 10px;
        }

        .status-content li {
            margin-bottom: 8px;
        }

        .actions {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            justify-content: center;
            margin-top: 20px;
            z-index: 2;
        }

        .btn {
            padding: 16px 32px;
            border-radius: 50px;
            font-weight: 600;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
            border: none;
        }

        .btn-primary {
            background: linear-gradient(90deg, #003366 0%, #00509e 100%);
            color: white;
            box-shadow: 0 5px 15px rgba(0, 48, 104, 0.2);
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(0, 48, 104, 0.3);
            background: linear-gradient(90deg, #00264d 0%, #004080 100%);
        }

        .btn-secondary {
            background: white;
            color: #003366;
            border: 2px solid #e2e8f0;
        }

        .btn-secondary:hover {
            background: #f8fafc;
            border-color: #cbd5e0;
        }

        .security-note {
            background: #f8fafc;
            border-top: 1px solid #e2e8f0;
            padding: 25px 40px;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .security-note i {
            font-size: 24px;
            color: #003366;
            flex-shrink: 0;
        }

        .security-text {
            font-size: 14px;
            color: #4a5568;
            line-height: 1.5;
        }

        .security-text a {
            color: #003366;
            text-decoration: none;
            font-weight: 600;
        }

        .security-text a:hover {
            text-decoration: underline;
        }

        .footer {
            background: #001f3f;
            color: #a0c4e0;
            padding: 20px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 14px;
        }

        .footer-links a {
            color: #a0c4e0;
            text-decoration: none;
            margin-left: 20px;
        }

        .footer-links a:hover {
            color: white;
            text-decoration: underline;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }

        @media (max-width: 768px) {
            .header {
                padding: 20px;
            }

            .main-content {
                padding: 40px 20px;
            }

            .error-code {
                font-size: 90px;
            }

            .error-title {
                font-size: 26px;
            }

            .error-description {
                font-size: 16px;
            }

            .error-graphic {
                font-size: 180px;
                right: 10px;
            }

            .actions {
                flex-direction: column;
                width: 100%;
            }

            .btn {
                width: 100%;
                justify-content: center;
            }

            .security-note {
                padding: 20px;
                flex-direction: column;
                text-align: center;
            }

            .footer {
                flex-direction: column;
                gap: 15px;
                text-align: center;
            }

            .footer-links {
                display: flex;
                flex-wrap: wrap;
                justify-content: center;
                gap: 15px;
            }

            .footer-links a {
                margin: 0;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <div class="header-content">
            <i class="fas fa-exclamation-circle"></i>
            <h1>Internal Server Error</h1>
        </div>
    </div>

    <div class="main-content">
        <div class="error-graphic">
            <i class="fas fa-server"></i>
        </div>

        <div class="bank-logo">
            <i class="fas fa-university"></i>
            <span>Vexa Bank</span>
        </div>

        <div class="error-code">500</div>
        <h2 class="error-title">We're experiencing technical difficulties</h2>
        <p class="error-description">
            Our servers encountered an unexpected condition that prevented it from fulfilling your request.<br>
            Our engineering team has been notified and is working to resolve the issue.
        </p>

        <div class="status-update">
            <div class="status-header">
                <i class="fas fa-exclamation-triangle"></i>
                <h3>Service Status Update</h3>
            </div>
            <div class="status-content">
                <p>We are currently experiencing issues with our online banking services. Here's what we know:</p>
                <ul>
                    <li>Core banking systems are operational and secure</li>
                    <li>No customer data has been compromised</li>
                    <li>Estimated resolution time: 30-60 minutes</li>
                    <li>ATM and branch services remain available</li>
                </ul>
            </div>
        </div>

        <div class="actions">
            <a href="#" class="btn btn-primary">
                <i class="fas fa-redo-alt"></i> Try Again
            </a>
            <a href="#" class="btn btn-secondary">
                <i class="fas fa-headset"></i> Emergency Support
            </a>
            <a href="#" class="btn btn-secondary">
                <i class="fas fa-broadcast-tower"></i> System Status
            </a>
        </div>
    </div>

    <div class="security-note">
        <i class="fas fa-shield-alt"></i>
        <p class="security-text">
            <strong>Security Assurance:</strong> Your financial data remains secure. SecureBank employs multiple layers of security and encryption to protect your information at all times. If you have immediate concerns, please call our 24/7 security hotline at 1-800-SECURE-BANK.
        </p>
    </div>

    <div class="footer">
        <div class="copyright">
            &copy; 2023 Vexa Bank. All rights reserved.
        </div>
        <div class="footer-links">
            <a href="#">Privacy Policy</a>
            <a href="#">Terms of Service</a>
            <a href="#">Security Center</a>
            <a href="#">Contact Us</a>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Animate the error code
        const errorCode = document.querySelector('.error-code');
        errorCode.style.opacity = '0';
        errorCode.style.transform = 'scale(0.8)';

        setTimeout(() => {
            errorCode.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
            errorCode.style.opacity = '1';
            errorCode.style.transform = 'scale(1)';
        }, 300);

        // Add pulsing animation to the try again button
        const tryAgainBtn = document.querySelector('.btn-primary');
        setTimeout(() => {
            tryAgainBtn.style.animation = 'pulse 2s infinite';
        }, 1500);
    });
</script>
</body>
</html>