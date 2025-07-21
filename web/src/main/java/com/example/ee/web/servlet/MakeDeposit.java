package com.example.ee.web.servlet;

import com.example.ee.core.model.Account;
import com.example.ee.core.model.AccountType;
import com.example.ee.core.model.Status;
import com.example.ee.core.service.AccountService;
import jakarta.annotation.security.DeclareRoles;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.HttpConstraint;
import jakarta.servlet.annotation.ServletSecurity;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
@DeclareRoles({"ADMIN","CUSTOMER"})
@ServletSecurity(@HttpConstraint(rolesAllowed = {"ADMIN"}))
@WebServlet("/make_deposit_transfer")
public class MakeDeposit extends HttpServlet {

    @EJB
    AccountService accountService;


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String amount = req.getParameter("amount");
        String to = req.getParameter("to");
        String description = req.getParameter("desc");

        Account toAccount = accountService.findAccountByAccountNumber(to);
        resp.setContentType("text/plain");

        if (toAccount == null) {
            resp.getWriter().write("Invalid Account Number");
        }else if (toAccount.getStatus() != Status.ACTIVE) {
            resp.getWriter().write("You can only make transactions with active accounts");
        }else {
            accountService.makeDeposit(toAccount,Double.parseDouble(amount),description);
            resp.getWriter().write("success");
        }

    }
}
