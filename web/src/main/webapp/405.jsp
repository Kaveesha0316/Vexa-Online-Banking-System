<%@page contentType="text/html; charset=UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Method Not Allowed | SecureBank</title>
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
      max-width: 800px;
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

    .header-content {
      position: relative;
      z-index: 2;
      display: flex;
      align-items: center;
      gap: 15px;
    }

    .header i {
      font-size: 32px;
      color: #FFA500;
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
      font-size: 220px;
      color: #FFA500;
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
      background: linear-gradient(135deg, #FF8C00 0%, #FFA500 100%);
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

    .explanation-box {
      background: #fffaf0;
      border: 1px solid #ffe4c4;
      border-radius: 12px;
      padding: 25px;
      width: 100%;
      max-width: 600px;
      margin: 20px 0;
      text-align: left;
      z-index: 2;
    }

    .explanation-header {
      display: flex;
      align-items: center;
      gap: 10px;
      margin-bottom: 15px;
    }

    .explanation-header i {
      color: #FF8C00;
      font-size: 20px;
    }

    .explanation-header h3 {
      color: #d2691e;
      font-size: 18px;
    }

    .explanation-content {
      color: #663333;
      font-size: 15px;
      line-height: 1.5;
    }

    .explanation-content ul {
      padding-left: 20px;
      margin-top: 10px;
    }

    .explanation-content li {
      margin-bottom: 8px;
      position: relative;
    }

    .explanation-content li:before {
      content: "•";
      color: #FF8C00;
      font-weight: bold;
      display: inline-block;
      width: 1em;
      margin-left: -1em;
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

    @keyframes shake {
      0%, 100% { transform: translateX(0); }
      10%, 30%, 50%, 70%, 90% { transform: translateX(-5px); }
      20%, 40%, 60%, 80% { transform: translateX(5px); }
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
        font-size: 150px;
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
      <i class="fas fa-ban"></i>
      <h1>Method Not Allowed</h1>
    </div>
  </div>

  <div class="main-content">
    <div class="error-graphic">
      <i class="fas fa-exclamation-triangle"></i>
    </div>

    <div class="bank-logo">
      <i class="fas fa-university"></i>
      <span>SecureBank</span>
    </div>

    <div class="error-code">405</div>
    <h2 class="error-title">Request Method Not Supported</h2>
    <p class="error-description">
      The HTTP method used for this request is not allowed for the requested resource.<br>
      This may be due to an incorrect form submission or outdated bookmark.
    </p>

    <div class="explanation-box">
      <div class="explanation-header">
        <i class="fas fa-lightbulb"></i>
        <h3>How to resolve this issue</h3>
      </div>
      <div class="explanation-content">
        <p>This error typically occurs when:</p>
        <ul>
          <li>You submitted a form using an incorrect method (GET vs POST)</li>
          <li>You tried to access a page through an unsupported HTTP method</li>
          <li>You used an outdated bookmark or link</li>
          <li>There was a temporary system configuration change</li>
        </ul>
        <p style="margin-top: 15px;">Please try one of the following:</p>
        <ul>
          <li>Return to the previous page and try a different action</li>
          <li>Clear your browser cache and cookies</li>
          <li>Use the navigation options below</li>
        </ul>
      </div>
    </div>

    <div class="actions">
      <a href="/dashboard" class="btn btn-primary">
        <i class="fas fa-home"></i> Go to Homepage
      </a>
      <a href="#" onclick="history.back()" class="btn btn-secondary">
        <i class="fas fa-arrow-left"></i> Back to Previous Page
      </a>
      <a href="/support" class="btn btn-secondary">
        <i class="fas fa-headset"></i> Contact Support
      </a>
    </div>
  </div>

  <div class="security-note">
    <i class="fas fa-shield-alt"></i>
    <p class="security-text">
      <strong>Security Notice:</strong> SecureBank uses advanced security protocols to protect your information.
      If you believe this error indicates a security concern, please contact our security team immediately at 1-800-SECURE-BANK.
    </p>
  </div>

  <div class="footer">
    <div class="copyright">
      &copy; 2023 SecureBank. All rights reserved.
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

    // Add shake animation to the error graphic on hover
    const errorGraphic = document.querySelector('.error-graphic');
    errorGraphic.addEventListener('mouseover', () => {
      errorGraphic.style.animation = 'shake 0.5s';
      setTimeout(() => {
        errorGraphic.style.animation = '';
      }, 500);
    });
  });
</script>
</body>
</html>