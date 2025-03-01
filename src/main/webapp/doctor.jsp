<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Virtual Doctor Chat</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        html, body {
            height: 100%;
            margin: 0;
        }
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        .main-content {
            flex: 1 0 auto;
            padding: 20px 0;
        }
        .chat-container {
            height: calc(70vh - 100px);
            overflow-y: auto;
            border: 1px solid #ddd;
            border-radius: 5px;
            margin-bottom: 20px;
            padding: 15px;
        }
        .message {
            margin-bottom: 10px;
            padding: 10px;
            border-radius: 5px;
        }
        .user-message {
            background-color: #e3f2fd;
            margin-left: 20%;
        }
        .bot-message {
            background-color: #f5f5f5;
            margin-right: 20%;
        }
        footer {
            flex-shrink: 0;
        }
    </style>
</head>
<body>
<jsp:include page="header.jsp" />

<div class="main-content">
    <div class="container">
        <div class="chat-container" id="chatContainer"></div>
        <div class="input-group">
            <input type="text" id="messageInput" class="form-control" placeholder="Type your message...">
            <button class="btn btn-success" onclick="sendMessage()">Send</button>
        </div>
    </div>
</div>
<script>
    // Store conversation history
    let conversationHistory = [];

    // Start conversation when page loads
    document.addEventListener('DOMContentLoaded', function() {
        // Add welcome message
        appendMessage('bot', 'Hello! I\'m your virtual doctor assistant. How can I help you today?');
        // Add initial message to history
        conversationHistory.push({
            role: "assistant",
            content: "Hello! I\'m your virtual doctor assistant. How can I help you today?"
        });
    });

    function sendMessage() {
        const input = document.getElementById('messageInput');
        const message = input.value.trim();
        if (message) {
            appendMessage('user', message);
            // Add user message to history
            conversationHistory.push({
                role: "user",
                content: message
            });

            fetch('/chat', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    '${_csrf.headerName}': '${_csrf.token}'
                },
                body: JSON.stringify({
                    message: message,
                    history: conversationHistory
                })
            })
                .then(response => response.text())
                .then(data => {
                    try {
                        const jsonData = JSON.parse(data);
                        const botResponse = jsonData.response;
                        appendMessage('bot', botResponse);
                        // Add bot response to history
                        conversationHistory.push({
                            role: "assistant",
                            content: botResponse
                        });
                    } catch (e) {
                        console.error("Error parsing response:", e);
                        appendMessage('bot', "Sorry, I encountered an error processing your request.");
                    }
                });
            input.value = '';
        }
    }

    function appendMessage(sender, message) {
        const container = document.getElementById('chatContainer');
        const messageDiv = document.createElement('div');
        messageDiv.className = `message ${sender}-message`;
        messageDiv.textContent = message;
        container.appendChild(messageDiv);
        container.scrollTop = container.scrollHeight;
    }

    // Allow sending message with Enter key
    document.getElementById('messageInput').addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
            sendMessage();
        }
    });
</script>

<jsp:include page="footer.jsp" />
</body>
</html>