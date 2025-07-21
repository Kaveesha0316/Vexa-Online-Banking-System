package com.example.ee.ejb.beans;

import com.example.ee.core.model.*;
import com.example.ee.core.service.AccountService;
import com.example.ee.core.service.InterestAccrualService;
import com.example.ee.core.service.TransactionService;
import jakarta.ejb.*;
import jakarta.persistence.EntityManager;
import jakarta.persistence.LockModeType;
import jakarta.persistence.PersistenceContext;

import java.util.Date;
import java.util.List;

@Singleton
public class InterestProcessorBean {
    @PersistenceContext
    private EntityManager em;

    @EJB
    private TransactionService transactionService;

    @EJB
    private AccountService accountService;

    @EJB
    private InterestAccrualService interestAccrualService;

    @Schedule(dayOfMonth = "1", hour = "0", minute = "0")
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void processMonthlyInterest() {

        List<Account> accountList = em.createNamedQuery("Account.findAllAccounts", Account.class).setParameter("sts", Status.ACTIVE).getResultList();

        for (Account account : accountList) {
            try {
                Account lockedAccount = em.find(Account.class, account.getAccountId(), LockModeType.PESSIMISTIC_WRITE);
                double interest = lockedAccount.getBalance() * (lockedAccount.getInterestRate() / 100);

                double newBalance = lockedAccount.getBalance() + interest;
                newBalance = Math.round(newBalance * 100.0) / 100.0;
                lockedAccount.setBalance(newBalance);

                String formattedInterest = String.format("%.2f", interest);

//                lockedAccount.setBalance(lockedAccount.getBalance() + Double.parseDouble(formattedInterest));
                em.merge(lockedAccount);

                // Log transaction
                Transaction t = new Transaction(
                        null, // fromAccount
                        lockedAccount,
                        TransactionType.INTEREST,
                        Double.parseDouble(formattedInterest),
                        "Monthly interest",
                        new Date()
                );
                transactionService.saveTransaction(t);

                InterestAccrual interestAccrual = new InterestAccrual(lockedAccount,Double.parseDouble(formattedInterest),new Date());
                interestAccrualService.save(interestAccrual);

                System.out.println("saved interest accrual");

            } catch (Exception ex) {
                ex.printStackTrace();

            }
        }
    }
}
