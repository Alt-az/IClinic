<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title><spring:message code="label.titleAddress"/></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-aFq/bzH65dt+w6FI2ooMVUpc+21e0SRygnTpmBvdBgSdnuTN7QbdgL+OapgHtvPp" crossorigin="anonymous">
    <script src="https://www.google.com/recaptcha/api.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/js/bootstrap.bundle.min.js" integrity="sha384-qKXV1j0HvMUeCBQ+QVp7JcfGl760yU08IQ+GpUo5hlbpg51QRiuqHAJz8+BrxE/N" crossorigin="anonymous"></script>
    <link href="<c:url value="/resources/css/home.css" />" rel="stylesheet">
</head>
<body>
<jsp:include page="header.jsp" />

<div class="main-content">
<form:form method="post" action="addAddress" modelAttribute="address">
    <div class="container">
        <h2><spring:message code="label.address"/></h2>
        <div class="form-group mb-3">
            <form:hidden path="id"/>
            <form:label path="street"><spring:message code="label.street"/></form:label>
            <form:input path="street" cssClass="form-control"/>
            <form:errors path="street" cssClass="text-danger"/>
        </div>
        <div class="form-group mb-3">
            <form:label path="number"><spring:message code="label.number"/></form:label>
            <form:input path="number" cssClass="form-control"/>
            <form:errors path="number" cssClass="text-danger"/>
        </div>
        <div class="form-group mb-3">
            <form:label path="city"><spring:message code="label.city"/></form:label>
            <form:input path="city" cssClass="form-control"/>
            <form:errors path="city" cssClass="text-danger"/>
        </div>
        <div class="form-group mb-3">
            <form:label path="postalCode"><spring:message code="label.postalCode"/></form:label>
            <form:input path="postalCode" cssClass="form-control"/>
            <form:errors path="postalCode" cssClass="text-danger"/>
        </div>
        <div class="form-group mb-3">
            <c:if test="${address.id==0}">
                <input class="btn btn-primary" type="submit" value="<spring:message code="label.addAddress"/>"/>
            </c:if>
            <c:if test="${address.id!=0}">
                <input class="btn btn-primary" type="submit" value="<spring:message code="label.editAddress"/>"/>
            </c:if>
        </div>
    </div>
</form:form>

<h3><spring:message code="label.addressList"/></h3>
<c:if  test="${!empty addressList}">
    <table class="table table-striped">
        <tr>
            <th><spring:message code="label.street"/></th>
            <th><spring:message code="label.number"/></th>
            <th><spring:message code="label.city"/></th>
            <th><spring:message code="label.postalCode"/></th>
            <th>&nbsp;</th>
            <th>&nbsp;</th>
        </tr>
        <c:forEach items="${addressList}" var="address">
            <tr>
                <td>${address.street} </td>
                <td>${address.number} </td>
                <td>${address.city}</td>
                <td>${address.postalCode}</td>
                <td><a href="deleteAddress/${address.id}" class="btn btn-danger">delete</a></td>
                <td><a href="addresses?addressId=${address.id}" class="btn btn-primary">edit</a></td>
            </tr>
        </c:forEach>
    </table>
</c:if>
</div>
<jsp:include page="footer.jsp" />
</body>
</html>
