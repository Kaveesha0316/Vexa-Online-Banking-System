package com.example.ee.core.service;

import com.example.ee.core.model.Transaction;
import jakarta.ejb.Remote;

@Remote
public interface TransactionService {
    void saveTransaction(Transaction transaction);
//    boolean makeTransaction(Long fromAccount, Long toAccount, double amount, String description,Transaction transaction);
}
