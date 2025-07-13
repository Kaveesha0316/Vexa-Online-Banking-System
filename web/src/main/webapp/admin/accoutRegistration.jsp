<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 7/6/2025
  Time: 3:48 PM
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BankAdmin Pro | Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary: #2563eb;
            --secondary: #64748b;
            --success: #10b981;
            --warning: #f59e0b;
            --danger: #ef4444;
            --dark: #0f172a;
            --light: #f8fafc;
            --sidebar-bg: #1e293b;
            --card-bg: #ffffff;
            --border: #e2e8f0;
            --sidebar-width: 260px;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #f1f5f9;
            color: #334155;
            display: flex;
            min-height: 100vh;
        }


        /* Sidebar Styles */
        .sidebar {
            width: var(--sidebar-width);
            background: var(--sidebar-bg);
            color: white;
            height: 100vh;
            position: fixed;
            padding: 24px 0;
            transition: all 0.3s ease;
            z-index: 100;
            box-shadow: 4px 0 15px rgba(0, 0, 0, 0.1);
        }

        .logo {
            display: flex;
            align-items: center;
            padding: 0 24px 24px;
            border-bottom: 1px solid rgba(255,255,255,0.1);
            margin-bottom: 24px;
        }

        .logo i {
            font-size: 28px;
            color: var(--accent);
            margin-right: 12px;
        }

        .logo h1 {
            font-family: 'Poppins', sans-serif;
            font-weight: 600;
            font-size: 24px;
            letter-spacing: 0.5px;
        }

        .nav-links {
            list-style: none;
            padding: 0 16px;
        }

        .nav-links li {
            margin-bottom: 4px;
            position: relative;
        }

        .nav-links a {
            display: flex;
            align-items: center;
            padding: 14px 16px;
            text-decoration: none;
            color: #cbd5e1;
            border-radius: 8px;
            transition: all 0.2s ease;
            font-size: 15px;
            font-weight: 500;
        }

        .nav-links a:hover {
            background: rgba(255,255,255,0.08);
            color: white;
        }

        .nav-links a.active {
            background: rgba(37, 99, 235, 0.2);
            color: white;
            font-weight: 500;
        }

        .nav-links a i {
            width: 30px;
            font-size: 18px;
            margin-right: 12px;
            transition: transform 0.3s ease;
        }

        .submenu {
            max-height: 0;
            overflow: hidden;
            transition: max-height 0.3s ease;
            padding-left: 40px;
        }

        .submenu.active {
            max-height: 500px;
        }

        .submenu a {
            padding: 10px 16px;
            font-size: 14px;
            background: transparent;
        }

        .submenu a::before {
            margin-right: 12px;
            color: var(--accent);
        }

        .has-submenu > a::after {
            content: "\f078";
            font-family: "Font Awesome 6 Free";
            font-weight: 900;
            margin-left: auto;
            font-size: 12px;
            transition: transform 0.3s ease;
        }

        .has-submenu.active > a::after {
            transform: rotate(180deg);
        }
        /*.menu {*/
        /*    padding: 15px 0;*/
        /*}*/

        /*.menu-title {*/
        /*    padding: 10px 20px;*/
        /*    font-size: 0.75rem;*/
        /*    text-transform: uppercase;*/
        /*    color: #94a3b8;*/
        /*    letter-spacing: 1px;*/
        /*}*/

        /*.menu-item {*/
        /*    padding: 12px 20px;*/
        /*    display: flex;*/
        /*    align-items: center;*/
        /*    cursor: pointer;*/
        /*    transition: all 0.2s;*/
        /*    border-left: 3px solid transparent;*/
        /*}*/

        /*.menu-item:hover, .menu-item.active {*/
        /*    background: rgba(255, 255, 255, 0.05);*/
        /*    border-left: 3px solid var(--primary);*/
        /*}*/

        /*.menu-item i {*/
        /*    width: 24px;*/
        /*    margin-right: 12px;*/
        /*    font-size: 1.1rem;*/
        /*}*/

        /*.submenu {*/
        /*    padding-left: 56px;*/
        /*    background: rgba(0, 0, 0, 0.1);*/
        /*    display: none;*/
        /*}*/

        /*.submenu.show {*/
        /*    display: block;*/
        /*}*/

        /*.submenu .menu-item {*/
        /*    padding: 10px 0;*/
        /*    font-size: 0.9rem;*/
        /*    border-left: none;*/
        /*}*/

        /*.submenu .menu-item:hover {*/
        /*    color: #dbeafe;*/
        /*}*/

        /* Main Content Styles */
        .main-content {
            flex: 1;
            margin-left: var(--sidebar-width);
            padding: 20px;
            transition: all 0.3s ease;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 0;
            margin-bottom: 25px;
        }

        .header-title h1 {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--dark);
        }

        .header-title p {
            color: var(--secondary);
            font-size: 0.9rem;
        }

        .user-menu {
            display: flex;
            align-items: center;
        }

        .search-bar {
            position: relative;
            margin-right: 20px;
        }

        .search-bar input {
            padding: 10px 15px 10px 40px;
            border-radius: 6px;
            border: 1px solid var(--border);
            background: white;
            width: 250px;
            font-size: 0.9rem;
        }

        .search-bar i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--secondary);
        }

        .user-profile {
            display: flex;
            align-items: center;
            cursor: pointer;
        }

        .user-profile img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
            margin-right: 10px;
            border: 2px solid var(--primary);
        }

        .user-info h4 {
            font-size: 0.95rem;
            font-weight: 600;
        }

        .user-info p {
            font-size: 0.8rem;
            color: var(--secondary);
        }

        /* Registration Form */
        .form-container {
            background: white;
            border-radius: 16px;
            padding: 30px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
        }

        .form-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            padding-bottom: 20px;
            border-bottom: 1px solid var(--border);
        }

        .form-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--dark);
        }

        .form-subtitle {
            color: var(--secondary);
            font-size: 1rem;
            margin-top: 5px;
        }

        .required-label {
            font-size: 0.9rem;
            color: var(--danger);
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 25px;
            margin-bottom: 25px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--dark);
            font-size: 0.95rem;
        }

        .form-group label span {
            color: var(--danger);
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

        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 14px 14px 14px 45px;
            border: 1px solid var(--border);
            border-radius: 10px;
            font-size: 1rem;
            transition: all 0.3s;
        }

        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
        }

        .form-group textarea {
            min-height: 100px;
            resize: vertical;
        }

        .form-actions {
            display: flex;
            justify-content: flex-end;
            gap: 15px;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid var(--border);
        }

        .btn {
            padding: 12px 28px;
            border-radius: 10px;
            font-size: 1rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s;
            border: none;
        }

        .btn-primary {
            background: var(--primary);
            color: white;
        }

        .btn-primary:hover {
            background: var(--primary-dark);
        }

        .btn-outline {
            background: transparent;
            border: 1px solid var(--border);
            color: var(--secondary);
        }

        .btn-outline:hover {
            background: #f8fafc;
            border-color: var(--primary);
            color: var(--primary);
        }

        .form-footer {
            margin-top: 30px;
            padding: 20px;
            background: #f1f5f9;
            border-radius: 12px;
            display: flex;
            align-items: center;
        }

        .form-footer i {
            font-size: 1.5rem;
            color: var(--primary);
            margin-right: 15px;
        }

        .form-footer p {
            font-size: 0.9rem;
            color: var(--secondary);
        }

        .form-footer a {
            color: var(--primary);
            text-decoration: none;
        }

        .form-footer a:hover {
            text-decoration: underline;
        }

        .steps {
            display: flex;
            margin-bottom: 30px;
            background: #f1f5f9;
            padding: 15px;
            border-radius: 12px;
        }

        .step {
            flex: 1;
            text-align: center;
            padding: 10px;
            position: relative;
        }

        .step.active .step-number {
            background: var(--primary);
            color: white;
        }

        .step.active .step-title {
            color: var(--dark);
            font-weight: 600;
        }

        .step.completed .step-number {
            background: var(--success);
            color: white;
        }

        .step.completed .step-title {
            color: var(--success);
        }

        .step-number {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            background: #cbd5e1;
            color: #64748b;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 10px;
            font-weight: 600;
            font-size: 0.9rem;
        }

        .step-title {
            font-size: 0.9rem;
            color: #94a3b8;
        }

        .step:not(:last-child)::after {
            content: '';
            position: absolute;
            top: 24px;
            right: -15px;
            width: 30px;
            height: 2px;
            background: #cbd5e1;
        }


        /*!* Responsive Design *!*/
        /*@media (max-width: 992px) {*/
        /*    .container {*/
        /*        flex-direction: column;*/
        /*    }*/

        /*    .sidebar {*/
        /*        width: 100%;*/
        /*        padding: 20px;*/
        /*    }*/

        /*    .main-content {*/
        /*        padding: 30px;*/
        /*    }*/

        /*    .form-grid {*/
        /*        grid-template-columns: 1fr;*/
        /*    }*/
        /*}*/

        /*@media (max-width: 576px) {*/
        /*    .header {*/
        /*        flex-direction: column;*/
        /*        align-items: flex-start;*/
        /*    }*/

        /*    .steps {*/
        /*        flex-direction: column;*/
        /*        gap: 15px;*/
        /*    }*/

        /*    .step:not(:last-child)::after {*/
        /*        display: none;*/
        /*    }*/

        /*    .form-actions {*/
        /*        flex-direction: column;*/
        /*    }*/

        /*    .btn {*/
        /*        width: 100%;*/
        /*    }*/
        /*}*/
        /*!* Responsive Design *!*/
        /*@media (max-width: 992px) {*/
        /*    .dashboard-grid {*/
        /*        grid-template-columns: 1fr;*/
        /*    }*/
        /*}*/

        @media (max-width: 768px) {
            .sidebar {
                width: 70px;
            }

            .sidebar .logo h2,
            .sidebar .menu-title,
            .sidebar .menu-item span {
                display: none;
            }

            .sidebar .menu-item {
                justify-content: center;
                padding: 15px 0;
            }

            .sidebar .menu-item i {
                margin-right: 0;
                font-size: 1.3rem;
            }

            .main-content {
                margin-left: 70px;
            }

            .search-bar input {
                width: 150px;
            }
        }

        @media (max-width: 576px) {
            .header {
                flex-direction: column;
                align-items: flex-start;
            }

            .user-menu {
                width: 100%;
                justify-content: space-between;
                margin-top: 15px;
            }

            .search-bar {
                flex: 1;
                margin-right: 10px;
            }

            .search-bar input {
                width: 100%;
            }

            .stats-container {
                grid-template-columns: 1fr;
            }
        }

        /* Responsive Design */



    </style>
</head>
<body>
<!-- Sidebar -->

<aside class="sidebar">
    <div class="logo">
        <i class="fas fa-university"></i>
        <h1>Vexa Bank</h1>
    </div>
    <ul class="nav-links">
        <li>
            <a href="adminDB.jsp" >
                <i class="fas fa-home"></i>
                <span>Dashboard</span>
            </a>
        </li>
        <li class="has-submenu">
            <a href="#">
                <i class="fas fa-wallet"></i>
                <span>Customers Management</span>
            </a>
            <ul class="submenu">
                <li><a href="customerRegistration.jsp">Register new customer</a></li>
                <li><a href="customerManagement.jsp">Customer Profiles</a></li>
            </ul>
        </li>
        <li class="has-submenu">
            <a href="#" class="active">
                <i class="fas fa-exchange-alt"></i>
                <span>Accounts Management</span>
            </a>
            <ul class="submenu">
                <li><a href="accoutRegistration.jsp">Create Accounts</a></li>
                <li><a href="accountManagement.jsp">Accounts Management</a></li>
            </ul>
        </li>
        <li class="has-submenu">
            <a href="#">
                <i class="fas fa-exchange-alt"></i>
                <span>Transactions Management</span>
            </a>
            <ul class="submenu">
                <li><a href="transactionManagement.jsp">Transaction Logs</a></li>
                <li><a href="auditLogManagemnt.jsp">Audit Logs</a></li>
            </ul>
        </li>
        <li>
            <a href="scheduledTrnsManagement.jsp">
                <i class="fas fa-file-invoice-dollar"></i>
                <span>Scheduled Tasks</span>
            </a>
        </li>
        <li>
            <a href="#">
                <i class="fas fa-cog"></i>
                <span>Security</span>
            </a>
        </li>
        <li>
            <a href="#">
                <i class="fas fa-sign-out-alt"></i>
                <span>Logout</span>
            </a>
        </li>
    </ul>
</aside>



<!-- Main Content -->
<div class="main-content">
    <div class="header">
        <div class="header-title">
            <h1>Account Registration</h1>
            <p>Register new Account for banking services</p>
        </div>

    </div>

    <div class="steps">
        <div class="step active">
            <div class="step-number">1</div>
            <div class="step-title">Personal Info</div>
        </div>
        <div class="step active">
            <div class="step-number">2</div>
            <div class="step-title">Account Setup</div>
        </div>

    </div>

    <div class="form-container">
        <div class="form-header">
            <div>
                <div class="form-title">Account Information</div>
                <div class="form-subtitle">Fill in the account details</div>
            </div>
            <div class="required-label">* Required fields</div>
        </div>

        <form id="customerRegistrationForm">
            <div class="form-grid">
                <div class="form-group">
                    <label for="nic">Customer NIC <span>*</span></label>
                    <div class="input-with-icon">
                        <i class="fas fa-user"></i>
                        <input type="text" id="nic" placeholder="Enter NIC" required>
                    </div>
                </div>
                <div class="form-group">
                    <label for="balance">balance<span>*</span></label>
                    <div class="input-with-icon">
                        <i class="fas fa-money-bill-wave"></i>
                        <input type="number" min="0"  id="balance" placeholder="0" required>
                    </div>
                </div>
            </div>


            <div class="form-grid">
                <div class="form-group">
                    <label for="state">Account Type</label>
                    <select id="state">
                        <option selected value="SAVINGS">SAVINGS</option>
                        <option value="FIXED_DEPOSIT">FIXED_DEPOSIT</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="interest">Interest Rate <span>*</span></label>
                    <div class="input-with-icon">
                        <i class="far fa-money-bill-alt"></i>
                    <input type="text" id="interest" readonly required>
                    </div>
                </div>
            </div>


            <div class="form-actions">

                <button type="button" onclick="create();" class="btn btn-primary">
                    <i class="fas fa-arrow-right"></i> Complete and Submit
                </button>
            </div>
        </form>

        <div class="form-footer">
            <i class="fas fa-shield-alt"></i>
            <p>All information is secured with bank-grade 256-bit encryption.
                <a href="#">Learn more</a> about our security practices.</p>
        </div>
    </div>
</div>

<script>
    // Toggle submenus
    document.querySelectorAll('.has-submenu > a').forEach(item => {
        item.addEventListener('click', function(e) {
            e.preventDefault();
            const parent = this.parentElement;
            parent.classList.toggle('active');
            const submenu = parent.querySelector('.submenu');
            if (parent.classList.contains('active')) {
                submenu.classList.add('active');
            } else {
                submenu.classList.remove('active');
            }
        });
    });

    // Listen for changes to Account Type
    document.getElementById('state').addEventListener('change', function() {
        const interestInput = document.getElementById('interest');
        const selected = this.value;

        if (selected === 'SAVINGS') {
            interestInput.value = "3.0%";
        } else if (selected === 'FIXED_DEPOSIT') {
            interestInput.value = "5.0%";
        } else {
            interestInput.value = "";
        }
    });


    // Simple interactivity for demo purposes
    <%--document.querySelectorAll('.action-btn').forEach(btn => {--%>
    <%--    btn.addEventListener('click', function() {--%>
    <%--        const action = this.querySelector('h4').textContent;--%>
    <%--        alert(`In a real application, this would initiate: ${action}`);--%>
    <%--    });--%>
    <%--});--%>

    // // Toggle notification badge
    // document.querySelector('.notification').addEventListener('click', function() {
    //     this.querySelector('.notification-badge').style.display = 'none';
    // });

    // Set active menu item
    document.querySelectorAll('.nav-links a').forEach(link => {
        link.addEventListener('click', function() {
            document.querySelectorAll('.nav-links a').forEach(item => {
                item.classList.remove('active');
            });
            this.classList.add('active');
        });
    });

    async function create(event) {
        // ✅ Prevent default form submission
        if (event) event.preventDefault();

        const nic = document.getElementById("nic").value.trim();
        const balance = document.getElementById("balance").value.trim();
        const state = document.getElementById("state").value;

        // ✅ Check empty fields
        if (!nic || !balance || !state) {
            Swal.fire({
                icon: "error",
                title: "Missing Fields",
                text: "Please fill in all fields."
            });
            return;
        }

        const nicPattern = /^(\d{9}[vVxX]|\d{12})$/;
        if (!nicPattern.test(nic)) {
            Swal.fire({
                icon: "error",
                title: "Invalid NIC",
                text: "NIC must be 9 digits + V/X or 12 digits."
            });
            return;
        }

        const formData = new URLSearchParams();
        formData.append("nic", nic);
        formData.append("balance", balance);
        formData.append("type", state);


        try {
            const response = await fetch("/banking-system/account_register", {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                body: formData.toString()
            });

            const responseText = await response.text();
            if (responseText.trim() === "success") {
                Swal.fire({
                    title: 'Success!',
                    text: 'The account has been registered successfully.',
                    icon: 'success',
                    confirmButtonText: 'OK'
                }).then((result) => {
                    if (result.isConfirmed) {
                        // Reload the page
                        location.reload();
                    }
                });
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
</script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

</body>
</html>
