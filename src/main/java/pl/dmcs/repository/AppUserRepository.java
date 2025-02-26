package pl.dmcs.repository;
//
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import pl.dmcs.domain.AppUser;
import pl.dmcs.domain.VerificationToken;

import java.util.List;

@Transactional
@Repository
public interface AppUserRepository extends JpaRepository<AppUser, Long> {

    List<AppUser> findByLastName(String lastName);
    AppUser findById(long id);
    AppUser findByLogin(String login);
    List<AppUser> findAllByEnabledIsFalse();
    AppUser findByToken(VerificationToken token);
}
