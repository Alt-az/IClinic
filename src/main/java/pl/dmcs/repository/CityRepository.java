package pl.dmcs.repository;

import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import pl.dmcs.domain.City;
import pl.dmcs.domain.VerificationToken;

import java.util.List;

@Transactional
@Repository
public interface CityRepository  extends JpaRepository<City, Long>{
    City findByCityName(String name);
    City findById(long id);
    List<City> findAll();
}
