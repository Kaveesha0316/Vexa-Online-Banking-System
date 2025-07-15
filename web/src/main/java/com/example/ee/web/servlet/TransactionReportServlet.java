package com.example.ee.web.servlet;

import com.example.ee.core.model.Transaction;
import com.example.ee.core.service.TransactionService;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet("/user/downloadTransactionReport")
public class TransactionReportServlet extends HttpServlet {

    @EJB
    private TransactionService transactionService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String fromDateStr = req.getParameter("fromDate");
        String toDateStr = req.getParameter("toDate");
        Long accountId = Long.parseLong(req.getParameter("accountId"));

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date fromDate, toDate;

        try {
            fromDate = sdf.parse(fromDateStr);
            toDate = sdf.parse(toDateStr);
        } catch (Exception e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid date format");
            return;
        }

        List<Transaction> transactions = transactionService.findTransactionsByAccountAndDateRange(accountId, fromDate, toDate);

        resp.setContentType("application/pdf");
        resp.setHeader("Content-Disposition", "attachment; filename=Transaction_Report.pdf");

        try (OutputStream os = resp.getOutputStream()) {
            com.itextpdf.text.Document document = new com.itextpdf.text.Document();
            com.itextpdf.text.pdf.PdfWriter.getInstance(document, os);
            document.open();

            // Title
            com.itextpdf.text.Font titleFont = new com.itextpdf.text.Font(com.itextpdf.text.Font.FontFamily.HELVETICA, 18, com.itextpdf.text.Font.BOLD);
            com.itextpdf.text.Paragraph title = new com.itextpdf.text.Paragraph("Transaction Report", titleFont);
            title.setAlignment(com.itextpdf.text.Element.ALIGN_CENTER);
            document.add(title);

            // Date Range
            com.itextpdf.text.Font dateFont = new com.itextpdf.text.Font(com.itextpdf.text.Font.FontFamily.HELVETICA, 12, com.itextpdf.text.Font.NORMAL);
            com.itextpdf.text.Paragraph dateRange = new com.itextpdf.text.Paragraph("Date Range: " + fromDateStr + " to " + toDateStr, dateFont);
            dateRange.setAlignment(com.itextpdf.text.Element.ALIGN_CENTER);
            dateRange.setSpacingAfter(20);
            document.add(dateRange);

            // Table
            com.itextpdf.text.pdf.PdfPTable table = new com.itextpdf.text.pdf.PdfPTable(5); // 5 columns
            table.setWidthPercentage(100);
            table.setWidths(new float[]{2, 2, 1, 1, 3}); // Column widths

            // Header
            com.itextpdf.text.Font headerFont = new com.itextpdf.text.Font(com.itextpdf.text.Font.FontFamily.HELVETICA, 12, com.itextpdf.text.Font.BOLD, com.itextpdf.text.BaseColor.WHITE);
            com.itextpdf.text.BaseColor headerBg = new com.itextpdf.text.BaseColor(0, 121, 182);

            String[] headers = {"To Account", "Date", "Amount", "Type", "Description"};
            for (String h : headers) {
                com.itextpdf.text.pdf.PdfPCell cell = new com.itextpdf.text.pdf.PdfPCell(new com.itextpdf.text.Phrase(h, headerFont));
                cell.setBackgroundColor(headerBg);
                cell.setHorizontalAlignment(com.itextpdf.text.Element.ALIGN_CENTER);
                cell.setPadding(5);
                table.addCell(cell);
            }

            // Rows
            com.itextpdf.text.Font rowFont = new com.itextpdf.text.Font(com.itextpdf.text.Font.FontFamily.HELVETICA, 11);
            SimpleDateFormat outputDateFormat = new SimpleDateFormat("MMM d, yyyy HH:mm");

            boolean alternate = false;
            com.itextpdf.text.BaseColor rowColor1 = new com.itextpdf.text.BaseColor(245, 245, 245);
            com.itextpdf.text.BaseColor rowColor2 = com.itextpdf.text.BaseColor.WHITE;

            for (Transaction t : transactions) {
                com.itextpdf.text.BaseColor bg = alternate ? rowColor1 : rowColor2;
                alternate = !alternate;

                String date = outputDateFormat.format(t.getCreatedAt());
                String amount = String.format("%.2f", t.getAmount());
                String type = t.getTransactionType().toString();
                String desc = t.getDescription();
                String toAcc = t.getTodAccount().getAccountNumber();

                String[] cells = {toAcc, date, "Rs. " + amount, type, desc};
                for (String c : cells) {
                    com.itextpdf.text.pdf.PdfPCell cell = new com.itextpdf.text.pdf.PdfPCell(new com.itextpdf.text.Phrase(c, rowFont));
                    cell.setBackgroundColor(bg);
                    cell.setPadding(5);
                    table.addCell(cell);
                }
            }

            document.add(table);
            document.close();
        } catch (Exception e) {
            throw new ServletException("PDF generation error", e);
        }
    }


}
