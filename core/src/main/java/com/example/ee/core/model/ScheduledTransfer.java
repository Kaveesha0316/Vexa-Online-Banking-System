package com.example.ee.core.model;

import jakarta.persistence.*;

import java.io.Serializable;
import java.time.LocalDate;
import java.util.Date;

@Entity
@Table(name = "scheduled_transfers")
@NamedQueries({
        @NamedQuery(name = "ScheduledTransfer.FindHistory", query = "select s from ScheduledTransfer s where s.fromAccount.accountId=:AccId order by s.createdAt DESC")
})
public class ScheduledTransfer implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long scheduleId;

    @ManyToOne(optional = false)
    @JoinColumn(name = "from_account_id")
    private Account fromAccount;

    @ManyToOne(optional = false)
    @JoinColumn(name = "to_account_id")
    private Account toAccount;

    @Column(nullable = false)
    private Double amount;

    @Enumerated(EnumType.STRING)
    private ScheduleSts scheduleSts;

    @Column(nullable = false)
    private Date scheduledDateTime;

    private Date createdAt;


    public ScheduledTransfer() {
    }

    public ScheduledTransfer(Account fromAccount, Account toAccount, Double amount, ScheduleSts scheduleSts, Date scheduledDateTime, Date createdAt) {
        this.fromAccount = fromAccount;
        this.toAccount = toAccount;
        this.amount = amount;
        this.scheduleSts = scheduleSts;
        this.scheduledDateTime = scheduledDateTime;
        this.createdAt = createdAt;
    }

    public Long getScheduleId() {
        return scheduleId;
    }

    public void setScheduleId(Long scheduleId) {
        this.scheduleId = scheduleId;
    }

    public Account getFromAccount() {
        return fromAccount;
    }

    public void setFromAccount(Account fromAccount) {
        this.fromAccount = fromAccount;
    }

    public Account getToAccount() {
        return toAccount;
    }

    public void setToAccount(Account toAccount) {
        this.toAccount = toAccount;
    }

    public Double getAmount() {
        return amount;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
    }

    public ScheduleSts getScheduleSts() {
        return scheduleSts;
    }

    public void setScheduleSts(ScheduleSts scheduleSts) {
        this.scheduleSts = scheduleSts;
    }

    public Date getScheduledDateTime() {
        return scheduledDateTime;
    }

    public void setScheduledDateTime(Date scheduledDateTime) {
        this.scheduledDateTime = scheduledDateTime;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
}
