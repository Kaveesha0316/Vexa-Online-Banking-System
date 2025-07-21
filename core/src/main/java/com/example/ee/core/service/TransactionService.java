package com.example.ee.core.service;

import com.example.ee.core.model.Transaction;
import jakarta.ejb.Remote;

import java.util.Date;
import java.util.List;

@Remote
public interface TransactionService {
    void saveTransaction(Transaction transaction);
//    boolean makeTransaction(Long fromAccount, Long toAccount, double amount, String description,Transaction transaction);
    List<Transaction> findlast5TransactionByFromAc(Long fromAccountId);
    List<Transaction> findTransactionsByAccountAndDateRange(Long accountId, Date from, Date to);
    List<Transaction> findTransactionHistory(Long accountId);
    Double findMonthlyIncome(Long accountId);
    Double findMonthlyExpense(Long accountId);
    List<Transaction> findlast5Transaction();
    int findTotalTransactions();
    List<Transaction> findAllTransactions();
    Transaction findTransactionById(Long transactionId);


}
