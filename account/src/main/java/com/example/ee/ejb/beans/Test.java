package com.example.ee.ejb.beans;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

@Stateless
public class Test {

    @PersistenceContext
    private EntityManager em;

}
