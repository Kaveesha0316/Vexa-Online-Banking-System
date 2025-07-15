package com.example.ee.core.model;

import jakarta.persistence.*;

import java.io.Serializable;
import java.time.LocalDate;
import java.util.Date;

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

    private Date accrualDate;

    public InterestAccrual() {
    }

    public InterestAccrual(Account account, Double amount, Date accrualDate) {
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

    public Date getAccrualDate() {
        return accrualDate;
    }

    public void setAccrualDate(Date accrualDate) {
        this.accrualDate = accrualDate;
    }
}
