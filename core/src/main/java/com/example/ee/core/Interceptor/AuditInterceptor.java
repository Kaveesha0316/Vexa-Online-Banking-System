package com.example.ee.core.Interceptor;

import com.example.ee.core.annotaion.Audited;
import com.example.ee.core.model.Account;
import com.example.ee.core.model.AuditLog;
import com.example.ee.core.model.User;
import com.example.ee.core.service.AccountService;
import jakarta.annotation.Resource;
import jakarta.ejb.EJB;
import jakarta.ejb.SessionContext;
import jakarta.interceptor.AroundInvoke;
import jakarta.interceptor.Interceptor;
import jakarta.interceptor.InvocationContext;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

import java.util.Date;

@Interceptor
@Audited
public class AuditInterceptor {

    @PersistenceContext
    private EntityManager em;

    @Resource
    private SessionContext ctx;


    @Resource
    private SessionContext sessionContext;

    @AroundInvoke
    public Object audit(InvocationContext ctx) throws Exception {

        Object[] args = ctx.getParameters();
        Double amount = (Double) args[2];

        String username = sessionContext.getCallerPrincipal() != null
                ? sessionContext.getCallerPrincipal().getName()
                : "Unknown";

        System.out.println("amount: " + amount);
        System.out.println("username: " + username);

        boolean success = false;
        Object result = null;
        Exception exception = null;

        try {
            result = ctx.proceed();
            success = true;
            return result;
        } catch (Exception e) {
            exception = e;
            throw e;
        } finally {
            try {
                AuditLog log = new AuditLog();
                log.setAmount(amount);
                log.setUsername(username);
                log.setAction(ctx.getMethod().getDeclaringClass().getSimpleName() + "." + ctx.getMethod().getName());
                log.setSuccess(success);
                log.setDetails(exception != null ? exception.getMessage() : "Success");
                log.setTimestamp(new Date());

                em.persist(log);
            } catch (Exception ex) {
                System.err.println("Failed to persist audit log: " + ex.getMessage());
            }
        }
    }


}
