package pl.dmcs.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import pl.dmcs.domain.Address;

import java.util.List;

@Repository
@Transactional
public interface AddressRepository extends JpaRepository<Address, Long> {
    List<Address> findByStreet(String address);
    Address findById(long id);
}
