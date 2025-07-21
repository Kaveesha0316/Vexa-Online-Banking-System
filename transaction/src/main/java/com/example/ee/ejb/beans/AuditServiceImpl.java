package com.example.ee.ejb.beans;

import com.example.ee.core.model.AuditLog;
import com.example.ee.core.service.AuditService;
import jakarta.annotation.security.RolesAllowed;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

import java.util.List;

@Stateless
public class AuditServiceImpl implements AuditService {

    @PersistenceContext
    private EntityManager em;

    @RolesAllowed("ADMIN")
    @Override
    public List<AuditLog> findAllAuditLog() {
        List<AuditLog> auditLogs = em.createNamedQuery("AuditLog.findAllAuditLog", AuditLog.class).getResultList();

        return auditLogs;
    }
}
