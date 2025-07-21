<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="com.example.ee.core.model.Customer" %>
<%@ page import="com.example.ee.core.model.Transaction" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.ee.core.model.ScheduledTransfer" %>
<%@ page import="com.example.ee.core.service.*" %><%--
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

        /*!* Sidebar Styles *!*/
        /*.sidebar {*/
        /*    width: var(--sidebar-width);*/
        /*    background: var(--sidebar-bg);*/
        /*    color: white;*/
        /*    height: 100vh;*/
        /*    position: fixed;*/
        /*    overflow-y: auto;*/
        /*    transition: all 0.3s ease;*/
        /*    z-index: 100;*/
        /*}*/

        /*.logo {*/
        /*    padding: 20px 15px;*/
        /*    display: flex;*/
        /*    align-items: center;*/
        /*    border-bottom: 1px solid rgba(255, 255, 255, 0.1);*/
        /*}*/

        /*.logo h2 {*/
        /*    margin-left: 12px;*/
        /*    font-size: 1.5rem;*/
        /*    font-weight: 600;*/
        /*}*/

        /*.logo i {*/
        /*    font-size: 1.8rem;*/
        /*    color: var(--primary);*/
        /*}*/


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

        /* Dashboard Stats */
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: var(--card-bg);
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.03);
            transition: transform 0.3s ease;
            border: 1px solid var(--border);
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 15px rgba(0, 0, 0, 0.05);
        }

        .stat-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .stat-title {
            font-size: 0.9rem;
            color: var(--secondary);
            font-weight: 500;
        }

        .stat-icon {
            width: 40px;
            height: 40px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .stat-icon.blue {
            background: #dbeafe;
            color: var(--primary);
        }

        .stat-icon.green {
            background: #dcfce7;
            color: var(--success);
        }

        .stat-icon.orange {
            background: #ffedd5;
            color: var(--warning);
        }

        .stat-icon.red {
            background: #fee2e2;
            color: var(--danger);
        }

        .stat-value {
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 5px;
        }

        .stat-diff {
            font-size: 0.85rem;
            display: flex;
            align-items: center;
        }

        .stat-diff.positive {
            color: var(--success);
        }

        .stat-diff.negative {
            color: var(--danger);
        }

        /* Recent Activity */
        .dashboard-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 25px;
            margin-bottom: 30px;
        }

        .card {
            background: var(--card-bg);
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.03);
            border: 1px solid var(--border);
        }

        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .card-title {
            font-size: 1.2rem;
            font-weight: 600;
            color: var(--dark);
        }

        .card-action {
            color: var(--primary);
            font-size: 0.9rem;
            font-weight: 500;
            cursor: pointer;
        }

        .transaction-list {
            list-style: none;
        }

        .transaction-item {
            display: flex;
            align-items: center;
            padding: 15px 0;
            border-bottom: 1px solid var(--border);
        }

        .transaction-item:last-child {
            border-bottom: none;
        }

        .transaction-icon {
            width: 40px;
            height: 40px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
        }

        .transaction-info {
            flex: 1;
        }

        .transaction-info h4 {
            font-size: 0.95rem;
            font-weight: 600;
            margin-bottom: 3px;
        }

        .transaction-info p {
            font-size: 0.85rem;
            color: var(--secondary);
        }

        .transaction-amount {
            font-weight: 600;
            font-size: 1.1rem;
        }

        .transaction-amount.positive {
            color: var(--success);
        }

        .transaction-amount.negative {
            color: var(--danger);
        }

        /* Quick Actions */
        .quick-actions {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 15px;
        }

        .action-button {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 20px;
            border-radius: 10px;
            background: #f8fafc;
            border: 1px dashed var(--border);
            cursor: pointer;
            transition: all 0.2s;
        }

        .action-button:hover {
            background: #f1f5f9;
            border-color: var(--primary);
        }

        .action-button i {
            font-size: 1.8rem;
            margin-bottom: 12px;
            color: var(--primary);
        }

        .action-button span {
            font-size: 0.9rem;
            font-weight: 500;
        }

        /* Responsive Design */
        @media (max-width: 992px) {
            .dashboard-grid {
                grid-template-columns: 1fr;
            }
        }

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
            <a href="adminDB.jsp" class="active">
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
            <a href="#">
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
            <a  href="${pageContext.request.contextPath}/logout" >
            <i class="fas fa-sign-out-alt"></i>
            <span>Logout</span>
        </a>
    </li>
    </ul>
</aside>

<%
    try {

        InitialContext ic = new InitialContext();
        AccountService accountService = (AccountService) ic.lookup("com.example.ee.core.service.AccountService");
        TransactionService transactionService = (TransactionService) ic.lookup("com.example.ee.core.service.TransactionService");
        AuthService authService = (AuthService) ic.lookup("com.example.ee.core.service.AuthService");

        ScheduledTransferService scheduledTransferService = (ScheduledTransferService) ic.lookup("java:global/banking-system-ear/transaction-module/ScheduledTransferServiceImpl!com.example.ee.core.service.ScheduledTransferService");


        Customer admin = (Customer) request.getSession().getAttribute("admin");


        List<Transaction> transactionList = transactionService.findlast5Transaction();
        int activeAccountCount = accountService.findActiveAccountCount();
        int activeCustomers = authService.ActiveCustomerCount();
        int totalTransactions = transactionService.findTotalTransactions();
        int pendingTransactions = scheduledTransferService.getpendingTransactions();


        System.out.println(transactionList);

        pageContext.setAttribute("admin", admin);
        pageContext.setAttribute("transList",transactionList);
        pageContext.setAttribute("activeAccountCount",activeAccountCount);
        pageContext.setAttribute("activeCustomers",activeCustomers);
        pageContext.setAttribute("totalTransactions",totalTransactions);
        pageContext.setAttribute("pendingTransactions",pendingTransactions);


    } catch (Exception e) {
        throw new RuntimeException(e);
    }
%>

<!-- Main Content -->
<div class="main-content">
    <div class="header">
        <div class="header-title">
            <h1>Admin Dashboard</h1>
            <p>Welcome back, Administrator. Here's what's happening today.</p>
        </div>

        <div class="user-menu">
            <div class="search-bar">
                <i class="fas fa-search"></i>
                <input type="text" placeholder="Search...">
            </div>

            <div class="user-profile">
                <img src="https://ui-avatars.com/api/?name=Admin&background=2563eb&color=fff" alt="Admin">
                <div class="user-info">
                    <h4>Administrator</h4>
                    <p>${admin.firstName} ${admin.lastName}</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Stats Cards -->
    <div class="stats-container">
        <div class="stat-card">
            <div class="stat-header">
                <div class="stat-title">Total Customers</div>
                <div class="stat-icon blue">
                    <i class="fas fa-users"></i>
                </div>
            </div>
            <div class="stat-value">${activeCustomers}</div>
            <div class="stat-diff positive">
                <i class="fas fa-arrow-up"></i>
                <span>12.5% since last month</span>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-header">
                <div class="stat-title">Active Accounts</div>
                <div class="stat-icon green">
                    <i class="fas fa-wallet"></i>
                </div>
            </div>
            <div class="stat-value">${activeAccountCount}</div>
            <div class="stat-diff positive">
                <i class="fas fa-arrow-up"></i>
                <span>8.3% since last month</span>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-header">
                <div class="stat-title">Total Transactions</div>
                <div class="stat-icon orange">
                    <i class="fas fa-exchange-alt"></i>
                </div>
            </div>
            <div class="stat-value">${totalTransactions}</div>
            <div class="stat-diff positive">
                <i class="fas fa-arrow-up"></i>
                <span>3.2% since yesterday</span>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-header">
                <div class="stat-title">Pending Actions</div>
                <div class="stat-icon red">
                    <i class="fas fa-exclamation-circle"></i>
                </div>
            </div>
            <div class="stat-value">${pendingTransactions}</div>
            <div class="stat-diff negative">
                <i class="fas fa-arrow-down"></i>
                <span>2.3% since yesterday</span>
            </div>
        </div>
    </div>

    <!-- Dashboard Grid -->
    <div class="dashboard-grid">
        <!-- Recent Transactions -->
        <div class="card">
            <div class="card-header">
                <div class="card-title">Recent Transactions</div>
                <div class="card-action">View All</div>
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
                            <td class="transaction-amount positive">Rs.${transaction.amount}</td>
                            <td><span class="transaction-status status-completed">Completed</span></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="card">
            <div class="card-header">
                <div class="card-title">Quick Actions</div>
            </div>
            <div class="quick-actions">
                <a  style="text-decoration: none" href="customerRegistration.jsp">
                <div class="action-button">
                    <i class="fas fa-user-plus"></i>
                    <span>New Customer</span>
                </div>
                </a>
                <a  style="text-decoration: none" href="accoutRegistration.jsp">
                <div class="action-button">
                    <i class="fas fa-plus-circle"></i>
                    <span>Create Account</span>
                </div>
                </a>
                <a style="text-decoration: none" href="adminTransaction.jsp">
                <div class="action-button">
                    <i class="fas fa-file-invoice-dollar"></i>
                    <span>Money Deposit</span>
                </div>
                </a>
                <div class="action-button">
                    <i class="fas fa-cog"></i>
                    <span>Settings</span>
                </div>
            </div>
        </div>
    </div>

    <!-- System Status -->
    <div class="card">
        <div class="card-header">
            <div class="card-title">System Status</div>
            <div class="card-action">View Details</div>
        </div>
        <div class="stats-container" style="margin-bottom: 0;">
            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-title">API Status</div>
                </div>
                <div class="stat-value" style="color: var(--success);">Operational</div>
                <div class="stat-diff">
                    <span>All systems normal</span>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-title">Security Level</div>
                </div>
                <div class="stat-value" style="color: var(--success);">High</div>
                <div class="stat-diff">
                    <span>No threats detected</span>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-title">Database</div>
                </div>
                <div class="stat-value" style="color: var(--success);">Online</div>
                <div class="stat-diff">
                    <span>98.7% uptime</span>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-title">Backup Status</div>
                </div>
                <div class="stat-value" style="color: var(--success);">Completed</div>
                <div class="stat-diff">
                    <span>Last: Today 2:30 AM</span>
                </div>
            </div>
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
</script>
</body>
</html>
