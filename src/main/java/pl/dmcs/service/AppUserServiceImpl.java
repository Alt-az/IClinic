package pl.dmcs.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import pl.dmcs.domain.AppUser;
import pl.dmcs.domain.VerificationToken;
import pl.dmcs.repository.AppUserRepository;
import pl.dmcs.repository.AppUserRoleRepository;
import pl.dmcs.repository.VerificationTokenRepository;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class AppUserServiceImpl implements AppUserService{

	private AppUserRepository appUserRepository;
	private AppUserRoleRepository appUserRoleRepository;
	private PasswordEncoder passwordEncoder;

	@Autowired
	public AppUserServiceImpl(AppUserRepository appUserRepository, AppUserRoleRepository appUserRoleRepository, PasswordEncoder passwordEncoder) {
		this.appUserRepository = appUserRepository;
		this.appUserRoleRepository = appUserRoleRepository;
		this.passwordEncoder = passwordEncoder;
	}

	@Transactional
	public void addAppUser(AppUser appUser) {
		appUser.getAppUserRole().add(appUserRoleRepository.findByRole("ROLE_USER"));
		appUser.setPassword(passwordEncoder.encode(appUser.getPassword()));
		appUserRepository.save(appUser);
	}

	@Transactional
	public void editAppUser(AppUser appUser) {
		appUser.setPassword(passwordEncoder.encode(appUser.getPassword()));
        appUserRepository.save(appUser);
	}

	@Transactional
	public List<AppUser> listAppUser() {
		return appUserRepository.findAll();
	}

	@Transactional
	public void removeAppUser(long id) {
        appUserRepository.deleteById(id);
	}

	@Transactional
	public AppUser getAppUser(long id) {
		return appUserRepository.findById(id);
	}
	@Transactional
	public AppUser findByLogin(String login) {
		return appUserRepository.findByLogin(login);
	}
//	@Scheduled(fixedRate = 60 * 1000)
	//@Scheduled(cron = "0 15 10 15 * ?")
	public void activateInactiveAppUsers() {
		String processName = "activating_inactive_users";
		System.out.println("activating_inactive_users: ");
		List<AppUser> appUsers = appUserRepository.findAllByEnabledIsFalse();
		appUsers.forEach(appUser -> {
			appUser.setEnabled(true);
			appUserRepository.saveAndFlush(appUser);
			System.out.println(appUser.getLogin());
		});
	}
	@Autowired
	private VerificationTokenRepository tokenRepository;

	public void createVerificationToken(AppUser user, String token) {
		VerificationToken verificationToken = new VerificationToken();
		verificationToken.setToken(token);
		verificationToken.setUser(user);
		verificationToken.setExpiryDate(LocalDateTime.now().plusHours(24));
		tokenRepository.save(verificationToken);
	}

	public VerificationToken getVerificationToken(String token) {
		return tokenRepository.findByToken(token);
	}

	public void enableUser(AppUser user) {
		user.setEnabled(true);
		appUserRepository.save(user);
	}
	public AppUser findByToken(VerificationToken token) {
		return appUserRepository.findByToken(token);
	}
}


