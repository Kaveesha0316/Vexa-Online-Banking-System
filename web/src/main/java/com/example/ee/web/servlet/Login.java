package com.example.ee.web.servlet;

import com.example.ee.core.model.Role;
import com.example.ee.core.model.Status;
import com.example.ee.core.model.User;
import com.example.ee.core.service.AuthService;
import com.example.ee.core.util.Encryption;
import jakarta.ejb.EJB;
import jakarta.inject.Inject;
import jakarta.security.enterprise.AuthenticationStatus;
import jakarta.security.enterprise.SecurityContext;
import jakarta.security.enterprise.authentication.mechanism.http.AuthenticationParameters;
import jakarta.security.enterprise.credential.UsernamePasswordCredential;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/login")
public class Login extends HttpServlet {

    @Inject
    private SecurityContext securityContext;

    @EJB
    private AuthService authService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        try {
            AuthenticationParameters parameters = AuthenticationParameters.withParams()
                    .credential(new UsernamePasswordCredential(username, Encryption.encrypt(password))
                    );

            AuthenticationStatus status = securityContext.authenticate(req, resp, parameters);

            System.out.println(status);
            resp.setContentType("text/plain");
            User user = authService.findByUserNameAndPassword(username,  Encryption.encrypt(password));

            if (status == AuthenticationStatus.SUCCESS && user.getStatus() == Status.ACTIVE) {

                    if (user.getRole() == Role.ADMIN) {
                        resp.getWriter().write("admin");
                        req.getSession().setAttribute("admin", user.getCustomer());
                    } else {
                        resp.getWriter().write("customer");
                        req.getSession().setAttribute("customer", user.getCustomer());
                    }

                    System.out.println("Authentication Successful");


            }else {
                resp.getWriter().write("Invalid username or password or blocked");
                System.out.println("Authentication failed");

            }
        } catch (Exception e) {
            e.printStackTrace();
        }


    }
}
