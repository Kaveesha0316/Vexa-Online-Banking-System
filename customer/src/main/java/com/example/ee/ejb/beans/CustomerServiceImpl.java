package com.example.ee.ejb.beans;

import com.example.ee.core.model.Customer;
import com.example.ee.core.service.CustomerService;
import jakarta.annotation.security.RolesAllowed;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;

import java.util.List;
import java.util.Optional;

@Stateless
public class CustomerServiceImpl implements CustomerService {

    @PersistenceContext
    private EntityManager em;

    @RolesAllowed("ADMIN")
    @Override
    public Customer createCustomer(Customer customer) {
        em.persist(customer);
        return customer;
    }

    @Override
    public Customer findCustomerByEmail(String email) {

            List<Customer> result = em.createNamedQuery("customer.findByEmail", Customer.class).setParameter("email", email).getResultList();

        if (result.isEmpty()) {
            return null;
        } else {
            return result.get(0);
        }


    }

    @Override
    public   Customer findCustomerByNic(String nic) {

            List<Customer> result = em.createNamedQuery("customer.findByNic", Customer.class).setParameter("nic", nic).getResultList();

        if (result.isEmpty()) {
            return null;
        } else {
            return result.get(0);
        }
    }

}
