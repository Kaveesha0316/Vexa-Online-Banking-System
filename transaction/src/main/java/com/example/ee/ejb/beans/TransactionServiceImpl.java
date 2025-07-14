package com.example.ee.ejb.beans;

import com.example.ee.core.model.Transaction;
import com.example.ee.core.service.AccountService;
import com.example.ee.core.service.TransactionService;
import jakarta.ejb.EJB;
import jakarta.ejb.Stateless;
import jakarta.ejb.TransactionAttribute;
import jakarta.ejb.TransactionAttributeType;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

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

}
