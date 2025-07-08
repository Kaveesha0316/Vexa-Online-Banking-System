package com.example.ee.core.povider;

import com.example.ee.core.mail.Mailable;
import com.example.ee.core.util.Env;
import jakarta.mail.Authenticator;
import jakarta.mail.PasswordAuthentication;

import java.util.Properties;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

public class MailServiceProvider {
    private Properties properties = new Properties();
    private Authenticator authenticator ;
    private static MailServiceProvider instance;
    private ThreadPoolExecutor executor;
    private BlockingQueue<Runnable> blockingQueue = new LinkedBlockingQueue<Runnable>();

    private MailServiceProvider(){
        properties.setProperty("mail.smtp.host", Env.getProperty("mailtrap.host"));
        properties.setProperty("mail.smtp.auth", "true");
        properties.setProperty("mail.smtp.port",  Env.getProperty("mailtrap.port"));
        properties.setProperty("mail.smtp.starttls.enable", "false");
    }

    public static MailServiceProvider getInstance(){
        if(instance == null){
            instance = new MailServiceProvider();
        }
        return instance;
    }

    public void start(){
        authenticator = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication( Env.getProperty("mailtrap.username"), Env.getProperty("mailtrap.password"));
            }
        };

        executor = new ThreadPoolExecutor(5,10,5, TimeUnit.SECONDS,blockingQueue,
                new ThreadPoolExecutor.AbortPolicy());
        executor.prestartAllCoreThreads();

        System.out.println("Mail service provider started");
    }

    public void sendMail(Mailable mail){
        blockingQueue.offer(mail);
    }

    public Properties getProperties() {
        return properties;
    }

    public Authenticator getAuthenticator() {
        return authenticator;
    }

    public void stop(){
        if(executor != null){
            executor.shutdown();
        }
    }

}
