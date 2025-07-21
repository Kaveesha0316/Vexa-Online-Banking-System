package com.example.ee.core.service;

import com.example.ee.core.model.AuditLog;
import jakarta.ejb.Remote;

import java.util.List;

@Remote
public interface AuditService {
    List<AuditLog> findAllAuditLog();
}
