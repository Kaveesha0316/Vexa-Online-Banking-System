package com.example.ee.ejb.beans;

import com.example.ee.core.exception.InsufficientFundsException;
import com.example.ee.core.model.*;
import com.example.ee.core.service.AccountService;
import jakarta.annotation.security.RolesAllowed;
import jakarta.ejb.Stateless;
import jakarta.ejb.TransactionAttribute;
import jakarta.ejb.TransactionAttributeType;
import jakarta.persistence.EntityManager;
import jakarta.persistence.LockModeType;
import jakarta.persistence.PersistenceContext;

import java.util.Date;
import java.util.List;

@Stateless
public class AccountServiceImpl implements AccountService {

    @PersistenceContext
    private EntityManager em;

    @RolesAllowed("ADMIN")
    @Override
    public boolean makeDeposit(Account account, Double amount,String description) {

        account.setBalance(account.getBalance() + amount);
        em.merge(account);

        Transaction transaction = new Transaction();
        transaction.setTodAccount(account);
        transaction.setAmount(amount);
        transaction.setTransactionType(TransactionType.DEPOSIT);
        transaction.setCreatedAt(new Date());
        transaction.setDescription(description);
        em.persist(transaction);

        return false;
    }

    @RolesAllowed("ADMIN")
    @Override
    public void createAccount(Account account) {
        em.persist(account);
    }

    @RolesAllowed("ADMIN")
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

    @Override
    public Account findFixedAccountByCustomerId(Long customerId) {
        List<Account> accountList = em.createNamedQuery("Account.findByCustomerId", Account.class).setParameter("customerId", customerId).getResultList();

        if (accountList.isEmpty()) {
            return null;
        }else {
            for (Account account : accountList) {
                if (account.getAccountType() == AccountType.FIXED_DEPOSIT){
                    return account;
                }
            }
            return null;
        }
    }

    @Override
    public double findMonthlyIncomeByCustomerId(Long customerId) {

        return 0;
    }

    @Override
    public Account findAccountById(Long accountId) {

       List<Account> accountList =  em.createNamedQuery("Account.findAccountById", Account.class).setParameter("Id", accountId).getResultList();

       if (accountList.isEmpty()) {
           return null;
       }else {
           return accountList.get(0);
       }
    }

    @Override
    public int findActiveAccountCount() {
        List<Account> accountList = em.createNamedQuery("Account.findAllAccounts", Account.class).setParameter("sts", Status.ACTIVE).getResultList();

        int count = 0;
        for (Account account : accountList) {
            if (account.getStatus() == Status.ACTIVE) {
                count++;
            }
        }
        return count;
    }

    @Override
    public List<Account> findAllAccounts() {
        List<Account> accountList = em.createNamedQuery("Account.findAllAccountHistory", Account.class).getResultList();
        return accountList;
    }

    @RolesAllowed("ADMIN")
    @Override
    public void ChangeStatus(Long accountId) {
        Account account = em.find(Account.class, accountId, LockModeType.PESSIMISTIC_WRITE);

        if (account == null) {
            throw new SecurityException("Unauthorized access - account not found.");
        }else {
            if (account.getStatus() == Status.ACTIVE) {
                account.setStatus(Status.INACTIVE);
            } else {
                account.setStatus(Status.ACTIVE);
            }
        }
    }



}
