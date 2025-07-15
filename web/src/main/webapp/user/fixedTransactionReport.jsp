<%@ page import="javax.naming.InitialContext" %>
<%@ page import="com.example.ee.core.service.AccountService" %>
<%@ page import="com.example.ee.core.model.Account" %>
<%@ page import="com.example.ee.core.service.TransactionService" %>
<%@ page import="com.example.ee.core.model.Customer" %>
<%@ page import="com.example.ee.core.model.Transaction" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vexa - Modern Banking Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #2563eb;
            --primary-dark: #1d4ed8;
            --secondary: #475569;
            --accent: #0ea5e9;
            --light: #f8fafc;
            --dark: #0f172a;
            --success: #10b981;
            --warning: #f59e0b;
            --danger: #ef4444;
            --card-bg: #ffffff;
            --sidebar-bg: #1e293b;
            --border: #e2e8f0;
            --shadow: rgba(0, 0, 0, 0.08);
            --sidebar-width: 280px;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Roboto', sans-serif;
            background: linear-gradient(135deg, #f1f5f9 0%, #e2e8f0 100%);
            color: var(--dark);
            display: flex;
            min-height: 100vh;
            overflow-x: hidden;
        }

        /*////*/
        h1 {
            margin-bottom: 20px;
        }
        form {
            background: #fff;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            display: inline-block;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background: #fff;
            border-radius: 8px;
            overflow: hidden;
        }
        th, td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
        }
        th {
            background: #2563eb;
            color: white;
            text-align: left;
        }
        tr:hover {
            background: #f0f0f0;
        }
        .btn {
            padding: 8px 12px;
            margin-top: 8px;
            border: none;
            background: #2563eb;
            color: white;
            border-radius: 4px;
            cursor: pointer;
        }
        .btn-download {
            background: #10b981;
        }
        .btn:hover {
            opacity: 0.9;
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
            content: "•";
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

        /* Main Content Area */
        .main-content {
            flex: 1;
            margin-left: var(--sidebar-width);
            padding: 24px;
        }

        /* Top Bar */
        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 32px;
            background: white;
            padding: 16px 24px;
            border-radius: 16px;
            box-shadow: 0 4px 6px var(--shadow);
        }

        .page-title h2 {
            font-family: 'Poppins', sans-serif;
            font-weight: 600;
            font-size: 24px;
            color: var(--dark);
        }

        .page-title p {
            color: var(--secondary);
            font-size: 14px;
            margin-top: 4px;
        }

        .user-actions {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .notification {
            position: relative;
            cursor: pointer;
        }

        .notification i {
            font-size: 20px;
            color: var(--secondary);
        }

        .notification-badge {
            position: absolute;
            top: -5px;
            right: -5px;
            background: var(--danger);
            color: white;
            font-size: 10px;
            width: 18px;
            height: 18px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .user-profile {
            display: flex;
            align-items: center;
            gap: 12px;
            cursor: pointer;
        }

        .avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: var(--primary);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 500;
            font-size: 18px;
        }

        .user-info h4 {
            font-weight: 500;
            font-size: 15px;
        }

        .user-info p {
            color: var(--secondary);
            font-size: 13px;
        }

        /* Dashboard Content */
        .dashboard-content {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 24px;
        }

        /* Cards */
        .card {
            background: var(--card-bg);
            border-radius: 16px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            padding: 24px;
            margin-bottom: 24px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.08);
        }

        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .card-title {
            font-family: 'Poppins', sans-serif;
            font-weight: 600;
            font-size: 18px;
            color: var(--dark);
        }

        .card-action {
            color: var(--primary);
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s;
        }

        .card-action:hover {
            color: var(--primary-dark);
        }

        /* Account Summary */
        .account-summary {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 16px;
            margin-bottom: 24px;
        }

        .account-card {
            background: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
            border-radius: 12px;
            padding: 20px;
            color: white;
            position: relative;
            overflow: hidden;
            box-shadow: 0 8px 15px rgba(37, 99, 235, 0.2);
        }

        .account-card::before {
            content: "";
            position: absolute;
            top: -50px;
            right: -50px;
            width: 150px;
            height: 150px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.1);
        }

        .account-card::after {
            content: "";
            position: absolute;
            bottom: -80px;
            right: -30px;
            width: 120px;
            height: 120px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.1);
        }

        .account-type {
            font-size: 14px;
            opacity: 0.9;
            margin-bottom: 5px;
        }

        .account-number {
            font-size: 16px;
            letter-spacing: 1px;
            margin-bottom: 15px;
            font-weight: 500;
        }

        .account-balance {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 5px;
            font-family: 'Poppins', sans-serif;
        }

        .account-details {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
            font-size: 14px;
        }

        /* Quick Actions */
        .quick-actions {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 16px;
            margin-bottom: 24px;
        }

        .action-btn {
            background: white;
            border-radius: 12px;
            padding: 20px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
            border: 1px solid var(--border);
            box-shadow: 0 4px 6px rgba(0,0,0,0.03);
        }

        .action-btn:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 15px rgba(0,0,0,0.05);
            border-color: var(--primary);
            background: #f8fafc;
        }

        .action-btn i {
            font-size: 28px;
            color: var(--primary);
            margin-bottom: 12px;
        }

        .action-btn h4 {
            font-size: 14px;
            font-weight: 500;
        }

        /* Recent Transactions */
        .transactions {
            overflow-x: auto;
        }

        .transactions table {
            width: 100%;
            border-collapse: collapse;
        }

        .transactions th {
            text-align: left;
            padding: 12px 0;
            font-weight: 500;
            color: var(--secondary);
            font-size: 14px;
            border-bottom: 1px solid var(--border);
        }

        .transactions td {
            padding: 16px 0;
            border-bottom: 1px solid var(--border);
        }

        .transaction-detail {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .transaction-icon {
            width: 40px;
            height: 40px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .icon-income {
            background: rgba(16, 185, 129, 0.1);
            color: var(--success);
        }

        .icon-expense {
            background: rgba(239, 68, 68, 0.1);
            color: var(--danger);
        }

        .icon-transfer {
            background: rgba(37, 99, 235, 0.1);
            color: var(--primary);
        }

        .transaction-info h4 {
            font-weight: 500;
            margin-bottom: 4px;
            font-size: 15px;
        }

        .transaction-info p {
            color: var(--secondary);
            font-size: 13px;
        }

        .transaction-amount.positive {
            color: var(--success);
            font-weight: 500;
        }

        .transaction-amount.negative {
            color: var(--danger);
            font-weight: 500;
        }

        .transaction-status {
            font-size: 12px;
            padding: 4px 8px;
            border-radius: 20px;
            font-weight: 500;
        }

        .status-completed {
            background: rgba(16, 185, 129, 0.1);
            color: var(--success);
        }

        .status-pending {
            background: rgba(245, 158, 11, 0.1);
            color: var(--warning);
        }

        /* Stats Cards */
        .stats-cards {
            display: grid;
            grid-template-columns: 1fr;
            gap: 16px;
        }

        .stat-card {
            background: white;
            border-radius: 12px;
            padding: 20px;
            display: flex;
            align-items: center;
            gap: 16px;
            transition: all 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 15px rgba(0,0,0,0.05);
        }

        .stat-icon {
            width: 50px;
            height: 50px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
        }

        .icon-1 {
            background: rgba(37, 99, 235, 0.1);
            color: var(--primary);
        }

        .icon-2 {
            background: rgba(16, 185, 129, 0.1);
            color: var(--success);
        }

        .icon-3 {
            background: rgba(245, 158, 11, 0.1);
            color: var(--warning);
        }

        .stat-info h3 {
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 4px;
            font-family: 'Poppins', sans-serif;
        }

        .stat-info p {
            color: var(--secondary);
            font-size: 14px;
        }

        /* Responsive Design */
        @media (max-width: 1200px) {
            .quick-actions {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 992px) {
            .dashboard-content {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 768px) {
            :root {
                --sidebar-width: 70px;
            }

            .logo h1, .nav-links a span, .has-submenu > a::after {
                display: none;
            }

            .logo {
                justify-content: center;
                padding: 0 0 24px;
            }

            .logo i {
                margin-right: 0;
                font-size: 30px;
            }

            .nav-links a {
                justify-content: center;
                padding: 16px;
            }

            .nav-links a i {
                margin-right: 0;
                font-size: 20px;
            }

            .submenu {
                display: none;
            }

            .main-content {
                margin-left: var(--sidebar-width);
            }

            .user-info {
                display: none;
            }
        }

        @media (max-width: 576px) {
            .top-bar {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }

            .quick-actions {
                grid-template-columns: 1fr;
            }

            .account-summary {
                grid-template-columns: 1fr;
            }
        }

        .transactions tbody tr:hover {
            background: rgba(0,0,0,0.02);
            cursor: pointer;
        }

    </style>
</head>
<body>
<!-- Sidebar Navigation -->
<aside class="sidebar">
    <div class="logo">
        <i class="fas fa-university"></i>
        <h1>VexaBank</h1>
    </div>
    <ul class="nav-links">
        <li>
            <a href="userDB.jsp" >
                <i class="fas fa-home"></i>
                <span>Dashboard</span>
            </a>
        </li>
        <li class="has-submenu">
            <a href="#">
                <i class="fas fa-exchange-alt"></i>
                <span>Transfers</span>
            </a>
            <ul class="submenu">
                <li><a href="userTransaction.jsp">New Transfer</a></li>
                <li><a href="scheduleTrnsManagement.jsp">Scheduled Transfers</a></li>
            </ul>
        </li>
        <li>
            <a href="transactionReport.jsp">
                <i class="fas fa-file-invoice-dollar"></i>
                <span>Saving Reports</span>
            </a>
        </li>
        <li>
            <a href="fixedTransactionReport.jsp" class="active">
                <i class="fas fa-file-invoice-dollar"></i>
                <span>Fixed Reports</span>
            </a>
        </li>
<%--        <li>--%>
<%--            <a href="#">--%>
<%--                <i class="fas fa-cog"></i>--%>
<%--                <span>Settings</span>--%>
<%--            </a>--%>
<%--        </li>--%>
        <li>
            <a  href="${pageContext.request.contextPath}/logout" >
                <i class="fas fa-sign-out-alt"></i>
                <span>Logout</span>
            </a>
        </li>
    </ul>
</aside>
<%

    Account account;
    List<Transaction> transactions;
    try {
        InitialContext ic = new InitialContext();
        AccountService accountService = (AccountService) ic.lookup("com.example.ee.core.service.AccountService");
        TransactionService transactionService = (TransactionService) ic.lookup("com.example.ee.core.service.TransactionService");

        Customer customer = (Customer) request.getSession().getAttribute("customer");

        account = accountService.findFixedAccountByCustomerId(customer.getCustomerId());

        if (account==null){

        }

//        account = (Account) request.getAttribute("account");
        transactions = (List<Transaction>) request.getAttribute("transactions");

    } catch (Exception e) {
        throw new RuntimeException(e);
    }
%>
<!-- Main Content -->
<main class="main-content">
    <h1>Fixed Deposit Transaction Report</h1>
    <form id="filterForm" method="get" action="<%=request.getContextPath()%>/user/fixedtransactionReport">
        <input  type="hidden" name="accountId" value="<%=account != null ? account.getAccountId() : ""%>"/>
        From:
        <input type="date" name="fromDate" required>
        To:
        <input type="date" name="toDate" required>
        <button type="submit"  <%= account == null ? "disabled" : "" %> class="btn">Search</button>
        <button type="button"
                <%= account == null ? "disabled" : "" %>
                id="down"
                onclick="download();"
                class="btn btn-download">
            Download PDF
        </button>

    </form>


    <table>
        <thead>
        <tr>
            <th>Date</th>
            <th>TO Account</th>
            <th>Description</th>
            <th>Amount</th>
            <th>Type</th>
        </tr>
        </thead>
        <tbody>
        <%
            if (transactions != null && !transactions.isEmpty()) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss a");
                for (Transaction t : transactions) {
                    request.setAttribute("transaction", t);
                    request.setAttribute("fixedaccount", account);
        %>
        <tr>
            <td><%=sdf.format(t.getCreatedAt())%></td>
            <td><%=t.getTodAccount().getAccountNumber()%></td>
            <td><%=t.getDescription()%></td>
            <c:choose>
                <c:when test="${transaction.fromAccount.accountId == fixedaccount.accountId}">
                    <%--                <td class="transaction-amount negative">-Rs.${transaction.amount}</td>--%>
                    <td class="transaction-amount negative">-RS.<%=String.format("%.2f", t.getAmount())%></td>
                </c:when>
                <c:otherwise>
                    <%--                <td class="transaction-amount positive">+Rs.${transaction.amount}</td>--%>
                    <td class="transaction-amount positive">+RS.<%=String.format("%.2f", t.getAmount())%></td>
                </c:otherwise>
            </c:choose>
            <td><%=t.getTransactionType().toString()%></td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="4" style="text-align:center;">No transactions found.</td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
</main>

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

    // Simple interactivity for demo purposes
    document.querySelectorAll('.action-btn').forEach(btn => {
        btn.addEventListener('click', function() {
            const action = this.querySelector('h4').textContent;
            alert(`In a real application, this would initiate: ${action}`);
        });
    });

    // Toggle notification badge
    document.querySelector('.notification').addEventListener('click', function() {
        this.querySelector('.notification-badge').style.display = 'none';
    });

    // Set active menu item
    document.querySelectorAll('.nav-links a').forEach(link => {
        link.addEventListener('click', function() {
            document.querySelectorAll('.nav-links a').forEach(item => {
                item.classList.remove('active');
            });
            this.classList.add('active');
        });
    });

    function download() {
        const currentUrl = window.location.href;
        const url = new URL(currentUrl);
        const params = url.searchParams;

        const hasAccountId = params.has("accountId");
        const hasFromDate = params.has("fromDate");
        const hasToDate = params.has("toDate");


        if (hasAccountId && hasFromDate && hasToDate) {
            const newUrl = currentUrl.replace("/user/fixedtransactionReport", "/user/downloadTransactionReport");
            console.log("New URL:", newUrl);
            window.location.href = newUrl;
            return newUrl;
        } else {
            Swal.fire({
                icon: "error",
                title: "Failed",
                text: "First Search Results"
            });
            console.log("Missing one or more required parameters.");
        }

    }

</script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

</body>
</html>
