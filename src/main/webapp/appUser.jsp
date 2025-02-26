<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title><spring:message code="label.addAppUser"/></title>
    <script src="https://www.google.com/recaptcha/api.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-aFq/bzH65dt+w6FI2ooMVUpc+21e0SRygnTpmBvdBgSdnuTN7QbdgL+OapgHtvPp" crossorigin="anonymous">
    <script src="https://www.google.com/recaptcha/api.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/js/bootstrap.bundle.min.js" integrity="sha384-qKXV1j0HvMUeCBQ+QVp7JcfGl760yU08IQ+GpUo5hlbpg51QRiuqHAJz8+BrxE/N" crossorigin="anonymous"></script>
    <link href="<c:url value="/resources/css/home.css" />" rel="stylesheet">
</head>
<body>

<jsp:include page="header.jsp" />
<div class="header">
    <span style="float: right">
    	<a style="background-color: white" href="?lang=pl">pl</a> | <a style="background-color: white" href="?lang=en">en</a> | <a style="background-color: white" href="?lang=de">de</a>
	</span>
</div>
<form:form method="post" action="addAppUser" modelAttribute="appUser">
    <div class="container">
        <h1>App user info:</h1>
        <div class="form-group mb-3">
            <form:hidden path="id"/>
            <form:label path="login"><spring:message code="label.login"/></form:label>
            <form:input path="login" cssClass="form-control"/>
            <form:errors path="login" cssClass="text-danger"/>
        </div>
        <div class="form-group mb-3">
            <form:label path="password"><spring:message code="label.password"/></form:label>
            <form:input type="password" path="password" cssClass="form-control"/>
            <form:errors path="password" cssClass="text-danger"/>
        </div>
        <div class="form-group mb-3">
            <form:label path="enabled"><spring:message code="label.enabled"/></form:label>
            <form:checkbox path="enabled"/>
            <form:errors path="enabled"/>
        </div>
        <div class="form-group mb-3">
            <form:label path="firstName"><spring:message code="label.firstName"/></form:label>
            <form:input path="firstName" cssClass="form-control"/>
            <form:errors path="firstName" cssClass="text-danger"/>
        </div>
        <div class="form-group mb-3">
            <form:label path="lastName"><spring:message code="label.lastName"/></form:label>
            <form:input path="lastName" cssClass="form-control"/>
            <form:errors path="lastName" cssClass="text-danger"/>
        </div>
        <div class="form-group mb-3">
            <form:label path="email"><spring:message code="label.email"/></form:label>
            <form:input path="email" cssClass="form-control"/>
            <form:errors path="email" cssClass="text-danger"/>
        </div>
        <div class="form-group mb-3">
            <form:label path="telephone"><spring:message code="label.telephone"/></form:label>
            <form:input path="telephone" cssClass="form-control"/>
            <form:errors path="telephone" cssClass="text-danger"/>
        </div>
        <div class="form-group mb-3">
            <form:label path="pesel.PESEL"><spring:message code="label.pesel"/></form:label>
            <form:input path="pesel.PESEL" cssClass="form-control"/>
            <form:errors path="pesel" cssClass="text-danger"/>
        </div>
        <div class="form-group mb-3">
            <form:label path="address"><spring:message code="label.address"/></form:label>
            <form:select path="address">
                <c:forEach items="${addressesList}" var="address">
                    <option value="${address.id}" ${address.id == selectedAddress ? 'selected="selected"' : ''}>${address.street}</option>
                </c:forEach>
            </form:select>
            <form:errors path="address"/>
        </div>
        <div class="form-group mb-3">
            <form:label path="appUserRole"><spring:message code="label.role"/></form:label>
            <form:select path="appUserRole" multiple="true">
                <form:options items="${appUserRoleList}" itemValue="id" itemLabel="role"/>
            </form:select>
            <form:errors path="appUserRole"/>
        </div>
        <div class="g-recaptcha mb-3" data-sitekey="6Le8bnwlAAAAAOt9ABkjYaYipNStknIIRLqHf5Gi"></div>
        <div class="form-group mb-3">
            <c:if test="${appUser.id==0}">
                <input type="submit" value="<spring:message code="label.addAppUser"/>" class="btn btn-primary"/>
            </c:if>
            <c:if test="${appUser.id!=0}">
                <input type="submit" value="<spring:message code="label.editAppUser"/>" class="btn btn-primary"/>
            </c:if>
        </div>
    </div>
</form:form>

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
                <td><a href="delete/${appUser.id}" class="btn btn-danger">delete</a></td>
                <td><a href="appUsers?appUserId=${appUser.id}" class="btn btn-primary">edit</a></td>
                <td><a href="generatePdf-${appUser.id}" class="btn btn-success">pdf</a></td>
            </tr>
        </c:forEach>
    </table>
</c:if>
<jsp:include page="footer.jsp" />
</body>
</html>

