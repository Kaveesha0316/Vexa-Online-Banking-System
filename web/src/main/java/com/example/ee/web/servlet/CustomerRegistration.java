package com.example.ee.web.servlet;

//import com.example.ee.core.bean.RegistrationOrchestratorBean;
//import com.example.ee.core.model.Customer;
import com.example.ee.core.model.Customer;
import com.example.ee.core.model.Role;
import com.example.ee.core.model.Status;
import com.example.ee.core.model.User;
import com.example.ee.core.service.AuthService;
import com.example.ee.core.service.CustomerService;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.security.SecureRandom;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.UUID;

@WebServlet("/customer_register")
public class CustomerRegistration extends HttpServlet {


    @EJB
    CustomerService customerService;

    @EJB
    AuthService authService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
        String firstName = req.getParameter("firstName");
        String lastName = req.getParameter("lastName");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String dob = req.getParameter("dob");
        String nic = req.getParameter("nic");
        String address = req.getParameter("address");

            System.out.println(firstName + " " + lastName + " " + email + " " + phone + " " + dob + " " + nic);

        String[] rs = dob.split("-");

        int year = Integer.parseInt(rs[0]);
        int month = Integer.parseInt(rs[1]);
        int day = Integer.parseInt(rs[2]);
//
//
//
            Customer customer = new Customer(firstName,lastName,email,phone,address,nic, LocalDate.of(year,month,day), LocalDateTime.now());
            Customer customer1 = customerService.createCustomer(customer);
//
            String username = firstName + "_" + lastName;
            String password = generatePassword(12);

            User user = new User(customer1,username,password, Role.CUSTOMER, Status.ACTIVE, LocalDateTime.now(),LocalDateTime.now());

            authService.Save(user);
            resp.setContentType("text/plain");
            resp.getWriter().write("success");
        }catch (Exception e) {
            e.printStackTrace();
        }

    }

    private String generatePassword(int length) {
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
