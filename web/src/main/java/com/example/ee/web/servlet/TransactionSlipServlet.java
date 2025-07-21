package com.example.ee.web.servlet;

import com.example.ee.core.model.TransactionType;
import jakarta.annotation.security.DeclareRoles;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.HttpConstraint;
import jakarta.servlet.annotation.ServletSecurity;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;

import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/user/transactionSlip")
@DeclareRoles({"CUSTOMER"})
@ServletSecurity(@HttpConstraint(rolesAllowed = {"CUSTOMER"}))
public class TransactionSlipServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String from = req.getParameter("from");
        String to = req.getParameter("to");
        String amount = req.getParameter("amount");
        String desc = req.getParameter("desc");

        resp.setContentType("application/pdf");
        resp.setHeader("Content-Disposition", "attachment; filename=Transaction_Slip.pdf");

        try (OutputStream os = resp.getOutputStream()) {
            Document document = new Document(PageSize.A5, 36, 36, 36, 36); // A5 size for slip feel
            PdfWriter writer = PdfWriter.getInstance(document, os);
            document.open();

            // Define fonts
            Font titleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 18);
            Font labelFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12);
            Font valueFont = FontFactory.getFont(FontFactory.HELVETICA, 12);
            Font smallFont = FontFactory.getFont(FontFactory.HELVETICA_OBLIQUE, 9, BaseColor.GRAY);

            // Title
            Paragraph title = new Paragraph("Payment Confirmation Slip", titleFont);
            title.setAlignment(Element.ALIGN_CENTER);
            title.setSpacingAfter(10);
            document.add(title);

            // Date
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Paragraph datePara = new Paragraph("Date: " + sdf.format(new Date()), smallFont);
            datePara.setAlignment(Element.ALIGN_RIGHT);
            document.add(datePara);

            document.add(Chunk.NEWLINE);

            // Table for transaction details
            PdfPTable table = new PdfPTable(2);
            table.setWidthPercentage(100);
            table.setSpacingBefore(10);
            table.setSpacingAfter(10);
            table.setWidths(new int[]{1, 2});

            // Helper method to add rows
            addRow(table, "From Account", (from == null || from.isEmpty()) ? "From Bank" : from, labelFont, valueFont);
            addRow(table, "To Account", to, labelFont, valueFont);
            addRow(table, "Amount", "Rs. " + String.format("%.2f", Double.parseDouble(amount)), labelFont, valueFont);
            addRow(table, "Type", TransactionType.TRANSFER.toString(), labelFont, valueFont);
            addRow(table, "Description", desc, labelFont, valueFont);

            document.add(table);

            // Footer
            Paragraph footer = new Paragraph("Thank you for banking with us.", smallFont);
            footer.setAlignment(Element.ALIGN_CENTER);
            footer.setSpacingBefore(20);
            document.add(footer);

            document.close();
            writer.close();

        } catch (Exception e) {
            throw new ServletException("PDF generation error", e);
        }
    }

    private void addRow(PdfPTable table, String label, String value, Font labelFont, Font valueFont) {
        PdfPCell labelCell = new PdfPCell(new Phrase(label, labelFont));
        labelCell.setBorder(Rectangle.NO_BORDER);
        labelCell.setPadding(5);

        PdfPCell valueCell = new PdfPCell(new Phrase(value, valueFont));
        valueCell.setBorder(Rectangle.NO_BORDER);
        valueCell.setPadding(5);

        table.addCell(labelCell);
        table.addCell(valueCell);
    }
}
