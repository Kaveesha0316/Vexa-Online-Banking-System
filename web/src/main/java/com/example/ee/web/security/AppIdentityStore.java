package com.example.ee.web.security;

import com.example.ee.core.model.User;
import com.example.ee.core.service.AuthService;
import jakarta.ejb.EJB;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.security.enterprise.credential.Credential;
import jakarta.security.enterprise.credential.UsernamePasswordCredential;
import jakarta.security.enterprise.identitystore.CredentialValidationResult;
import jakarta.security.enterprise.identitystore.IdentityStore;

import java.util.Set;
@ApplicationScoped
public class AppIdentityStore implements IdentityStore {

    @EJB
    AuthService authService;

    @Override
    public CredentialValidationResult validate(Credential credential) {
        if (credential instanceof UsernamePasswordCredential){
            UsernamePasswordCredential usernamePasswordCredential = (UsernamePasswordCredential) credential;

            if(authService.isUserValid(usernamePasswordCredential.getCaller(),usernamePasswordCredential.getPasswordAsString())){
                User user = authService.findByUserNameAndPassword(usernamePasswordCredential.getCaller(), usernamePasswordCredential.getPasswordAsString());

                return new CredentialValidationResult(user.getUsername(),Set.of(user.getRole().name()));
            }

        }
        return CredentialValidationResult.INVALID_RESULT;
    }
}
