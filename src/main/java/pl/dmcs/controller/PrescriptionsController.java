package pl.dmcs.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import pl.dmcs.domain.AppUser;
import pl.dmcs.domain.Prescription;
import pl.dmcs.service.AppUserService;
import pl.dmcs.service.PrescriptionService;

import java.nio.charset.StandardCharsets;
import java.security.Permission;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.net.URLEncoder;

@Controller
public class PrescriptionsController {
    @Autowired
    PrescriptionService prescriptionService;

    @Autowired
    AppUserService appUserService;

    @Autowired
    public PrescriptionsController(PrescriptionService prescriptionService, AppUserService appUserService){
        this.prescriptionService = prescriptionService;
        this.appUserService = appUserService;
    }

    @RequestMapping("/prescriptions")
    public String prescriptions(Model model, Principal login) {
        AppUser appUser = appUserService.findByLogin(login.getName());
        List<Prescription> prescriptionList = prescriptionService.findPrescriptionByPatient_Id(appUser.getId());
        model.addAttribute("prescriptions", prescriptionList);
        return "prescriptions";
    }

    @RequestMapping("/prescriptionsForm")
    public String prescriptionsForm(Model model, HttpServletRequest request) {
        model.addAttribute("appUserList", appUserService.listAppUser());
        long id = ServletRequestUtils.getLongParameter(request, "appUserId" , -1);
        if (id > 0){
            model.addAttribute("appUser", appUserService.getAppUser(id));
            model.addAttribute("prescriptionList", prescriptionService.findPrescriptionByPatient_Id(id));
        }
        else{
            model.addAttribute("appUser", new AppUser());
            model.addAttribute("prescriptionList", new ArrayList<Prescription>());
        }
        id = ServletRequestUtils.getLongParameter(request, "prescriptionId" , -1);
        System.out.println(id);
        if (id > 0){
            model.addAttribute("prescription", prescriptionService.findPrescriptionById(id));
            SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy HH:mm");
            String formattedDate = dateFormat.format(prescriptionService.findPrescriptionById(id).getExpirationDate());
            model.addAttribute("formattedDate", formattedDate);
        }
        else{
            model.addAttribute("prescription", new Prescription());
            Date appointmentDate = new Date(); // Get your date from the database or service
            SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy HH:mm");
            String formattedDate = dateFormat.format(appointmentDate);
            model.addAttribute("formattedDate", formattedDate);
        }
        return "prescriptionForm";
    }

    @RequestMapping(value="/addPrescription", method = RequestMethod.POST)
    public String addPrescription(@Valid @ModelAttribute("prescription") Prescription prescription, Model model) {
        System.out.println("halo");
        System.out.println(prescription.getId());
        prescription.setPatient(appUserService.getAppUser(prescription.getPatient().getId()));
        if (prescription.getId() > 0){
            prescriptionService.editPrescription(prescription);
        }
        else{
            prescriptionService.addPrescription(prescription);
        }
        return "redirect:/prescriptionsForm?appUserId="+ prescription.getPatient().getId();
    }
}
