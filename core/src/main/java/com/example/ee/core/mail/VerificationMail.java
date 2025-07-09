package com.example.ee.core.mail;

import jakarta.mail.Message;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeBodyPart;
import jakarta.mail.internet.MimeMultipart;

public class VerificationMail extends Mailable {
    private final String to;
    private final String username;
    private final String password;

    public VerificationMail(String to, String username, String password) {
        this.to = to;
        this.username = username;
        this.password = password;
    }

    @Override
    public void build(Message message) throws Exception {
        message.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
        message.setSubject("Your Vexa Bank Account Credentials");

        // HTML email body
        String html =
                "<div style=\"font-family:Arial,sans-serif;max-width:600px;margin:auto;padding:20px;"
                        + "border:1px solid #e0e0e0;border-radius:8px;\">"
                        + "<h2 style=\"color:#2563eb;\">Welcome to Vexa Bank</h2>"
                        + "<p>Dear Customer,</p>"
                        + "<p>Your online banking account has been successfully created. Here are your credentials:</p>"
                        + "<table style=\"width:100%;margin:20px 0;border-collapse:collapse;\">"
                        + "<tr>"
                        + "<td style=\"background:#f1f5f9;padding:10px 15px;font-weight:bold;\">Username:</td>"
                        + "<td style=\"background:#f1f5f9;padding:10px 15px;\">" + username + "</td>"
                        + "</tr>"
                        + "<tr>"
                        + "<td style=\"background:#f1f5f9;padding:10px 15px;font-weight:bold;\">Temporary Password:</td>"
                        + "<td style=\"background:#f1f5f9;padding:10px 15px;\">" + password + "</td>"
                        + "</tr>"
                        + "</table>"
                        + "<p style=\"color:#ef4444;\"><strong>Important:</strong> Please log in and change your password immediately.</p>"
                        + "<p>Thank you for choosing Vexa Bank.</p>"
                        + "<p style=\"font-size:0.9em;color:#64748b;\">If you did not request this account, please contact our support immediately.</p>"
                        + "</div>";

        MimeBodyPart mimeBodyPart = new MimeBodyPart();
        mimeBodyPart.setContent(html, "text/html; charset=utf-8");

        MimeMultipart multipart = new MimeMultipart();
        multipart.addBodyPart(mimeBodyPart);

        message.setContent(multipart);
    }
}
