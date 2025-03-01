package pl.dmcs.controller;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import pl.dmcs.service.VirtualDoctorService;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@Controller
public class VirtualDoctorController {

    private final VirtualDoctorService virtualDoctorService;

    @Autowired
    public VirtualDoctorController(VirtualDoctorService virtualDoctorService) {
        this.virtualDoctorService = virtualDoctorService;
    }

    @PostMapping("/chat")
    public ResponseEntity<String> chat(@RequestBody Map<String, Object> request) throws IOException {
        String message = (String) request.get("message");
        List<Map<String, String>> history = (List<Map<String, String>>) request.get("history");
        String response = virtualDoctorService.processMessage(message, history);
        System.out.println("AI response: " + response);
        return ResponseEntity.ok(response);
    }
    @RequestMapping("/doctor-view")
    public String doctorChat(Model model, HttpServletRequest request) {
        return "doctor";
    }
}