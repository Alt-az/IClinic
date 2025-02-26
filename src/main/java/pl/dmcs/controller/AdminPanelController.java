package pl.dmcs.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import pl.dmcs.domain.City;
import pl.dmcs.domain.Doctor;
import pl.dmcs.service.CityService;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

@Controller
public class AdminPanelController {
    @Autowired
    CityService cityService;

    @Autowired
    public AdminPanelController(CityService cityService) {
        this.cityService = cityService;
    }

    @RequestMapping(value = "/admin-panel")
    public String helloWorld(Locale locale, Model model) {

        Date date = new Date();
        DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
        String formattedDate = dateFormat.format(date);

        model.addAttribute("serverTime", formattedDate );
        model.addAttribute("message","Polish characters encoding: ółźżćśńąęÓŁŹŻĆŚŃĄĘ");

        return "admin-panel";
    }
    @RequestMapping(value = "/")
    public String home(Locale locale, Model model) {

        Doctor doctor = new Doctor();
        model.addAttribute("doctor", doctor);

        List<City> cities = cityService.listCity();
        model.addAttribute("cities", cities);

        model.addAttribute("selectedCity", doctor.getCityName());

        Date date = new Date();
        DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
        String formattedDate = dateFormat.format(date);

        model.addAttribute("serverTime", formattedDate );
        model.addAttribute("message","Polish characters encoding: ółźżćśńąęÓŁŹŻĆŚŃĄĘ");

        return "home";
    }
}

