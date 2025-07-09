<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Secure Banking Sign In</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        :root {
            --primary: #2563eb;
            --primary-dark: #1d4ed8;
            --secondary: #64748b;
            --success: #10b981;
            --warning: #f59e0b;
            --danger: #ef4444;
            --dark: #0f172a;
            --light: #f8fafc;
            --card-bg: #ffffff;
            --border: #e2e8f0;
            --sidebar-bg: #1e293b;
        }

        body {
            background: linear-gradient(135deg, #0f172a, #1e293b);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
            color: #334155;
        }

        .security-banner {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            background: rgba(239, 68, 68, 0.1);
            color: #fee2e2;
            text-align: center;
            padding: 10px;
            font-size: 0.9rem;
            border-bottom: 1px solid rgba(239, 68, 68, 0.3);
        }

        .security-banner i {
            margin-right: 8px;
            color: #ef4444;
        }

        .container {
            display: flex;
            width: 100%;
            max-width: 1000px;
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
        }

        .brand-section {
            flex: 1;
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            color: white;
            padding: 60px 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .brand-section::before {
            content: "";
            position: absolute;
            width: 300px;
            height: 300px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            top: -100px;
            right: -100px;
        }

        .brand-section::after {
            content: "";
            position: absolute;
            width: 200px;
            height: 200px;
            background: rgba(255, 255, 255, 0.05);
            border-radius: 50%;
            bottom: -80px;
            left: -80px;
        }

        .logo {
            display: flex;
            align-items: center;
            margin-bottom: 30px;
            z-index: 2;
        }

        .logo i {
            font-size: 2.5rem;
            margin-right: 15px;
            color: white;
        }

        .logo h1 {
            font-size: 2rem;
            font-weight: 700;
        }

        .brand-content {
            max-width: 400px;
            z-index: 2;
        }

        .brand-content h2 {
            font-size: 1.8rem;
            margin-bottom: 20px;
            font-weight: 600;
        }

        .brand-content p {
            font-size: 1rem;
            line-height: 1.6;
            opacity: 0.9;
            margin-bottom: 30px;
        }

        .features {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
            margin-top: 30px;
            z-index: 2;
        }

        .feature {
            background: rgba(255, 255, 255, 0.1);
            padding: 15px;
            border-radius: 10px;
            width: 140px;
            text-align: center;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .feature i {
            font-size: 1.8rem;
            margin-bottom: 10px;
            color: white;
        }

        .feature span {
            font-size: 0.85rem;
            display: block;
        }

        .login-section {
            flex: 1;
            padding: 60px 50px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .login-header {
            margin-bottom: 40px;
        }

        .login-header h2 {
            font-size: 1.8rem;
            color: var(--dark);
            margin-bottom: 10px;
        }

        .login-header p {
            color: var(--secondary);
            font-size: 1rem;
        }

        .login-form .input-group {
            margin-bottom: 25px;
            position: relative;
        }

        .login-form label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--dark);
            font-size: 0.95rem;
        }

        .input-with-icon {
            position: relative;
        }

        .input-with-icon i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--secondary);
            font-size: 1.1rem;
        }

        .login-form input {
            width: 100%;
            padding: 14px 14px 14px 45px;
            border: 1px solid var(--border);
            border-radius: 10px;
            font-size: 1rem;
            transition: all 0.3s;
        }

        .login-form input:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
        }

        .password-toggle {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: var(--secondary);
        }

        .remember-forgot {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .remember {
            display: flex;
            align-items: center;
        }

        .remember input {
            margin-right: 8px;
            width: auto;
        }

        .remember label {
            margin-bottom: 0;
            color: var(--secondary);
            font-size: 0.95rem;
        }

        .forgot-password {
            color: var(--primary);
            text-decoration: none;
            font-size: 0.95rem;
            transition: color 0.3s;
        }

        .forgot-password:hover {
            color: var(--primary-dark);
            text-decoration: underline;
        }

        .login-button {
            width: 100%;
            padding: 15px;
            background: var(--primary);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.3s;
            margin-bottom: 25px;
        }

        .login-button:hover {
            background: var(--primary-dark);
        }

        .login-button i {
            margin-right: 10px;
        }

        .divider {
            display: flex;
            align-items: center;
            margin-bottom: 25px;
        }

        .divider span {
            flex: 1;
            height: 1px;
            background: var(--border);
        }

        .divider p {
            padding: 0 15px;
            color: var(--secondary);
            font-size: 0.9rem;
        }

        .alternative-login {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-bottom: 30px;
        }

        .alt-login-btn {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            background: var(--light);
            border: 1px solid var(--border);
            color: var(--dark);
            font-size: 1.2rem;
            cursor: pointer;
            transition: all 0.3s;
        }

        .alt-login-btn:hover {
            background: #e2e8f0;
            transform: translateY(-3px);
        }

        .signup-link {
            text-align: center;
            color: var(--secondary);
            font-size: 0.95rem;
        }

        .signup-link a {
            color: var(--primary);
            text-decoration: none;
            font-weight: 600;
        }

        .signup-link a:hover {
            text-decoration: underline;
        }

        .security-info {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            margin-top: 30px;
            color: var(--secondary);
            font-size: 0.85rem;
        }

        .security-info i {
            color: var(--success);
        }

        @media (max-width: 768px) {
            .container {
                flex-direction: column;
            }

            .brand-section {
                padding: 40px 20px;
            }

            .login-section {
                padding: 40px 30px;
            }

            .features {
                display: none;
            }
        }

        /* Animation */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .login-section {
            animation: fadeIn 0.8s ease-out;
        }
    </style>
</head>
<body>
<%--<div class="security-banner">--%>
<%--    <i class="fas fa-shield-alt"></i>--%>
<%--    <span>Enhanced security is active. Always verify the URL before signing in.</span>--%>
<%--</div>--%>

<div class="container">
    <div class="brand-section">
        <div class="logo">
            <i class="fas fa-university"></i>
            <h1>Vexa Bank</h1>
        </div>

        <div class="brand-content">
            <h2>Secure Banking Platform</h2>
            <p>Access your banking  dashboard with enterprise-grade security and advanced financial tools designed for modern banking operations.</p>

            <div class="features">
                <div class="feature">
                    <i class="fas fa-shield-alt"></i>
                    <span>256-bit Encryption</span>
                </div>
                <div class="feature">
                    <i class="fas fa-user-lock"></i>
                    <span>2FA Support</span>
                </div>
                <div class="feature">
                    <i class="fas fa-bell"></i>
                    <span>Real-time Alerts</span>
                </div>
            </div>
        </div>
    </div>

    <div class="login-section">
        <div class="login-header">
            <h2>Sign In</h2>
            <p>Enter your credentials to access the dashboard</p>
        </div>

        <form class="login-form">
            <div class="input-group">
                <label for="username">Username</label>
                <div class="input-with-icon">
                    <i class="fas fa-user"></i>
                    <input type="text" id="username" placeholder="Enter your admin ID" required>
                </div>
            </div>

            <div class="input-group">
                <label for="password">Password</label>
                <div class="input-with-icon">
                    <i class="fas fa-lock"></i>
                    <input type="password" id="password" placeholder="Enter your password" required>
                    <span class="password-toggle" id="togglePassword">
                            <i class="fas fa-eye"></i>
                        </span>
                </div>
            </div>

            <div class="remember-forgot">
                <div class="remember">
                    <input type="checkbox" id="remember">
                    <label for="remember">Remember this device</label>
                </div>
                <a href="#" class="forgot-password">Forgot Password?</a>
            </div>

            <button onclick="signIn();" type="button" class="login-button">
                <i class="fas fa-sign-in-alt"></i> Sign In
            </button>

            <div class="divider">
                <span></span>
                <p>or continue with</p>
                <span></span>
            </div>

            <div class="alternative-login">
                <div class="alt-login-btn">
                    <i class="fab fa-google"></i>
                </div>
                <div class="alt-login-btn">
                    <i class="fas fa-fingerprint"></i>
                </div>
                <div class="alt-login-btn">
                    <i class="fas fa-mobile-alt"></i>
                </div>
            </div>

            <div class="security-info">
                <i class="fas fa-lock"></i>
                <span>Your information is protected with bank-grade security</span>
            </div>
        </form>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
    // Toggle password visibility
    const togglePassword = document.querySelector('#togglePassword');
    const password = document.querySelector('#password');

    togglePassword.addEventListener('click', function() {
        const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
        password.setAttribute('type', type);
        this.innerHTML = type === 'password' ? '<i class="fas fa-eye"></i>' : '<i class="fas fa-eye-slash"></i>';
    });

    async function signIn(event) {
        // ✅ Prevent default form submission
        if (event) event.preventDefault();

        const username = document.getElementById("username").value.trim();
        const password = document.getElementById("password").value.trim();

        // ✅ Check empty fields
        if (!username || !password) {
            Swal.fire({
                icon: "error",
                title: "Missing Fields",
                text: "Please fill in all fields."
            });
            return;
        }


        const formData = new URLSearchParams();
        formData.append("username", username);
        formData.append("password", password);


        try {
            const response = await fetch("/banking-system/login", {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                body: formData.toString()
            });

            const responseText = await response.text();
            if (responseText.trim() === "admin") {
                window.location.replace("/banking-system/admin/adminDB.jsp");
            }else if (responseText.trim() === "customer") {
                window.location.replace("/banking-system/user/userDB.jsp");
            }else {
                Swal.fire({
                    icon: "error",
                    title: responseText.trim(),
                    text: "Something went wrong. Please try again."
                });
            }
        } catch (err) {
            console.error("Error:", err);
            Swal.fire({
                icon: "error",
                title: "Network Error",
                text: "Unable to connect to server."
            });
        }
    }

    // Security banner animation
    const securityBanner = document.querySelector('.security-banner');
    setInterval(() => {
        securityBanner.style.backgroundColor = securityBanner.style.backgroundColor === 'rgba(239, 68, 68, 0.1)' ?
            'rgba(16, 185, 129, 0.1)' : 'rgba(239, 68, 68, 0.1)';
        securityBanner.style.borderBottomColor = securityBanner.style.borderBottomColor === 'rgba(239, 68, 68, 0.3)' ?
            'rgba(16, 185, 129, 0.3)' : 'rgba(239, 68, 68, 0.3)';
    }, 3000);
</script>
</body>
</html>