package com.example.ee.web.servlet;

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
@WebServlet("/admin/change_Accstatus")
public class ChangeAccountStatus extends HttpServlet {

    @EJB
    private AccountService accountService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String acId = req.getParameter("acId");

        accountService.ChangeStatus(Long.parseLong(acId));
        resp.sendRedirect(req.getContextPath() + "/admin/accountManagement.jsp");

    }
}
