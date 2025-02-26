package pl.dmcs.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import pl.dmcs.domain.Prescription;

import java.util.List;

@Repository
public interface PrescriptionRepository extends JpaRepository<Prescription, Long> {
    List<Prescription> findPrescriptionByPatient_Id(long id);
    Prescription findPrescriptionById(long id);
}
