package com.example.ee.web.servlet;

import com.example.ee.core.model.Customer;
import com.example.ee.core.model.User;
import com.example.ee.core.service.AuthService;
import com.example.ee.core.util.Encryption;
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
@ServletSecurity(@HttpConstraint(rolesAllowed = {"CUSTOMER"}))
@WebServlet("/change_password")
public class PasswordChange extends HttpServlet {

    @EJB
    private AuthService authService;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/plain");
        String verificationCode = request.getParameter("verificationCode");
        String newPassword = request.getParameter("newPassword");
        String oldPassword = request.getParameter("oldPassword");

        Customer customer = (Customer) request.getSession().getAttribute("customer");

        User user = authService.findUserByCustomerId(customer.getCustomerId());

        if (verificationCode.equals(user.getVerificationCode()) &&  Encryption.encrypt(oldPassword).equals(user.getPasswordHash())) {
            user.setPasswordHash( Encryption.encrypt(newPassword));
            authService.update(user);
            response.getWriter().write("success");
        }else {
            response.getWriter().write("Invalid verification code or old password");

        }


    }
}
