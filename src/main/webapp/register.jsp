<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>Title</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-aFq/bzH65dt+w6FI2ooMVUpc+21e0SRygnTpmBvdBgSdnuTN7QbdgL+OapgHtvPp" crossorigin="anonymous">
    <script src="https://www.google.com/recaptcha/api.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/js/bootstrap.bundle.min.js" integrity="sha384-qKXV1j0HvMUeCBQ+QVp7JcfGl760yU08IQ+GpUo5hlbpg51QRiuqHAJz8+BrxE/N" crossorigin="anonymous"></script>
    <link href="<c:url value="/resources/css/home.css" />" rel="stylesheet">
    <style>
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        .main-content {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        .form-container {
            width: 100%;
            max-width: 400px;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 10px;
            background-color: #f9f9f9;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .form-container .form-signin {
            width: 100%;
        }
        .alert-danger, .alert-success {
            text-align: center;
        }
        .back-button {
            position: absolute;
            top: 10px;
            right: 10px;
            z-index: 10;
        }
    </style>
</head>
<body>
<%--<jsp:include page="header.jsp" />--%>
<a href="/" class="btn btn-secondary back-button">Home</a>
<div class="main-content container ">
    <div class="form-container">
        <c:if test="${empty msg}">
            <ul class="nav nav-pills nav-justified mb-3" id="ex1" role="tablist">
                <li class="nav-item" role="presentation">
                    <a class="nav-link" id="tab-login" data-mdb-pill-init href="/login" role="tab"
                       aria-controls="pills-login" aria-selected="true">Login</a>
                </li>
                <li class="nav-item" role="presentation">
                    <a class="nav-link active" id="tab-register" data-mdb-pill-init href="/register" role="tab"
                       aria-controls="pills-register" aria-selected="false">Register</a>
                </li>
            </ul>
            <c:if test="${not empty error}">
                <div class="alert alert-danger" role="alert">${error}</div>
            </c:if>
            <form:form cssClass="form-signin" method="post" action="registerUser" modelAttribute="appUser">
                <form:hidden path="id"/>
                <div class="form-group mb-3">
                    <form:label path="email"><spring:message code="label.email"/></form:label>
                    <form:input path="email" cssClass="form-control"/>
                    <form:errors path="email" cssClass="text-danger"/>
                </div>
                <div class="form-group mb-3">
                    <form:label path="login"><spring:message code="label.login"/></form:label>
                    <form:input path="login" cssClass="form-control"/>
                    <form:errors path="login" cssClass="text-danger"/>
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
                    <form:label path="password"><spring:message code="label.password"/></form:label>
                    <form:input type="password" path="password" cssClass="form-control"/>
                    <form:errors path="password" cssClass="text-danger"/>
                </div>
                <div class="g-recaptcha mb-3" data-sitekey="6Le8bnwlAAAAAOt9ABkjYaYipNStknIIRLqHf5Gi"></div>
                <input class="btn btn-lg btn-primary btn-block" type="submit" value="<spring:message code='label.register'/>"/>
            </form:form>
        </c:if>
        <c:if test="${not empty msg}">
            <div class="alert alert-success" role="alert">${msg}</div>
        </c:if>
    </div>
</div>
<%--<jsp:include page="footer.jsp" />--%>
</body>
</html>
