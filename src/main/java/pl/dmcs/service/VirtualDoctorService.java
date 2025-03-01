package pl.dmcs.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

public interface VirtualDoctorService {
    public String processMessage(String message, List<Map<String, String>> history) throws IOException;
}
