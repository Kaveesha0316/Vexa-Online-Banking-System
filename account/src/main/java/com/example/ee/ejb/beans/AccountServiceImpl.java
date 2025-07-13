package com.example.ee.ejb.beans;

import com.example.ee.core.exception.InsufficientFundsException;
import com.example.ee.core.model.Account;
import com.example.ee.core.model.AccountType;
import com.example.ee.core.service.AccountService;
import jakarta.ejb.Stateless;
import jakarta.ejb.TransactionAttribute;
import jakarta.ejb.TransactionAttributeType;
import jakarta.persistence.EntityManager;
import jakarta.persistence.LockModeType;
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

    @Override
    public void  debitAccount(Long accountId, Double amount) {

        Account account = em.find(Account.class, accountId, LockModeType.PESSIMISTIC_WRITE);

        if (account == null) {
            throw new IllegalArgumentException("Account not found");
        }

        if (account.getBalance() - amount <= 1000) {
            throw new InsufficientFundsException("Insufficient funds");
        }

        account.setBalance(account.getBalance() - amount);
        em.merge(account);


    }

    @Override
    public void  creditAccount(Long accountId, Double amount) {

        Account account = em.find(Account.class, accountId, LockModeType.PESSIMISTIC_WRITE);

        if (account == null) {
            throw new IllegalArgumentException("Account not found");
        }

        account.setBalance(account.getBalance() + amount);
        em.merge(account);

    }

    @Override
    public Account findAccountByAccountNumber(String accountNumber) {
       List<Account> accountList = em.createNamedQuery("Account.findByAccountNo", Account.class).setParameter("accountNo", accountNumber).getResultList();

       if (accountList.isEmpty()) {
           return null;
       }else {
           return accountList.get(0);
       }

    }

    @Override
    public Account findAccountByCustomerId(Long customerId) {
       List<Account> accountList = em.createNamedQuery("Account.findByCustomerId", Account.class).setParameter("customerId", customerId).getResultList();

       if (accountList.isEmpty()) {
           return null;
       }else {
           for (Account account : accountList) {
               if (account.getAccountType() == AccountType.SAVINGS){
                   return account;
               }
           }
           return null;
       }
    }

}
