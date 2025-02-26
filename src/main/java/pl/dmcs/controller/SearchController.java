package pl.dmcs.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import pl.dmcs.domain.City;
import pl.dmcs.domain.Doctor;
import pl.dmcs.service.CityService;
import pl.dmcs.service.DoctorService;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.Arrays;
import java.util.List;

@Controller
public class SearchController {
    @Autowired
    CityService cityService;

    @Autowired
    DoctorService doctorService;

    @Autowired
    public SearchController(CityService cityService, DoctorService doctorService) {
        this.cityService = cityService;
        this.doctorService = doctorService;
    }


    @RequestMapping("/search")
    public String search(Model model, HttpServletRequest request) {
        String cityName = request.getParameter("cityName");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        Doctor doctor = new Doctor();
        model.addAttribute("doctor", doctor);
        List<City> cities = cityService.listCity();
        model.addAttribute("cities", cities);
        model.addAttribute("selectedCity", doctor.getCityName());
        model.addAttribute("doctors", doctorService.searchDoctors(cityName, firstName, lastName));
        return "search";
    }

    @RequestMapping(value = "/searchSubmit", method = RequestMethod.POST)
    public String searchSubmit(@Valid @ModelAttribute("doctor") Doctor doctor,
                               BindingResult result, Model model,
                               HttpServletRequest request) throws UnsupportedEncodingException {
        model.addAttribute("doctor", doctor);
        List<City> cities = cityService.listCity();
        model.addAttribute("cities", cities);
        model.addAttribute("selectedCity", doctor.getCityName());
        model.addAttribute("doctors", doctorService.searchDoctors(doctor.getCityName(), doctor.getFirstName(), doctor.getLastName()));
        return "redirect:/search?cityName=" + URLEncoder.encode(doctor.getCityName(), StandardCharsets.UTF_8) +
                "&firstName=" +URLEncoder.encode(doctor.getFirstName(), StandardCharsets.UTF_8)
                + "&lastName=" + URLEncoder.encode(doctor.getLastName(), StandardCharsets.UTF_8);
    }
}
