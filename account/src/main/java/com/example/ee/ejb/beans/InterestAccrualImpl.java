package com.example.ee.ejb.beans;

import com.example.ee.core.model.InterestAccrual;
import com.example.ee.core.service.InterestAccrualService;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

@Stateless
public class InterestAccrualImpl implements InterestAccrualService {

    @PersistenceContext
    private EntityManager em;


    @Override
    public void save(InterestAccrual interestAccrual) {
        em.persist(interestAccrual);
    }
}
