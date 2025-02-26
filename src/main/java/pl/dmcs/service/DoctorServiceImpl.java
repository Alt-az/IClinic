package pl.dmcs.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pl.dmcs.domain.Doctor;
import pl.dmcs.repository.DoctorRepository;

import java.security.Provider;
import java.util.List;

@Service
public class DoctorServiceImpl implements DoctorService {
    @Autowired
    DoctorRepository doctorRepository;

    @Autowired
    public DoctorServiceImpl(DoctorRepository doctorRepository) {
        this.doctorRepository = doctorRepository;
    }

    public List<Doctor> searchDoctors(String cityName, String firstName, String lastName){
        List<Doctor> doctorList = doctorRepository.findByCityNameAndFirstNameAndLastName(cityName,firstName,lastName);
        if (doctorList.isEmpty() && firstName.isEmpty() && lastName.isEmpty()){
            doctorList = doctorRepository.findByCityName(cityName);
        }
        else if(lastName.isEmpty()){
            doctorList = doctorRepository.findByFirstName(firstName);
        } else if (firstName.isEmpty()) {
            doctorList = doctorRepository.findByLastName(lastName);
        }
        return doctorList;
    }

    public Doctor findDoctorById(long id){
        return doctorRepository.findById(id);
    }
    public List<Doctor> findAll(){
        return doctorRepository.findAll();
    }
}
