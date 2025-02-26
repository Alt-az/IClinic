<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html>
<head>
    <title>Prescription Form</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-aFq/bzH65dt+w6FI2ooMVUpc+21e0SRygnTpmBvdBgSdnuTN7QbdgL+OapgHtvPp" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/js/bootstrap.bundle.min.js" integrity="sha384-qKXV1j0HvMUeCBQ+QVp7JcfGl760yU08IQ+GpUo5hlbpg51QRiuqHAJz8+BrxE/N" crossorigin="anonymous"></script>
    <link href="<c:url value="/resources/css/home.css" />" rel="stylesheet">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-ui-timepicker-addon/1.6.3/jquery-ui-timepicker-addon.min.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-ui-timepicker-addon/1.6.3/jquery-ui-timepicker-addon.min.js"></script>
    <script>
        $( function() {
            $( "#appointmentDate" ).datetimepicker();
        } );
    </script>
</head>
<body>
<jsp:include page="header.jsp" />

<div class="main-content">
    <form:form method="post" action="addPrescription" modelAttribute="prescription">
        <div class="container">
            <h2>Prescriptions</h2>
            <form:hidden path="id"/>
            <form:hidden path="patient.id" value="${appUser.id}"/>
            <div class="form-group mb-3">
                <label for="appointmentDate" class="form-label">Appointment Date and Time</label>
                <form:input path="expirationDate" cssClass="form-control" id="appointmentDate" required="true" value="${formattedDate}"/>
            </div>
            <div class="form-group mb-3">
                <form:label path="medicines">Medicines</form:label>
                <form:input path="medicines" cssClass="form-control"/>
                <form:errors path="medicines" cssClass="text-danger"/>
            </div>
            <div class="form-group mb-3">
                <c:if test="${prescription.id==0}">
                    <c:if test="${appUser.id<=0}">
                        <input class="btn btn-primary" disabled type="submit" value="<spring:message code="label.addPrescription"/>"/>
                    </c:if>
                    <c:if test="${appUser.id>0}">
                        <input class="btn btn-primary" type="submit" value="<spring:message code="label.addPrescription"/>"/>
                    </c:if>
                </c:if>
                <c:if test="${prescription.id!=0}">
                    <input class="btn btn-primary" type="submit" value="<spring:message code="label.editPrescription"/>"/>
                </c:if>
            </div>
        </div>
    </form:form>

    <div class="container">
        <h3><spring:message code="label.prescriptionList"/></h3>
        <c:if  test="${!empty prescriptionList}">
            <table class="table table-striped">
                <tr>
                    <th><spring:message code="label.firstName"/> <spring:message code="label.lastName"/></th>
                    <th><spring:message code="label.medicines"/></th>
                    <th><spring:message code="label.expirationDate"/></th>
                    <th>&nbsp;</th>
                    <th>&nbsp;</th>
                    <th> </th>
                </tr>
                <c:forEach items="${prescriptionList}" var="prescription">
                    <tr>
                        <td>${prescription.patient.firstName} ${prescription.patient.lastName}</td>
                        <td>${prescription.medicines}</td>
                        <td>${prescription.expirationDate}</td>
                        <td><a href="prescriptionsForm?appUserId=${appUser.id}&prescriptionId=${prescription.id}" class="btn btn-primary">Select</a></td>
                    </tr>
                </c:forEach>
            </table>
        </c:if>
    </div>

    <div class="container">
    <h3><spring:message code="label.userList"/></h3>
    <c:if  test="${!empty appUserList}">
        <table class="table table-striped">
            <tr>
                <th><spring:message code="label.firstName"/></th>
                <th><spring:message code="label.lastName"/></th>
                <th><spring:message code="label.email"/></th>
                <th><spring:message code="label.telephone"/></th>
                <th>&nbsp;</th>
                <th>&nbsp;</th>
                <th> </th>
            </tr>
            <c:forEach items="${appUserList}" var="appUser">
                <tr>
                    <td>${appUser.firstName} </td>
                    <td>${appUser.lastName} </td>
                    <td>${appUser.email}</td>
                    <td>${appUser.telephone}</td>
                    <td><a href="prescriptionsForm?appUserId=${appUser.id}" class="btn btn-primary">Select</a></td>
                </tr>
            </c:forEach>
        </table>
    </c:if>
    </div>
</div>
<jsp:include page="footer.jsp" />
</body>
</html>
