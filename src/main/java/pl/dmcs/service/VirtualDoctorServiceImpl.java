package pl.dmcs.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import okhttp3.*;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

@Service
public class VirtualDoctorServiceImpl implements VirtualDoctorService{
    private static final String OLLAMA_URL = "http://localhost:11434/api/chat";
    private final OkHttpClient client;
    private final ObjectMapper mapper = new ObjectMapper();

    public VirtualDoctorServiceImpl() {
        this.client = new OkHttpClient.Builder()
                .connectTimeout(30, TimeUnit.SECONDS)
                .writeTimeout(30, TimeUnit.SECONDS)
                .readTimeout(30, TimeUnit.SECONDS)
                .build();
    }

    public VirtualDoctorServiceImpl(OkHttpClient client) {
        this.client = client;
    }

    public String processMessage(String message, List<Map<String, String>> history) throws IOException {
        // Create JSON request body
        Map<String, Object> requestBody = new HashMap<>();
        requestBody.put("model", "mistral");
        requestBody.put("messages", history); // History as messages list
        requestBody.put("stream", false);

        // Add user input as a new message
        Map<String, String> userMessage = new HashMap<>();
        userMessage.put("role", "user");
        userMessage.put("content", message);
        history.add(userMessage);

        // Convert to JSON
        String jsonBody = mapper.writeValueAsString(requestBody);

        RequestBody body = RequestBody.create(jsonBody, MediaType.parse("application/json"));

        Request request = new Request.Builder()
                .url(OLLAMA_URL)
                .post(body)
                .build();

        try (Response response = client.newCall(request).execute()) {
            if (!response.isSuccessful()) {
                throw new IOException("Unexpected response " + response);
            }

            assert response.body() != null;

            // Parse JSON response
            String responseBody = response.body().string();
            JsonNode rootNode = mapper.readTree(responseBody);
            String botResponse = rootNode.get("message").get("content").asText(); // Fixing response extraction

            // Add AI response to history
            Map<String, String> botMessage = new HashMap<>();
            botMessage.put("role", "assistant");
            botMessage.put("content", botResponse);
            history.add(botMessage);

            // Return structured response
            Map<String, String> result = new HashMap<>();
            result.put("response", botResponse);
            return mapper.writeValueAsString(result);
        }
    }
}
