package com.example.ee.core.service;

import com.example.ee.core.model.Transaction;
import jakarta.ejb.Remote;

@Remote
public interface TransactionOrchestratorService {
    void makeTransaction(Long from, Long to, double amount, String desc, Transaction transaction);
}
