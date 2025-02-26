<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html>
<head>
    <title>Appointment Form</title>
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
            $("#appointmentDate").datetimepicker({
                dateFormat: 'mm/dd/yy',
                timeFormat: 'HH:mm'
            });
        } );
    </script>
</head>
<body>
<jsp:include page="header.jsp" />

<div class="main-content">
    <form:form method="post" action="addAppointment" modelAttribute="appointment">
        <div class="container">
            <h2>Appointment</h2>
            <form:hidden path="id"/>
            <form:hidden path="patient.id" value="${appUser.id}"/>
            <div class="form-group mb-3">
                <label for="appointmentDate" class="form-label">Appointment Date and Time</label>
                <form:input path="date" cssClass="form-control" id="appointmentDate" required="true" value="${formattedDate}"/>
            </div>
            <div class="form-group mb-3">
                <form:label path="doctor"><spring:message code="label.doctorName"/></form:label>
                <form:select path="doctor.id">
                    <c:forEach items="${doctorList}" var="doctor">
                        <option value="${doctor.id}" ${doctor.id == selectedDoctor ? 'selected="selected"' : ''}>${doctor.firstName} ${doctor.lastName}</option>
                    </c:forEach>
                </form:select>
                <form:errors path="doctor" cssClass="text-danger"/>
            </div>
            <div class="form-group mb-3">
                <form:label path="paymentStatus"><spring:message code="label.paymentStatus"/></form:label>
                <form:checkbox path="paymentStatus"/>
                <form:errors path="paymentStatus"/>
            </div>
            <div class="form-group mb-3">
                <c:if test="${appointment.id==0}">
                    <c:if test="${appUser.id<=0}">
                        <input class="btn btn-primary" disabled type="submit" value="<spring:message code="label.addAppointment"/>"/>
                    </c:if>
                    <c:if test="${appUser.id>0}">
                        <input class="btn btn-primary" type="submit" value="<spring:message code="label.addAppointment"/>"/>
                    </c:if>
                </c:if>
                <c:if test="${appointment.id!=0}">
                    <input class="btn btn-primary" type="submit" value="<spring:message code="label.editAppointment"/>"/>
                </c:if>
            </div>
        </div>
    </form:form>

    <div class="container">
        <h3><spring:message code="label.appointmentList"/></h3>
        <c:if  test="${!empty appointmentList}">
            <table class="table table-striped">
                <tr>
                    <th><spring:message code="label.firstName"/> <spring:message code="label.lastName"/></th>
                    <th><spring:message code="label.doctorName"/></th>
                    <th><spring:message code="label.date"/></th>
                    <th>&nbsp;</th>
                    <th>&nbsp;</th>
                    <th> </th>
                </tr>
                <c:forEach items="${appointmentList}" var="appointment">
                    <tr>
                        <td>${appointment.patient.firstName} ${appointment.patient.lastName}</td>
                        <td>${appointment.doctor.firstName} ${appointment.doctor.lastName}</td>
                        <td>${appointment.date}</td>
                        <td><a href="appointmentsForm?appUserId=${appUser.id}&appointmentId=${appointment.id}" class="btn btn-primary">Select</a></td>
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
                        <td><a href="appointmentsForm?appUserId=${appUser.id}" class="btn btn-primary">Select</a></td>
                    </tr>
                </c:forEach>
            </table>
        </c:if>
    </div>
</div>
<jsp:include page="footer.jsp" />
</body>
</html>
