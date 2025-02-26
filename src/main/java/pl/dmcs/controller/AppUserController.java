package pl.dmcs.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import pl.dmcs.domain.AppUser;
import pl.dmcs.service.*;
import pl.dmcs.validator.AppUserValidator;

import java.security.Principal;

@Controller
public class AppUserController {


    private AppUserValidator appUserValidator = new AppUserValidator();

    // injected by field
    @Autowired
    AddressService addressService;

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
    public AppUserController(AppUserService appUserService, EmailService emailService) {
        this.appUserService = appUserService;
        this.emailService = emailService;
    }

    @RequestMapping(value = "/appUsers")
    public String showAppUsers(Model model, HttpServletRequest request) {
        int appUserId = ServletRequestUtils.getIntParameter(request, "appUserId" , -1);
        if (appUserId > 0){
            AppUser appUser = appUserService.getAppUser(appUserId);
            appUser.setPassword("");
            appUser.setAddress(addressService.getAddress(appUserService.getAppUser(appUserId).getAddress().getId()));
            model.addAttribute("selectedAddress", appUserService.getAppUser(appUserId).getAddress().getId());
            model.addAttribute("appUser", appUser);
        }
        else
            model.addAttribute("appUser", new AppUser());

        model.addAttribute("appUserList", appUserService.listAppUser());
        model.addAttribute("appUserRoleList",appUserRoleService.listAppUserRole());
        model.addAttribute("addressesList", addressService.listAddress());

        return "appUser";
    }

    @RequestMapping(value = "/appUserManage")
    public String showAppUserManager(Model model, HttpServletRequest request, Principal login) {
        AppUser appUser = appUserService.findByLogin(login.getName());
        long appUserId = appUser.getId();
        appUser.setPassword("");
        if(appUser.getAddress() != null){
            appUser.setAddress(addressService.getAddress(appUserService.getAppUser(appUserId).getAddress().getId()));
            model.addAttribute("selectedAddress", appUserService.getAppUser(appUserId).getAddress().getId());
        }
        model.addAttribute("appUser", appUser);
        model.addAttribute("appUserList", appUserService.listAppUser());
        model.addAttribute("appUserRoleList",appUserRoleService.listAppUserRole());
        model.addAttribute("addressesList", addressService.listAddress());

        return "manageAccount";
    }

    @RequestMapping(value = "/editAppUserManager", method = RequestMethod.POST)
    public String editAppUserManager(@Valid @ModelAttribute("appUser") AppUser appUser, BindingResult result, Model model,
                             HttpServletRequest request) {

        appUserValidator.validate(appUser, result);
//        System.out.println("halo1" + result.getErrorCount() + " " + reCaptchaService.verify(request.getParameter("g-recaptcha-response")));
        if (result.getErrorCount() == 0  && reCaptchaService.verify(request.getParameter("g-recaptcha-response")))  {
//            System.out.println("halo2");
            appUser.setAppUserRole(appUserService.getAppUser(appUser.getId()).getAppUserRole());
            if (appUser.getId() == 0)
                appUserService.addAppUser(appUser);
            else
                appUserService.editAppUser(appUser);

//            emailService.sendMail(appUser.getEmail(),"Hello in the app!", "Account created - confirmation email");
            return "redirect:appUserManage";
        }

        // when at least one role is selected this line prevents from lazy init exception
        appUser.getAppUserRole().clear();

        model.addAttribute("appUserList", appUserService.listAppUser());
        model.addAttribute("appUserRoleList",appUserRoleService.listAppUserRole());
        model.addAttribute("addressesList", addressService.listAddress());
        return "manageAccount";
    }

    @RequestMapping(value = "/addAppUser", method = RequestMethod.POST)
    public String addAppUser(@Valid @ModelAttribute("appUser") AppUser appUser, BindingResult result, Model model,
                             HttpServletRequest request) {

        appUserValidator.validate(appUser, result);

        if (result.getErrorCount() == 0  && reCaptchaService.verify(request.getParameter("g-recaptcha-response")))  {

            if (appUser.getId() == 0)
                appUserService.addAppUser(appUser);
            else
                appUserService.editAppUser(appUser);

            emailService.sendMail(appUser.getEmail(),"Hello in the app!", "Account created - confirmation email");
            return "redirect:appUsers";
        }

        // when at least one role is selected this line prevents from lazy init exception
        appUser.getAppUserRole().clear();

        model.addAttribute("appUserList", appUserService.listAppUser());
        model.addAttribute("appUserRoleList",appUserRoleService.listAppUserRole());
        model.addAttribute("addressesList", addressService.listAddress());
        return "appUser";
    }

    @RequestMapping("/delete/{appUserId}")
    public String deleteUser(@PathVariable("appUserId") Long appUserId) {
        appUserService.removeAppUser(appUserId);
        return "redirect:/appUsers";
    }

}
