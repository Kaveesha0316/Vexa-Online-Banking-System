package com.example.ee.ejb.beans;

import com.example.ee.core.model.User;
import com.example.ee.core.service.AuthService;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

@Stateless
public class AuthServiceImpl implements AuthService {

    @PersistenceContext
    private EntityManager em;

    @Override
    public void Save(User user) {
        em.persist(user);
    }

    @Override
    public void update(User user) {

    }

    @Override
    public User findByUserName(String userName) {
        return null;
    }
}
