package pl.dmcs.repository;

import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import pl.dmcs.domain.Doctor;
import pl.dmcs.domain.VerificationToken;

import java.util.List;

@Transactional
@Repository
public interface DoctorRepository extends JpaRepository<Doctor, Long> {

    List<Doctor> findByFirstName(String lastName);
    List<Doctor> findByLastName(String lastName);
    List<Doctor> findByCityName(String cityName);
    List<Doctor> findByCityNameAndFirstNameAndLastName(String cityName, String firstName, String lastName);
    Doctor findById(long id);
    List<Doctor> findAll();
}