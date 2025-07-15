package com.example.ee.core.service;

import com.example.ee.core.model.Account;
import jakarta.ejb.Remote;

import java.util.List;

@Remote
public interface AccountService {

    void createAccount(Account account);
    List<Account> checkAccountCount(Long customerId);
    void  debitAccount(Long accountId, Double balance);
    void  creditAccount(Long accountId, Double balance);
    Account findAccountByAccountNumber(String accountNumber);
    Account findAccountByCustomerId(Long customerId);
    Account findFixedAccountByCustomerId(Long customerId);
    double findMonthlyIncomeByCustomerId(Long customerId);
    Account findAccountById(Long accountId);

}
