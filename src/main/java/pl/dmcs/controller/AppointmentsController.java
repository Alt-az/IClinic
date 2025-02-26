package pl.dmcs.controller;

import jakarta.servlet.Servlet;
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
import pl.dmcs.domain.Appointment;
import pl.dmcs.domain.Prescription;
import pl.dmcs.service.AppUserService;
import pl.dmcs.service.AppointmentService;
import pl.dmcs.service.DoctorService;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
public class AppointmentsController {
    @Autowired
    AppointmentService appointmentService;

    @Autowired
    AppUserService appUserService;

    @Autowired
    DoctorService doctorService;

    @Autowired
    public AppointmentsController(AppointmentService appointmentService, AppUserService appUserService){
        this.appointmentService = appointmentService;
        this.appUserService = appUserService;
    }

    @RequestMapping("/appointments")
    public String appointments(Model model, Principal login) {
        AppUser appUser = appUserService.findByLogin(login.getName());
        List<Appointment> appointments = appointmentService.findAppointmentByPatient(appUser);
        model.addAttribute("appointments", appointments);
        return "appointments";
    }
    @RequestMapping(value = "/paybill")
    public String payBill(Model model, Principal login, HttpServletRequest request) {
        AppUser appUser = appUserService.findByLogin(login.getName());
        int id = ServletRequestUtils.getIntParameter(request, "appointmentId", -1);
        Appointment appointment = appointmentService.findAppointmentById(id);
        appointment.setPaymentStatus(true);
        appointmentService.editAppointment(appointment);
        return "redirect:/appointments";
    }

    @RequestMapping("/appointmentsForm")
    public String appointmentsForm(Model model, HttpServletRequest request) {
        model.addAttribute("appUserList", appUserService.listAppUser());
        long id = ServletRequestUtils.getLongParameter(request, "appUserId" , -1);
        if (id > 0){
            AppUser appUser = appUserService.getAppUser(id);
            model.addAttribute("appUser", appUser);
            model.addAttribute("appointmentList", appointmentService.findAppointmentByPatient(appUser));
        }
        else{
            model.addAttribute("appUser", new AppUser());
            model.addAttribute("appointmentList", new ArrayList<Appointment>());
        }
        id = ServletRequestUtils.getLongParameter(request, "appointmentId" , -1);
        System.out.println(id);
        if (id > 0){
            model.addAttribute("selectedDoctor", appointmentService.findAppointmentById(id).getDoctor().getId());
            model.addAttribute("appointment", appointmentService.findAppointmentById(id));
            SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy HH:mm");
            String formattedDate = dateFormat.format(appointmentService.findAppointmentById(id).getDate());
            model.addAttribute("formattedDate", formattedDate);
        }
        else{
            model.addAttribute("appointment", new Appointment());
            Date appointmentDate = new Date(); // Get your date from the database or service
            SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy HH:mm");
            String formattedDate = dateFormat.format(appointmentDate);
            model.addAttribute("formattedDate", formattedDate);
        }
        model.addAttribute("doctorList", doctorService.findAll());
        return "appointmentsForm";
    }

    @RequestMapping(value="/addAppointment", method = RequestMethod.POST)
    public String addAppointment(@Valid @ModelAttribute("appointment") Appointment appointment, Model model) {
        System.out.println("halo");
        System.out.println(appointment.getId());
        appointment.setPatient(appUserService.getAppUser(appointment.getPatient().getId()));
        appointment.setDoctor(doctorService.findDoctorById(appointment.getDoctor().getId()));
        if (appointment.getId() > 0){
            appointmentService.editAppointment(appointment);
        }
        else{
            appointmentService.addAppointment(appointment);
        }
        return "redirect:/appointmentsForm?appUserId="+ appointment.getPatient().getId();
    }
}
