package com.example.ee.core.model;

import jakarta.persistence.*;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;


@Entity
@Table(name = "accounts")
@NamedQueries({
        @NamedQuery(name = "Account.getCuscount", query = "select a from Account a where a.customer.customerId =:customerId"),
        @NamedQuery(name = "Account.findByAccountNo", query = "select a from Account a where a.accountNumber =:accountNo"),
        @NamedQuery(name = "Account.findByCustomerId", query = "select a from Account a where a.customer.customerId =:customerId"),
        @NamedQuery(name = "Account.findAllAccounts", query = "select a from Account a where a.status =:sts"),
        @NamedQuery(name = "Account.findAccountById", query = "select a from Account a where a.accountId =:Id"),
        @NamedQuery(name = "Account.findAllAccountHistory", query = "select a from Account a order by a.createdAt desc ")
})
public class Account implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long accountId;

    @ManyToOne
    @JoinColumn(name = "customer_id")
    private Customer customer;

    private String accountNumber;
    @Enumerated(EnumType.STRING)
    private AccountType accountType;

    private Double balance;
    private Double interestRate;

    @Enumerated(EnumType.STRING)
    private Status status;

    private Date createdAt;

    @OneToMany(mappedBy = "fromAccount", cascade = CascadeType.ALL)
    private List<Transaction> fromAccount;

    @OneToMany(mappedBy = "account", cascade = CascadeType.ALL)
    private List<InterestAccrual> interestAccruals;

    public Account() {
    }

    public Account(Customer customer, String accountNumber, AccountType accountType, Double balance, Double interestRate, Status status, Date createdAt) {
        this.customer = customer;
        this.accountNumber = accountNumber;
        this.accountType = accountType;
        this.balance = balance;
        this.interestRate = interestRate;
        this.status = status;
        this.createdAt = createdAt;
    }

    public Long getAccountId() {
        return accountId;
    }

    public void setAccountId(Long accountId) {
        this.accountId = accountId;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public String getAccountNumber() {
        return accountNumber;
    }

    public void setAccountNumber(String accountNumber) {
        this.accountNumber = accountNumber;
    }

    public AccountType getAccountType() {
        return accountType;
    }

    public void setAccountType(AccountType accountType) {
        this.accountType = accountType;
    }

    public Double getBalance() {
        return balance;
    }

    public void setBalance(Double balance) {
        this.balance = balance;
    }

    public Double getInterestRate() {
        return interestRate;
    }

    public void setInterestRate(Double interestRate) {
        this.interestRate = interestRate;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
}
