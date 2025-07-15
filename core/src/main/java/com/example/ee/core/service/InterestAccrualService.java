package com.example.ee.core.service;

import com.example.ee.core.model.InterestAccrual;
import jakarta.ejb.Remote;

@Remote
public interface InterestAccrualService {
    void save(InterestAccrual interestAccrual);
}
