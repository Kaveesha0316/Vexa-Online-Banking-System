package com.example.ee.core.model;

import jakarta.persistence.*;

import java.io.Serializable;
import java.time.LocalDate;

@Entity
@Table(name = "interest_accrual")
public class InterestAccrual implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long accrualId;

    @ManyToOne
    @JoinColumn(name = "account_id")
    private Account account;

    private Double amount;

    private LocalDate accrualDate;

    public InterestAccrual() {
    }

    public InterestAccrual(Account account, Double amount, LocalDate accrualDate) {
        this.account = account;
        this.amount = amount;
        this.accrualDate = accrualDate;
    }

    public Long getAccrualId() {
        return accrualId;
    }

    public void setAccrualId(Long accrualId) {
        this.accrualId = accrualId;
    }

    public Account getAccount() {
        return account;
    }

    public void setAccount(Account account) {
        this.account = account;
    }

    public Double getAmount() {
        return amount;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
    }

    public LocalDate getAccrualDate() {
        return accrualDate;
    }

    public void setAccrualDate(LocalDate accrualDate) {
        this.accrualDate = accrualDate;
    }
}
