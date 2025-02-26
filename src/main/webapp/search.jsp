<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html>
<head>
    <title>Title</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-aFq/bzH65dt+w6FI2ooMVUpc+21e0SRygnTpmBvdBgSdnuTN7QbdgL+OapgHtvPp" crossorigin="anonymous">
    <script src="https://www.google.com/recaptcha/api.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/js/bootstrap.bundle.min.js" integrity="sha384-qKXV1j0HvMUeCBQ+QVp7JcfGl760yU08IQ+GpUo5hlbpg51QRiuqHAJz8+BrxE/N" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link href="<c:url value="/resources/css/search.css" />" rel="stylesheet">
    <script>
        $(document).ready(function($){
            $(".clickable-row").click(function(){
                window.location = $(this).data("href");
            });
        });
    </script>
</head>
<body>
<jsp:include page="header.jsp" />
<div class="main-content container">
    <h2 class="text-center">Search for Doctors</h2>
    <form:form method="post" action="searchSubmit" modelAttribute="doctor">
        <div class="row mb-3">
            <div class="col">
                <form:input cssClass="form-control mr-sm-2" path="firstName" />
            </div>
            <div class="col">
                <form:input cssClass="form-control mr-sm-2" path="lastName" />
            </div>
            <div class="col">
                <form:select cssClass="form-control mr-sm-2" path="cityName">
                    <c:forEach items="${cities}" var="city">
                        <option value="${city.cityName}" ${city.cityName == selectedCity ? 'selected="selected"' : ''}>${city.cityName}</option>
                    </c:forEach>
                </form:select>
            </div>
        </div>
        <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
    </form:form>
    <div class="container mt-5">
        <h2 class="text-center">Search Results</h2>
        <table class="table table-striped">
            <thead>
            <tr>
                <th>First Name</th>
                <th>Last Name</th>
                <th>City</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${doctors}" var="doctor">
                <tr class="clickable-row" data-href="<c:url value='/details?id=${doctor.id}' />">
                    <td>${doctor.firstName}</td>
                    <td>${doctor.lastName}</td>
                    <td>${doctor.cityName}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<jsp:include page="footer.jsp" />
</body>
</html>
