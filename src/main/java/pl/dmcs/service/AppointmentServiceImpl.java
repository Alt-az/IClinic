package pl.dmcs.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import pl.dmcs.domain.AppUser;
import pl.dmcs.domain.Appointment;
import pl.dmcs.repository.AppointmentRepository;

import java.util.List;

@Service
public class AppointmentServiceImpl implements AppointmentService{

    AppointmentRepository appointmentRepository;

    @Autowired
    public AppointmentServiceImpl(AppointmentRepository appointmentRepository) {
        this.appointmentRepository = appointmentRepository;
    }

    @Override
    public void addAppointment(Appointment appointment) {
        appointmentRepository.save(appointment);
    }

    @Override
    public void editAppointment(Appointment appointment) {
        appointmentRepository.save(appointment);
    }

    @Override
    public void removeAppointment(long id) {
        appointmentRepository.deleteById(id);
    }

    @Override
    public List<Appointment> findAppointmentByPatient(AppUser appUser) {
        return appointmentRepository.findAppointmentByPatient(appUser);
    }
    @Override
    public Appointment findAppointmentById(long id) {
        return appointmentRepository.findAppointmentById(id);
    }

    @Scheduled(fixedRate = 60 * 1000)
    @Override
    public void unpaidBillRemoval() {
        List<Appointment> appointments = appointmentRepository.findAll();
        for (Appointment appointment : appointments) {
            if (appointment != null && !appointment.getPaymentStatus()) {
                appointmentRepository.delete(appointment);
            }
        }
    }
}
