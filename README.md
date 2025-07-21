# 🏦 Vexa Banking System – Java EE (EAR Project)

This project is a Vexa Banking System developed using Java EE (Jakarta EE) as an Enterprise Archive (EAR) application. It supports secure, modular banking operations for both administrators and customers, including account management, transaction processing, scheduled tasks, and role-based authentication.

## 🔧 Tech Stack

- Java EE 7 / Jakarta EE
- EJB (Stateless, Singleton, Timer Services)
- JSP & Servlets
- JPA (EclipseLink)
- MySQL
- GlassFish Application Server
- JavaMail (MailTrap)
- JAAS / Container Managed Security
- Maven (EAR, EJB, WAR Modules)

## 📁 Project Modules

The system is structured using a multi-module EAR design:

- `auth` – User authentication & authorization (EJB)
- `account` – Account creation, interest processing, deposits (EJB)
- `customer` – Customer management (EJB)
- `transaction` – Fund transfers, scheduled transactions, transaction history (EJB)
- `core` – Shared components like interceptors, enums, exceptions
- `web` – JSP/Servlet-based user and admin front-end (WAR)

## 🔐 User Roles

- `ADMIN`: Manages users, accounts, deposit, audits
- `CUSTOMER`: Can log in, transfer funds, view/download statements, schedule transfers

## ✨ Key Features

- 🧑‍💼 Admin Panel: Dashboard with stats, user/account management, audit & transaction logs
- 👤 Customer Panel: Fund transfers, view history, download PDF, income/expense charts
- 🔄 Scheduled Transactions: Executed using EJB programmatic timers
- 💰 Monthly Interest: Automatically added via `@Schedule` EJB timers
- 🔐 Role-Based Access Control: Secured via `@RolesAllowed`, web.xml, and JAAS
- 📧 Email Notifications: Auto-generated credentials sent via MailTrap
- 📋 Audit Logging: Cross-cutting auditing using EJB Interceptors
- 🛠️ Error Pages: Custom JSP error handlers (401, 403, 404, 500)

## 🏁 How It Works

1. Admin logs in to register customers and create accounts (savings/fixed).
2. Customers receive email with username and auto-generated password.
3. Customers can log in, update password, transfer funds, or schedule transactions.
4. Scheduled tasks execute at specified times or on month start using EJB Timer Services.
5. Both admin and users can view/download transaction histories and dashboards.

## 🧪 Testing Strategy

- Transaction integrity tested using pessimistic locking and exception simulation
- Timer-based scheduled jobs validated with different time/date conditions
- Role-based access tested via secured URL patterns and JAAS
- Security tested with invalid role access and exception logging

## 💡 Sample Admin Dashboard

- Total Customers
- Active Accounts
- Pending Scheduled Transactions
- Total Fund Transfers

## 📂 How to Deploy

1. Import the EAR Maven project in IntelliJ IDEA / NetBeans.
2. Configure MySQL datasource.
3. Build and deploy to Payara Server.


## 🧑‍💻 Developed By

Kaveesha Danujaya – Final Year Java EE Project (BDC2)
Follow me on [LinkedIn](https://www.linkedin.com/) for updates and other projects!
