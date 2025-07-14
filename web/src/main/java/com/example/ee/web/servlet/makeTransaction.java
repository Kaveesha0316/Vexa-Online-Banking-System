package com.example.ee.web.servlet;

import com.example.ee.core.exception.InsufficientFundsException;
import com.example.ee.core.model.*;
import com.example.ee.core.service.AccountService;
import com.example.ee.core.service.TransactionOrchestratorService;
import com.example.ee.core.service.TransactionService;
import jakarta.ejb.EJB;
import jakarta.ejb.EJBTransactionRolledbackException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.Date;

@WebServlet("/make_transaction")
public class makeTransaction extends HttpServlet {

    @EJB
    AccountService accountService;

    @EJB
    TransactionService transactionService;

    @EJB
    TransactionOrchestratorService transactionOrchestratorService;


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String from =req.getParameter("from");
        String to = req.getParameter("to");
        String amount = req.getParameter("amount");
        String description =req.getParameter("desc");

        Account fromAccount = accountService.findAccountByAccountNumber(from);
        Account toAccount = accountService.findAccountByAccountNumber(to);
        resp.setContentType("text/plain");



        if (toAccount == null) {
            resp.getWriter().write("Invalid Account Number");
        }else if (toAccount.getAccountType() != AccountType.SAVINGS || fromAccount.getAccountType() != AccountType.SAVINGS) {
            resp.getWriter().write("You can only make transactions with savings accounts");
        }else if (toAccount.getStatus() != Status.ACTIVE || fromAccount.getStatus() != Status.ACTIVE) {
            resp.getWriter().write("You can only make transactions with active accounts");
        }else {
            try {
                Transaction transaction = new Transaction(
                        fromAccount,
                        toAccount,
                        TransactionType.WITHDRAWAL,
                        Double.parseDouble(amount),
                        description,
                        new Date()
                );

                transactionOrchestratorService.makeTransaction(
                        fromAccount.getAccountId(),
                        toAccount.getAccountId(),
                        Double.parseDouble(amount),
                        description,
                        transaction
                );

                resp.getWriter().write("success");

            } catch (InsufficientFundsException ex) {
                resp.getWriter().write(ex.getMessage());
            } catch (IllegalArgumentException ex) {
                // This comes from debitAccount() or creditAccount()
                resp.getWriter().write(ex.getMessage());
            } catch (Exception ex) {
                ex.printStackTrace();
                resp.getWriter().write("Unexpected error occurred");
            }

        }

    }
}
