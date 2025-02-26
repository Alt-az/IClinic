<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html>
<head>
    <title>Prescriptions</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-aFq/bzH65dt+w6FI2ooMVUpc+21e0SRygnTpmBvdBgSdnuTN7QbdgL+OapgHtvPp" crossorigin="anonymous">
    <script src="https://www.google.com/recaptcha/api.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/js/bootstrap.bundle.min.js" integrity="sha384-qKXV1j0HvMUeCBQ+QVp7JcfGl760yU08IQ+GpUo5hlbpg51QRiuqHAJz8+BrxE/N" crossorigin="anonymous"></script>
    <link href="<c:url value="/resources/css/home.css" />" rel="stylesheet">
</head>
<body>
<jsp:include page="header.jsp" />
  <div class="main-content container">
    <h2 class="text-center">Prescriptions</h2>
    <table class="table table-striped">
        <tr>
            <td>Patient Name</td>
            <td>Expiration Date</td>
            <td>Medicines</td>
        </tr>
        <c:if test="${!empty prescriptions}">
        <c:forEach items="${prescriptions}" var="prescription">
            <tr>
                <td>${prescription.patient.firstName} ${prescription.patient.lastName}</td>
                <td>${prescription.expirationDate}</td>
                <td>${prescription.medicines}</td>
            </tr>
        </c:forEach>
         </c:if>
    </table>
  </div>
<jsp:include page="footer.jsp" />
</body>
</html>
