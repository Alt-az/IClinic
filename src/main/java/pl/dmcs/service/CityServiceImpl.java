package pl.dmcs.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pl.dmcs.domain.City;
import pl.dmcs.repository.CityRepository;

import java.util.List;
@Service
public class CityServiceImpl implements CityService{
    CityRepository cityRepository;

    @Autowired
    public CityServiceImpl(CityRepository cityRepository) {
        this.cityRepository = cityRepository;
    }

    @Override
    public List<City> listCity() {
        return cityRepository.findAll();
    }
}
