package com.example.ee.core.service;

import com.example.ee.core.model.Customer;
import com.example.ee.core.model.User;
import jakarta.ejb.Remote;

import java.util.List;

@Remote
public interface AuthService {

    void Save(User user);
    void update(User user);
    User findByUserNameAndPassword(String userName, String password);
    boolean isUserValid(String username, String password);
    User findUserByCustomerId(Long customerId);
    int ActiveCustomerCount();
    List<User> findAllCustomers();
    void changeStatus(Long userId);

}
