package com.example.ee.web.servlet;

import com.example.ee.core.model.Account;
import com.example.ee.core.model.AccountType;
import com.example.ee.core.model.ScheduledTransfer;
import com.example.ee.core.model.Status;
import com.example.ee.core.service.AccountService;
import com.example.ee.core.service.ScheduledTransferService;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Date;

@WebServlet("/schedule_transaction")
public class SheduelTranction extends HttpServlet {

    @EJB
    AccountService accountService;

    @EJB
    ScheduledTransferService scheduledTransferService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String from = req.getParameter("from");
        String to = req.getParameter("to");
        double amount = Double.parseDouble(req.getParameter("amount"));
        String description = req.getParameter("desc");
        String scheduleDate = req.getParameter("scheduleDate");

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
        LocalDateTime localDateTime = LocalDateTime.parse(scheduleDate, formatter);

        Date date = Date.from(localDateTime.atZone(ZoneId.systemDefault()).toInstant());


        Account fromAccount = accountService.findAccountByAccountNumber(from);
        Account toAccount = accountService.findAccountByAccountNumber(to);

        resp.setContentType("text/plain");
        if (toAccount == null) {
            resp.getWriter().write("Invalid Account Number");
        }else if (fromAccount.getBalance()-999.00 < amount) {
            resp.getWriter().write("Insufficient Balance");
        }else if (toAccount.getAccountType() != AccountType.SAVINGS || fromAccount.getAccountType() != AccountType.SAVINGS) {
            resp.getWriter().write("You can only make transactions with savings accounts");
        }else if (toAccount.getStatus() != Status.ACTIVE || fromAccount.getStatus() != Status.ACTIVE) {
            resp.getWriter().write("You can only make transactions with active accounts");
        }else {

            ScheduledTransfer transfer = new ScheduledTransfer();
            transfer.setFromAccount(fromAccount);
            transfer.setToAccount(toAccount);
            transfer.setAmount(amount);
            transfer.setCreatedAt(new Date());
            transfer.setScheduledDateTime(date);

            scheduledTransferService.save(transfer);
            resp.getWriter().write("success");
            System.out.println("success");
        }
    }
}
