package pl.dmcs.service;

import jakarta.servlet.http.HttpServletResponse;
import pl.dmcs.domain.AppUser;
import pl.dmcs.domain.Appointment;

public interface PdfService {
    public void generatePdf(AppUser appUser, HttpServletResponse response);
    public void generatePdfAppointment(Appointment appointment, HttpServletResponse response);
}




