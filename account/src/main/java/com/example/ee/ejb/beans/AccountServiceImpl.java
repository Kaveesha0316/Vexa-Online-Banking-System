package com.example.ee.ejb.beans;

import com.example.ee.core.model.Account;
import com.example.ee.core.service.AccountService;
import com.example.ee.core.service.CustomerService;
import jakarta.ejb.EJB;
import jakarta.ejb.Stateless;
import jakarta.ejb.TransactionManagement;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

import java.util.List;

@Stateless
public class AccountServiceImpl implements AccountService {

    @PersistenceContext
    private EntityManager em;

    @Override
    public void createAccount(Account account) {
        em.persist(account);
    }

    @Override
    public List<Account> checkAccountCount(Long customerId) {
        return  em.createNamedQuery("Account.getCuscount", Account.class).setParameter("customerId", customerId).getResultList();

    }
}
