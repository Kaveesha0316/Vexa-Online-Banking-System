package com.example.ee.ejb.beans;

import com.example.ee.core.model.User;
import com.example.ee.core.service.AuthService;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

import java.util.List;

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
    public User findByUserNameAndPassword(String userName, String password) {
        List<User> userList = em.createNamedQuery("user.findByUsernameAndPassword", User.class).setParameter("username", userName).setParameter("password",password).getResultList();


       if (userList.isEmpty()) {
           return null;
       }else {
           return userList.get(0);
       }
    }

    @Override
    public boolean isUserValid(String username, String password) {
        List<User> userList = em.createNamedQuery("user.findByUsernameAndPassword", User.class).setParameter("username", username).setParameter("password",password).getResultList();
        if (userList.isEmpty()) {
            return false;
        }else {
            return true;
        }

    }

    @Override
    public User findUserByCustomerId(Long customerId) {
        List<User> userList =  em.createNamedQuery("user.findByUserByCustomerId", User.class).setParameter("customerid", customerId).getResultList();
        if (userList.isEmpty()) {
           return null;
        }else {
           return userList.get(0);
        }
    }


}
