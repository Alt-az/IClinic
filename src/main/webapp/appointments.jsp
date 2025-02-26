<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html>
<head>
    <title>Appointments</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-aFq/bzH65dt+w6FI2ooMVUpc+21e0SRygnTpmBvdBgSdnuTN7QbdgL+OapgHtvPp" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/js/bootstrap.bundle.min.js" integrity="sha384-qKXV1j0HvMUeCBQ+QVp7JcfGl760yU08IQ+GpUo5hlbpg51QRiuqHAJz8+BrxE/N" crossorigin="anonymous"></script>
</head>
<body>
<jsp:include page="header.jsp" />
<div class="main-content">
    <div class="container">
        <h2 class="text-center">Appointments</h2>
        <table class="table table-striped">
            <tr>
                <td>Doctor Name</td>
                <td>City</td>
                <td>Appointment Date</td>
                <td>Payment status</td>
                <td>Generate bill</td>
            </tr>
            <c:if test="${!empty appointments}">
        <c:forEach items="${appointments}" var="appointment">
            <tr>
                <td>${appointment.doctor.firstName} ${appointment.doctor.lastName}</td>
                <td>${appointment.doctor.cityName}</td>
                <td>${appointment.date}</td>
                <c:if test="${true==appointment.paymentStatus}">
                    <td>Paid</td>
                    <td><a href="generatePdfAppointment-${appointment.id}">Generate bill</a></td>
                </c:if>
                <c:if test="${false==appointment.paymentStatus}">
                    <td>Not paid</td>
                    <td><a href="paybill?appointmentId=${appointment.id}">Pay bill</a></td>
                </c:if>

            </tr>
        </c:forEach>
         </c:if>
        </table>
    </div>
</div>
<jsp:include page="footer.jsp" />
</body>
</html>
