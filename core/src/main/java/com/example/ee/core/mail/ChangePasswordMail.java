package com.example.ee.core.mail;

import jakarta.mail.Message;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeBodyPart;
import jakarta.mail.internet.MimeMultipart;

public class ChangePasswordMail extends Mailable{

    private final String to;
    private final String verificationCode;

    public ChangePasswordMail(String to, String vcode) {
        this.to = to;
        verificationCode = vcode;
    }

    @Override
    public void build(Message message) throws Exception {
        message.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
        message.setSubject("Vexa Bank Password Change Verification Code");

// Generate your code somewhere before this (e.g., String verificationCode = "123456";)

        String html =
                "<div style=\"font-family:Arial,sans-serif;max-width:600px;margin:auto;padding:20px;"
                        + "border:1px solid #e0e0e0;border-radius:8px;\">"
                        + "<h2 style=\"color:#2563eb;\">Password Change Request</h2>"
                        + "<p>Dear Customer,</p>"
                        + "<p>We received a request to change the password for your Vexa Bank account.</p>"
                        + "<p>To proceed, please use the following verification code:</p>"
                        + "<div style=\"background:#f1f5f9;padding:20px;font-size:24px;font-weight:bold;"
                        + "text-align:center;border-radius:6px;margin:20px 0;\">" + verificationCode + "</div>"
                        + "<p>This code will expire in 10 minutes.</p>"
                        + "<p>If you did not request this change, please contact our support team immediately.</p>"
                        + "<p>Thank you for banking with us.</p>"
                        + "<p style=\"font-size:0.9em;color:#64748b;\">Vexa Bank Security Team</p>"
                        + "</div>";

        MimeBodyPart mimeBodyPart = new MimeBodyPart();
        mimeBodyPart.setContent(html, "text/html; charset=utf-8");

        MimeMultipart multipart = new MimeMultipart();
        multipart.addBodyPart(mimeBodyPart);

        message.setContent(multipart);

    }
}
