package com.example.ee.core.service;

import com.example.ee.core.model.Customer;
import jakarta.ejb.Remote;

@Remote
public interface CustomerService {

    Customer createCustomer(Customer customer);

    Customer findCustomerByEmail(String email);
    Customer findCustomerByNic(String nic);
}
