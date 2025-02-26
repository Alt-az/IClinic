package pl.dmcs.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import pl.dmcs.domain.AppUser;
import pl.dmcs.domain.Appointment;

import java.util.List;

@Repository
public interface AppointmentRepository extends JpaRepository<Appointment, Long> {
    List<Appointment> findAppointmentByPatient(AppUser patient);
    Appointment findAppointmentById(Long id);
    List<Appointment> findAll();
}
