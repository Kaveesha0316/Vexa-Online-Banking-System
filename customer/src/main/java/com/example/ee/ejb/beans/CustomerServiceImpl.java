package com.example.ee.ejb.beans;

import com.example.ee.core.model.Customer;
import com.example.ee.core.service.CustomerService;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

@Stateless
public class CustomerServiceImpl implements CustomerService {

    @PersistenceContext
    private EntityManager em;

    @Override
    public Customer createCustomer(Customer customer) {
        em.persist(customer);
        return customer;
    }

    @Override
    public Customer findCustomerByEmail(String email) {
        return null;
    }

    @Override
    public Customer findCustomerByNic(String nic) {
        return null;
    }
}
