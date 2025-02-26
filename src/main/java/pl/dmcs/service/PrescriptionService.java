package pl.dmcs.service;

import pl.dmcs.domain.Prescription;

import java.util.List;

public interface PrescriptionService {
    void addPrescription(Prescription prescription);
    void editPrescription(Prescription prescription);
    void removePrescription(long id);
    List<Prescription> findPrescriptionByPatient_Id(long id);
    Prescription findPrescriptionById(long id);
}
