        <%@ page import="javax.naming.InitialContext" %>
<%@ page import="com.example.ee.core.service.AccountService" %>
<%@ page import="com.example.ee.core.model.Customer" %>
<%@ page import="com.example.ee.core.model.Account" %>
        <%@ page import="com.example.ee.core.service.TransactionService" %>
        <%@ page import="java.util.List" %>
        <%@ page import="com.example.ee.core.model.Transaction" %>
        <%@ page import="com.example.ee.core.service.ScheduledTransferService" %>
        <%@ page import="com.example.ee.core.model.ScheduledTransfer" %>
        <%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

        /*//////*/

        .modal {
            display: none;
            position: fixed;
            z-index: 999;
            padding-top: 100px;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.5);
        }

        .modal-content {
            background-color: #fff;
            margin: auto;
            padding: 20px;
            border: 1px solid #888;
            width: 90%;
            max-width: 400px;
            border-radius: 8px;
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 24px;
            font-weight: bold;
            cursor: pointer;
        }

        .close:hover {
            color: #000;
        }

        .modal-content h2 {
            margin-top: 0;
        }

        .modal-content form {
            display: flex;
            flex-direction: column;
        }

        .modal-content label {
            margin-top: 10px;
        }

        .modal-content input {
            padding: 8px;
            margin-top: 4px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .modal-content button {
            margin-top: 20px;
            padding: 10px;
            background-color: var(--primary);
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .modal-content button:hover {
            background-color: var(--primary-dark);
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
            display: block;
            text-decoration: none;
            color: white;
            background: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
            border-radius: 12px;
            padding: 24px;
            position: relative;
            overflow: hidden;
            box-shadow: 0 8px 15px rgba(37, 99, 235, 0.2);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            text-decoration: none;
        }

        .account-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 12px 25px rgba(0,0,0,0.1);
            text-decoration: none;
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
            text-decoration: none;
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
            text-decoration: none;
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
            <a href="#" class="active">
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
            <a href="fixedTransactionReport.jsp">
                <i class="fas fa-file-invoice-dollar"></i>
                <span>Fixed Reports</span>
            </a>
        </li>
        <li>
            <a href="#" onclick="sendVerificationEmail();">
                <i class="fas fa-cog"></i>
                <span>Change Password</span>
            </a>
        </li>
        <li>
            <a  href="${pageContext.request.contextPath}/logout" >
                <i class="fas fa-sign-out-alt"></i>
                <span>Logout</span>
            </a>
        </li>
    </ul>
</aside>

<%
    Account savingaccount;
    Account fixedaccount;
    try {

        InitialContext ic = new InitialContext();
        AccountService accountService = (AccountService) ic.lookup("com.example.ee.core.service.AccountService");
        TransactionService transactionService = (TransactionService) ic.lookup("com.example.ee.core.service.TransactionService");

        ScheduledTransferService scheduledTransferService = (ScheduledTransferService) ic.lookup("java:global/banking-system-ear/transaction-module/ScheduledTransferServiceImpl!com.example.ee.core.service.ScheduledTransferService");


        Customer customer = (Customer) request.getSession().getAttribute("customer");

        savingaccount = accountService.findAccountByCustomerId(customer.getCustomerId());
        fixedaccount = accountService.findFixedAccountByCustomerId(customer.getCustomerId());

        List<Transaction> transactionList = transactionService.findlast5TransactionByFromAc(savingaccount.getAccountId());
        List<ScheduledTransfer> scheduledTransferList = scheduledTransferService.get5ScheduledTransfersBYAccountId(savingaccount.getAccountId());
        Double income = transactionService.findMonthlyIncome(savingaccount.getAccountId());
        Double expense = transactionService.findMonthlyExpense(savingaccount.getAccountId());

        pageContext.setAttribute("savingaccount", savingaccount);
        pageContext.setAttribute("fixedaccount", fixedaccount);
        pageContext.setAttribute("customer", customer);
        pageContext.setAttribute("transList",transactionList);
        pageContext.setAttribute("scheduledTransferList",scheduledTransferList);
        pageContext.setAttribute("income",income);
        pageContext.setAttribute("expense",expense);

        System.out.println(transactionList);

    } catch (Exception e) {
        throw new RuntimeException(e);
    }
%>

<!-- Main Content -->
<main class="main-content">
    <!-- Top Bar -->
    <div class="top-bar">
        <div class="page-title">
            <h2>Dashboard</h2>
            <p>Welcome back, ${customer.firstName}! Here's your financial summary.</p>
        </div>
        <div class="user-actions">
            <div class="notification">
                <i class="fas fa-bell"></i>
                <span class="notification-badge">3</span>
            </div>
            <div class="user-profile">
                <div class="avatar"> ${fn:toUpperCase(fn:substring(customer.firstName,0,1))}${fn:toUpperCase(fn:substring(customer.lastName,0,1))}</div>
                <div class="user-info">
                    <h4>${customer.firstName} ${customer.lastName}</h4>
                    <p>Premium Member</p>
                </div>
                <i class="fas fa-chevron-down"></i>
            </div>
        </div>
    </div>

    <!-- Dashboard Content -->
    <div class="dashboard-content">
        <!-- Left Column -->
        <div class="left-column">
            <!-- Account Summary -->
            <div class="account-summary">
                <a href="savingAccountDetails.jsp" class="account-card">
                    <div class="account-type">Saving Account</div>
                    <div class="account-number">****** ${savingaccount.accountNumber.substring(6)}</div>
                    <div class="account-balance">Rs.${savingaccount.balance}</div>
                    <div class="account-details">
                        <span>${savingaccount.interestRate}0%</span>
                        <span>Vexa Bank</span>
                    </div>
                </a>

                <% if (fixedaccount != null) { %>
                <a href="fixedAccountDetails.jsp" class="account-card" style="background: linear-gradient(135deg, #0f172a 0%, #334155 100%);">
                    <div class="account-type">Fixed Account</div>
                    <div class="account-number">****** <%=fixedaccount.getAccountNumber().substring(6)%></div>
                    <div class="account-balance">Rs.<%=fixedaccount.getBalance()%></div>
                    <div class="account-details">
                        <span><%=fixedaccount.getInterestRate()%>0%</span>
                        <span>Vexa Bank</span>
                    </div>
                </a>
                <% } else { %>
                <a href="#" class="account-card" style="background: linear-gradient(135deg, #0f172a 0%, #334155 100%);">
                    <div class="account-type">Fixed Account</div>
                    <div class="account-number">****** (Not Available)</div>
                    <div class="account-balance">Rs.0.00</div>
                    <div class="account-details">
                        <span>0.0%</span>
                        <span>Vexa Bank</span>
                    </div>
                </a>
                <% } %>
            </div>


            <!-- Quick Actions -->
<%--            <div class="quick-actions">--%>
<%--                <div class="action-btn">--%>
<%--                    <i class="fas fa-paper-plane"></i>--%>
<%--                    <h4>Send Money</h4>--%>
<%--                </div>--%>
<%--                <div class="action-btn">--%>
<%--                    <i class="fas fa-exchange-alt"></i>--%>
<%--                    <h4>Transfer</h4>--%>
<%--                </div>--%>
<%--                <div class="action-btn">--%>
<%--                    <i class="fas fa-mobile-alt"></i>--%>
<%--                    <h4>Pay Bills</h4>--%>
<%--                </div>--%>
<%--                <div class="action-btn">--%>
<%--                    <i class="fas fa-download"></i>--%>
<%--                    <h4>Deposit</h4>--%>
<%--                </div>--%>
<%--            </div>--%>

            <!-- Recent Transactions -->
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">Recent Transactions</h3>
                    <span class="card-action">View All</span>
                </div>
                <div class="transactions">
                    <table>
                        <thead>
                        <tr>
                            <th>DESCRIPTION</th>
                            <th>DATE</th>
                            <th>AMOUNT</th>
                            <th>STATUS</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="transaction" items="${transList}">
                        <tr>
                            <td>
                                <div class="transaction-detail">
                                    <div class="transaction-info">
                                        <h4>${transaction.description}</h4>
                                    </div>
                                </div>
                            </td>
                            <td><fmt:formatDate value="${transaction.createdAt}" pattern="MMM d, yyyy" /></td>
                            <c:choose>
                                <c:when test="${transaction.fromAccount.accountId == savingaccount.accountId}">
                                    <td class="transaction-amount negative">-Rs.${transaction.amount}</td>
                                </c:when>
                                <c:otherwise>
                                    <td class="transaction-amount positive">+Rs.${transaction.amount}</td>
                                </c:otherwise>
                            </c:choose>
                            <td><span class="transaction-status status-completed">Completed</span></td>
                        </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Right Column -->
        <div class="right-column">
            <!-- Financial Summary -->
            <div class="stats-cards">
                <div class="stat-card">
                    <div class="stat-icon icon-1">
                        <i class="fas fa-arrow-up"></i>
                    </div>
                    <div class="stat-info">
                        <h3>Rs.${income}</h3>
                        <p>Monthly Income</p>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon icon-2">
                        <i class="fas fa-arrow-down"></i>
                    </div>
                    <div class="stat-info">
                        <h3>Rs.${expense}0</h3>
                        <p>Monthly Expenses</p>
                    </div>
                </div>
            </div>

            <!-- Upcoming Bills -->
            <div class="card" style="margin-top: 10px;">
                <div class="card-header">
                    <h3 class="card-title">Upcoming Schedules</h3>
                    <span class="card-action">Manage</span>
                </div>
                <div class="transactions">
                    <table>
                        <tbody>
        <c:forEach var="shedules" items="${scheduledTransferList}">
                        <tr>
                            <td>
                                <div class="transaction-detail">
                                    <div class="transaction-icon" style="background: rgba(245, 158, 11, 0.1); color: var(--warning);">
                                        <i class="fas fa-credit-card"></i>
                                    </div>
                                    <div class="transaction-info">
                                        <h4>${shedules.toAccount.accountNumber}</h4>
                                        <p><fmt:formatDate value="${shedules.createdAt}" pattern="MMM d, yyyy" /></p>
                                    </div>
                                </div>
                            </td>
                            <td style="margin-right: -20px" class="transaction-amount negative">-Rs.${shedules.amount}0</td>
                        </tr>
        </c:forEach>

                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div id="changePasswordModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="document.getElementById('changePasswordModal').style.display='none'">&times;</span>
            <h2>Change Password</h2>
            <form  method="post">
                <label for="verificationCode">Verification Code</label>
                <input type="text" id="verificationCode" name="verificationCode" required>

                <label for="oldPassword">Old Password</label>
                <input type="password" id="oldPassword" name="oldPassword" required>

                <label for="newPassword">New Password</label>
                <input type="password" id="newPassword" name="newPassword" required>

                <button type="button" onclick="changePassword()">Submit</button>
            </form>
        </div>
    </div>

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

    function sendVerificationEmail() {
        // Call your servlet or REST endpoint to send the email
        fetch('/banking-system/sendVerificationCode', { method: 'POST' })
            .then(response => {
                if (response.ok) {
                    // Email sent successfully, show modal
                    Swal.fire({
                        icon: "Verification",
                        title: "Verification Code has been sent",
                        text: "Please check your email",
                    });
                    document.getElementById('changePasswordModal').style.display = 'block';
                } else {
                    alert('Failed to send verification email. Please try again.');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('An error occurred while sending the email.');
            });
    }

    async function changePassword(event) {

        if (event) event.preventDefault();

        const verificationCode = document.getElementById("verificationCode").value;
        const oldPassword = document.getElementById("oldPassword").value.trim();
        const newPassword = document.getElementById("newPassword").value.trim();




        if (!verificationCode || !oldPassword || !newPassword) {
            Swal.fire({
                icon: "error",
                title: "Missing Fields",
                text: "Please fill in all fields."
            });
            return;
        }

        // Strong password regex:
        const strongPasswordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$/;

        if (!strongPasswordRegex.test(newPassword)) {
            Swal.fire({
                icon: "error",
                title: "Weak Password",
                html: `
                <p>Your new password must contain:</p>
                <ul style="text-align: left; margin-left: 1em;">
                    <li>At least 8 characters</li>
                    <li>At least 1 uppercase letter</li>
                    <li>At least 1 lowercase letter</li>
                    <li>At least 1 number</li>
                    <li>At least 1 special character</li>
                </ul>`
            });
            return;
        }



        const formData = new URLSearchParams();
        formData.append("verificationCode", verificationCode);
        formData.append("oldPassword", oldPassword);
        formData.append("newPassword", newPassword);

        try {
            const response = await fetch("/banking-system/change_password", {
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
                    text: 'Password updated successfully!',
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

    window.onclick = function(event) {
        const modal = document.getElementById('changePasswordModal');
        if (event.target === modal) {
            modal.style.display = "none";
        }
    }
</script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</body>
</html>
