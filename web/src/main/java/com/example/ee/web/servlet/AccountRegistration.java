package com.example.ee.web.servlet;

import com.example.ee.core.model.*;
import com.example.ee.core.service.AccountService;
import com.example.ee.core.service.AuthService;
import com.example.ee.core.service.CustomerService;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

@WebServlet("/account_register")
public class AccountRegistration extends HttpServlet {

    @EJB
    AccountService accountService;

    @EJB
    CustomerService customerService;

    @EJB
    AuthService authService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/plain");

        try {
            String nic = req.getParameter("nic");
            String acTypeParam = req.getParameter("type");
            String balanceParam = req.getParameter("balance");

            if (nic == null || acTypeParam == null || balanceParam == null) {
                resp.getWriter().write("Missing parameters");
                return;
            }

            AccountType accountType;
            try {
                accountType = AccountType.valueOf(acTypeParam);
            } catch (IllegalArgumentException ex) {
                resp.getWriter().write("Invalid AccountType");
                return;
            }

            Double acBalance;
            try {
                acBalance = Double.valueOf(balanceParam);
            } catch (NumberFormatException ex) {
                resp.getWriter().write("Invalid AccountBalance");
                return;
            }

            if(Double.parseDouble(balanceParam) < 1000.0){
                resp.getWriter().write("Account Balance is less than 1000.00");
                return;
            }

            Customer customer = customerService.findCustomerByNic(nic);
            if (customer == null) {
                resp.getWriter().write("Invalid NIC");
                return;
            }else {
                User user = authService.findUserByCustomerId(customer.getCustomerId());
                if (user.getStatus() == Status.INACTIVE) {
                    resp.getWriter().write("This user blocked");
                    return;
                }
            }
            List<Account> accountList = accountService.checkAccountCount(customer.getCustomerId());
            int savings = 0;
            int fixed = 0;
            for (Account account : accountList) {
                if (account.getAccountType() == AccountType.SAVINGS) {
                    savings++;
                } else if (account.getAccountType() == AccountType.FIXED_DEPOSIT) {
                    fixed++;
                }
            }

            if (accountType == AccountType.SAVINGS && savings >= 1) {
                resp.getWriter().write("Customer has reached limit of 1 Savings account");
                return;
            }
            if (accountType == AccountType.FIXED_DEPOSIT && fixed >= 1) {
                resp.getWriter().write("Customer has reached limit of 1 Fixed Deposit account");
                return;
            }

            String accountNumber = generateAccountNumber();

            Double interestRate = (accountType == AccountType.SAVINGS) ? 3.0 : 5.0;

            Account account = new Account(
                    customer,
                    accountNumber,
                    accountType,
                    acBalance,
                    interestRate,
                    Status.ACTIVE,
                    LocalDateTime.now()
            );

            accountService.createAccount(account);
            resp.getWriter().write("success");

        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().write("Error: " + e.getMessage());
        }
    }

    private String generateAccountNumber() {
        long min = 1_000_000_000L;
        long max = 9_999_999_999L;
        long number = min + (long)(Math.random() * (max - min));
        return String.valueOf(number);
    }
}

