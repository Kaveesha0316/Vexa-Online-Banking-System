package com.example.ee.ejb.beans;

import com.example.ee.core.Interceptor.AuditInterceptor;
import com.example.ee.core.annotaion.Audited;
import com.example.ee.core.model.Transaction;
import com.example.ee.core.service.AccountService;
import com.example.ee.core.service.TransactionOrchestratorService;
import com.example.ee.core.service.TransactionService;
import jakarta.annotation.security.PermitAll;
import jakarta.ejb.EJB;
import jakarta.ejb.Stateless;
import jakarta.ejb.TransactionAttribute;
import jakarta.ejb.TransactionAttributeType;
import jakarta.interceptor.Interceptors;

@Stateless
@Interceptors(AuditInterceptor.class)
@TransactionAttribute(TransactionAttributeType.REQUIRED)
public class TransactionOrchestratorImpl implements TransactionOrchestratorService {

    @EJB
    AccountService accountService;

    @EJB
    TransactionService transactionService;

    @PermitAll
    @Override
    public void makeTransaction(Long from, Long to, double amount, String desc, Transaction transaction) {
        accountService.debitAccount(from, amount);
        accountService.creditAccount(to, amount);
        transactionService.saveTransaction(transaction);
    }
}

