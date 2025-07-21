<%@page contentType="text/html; charset=UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Page Not Found | SecureBank</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #e4e8f0 100%);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 20px;
            color: #1a2a3a;
        }

        .container {
            max-width: 800px;
            width: 100%;
            background: white;
            border-radius: 20px;
            box-shadow: 0 15px 50px rgba(0, 30, 84, 0.15);
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

        .content {
            padding: 50px 40px;
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
        }

        .error-code {
            font-size: 120px;
            font-weight: 800;
            background: linear-gradient(135deg, #003366 0%, #4d9de0 100%);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            line-height: 1;
            margin-bottom: 20px;
        }

        .error-title {
            font-size: 32px;
            font-weight: 700;
            color: #001f3f;
            margin-bottom: 15px;
        }

        .error-description {
            font-size: 18px;
            color: #4a5568;
            max-width: 600px;
            line-height: 1.6;
            margin-bottom: 30px;
        }

        .actions {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            justify-content: center;
            margin-top: 20px;
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

        .bank-logo {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 30px;
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

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 600px) {
            .header {
                padding: 20px;
            }

            .content {
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
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <i class="fas fa-exclamation-triangle"></i>
        <h1>Page Not Found</h1>
    </div>

    <div class="content">
        <div class="bank-logo">
            <i class="fas fa-university"></i>
            <span>Vexa Bank</span>
        </div>

        <div class="error-code">404</div>
        <h2 class="error-title">We couldn't find that page</h2>
        <p class="error-description">
            The page you are looking for might have been removed, had its name changed,
            or is temporarily unavailable. Please check the URL and try again.
        </p>

        <div class="actions">
            <a href="/banking-system/index.jsp" class="btn btn-primary">
                <i class="fas fa-home"></i> Go to Homepage
            </a>
            <a href="#" class="btn btn-secondary">
                <i class="fas fa-headset"></i> Contact Support
            </a>
            <button onclick="history.back()" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Back to Previous Page
            </button>
        </div>
    </div>

    <div class="security-note">
        <i class="fas fa-shield-alt"></i>
        <p class="security-text">
            <strong>Security Notice:</strong> SecureBank will never ask for your password or PIN via email,
            phone, or text message. If you suspect suspicious activity,
            <a href="/security-center">visit our Security Center</a> or contact us immediately.
        </p>
    </div>
</div>

<script>
    // Add a subtle animation to the error code
    document.addEventListener('DOMContentLoaded', function() {
        const errorCode = document.querySelector('.error-code');
        errorCode.style.opacity = '0';
        errorCode.style.transform = 'scale(0.8)';

        setTimeout(() => {
            errorCode.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
            errorCode.style.opacity = '1';
            errorCode.style.transform = 'scale(1)';
        }, 300);
    });
</script>
</body>
</html>