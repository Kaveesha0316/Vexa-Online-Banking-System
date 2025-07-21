package com.example.ee.ejb.beans;

import com.example.ee.core.Interceptor.AuditInterceptor;
import com.example.ee.core.annotaion.Audited;
import com.example.ee.core.model.Transaction;
import com.example.ee.core.model.TransactionType;
import com.example.ee.core.service.AccountService;
import com.example.ee.core.service.TransactionService;
import jakarta.ejb.EJB;
import jakarta.ejb.Stateless;
import jakarta.ejb.TransactionAttribute;
import jakarta.ejb.TransactionAttributeType;
import jakarta.interceptor.Interceptors;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

import java.time.LocalDate;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

@Stateless
public class TransactionServiceImpl implements TransactionService {

    @PersistenceContext
    private EntityManager em;

    @EJB
    AccountService accountService;

    @EJB
    TransactionService transactionService;


    @Override
    public void saveTransaction(Transaction transaction) {
        em.persist(transaction);
    }

    @Override
    public List<Transaction> findlast5TransactionByFromAc(Long fromAccountId) {

       List<Transaction> transactionList = em.createNamedQuery("Transaction.findLast5TrnsByCusId", Transaction.class).setParameter("accNo", fromAccountId).setParameter("accNo2", fromAccountId).setMaxResults(5).getResultList();

        return transactionList;
    }

    @Override
    public List<Transaction> findTransactionsByAccountAndDateRange(Long accountId, Date from, Date to) {

        List<Transaction> transactionList = em.createNamedQuery("Transaction.findTransactionsByAccountAndDateRange", Transaction.class).setParameter("accNo", accountId).setParameter("accNo2", accountId).setParameter("from", from)
                .setParameter("to", to).getResultList();
        return transactionList;
    }

    @Override
    public List<Transaction> findTransactionHistory(Long accountId) {
        return em.createNamedQuery("Transaction.findLast5TrnsByCusId", Transaction.class).setParameter("accNo", accountId).setParameter("accNo2", accountId).getResultList();
    }

    @Override
    public Double findMonthlyExpense(Long accountId) {
        LocalDate thirtyDaysAgo = LocalDate.now().minusDays(30);
        Date fromDate = java.sql.Date.valueOf(thirtyDaysAgo);
        Double totalexpence = 0.0;

        List<Transaction> results = em
                .createNamedQuery("Transaction.findLast30Daysexpens", Transaction.class)
                .setParameter("accId", accountId)
                .setParameter("fromDate", fromDate)
                .getResultList();

        for (Transaction transaction : results) {
            if (transaction.getAmount() != null) {
                totalexpence += transaction.getAmount();
            }
        }


        return totalexpence;
    }

    @Override
    public List<Transaction> findlast5Transaction() {

        List<Transaction> transactionList = em.createNamedQuery("Transaction.findLast5Trns", Transaction.class).setMaxResults(5).getResultList();
        return transactionList;
    }

    @Override
    public int findTotalTransactions() {
        List<Transaction> transactionList = em.createNamedQuery("Transaction.findtotal", Transaction.class).getResultList();
        int totalTransactions = 0;
        for (Transaction transaction : transactionList) {
            if(transaction.getTransactionType()== TransactionType.TRANSFER){
                totalTransactions ++;
            }
        }
        return totalTransactions;
    }

    @Override
    public List<Transaction> findAllTransactions() {
        List<Transaction> transactionList = em.createNamedQuery("Transaction.findtotal", Transaction.class).getResultList();
            return transactionList;
    }

    @Override
    public Transaction findTransactionById(Long transactionId) {
        return em.find(Transaction.class, transactionId);
    }

    @Override
    public Double findMonthlyIncome(Long accountId) {
        LocalDate thirtyDaysAgo = LocalDate.now().minusDays(30);
        Date fromDate = java.sql.Date.valueOf(thirtyDaysAgo);
        Double totaleIncome = 0.0;

        List<Transaction> results = em
                .createNamedQuery("Transaction.findLast30DaysIncome", Transaction.class)
                .setParameter("accId", accountId)
                .setParameter("fromDate", fromDate)
                .getResultList();

        for (Transaction transaction : results) {
            if (transaction.getAmount() != null) {
                totaleIncome += transaction.getAmount();
            }
        }
        return totaleIncome;
    }

}
