package pl.dmcs.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import pl.dmcs.domain.AppUser;
import pl.dmcs.domain.Appointment;
import pl.dmcs.domain.Doctor;
import pl.dmcs.service.AppUserService;
import pl.dmcs.service.AppointmentService;
import pl.dmcs.service.DoctorService;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;

@Controller
public class DetailsController {
    @Autowired
    DoctorService doctorService;

    @Autowired
    AppointmentService appointmentService;

    @Autowired
    AppUserService appUserService;

    @Autowired
    public DetailsController(DoctorService doctorService, AppointmentService appointmentService, AppUserService appUserService){
        this.doctorService = doctorService;
        this.appointmentService = appointmentService;
        this.appUserService = appUserService;
    }

    @GetMapping(value="/details")
    public String details(Model model, HttpServletRequest request, Principal login) {
        int id = Integer.parseInt(request.getParameter("id"));
        Doctor doctor = doctorService.findDoctorById(id);
        model.addAttribute("doctor", doctor);
        Appointment appointment = new Appointment();
        model.addAttribute("appointment", appointment);
        Date appointmentDate = new Date(); // Get your date from the database or service
        SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy HH:mm");
        String formattedDate = dateFormat.format(appointmentDate);
        model.addAttribute("formattedDate", formattedDate);
        if(login == null) {
            return "details";
        }
        AppUser appUserload = appUserService.findByLogin(login.getName());
        model.addAttribute("appUser", appUserload);
        return "details";
    }

    @RequestMapping(value = "/makeAppointment",method = RequestMethod.POST)
    public String makeAppointment(@Valid @ModelAttribute("appointment") Appointment appointment,
                                  Model model, HttpServletRequest request) {
        int id = Math.toIntExact(appointment.getDoctor().getId());
        if(appointment.getDate().before(new Date())){
            return "redirect:/details?id="+ id;
        }
        Doctor doctor = doctorService.findDoctorById(id);
        appointment.setDoctor(doctor);
        AppUser appUser = appUserService.getAppUser(appointment.getPatient().getId());
        appointment.setPatient(appUser);
        appointmentService.addAppointment(appointment);
        return "redirect:/appointments";
    }
}
