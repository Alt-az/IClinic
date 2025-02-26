package pl.dmcs.service;

import pl.dmcs.domain.AppUser;
import pl.dmcs.domain.Appointment;

import java.util.List;

public interface AppointmentService {
    void addAppointment(Appointment appointment);
    void editAppointment(Appointment appointment);
    void removeAppointment(long id);
    List<Appointment> findAppointmentByPatient(AppUser appUser);
    Appointment findAppointmentById(long id);
    void unpaidBillRemoval();
}
