package com.example.ee.ejb.beans;

import com.example.ee.core.exception.InsufficientFundsException;
import com.example.ee.core.model.*;
import com.example.ee.core.service.ScheduledTransferService;
import com.example.ee.core.service.TransactionOrchestratorService;
import jakarta.annotation.Resource;
import jakarta.ejb.*;
import jakarta.persistence.EntityManager;
import jakarta.persistence.LockModeType;
import jakarta.persistence.PersistenceContext;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;

@Stateless
public class ScheduledTransferServiceImpl implements ScheduledTransferService {

    @Resource
    private TimerService timerService;

    @PersistenceContext
    private EntityManager em;

    @EJB
    private TransactionOrchestratorService transactionOrchestratorService;

    @Override
    public void save(ScheduledTransfer transfer) {
        transfer.setScheduleSts(ScheduleSts.PENDING);
        em.persist(transfer);
        em.flush(); // to get scheduleId

        scheduleTimer(transfer);
    }

    @Override
    public void cancel(Long scheduleId) {
        ScheduledTransfer transfer = em.find(ScheduledTransfer.class, scheduleId);
        if (transfer == null || transfer.getScheduleSts() != ScheduleSts.PENDING) {
            return; // Either not found or already executed/cancelled
        }

// Cancel the associated timer
        for (Timer timer : timerService.getTimers()) {
            if (scheduleId.equals(timer.getInfo())) {
                timer.cancel();
                break;
            }
        }

// Update the transfer status
        transfer.setScheduleSts(ScheduleSts.FAILED); // Or use a specific CANCELLED status if you have one
        em.merge(transfer);
    }

    @Override
    public List<ScheduledTransfer> getScheduledTransfersBYAccountId(Long accountId) {

        List<ScheduledTransfer> scheduledTransferList = em.createNamedQuery("ScheduledTransfer.FindHistory", ScheduledTransfer.class).setParameter("AccId", accountId).getResultList();

        return scheduledTransferList;
    }

    private void scheduleTimer(ScheduledTransfer transfer) {
        Date executionDate = transfer.getScheduledDateTime(); // already java.util.Date

        TimerConfig config = new TimerConfig();
        config.setInfo(transfer.getScheduleId());
        config.setPersistent(true);

        timerService.createSingleActionTimer(executionDate, config);
    }

    @Timeout
    public void processScheduledTransfer(Timer timer) {
        Long scheduleId = (Long) timer.getInfo();
        ScheduledTransfer transfer = em.find(ScheduledTransfer.class, scheduleId);

        if (transfer == null || transfer.getScheduleSts() != ScheduleSts.PENDING) {
            System.out.println("Insufficient Balance");
            return; // Already processed or deleted
        }

        try {
            transactionOrchestratorService.makeTransaction(
                    transfer.getFromAccount().getAccountId(),
                    transfer.getToAccount().getAccountId(),
                    transfer.getAmount(),
                    "Scheduled Transfer",
                    new Transaction(
                            transfer.getFromAccount(),
                            transfer.getToAccount(),
                            TransactionType.WITHDRAWAL,
                            transfer.getAmount(),
                            "Scheduled Transfer",
                            new Date()
                    )
            );

            // If no exception was thrown, mark as succeeded
            transfer.setScheduleSts(ScheduleSts.SUCCEEDED);
            em.merge(transfer);
            System.out.println("Scheduled Transfer succeeded");

        } catch (InsufficientFundsException ex) {
            transfer.setScheduleSts(ScheduleSts.FAILED);
            em.merge(transfer);
            System.out.println("Insufficient funds");

        } catch (IllegalArgumentException ex) {
            transfer.setScheduleSts(ScheduleSts.FAILED);
            em.merge(transfer);
            System.out.println("Illegal argument");

        } catch (Exception ex) {
            transfer.setScheduleSts(ScheduleSts.FAILED);
            em.merge(transfer);
            ex.printStackTrace();
            System.out.println("Error");
        }
    }


}
