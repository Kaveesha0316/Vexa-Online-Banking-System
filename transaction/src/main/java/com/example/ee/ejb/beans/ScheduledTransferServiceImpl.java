package com.example.ee.ejb.beans;

import com.example.ee.core.Interceptor.AuditInterceptor;
import com.example.ee.core.exception.InsufficientFundsException;
import com.example.ee.core.model.*;
import com.example.ee.core.service.ScheduledTransferService;
import com.example.ee.core.service.TransactionOrchestratorService;
import jakarta.annotation.Resource;
import jakarta.ejb.*;
import jakarta.interceptor.Interceptors;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

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
        em.flush();

        scheduleTimer(transfer);
    }

    @Override
    public void cancel(Long scheduleId) {
        ScheduledTransfer transfer = em.find(ScheduledTransfer.class, scheduleId);
        if (transfer == null || transfer.getScheduleSts() != ScheduleSts.PENDING) {
            return;
        }


        for (Timer timer : timerService.getTimers()) {
            if (scheduleId.equals(timer.getInfo())) {
                timer.cancel();
                break;
            }
        }


        transfer.setScheduleSts(ScheduleSts.FAILED);
        em.merge(transfer);
    }

    @Override
    public List<ScheduledTransfer> getScheduledTransfersBYAccountId(Long accountId) {

        List<ScheduledTransfer> scheduledTransferList = em.createNamedQuery("ScheduledTransfer.FindHistory", ScheduledTransfer.class).setParameter("AccId", accountId).getResultList();

        return scheduledTransferList;
    }

    @Override
    public List<ScheduledTransfer> get5ScheduledTransfersBYAccountId(Long accountId) {
        List<ScheduledTransfer> scheduledTransferList = em.createNamedQuery("ScheduledTransfer.FindLast5History", ScheduledTransfer.class).setParameter("AccId", accountId).setParameter("date", new Date()).setMaxResults(5).getResultList();
        return scheduledTransferList;
    }

    @Override
    public int getpendingTransactions() {
        List<ScheduledTransfer> scheduledTransferList = em.createNamedQuery("ScheduledTransfer.FindpendingHistory", ScheduledTransfer.class).getResultList();

        int pendingTransactions = 0;
        for (ScheduledTransfer scheduledTransfer : scheduledTransferList) {
            if (scheduledTransfer.getScheduleSts() == ScheduleSts.PENDING) {
                pendingTransactions++;
            }
        }

        return pendingTransactions;
    }

    @Override
    public List<ScheduledTransfer> findAllScheduledTransfers() {
        List<ScheduledTransfer> scheduledTransferList = em.createNamedQuery("ScheduledTransfer.FindAllShedules", ScheduledTransfer.class).getResultList();

        return scheduledTransferList;
    }

    private void scheduleTimer(ScheduledTransfer transfer) {
        Date executionDate = transfer.getScheduledDateTime();

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
            System.out.println("Already processed or invalid");
            return;
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
                            TransactionType.TRANSFER,
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
