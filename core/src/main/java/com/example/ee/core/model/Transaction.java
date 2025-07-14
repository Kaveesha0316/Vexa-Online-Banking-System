package com.example.ee.core.model;

import jakarta.persistence.*;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Date;

@Entity
@Table(name = "transactions")
@NamedQueries({
        @NamedQuery(name = "Transaction.findLast5TrnsByCusId",query = "SELECT t FROM Transaction t where t.fromAccount.accountId=:accNo or t.todAccount.accountId=:accNo2 order by t.createdAt DESC")
})
public class Transaction implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long transactionId;

    @ManyToOne
    @JoinColumn(name = "from_account_id")
    private Account fromAccount;

    @ManyToOne
    @JoinColumn(name = "to_account_id")
    private Account todAccount; // for transfers

    @Enumerated(EnumType.STRING)
    private TransactionType transactionType;

    private Double amount;

    private String description;

    private Date createdAt;

    public Transaction() {
    }

    public Transaction(Account fromAccount, Account todAccount, TransactionType transactionType, Double amount, String description, Date createdAt) {
        this.fromAccount = fromAccount;
        this.todAccount = todAccount;
        this.transactionType = transactionType;
        this.amount = amount;
        this.description = description;
        this.createdAt = createdAt;
    }

    public Long getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(Long transactionId) {
        this.transactionId = transactionId;
    }

    public Account getFromAccount() {
        return fromAccount;
    }

    public void setFromAccount(Account fromAccount) {
        this.fromAccount = fromAccount;
    }

    public Account getTodAccount() {
        return todAccount;
    }

    public void setTodAccount(Account todAccount) {
        this.todAccount = todAccount;
    }

    public TransactionType getTransactionType() {
        return transactionType;
    }

    public void setTransactionType(TransactionType transactionType) {
        this.transactionType = transactionType;
    }

    public Double getAmount() {
        return amount;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
}
