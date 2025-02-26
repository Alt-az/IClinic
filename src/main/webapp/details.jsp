<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Lekarz</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-aFq/bzH65dt+w6FI2ooMVUpc+21e0SRygnTpmBvdBgSdnuTN7QbdgL+OapgHtvPp" crossorigin="anonymous">
    <script src="https://www.google.com/recaptcha/api.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/js/bootstrap.bundle.min.js" integrity="sha384-qKXV1j0HvMUeCBQ+QVp7JcfGl760yU08IQ+GpUo5hlbpg51QRiuqHAJz8+BrxE/N" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-ui-timepicker-addon/1.6.3/jquery-ui-timepicker-addon.min.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-ui-timepicker-addon/1.6.3/jquery-ui-timepicker-addon.min.js"></script>
    <link href="<c:url value="/resources/css/home.css" />" rel="stylesheet">
    <script>
        $( function() {
            $( "#appointmentDate" ).datetimepicker();
        } );
    </script>
</head>
<body>
<jsp:include page="header.jsp" />
<div class="main-content">
<div class="container mt-5">
    <h2 class="text-center">Doctor Details</h2>
    <table class="table table-striped">
        <tbody>
        <tr>
            <th>First Name</th>
            <td>${doctor.firstName}</td>
        </tr>
        <tr>
            <th>Last Name</th>
            <td>${doctor.lastName}</td>
        </tr>
        <tr>
            <th>City</th>
            <td>${doctor.cityName}</td>
        </tr>

        </tbody>
    </table>
    <sec:authorize access="hasRole('ROLE_USER')">
    <div class="container mt-5">
        <h2 class="text-center">Make an Appointment</h2>
        <form:form method="post" action="makeAppointment" modelAttribute="appointment">
            <form:hidden path="doctor.id" value="${doctor.id}"/>
            <form:hidden path="patient.id" value="${appUser.id}"/>
            <form:hidden path="paymentStatus" value="${false}"/>
            <div class="mb-3">
                <label for="appointmentDate" class="form-label">Appointment Date and Time</label>
                <form:input path="date" cssClass="form-control" id="appointmentDate" required="true" value="${formattedDate}"/>
            </div>
            <button type="submit" class="btn btn-primary">Submit</button>
        </form:form>
    </div>
    </sec:authorize>
</div>
</div>
<jsp:include page="footer.jsp" />
</body>
</html>
