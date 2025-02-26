<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>AppUserRole</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-aFq/bzH65dt+w6FI2ooMVUpc+21e0SRygnTpmBvdBgSdnuTN7QbdgL+OapgHtvPp" crossorigin="anonymous">
    <script src="https://www.google.com/recaptcha/api.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/js/bootstrap.bundle.min.js" integrity="sha384-qKXV1j0HvMUeCBQ+QVp7JcfGl760yU08IQ+GpUo5hlbpg51QRiuqHAJz8+BrxE/N" crossorigin="anonymous"></script>
    <link href="<c:url value="/resources/css/home.css" />" rel="stylesheet">
</head>
<body>

<jsp:include page="header.jsp" />
<div class="main-content">
<form:form method="post" action="addAppUserRole" modelAttribute="appUserRole">
<div class="container">
    <h1>App user info:</h1>
    <div class="form-group mb-3">
        <form:hidden path="id"/>
        <form:label path="role"><spring:message code="label.role"/></form:label>
        <form:input path="role" cssClass="form-control"/>
        <form:errors path="role" cssClass="text-danger"/>
    </div>
    <div class="form-group mb-3">
        <input class="btn btn-primary" type="submit" value="<spring:message code="label.addAppUserRole"/>"/>
    </div>
</div>
</form:form>
</div>
<jsp:include page="footer.jsp" />
</body>
</html>

