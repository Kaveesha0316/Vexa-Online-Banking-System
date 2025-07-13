package com.example.ee.core.exception;

import jakarta.ejb.ApplicationException;

@ApplicationException(rollback = true)
public class InsufficientFundsException extends  RuntimeException {
    public InsufficientFundsException(String message) {
        super(message);
    }
}
