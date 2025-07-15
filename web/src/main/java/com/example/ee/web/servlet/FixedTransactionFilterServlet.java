package com.example.ee.web.servlet;

import com.example.ee.core.model.Account;
import com.example.ee.core.model.Transaction;
import com.example.ee.core.service.AccountService;
import com.example.ee.core.service.TransactionService;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet("/user/fixedtransactionReport")
public class FixedTransactionFilterServlet extends HttpServlet {
    @EJB
    private TransactionService transactionService;

    @EJB
    private AccountService accountService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String fromDateStr = req.getParameter("fromDate");
        String toDateStr = req.getParameter("toDate");
        String accountIdStr = req.getParameter("accountId");

        System.out.println("fromDateStr: " + fromDateStr);
        System.out.println("toDateStr: " + toDateStr);
        System.out.println("accountIdStr: " + accountIdStr);

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        Date fromDate = null;
        Date toDate = null;
        Long accountId = null;

        try {
            if (fromDateStr != null && toDateStr != null) {
                fromDate = sdf.parse(fromDateStr);
                toDate = sdf.parse(toDateStr);
            }
            if (accountIdStr != null) {
                accountId = Long.parseLong(accountIdStr);
            }
        } catch (Exception e) {
            throw new ServletException("Invalid parameters", e);
        }

        if (accountId == null) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Account ID is required");
            return;
        }

        Account account = accountService.findAccountById(accountId);
        if (account == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Account not found");
            return;
        }

        List<Transaction> transactions = transactionService.findTransactionsByAccountAndDateRange(accountId, fromDate, toDate);

        req.setAttribute("account", account);
        req.setAttribute("transactions", transactions);

        req.getRequestDispatcher("/user/fixedTransactionReport.jsp").forward(req, resp);
        System.out.println("asasas");

    }
}
