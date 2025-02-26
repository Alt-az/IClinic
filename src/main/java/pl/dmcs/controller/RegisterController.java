package pl.dmcs.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.*;
import pl.dmcs.domain.AppUser;
import pl.dmcs.domain.AppUserRole;
import pl.dmcs.domain.VerificationToken;
import pl.dmcs.service.*;
import pl.dmcs.validator.RegisterValidator;

import java.time.LocalDateTime;
import java.util.*;

@Controller
public class RegisterController {
    private RegisterValidator registerValidator = new RegisterValidator();


    // injected by field
    @Autowired
    AppUserRoleService appUserRoleService;

    // injected by constructor
    private AppUserService appUserService;
    private EmailService emailService;
    ReCaptchaService reCaptchaService;
    @Autowired
    public void setReCaptchaService(ReCaptchaService reCaptchaService) {
        this.reCaptchaService = reCaptchaService;
    }

    @Autowired
    public RegisterController(AppUserService appUserService, EmailService emailService) {
        this.appUserService = appUserService;
        this.emailService = emailService;
    }

    @RequestMapping(value = "/register")
    public String showAppUsers(Model model, HttpServletRequest request) {
        AppUser appUser = new AppUser();
        appUser.setEnabled(false);
        model.addAttribute("appUser", appUser);
        return "register";
    }

    @RequestMapping(value = "/registerUser", method = RequestMethod.POST)
    public String addAppUser(@Valid @ModelAttribute("appUser") AppUser appUser, BindingResult result, @RequestParam(value = "error", required = false) String error, Model model,
                             HttpServletRequest request) {

        registerValidator.validate(appUser, result);

        if (result.getErrorCount() == 0  && reCaptchaService.verify(request.getParameter("g-recaptcha-response")))  {
            appUserService.addAppUser(appUser);
            String token = UUID.randomUUID().toString();
            appUserService.createVerificationToken(appUser,token);
            String confirmationUrl = request.getContextPath() + "/confirm?token=" + token;
            emailService.sendMail(appUser.getEmail(),
                    "Kliknij w link, aby potwierdzić rejestrację: " +
                            "http://localhost:8080" + confirmationUrl,
                    "Potwierdzenie rejestracji");
            model.addAttribute("msg", "Rejestracja przebiegła pomyślnie." +
                    " Na podany adres email został wysłany link aktywacyjny.");
            return "register";
        }

        // when at least one role is selected this line prevents from lazy init exception
        appUser.getAppUserRole().clear();
        model.addAttribute("error", "Invalid username and password!");
        return "register";
    }

    @GetMapping("/confirm")
    public String confirmRegistration(@RequestParam("token") String token, Model model,
                                      HttpServletRequest request) {
        VerificationToken verificationToken = appUserService.getVerificationToken(token);
        if (verificationToken == null) {
            model.addAttribute("msg", "Token jest nieważny");
        }
        AppUser user = verificationToken.getUser();
        if (verificationToken.getExpiryDate().isBefore(LocalDateTime.now())) {
            model.addAttribute("msg", "Token wygasł");
        }
        else{
            model.addAttribute("msg", "Konto zostało aktywowane");
        }
        model.addAttribute("appUser", appUserService.findByToken(appUserService.getVerificationToken(token)));
        appUserService.enableUser(user);
        return "register";
    }
}
