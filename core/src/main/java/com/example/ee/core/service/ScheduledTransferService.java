package com.example.ee.core.service;

import com.example.ee.core.model.ScheduledTransfer;

import java.util.List;

public interface ScheduledTransferService {
    void save(ScheduledTransfer scheduledTransfer);
    void cancel(Long scheduleId);
    List<ScheduledTransfer> getScheduledTransfersBYAccountId(Long accountId);
    List<ScheduledTransfer> get5ScheduledTransfersBYAccountId(Long accountId);
    int getpendingTransactions();
    List<ScheduledTransfer> findAllScheduledTransfers();
}
