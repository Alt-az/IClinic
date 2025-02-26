<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<html>
<head>
    <title>Admin Panel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-aFq/bzH65dt+w6FI2ooMVUpc+21e0SRygnTpmBvdBgSdnuTN7QbdgL+OapgHtvPp" crossorigin="anonymous">
    <script src="https://www.google.com/recaptcha/api.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/js/bootstrap.bundle.min.js" integrity="sha384-qKXV1j0HvMUeCBQ+QVp7JcfGl760yU08IQ+GpUo5hlbpg51QRiuqHAJz8+BrxE/N" crossorigin="anonymous"></script>
    <link href="<c:url value="/resources/css/home.css" />" rel="stylesheet">
    <style>
        .list-group-item:hover {
            background-color: #f8f9fa; /* Change this to the color you want when hovering */
            cursor: pointer;
        }
    </style>
</head>
<body>
<jsp:include page="header.jsp" />
<div class="main-content container">
<h2>Admin Panel</h2>

    <div class="card">
        <sec:authorize access="hasRole('ROLE_ADMIN')">
            <ul class="list-group list-group-flush">
                <li class="list-group-item"><a href="/appUsers" class="text-decoration-none text-dark"><spring:message code="label.addAppUser"/></a></li>
                <li class="list-group-item"><a href="/appUserRole" class="text-decoration-none text-dark"><spring:message code="label.role"/></a></li>
                <li class="list-group-item"><a href="/addresses" class="text-decoration-none text-dark"><spring:message code="label.address"/></a></li>
                <li class="list-group-item"><a href="/prescriptionsForm" class="text-decoration-none text-dark">Prescription Form</a></li>
                <li class="list-group-item"><a href="/appointmentsForm" class="text-decoration-none text-dark">Appointment Form</a></li>
            </ul>
        </sec:authorize>
    </div>
</div>
<jsp:include page="footer.jsp" />
</body>
</html>

