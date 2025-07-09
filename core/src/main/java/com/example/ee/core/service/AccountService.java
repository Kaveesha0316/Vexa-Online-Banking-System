package com.example.ee.core.service;

import com.example.ee.core.model.Account;
import jakarta.ejb.Remote;

import java.util.List;

@Remote
public interface AccountService {

    void createAccount(Account account);
    List<Account> checkAccountCount(Long customerId);
}
