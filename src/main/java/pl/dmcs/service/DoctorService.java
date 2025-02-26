package pl.dmcs.service;
import pl.dmcs.domain.Doctor;

import java.util.List;

public interface DoctorService {
    List<Doctor> searchDoctors(String cityName, String firstName, String lastName);
    Doctor findDoctorById(long id);
    List<Doctor> findAll();
}
