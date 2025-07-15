package com.example.ee.web.servlet;

import com.example.ee.core.mail.ChangePasswordMail;
import com.example.ee.core.model.Customer;
import com.example.ee.core.model.User;
import com.example.ee.core.povider.MailServiceProvider;
import com.example.ee.core.service.AccountService;
import com.example.ee.core.service.AuthService;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.security.SecureRandom;


@WebServlet("/sendVerificationCode")
public class SendVerification extends HttpServlet {

    @EJB
    private AuthService authService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

       Customer customer = (Customer) req.getSession().getAttribute("customer");

       User user = authService.findUserByCustomerId(customer.getCustomerId());

       String code = generateVerificationCode(10);

       user.setVerificationCode(code);
       authService.update(user);

        ChangePasswordMail mail = new ChangePasswordMail(customer.getEmail(),code);
        MailServiceProvider.getInstance().sendMail(mail);
        System.out.println("Sending verification email");


        resp.setStatus(HttpServletResponse.SC_OK);
    }

    private String generateVerificationCode(int length) {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        StringBuilder sb = new StringBuilder();
        SecureRandom random = new SecureRandom();
        for (int i = 0; i < length; i++) {
            int index = random.nextInt(chars.length());
            sb.append(chars.charAt(index));
        }
        return sb.toString();
    }
}
