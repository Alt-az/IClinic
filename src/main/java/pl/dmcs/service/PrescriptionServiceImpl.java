package pl.dmcs.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pl.dmcs.domain.Prescription;
import pl.dmcs.repository.PrescriptionRepository;
import java.util.List;
@Service
public class PrescriptionServiceImpl implements PrescriptionService {
    @Autowired
    PrescriptionRepository prescriptionRepository;

    @Autowired
    public PrescriptionServiceImpl(PrescriptionRepository prescriptionRepository) {
        this.prescriptionRepository = prescriptionRepository;
    }

    @Override
    public void addPrescription(Prescription prescription) {
        prescriptionRepository.save(prescription);
    }

    @Override
    public void editPrescription(Prescription prescription) {
        prescriptionRepository.save(prescription);
    }

    @Override
    public void removePrescription(long id) {
        prescriptionRepository.deleteById(id);
    }

    @Override
    public List<Prescription> findPrescriptionByPatient_Id(long id) {
        return prescriptionRepository.findPrescriptionByPatient_Id(id);
    }
    @Override
    public Prescription findPrescriptionById(long id) {
        return prescriptionRepository.findPrescriptionById(id);
    }
}
