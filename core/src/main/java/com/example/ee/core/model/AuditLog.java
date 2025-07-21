package com.example.ee.core.model;

import jakarta.persistence.*;

import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "audit_log")
@NamedQueries({
        @NamedQuery(name = "AuditLog.findAllAuditLog",query = "select a from AuditLog a order by a.timestamp desc ")
})
public class AuditLog  implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long logId;



    private Double amount;

    private String action;

    private String username;

    private boolean success;

    private String details;

    private Date timestamp;

    public AuditLog() {
    }

    public AuditLog(String username, Double amount, String action, boolean success, String details, Date timestamp) {
        this.username = username;
        this.amount = amount;
        this.action = action;
        this.success = success;
        this.details = details;
        this.timestamp = timestamp;
    }

    public Long getLogId() {
        return logId;
    }

    public void setLogId(Long logId) {
        this.logId = logId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Double getAmount() {
        return amount;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public String getDetails() {
        return details;
    }

    public void setDetails(String details) {
        this.details = details;
    }

    public Date getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Date timestamp) {
        this.timestamp = timestamp;
    }
}
