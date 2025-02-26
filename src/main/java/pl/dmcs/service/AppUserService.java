package pl.dmcs.service;

import org.springframework.security.access.annotation.Secured;
import org.springframework.security.access.prepost.PreAuthorize;
import pl.dmcs.domain.AppUser;
import pl.dmcs.domain.VerificationToken;

import java.util.List;

public interface AppUserService {

	@Secured("ROLE_ADMIN")
	void addAppUser(AppUser appUser);

	@PreAuthorize("hasRole('ROLE_ADMIN') OR (#appUser.login == principal.username)")
	void editAppUser(AppUser appUser);

	List<AppUser> listAppUser();

	@Secured("ROLE_ADMIN")
	void removeAppUser (long id);
	AppUser getAppUser(long id);
	AppUser findByLogin(String login);
	void activateInactiveAppUsers();
	void createVerificationToken(AppUser user, String token);
	VerificationToken getVerificationToken(String token);
	void enableUser(AppUser user);
	AppUser findByToken(VerificationToken token);
}

