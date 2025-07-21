<%@page contentType="text/html; charset=UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Access Denied | SecureBank</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background: linear-gradient(135deg, #0a192f 0%, #0d1b2a 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            color: #e6f1ff;
        }

        .container {
            max-width: 900px;
            width: 100%;
            background: linear-gradient(145deg, #112240 0%, #0a192f 100%);
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.5);
            overflow: hidden;
            display: flex;
            flex-direction: column;
            animation: fadeIn 0.8s ease-out;
            border: 1px solid rgba(100, 255, 218, 0.1);
            position: relative;
            overflow: hidden;
        }

        .container::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #ff2a6d, #d16ba5, #86a8e7, #5ffbf1);
            background-size: 300% 300%;
            animation: gradient 5s ease infinite;
        }

        .header {
            background: rgba(10, 25, 47, 0.8);
            backdrop-filter: blur(10px);
            padding: 25px 40px;
            display: flex;
            align-items: center;
            gap: 15px;
            position: relative;
            z-index: 2;
            border-bottom: 1px solid rgba(100, 255, 218, 0.1);
        }

        .header-content {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .header i {
            font-size: 32px;
            color: #ff2a6d;
        }

        .header h1 {
            font-weight: 600;
            font-size: 24px;
            letter-spacing: 0.5px;
            background: linear-gradient(90deg, #ff2a6d, #d16ba5);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
        }

        .main-content {
            padding: 60px 40px;
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
            position: relative;
            z-index: 2;
        }

        .security-graphic {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 100%;
            height: 100%;
            opacity: 0.03;
            z-index: 1;
        }

        .security-graphic i {
            position: absolute;
            font-size: 300px;
            color: #64ffda;
        }

        .lock-icon {
            position: absolute;
            top: 20%;
            left: 10%;
            animation: float 8s ease-in-out infinite;
        }

        .shield-icon {
            position: absolute;
            top: 60%;
            right: 15%;
            animation: float 10s ease-in-out infinite;
            animation-delay: 1s;
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
            color: #64ffda;
        }

        .bank-logo span {
            font-size: 24px;
            font-weight: 700;
            color: #64ffda;
        }

        .error-code {
            font-size: 140px;
            font-weight: 800;
            background: linear-gradient(135deg, #ff2a6d 0%, #d16ba5 50%, #5ffbf1 100%);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            line-height: 1;
            margin-bottom: 20px;
            z-index: 2;
            text-shadow: 0 0 20px rgba(255, 42, 109, 0.3);
        }

        .error-title {
            font-size: 36px;
            font-weight: 700;
            color: #e6f1ff;
            margin-bottom: 15px;
            z-index: 2;
        }

        .error-description {
            font-size: 18px;
            color: #a8b2d1;
            max-width: 700px;
            line-height: 1.6;
            margin-bottom: 30px;
            z-index: 2;
        }

        .access-denied-box {
            background: rgba(23, 42, 69, 0.6);
            border: 1px solid rgba(100, 255, 218, 0.2);
            border-radius: 15px;
            padding: 25px;
            width: 100%;
            max-width: 600px;
            margin: 30px 0;
            text-align: center;
            z-index: 2;
            backdrop-filter: blur(5px);
        }

        .access-denied-header {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            margin-bottom: 20px;
        }

        .access-denied-header i {
            color: #ff2a6d;
            font-size: 28px;
        }

        .access-denied-header h3 {
            color: #64ffda;
            font-size: 22px;
            font-weight: 600;
        }

        .access-denied-content {
            color: #a8b2d1;
            font-size: 16px;
            line-height: 1.7;
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
            padding: 16px 35px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            text-decoration: none;
            border: none;
            position: relative;
            overflow: hidden;
            z-index: 1;
        }

        .btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(255, 255, 255, 0.1);
            z-index: -1;
            transform: scaleX(0);
            transform-origin: left;
            transition: transform 0.4s ease;
        }

        .btn:hover::before {
            transform: scaleX(1);
        }

        .btn-primary {
            background: linear-gradient(90deg, #ff2a6d 0%, #d16ba5 100%);
            color: white;
            box-shadow: 0 5px 25px rgba(255, 42, 109, 0.3);
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 30px rgba(255, 42, 109, 0.5);
        }

        .btn-secondary {
            background: transparent;
            color: #64ffda;
            border: 1px solid rgba(100, 255, 218, 0.4);
        }

        .btn-secondary:hover {
            background: rgba(100, 255, 218, 0.1);
            box-shadow: 0 5px 25px rgba(100, 255, 218, 0.2);
        }

        .security-note {
            background: rgba(10, 25, 47, 0.8);
            border-top: 1px solid rgba(100, 255, 218, 0.1);
            padding: 25px 40px;
            display: flex;
            align-items: center;
            gap: 15px;
            z-index: 2;
            backdrop-filter: blur(5px);
        }

        .security-note i {
            font-size: 24px;
            color: #64ffda;
            flex-shrink: 0;
        }

        .security-text {
            font-size: 14px;
            color: #a8b2d1;
            line-height: 1.5;
        }

        .security-text a {
            color: #64ffda;
            text-decoration: none;
            font-weight: 600;
        }

        .security-text a:hover {
            text-decoration: underline;
        }

        .footer {
            background: rgba(10, 25, 47, 0.9);
            padding: 20px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 14px;
            color: #64ffda;
            z-index: 2;
            border-top: 1px solid rgba(100, 255, 218, 0.1);
        }

        .footer-links a {
            color: #a8b2d1;
            text-decoration: none;
            margin-left: 20px;
            transition: color 0.3s ease;
        }

        .footer-links a:hover {
            color: #64ffda;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes gradient {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        @keyframes float {
            0% { transform: translateY(0px); }
            50% { transform: translateY(-20px); }
            100% { transform: translateY(0px); }
        }

        @keyframes pulse {
            0% { box-shadow: 0 0 0 0 rgba(255, 42, 109, 0.4); }
            70% { box-shadow: 0 0 0 15px rgba(255, 42, 109, 0); }
            100% { box-shadow: 0 0 0 0 rgba(255, 42, 109, 0); }
        }

        @media (max-width: 768px) {
            .header, .main-content, .security-note, .footer {
                padding: 20px;
            }

            .error-code {
                font-size: 100px;
            }

            .error-title {
                font-size: 28px;
            }

            .error-description {
                font-size: 16px;
            }

            .security-graphic i {
                font-size: 200px;
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
            <i class="fas fa-lock"></i>
            <h1>Access Denied</h1>
        </div>
    </div>

    <div class="main-content">
        <div class="security-graphic">
            <i class="fas fa-lock lock-icon"></i>
            <i class="fas fa-shield-alt shield-icon"></i>
        </div>

        <div class="bank-logo">
            <i class="fas fa-university"></i>
            <span>Vexa Bank</span>
        </div>

        <div class="error-code">403</div>
        <h2 class="error-title">Unauthorized Access Attempt</h2>
        <p class="error-description">
            You do not have permission to access this resource.<br>
            This area is restricted to authorized personnel only.
        </p>

        <div class="access-denied-box">
            <div class="access-denied-header">
                <i class="fas fa-exclamation-circle"></i>
                <h3>Security Alert</h3>
            </div>
            <div class="access-denied-content">
                <p>Our systems have detected an unauthorized access attempt. For your security:</p>
                <p style="margin: 15px 0; padding: 10px; background: rgba(255, 42, 109, 0.1); border-left: 3px solid #ff2a6d;">
                    <i class="fas fa-info-circle"></i> This incident has been logged for security review (Ref: #SEC-403-{{timestamp}})
                </p>
                <p>If you believe this is an error, please contact our security team with your reference number.</p>
            </div>
        </div>

        <div class="actions">
            <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-primary">
                <i class="fas fa-home"></i> Return to Homepage
            </a>
            <a href="#" onclick="history.back()" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Back to Safety
            </a>
            <a href="#" class="btn btn-secondary">
                <i class="fas fa-shield-alt"></i> Security Center
            </a>
        </div>
    </div>

    <div class="security-note">
        <i class="fas fa-user-shield"></i>
        <p class="security-text">
            <strong>Security Notice:</strong> Vexa Bank employs advanced security measures to protect your accounts.
            Unauthorized access attempts violate our terms of service and may be reported to authorities.
            If you need access to this resource, please <a href="/access-request">submit an access request</a>.
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
            <a href="#">Report Suspicious Activity</a>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Generate a random timestamp for the security reference
        const now = new Date();


        // Animate the error code
        const errorCode = document.querySelector('.error-code');
        errorCode.style.opacity = '0';
        errorCode.style.transform = 'scale(0.8)';

        setTimeout(() => {
            errorCode.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
            errorCode.style.opacity = '1';
            errorCode.style.transform = 'scale(1)';
        }, 300);

        // Add pulsing animation to the security alert
        const securityAlert = document.querySelector('.access-denied-box');
        setTimeout(() => {
            securityAlert.style.animation = 'pulse 2s 3';
        }, 1000);
    });
</script>
</body>
</html>