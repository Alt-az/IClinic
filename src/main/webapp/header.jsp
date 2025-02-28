<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-aFq/bzH65dt+w6FI2ooMVUpc+21e0SRygnTpmBvdBgSdnuTN7QbdgL+OapgHtvPp" crossorigin="anonymous">
    <link href="<c:url value="/resources/css/home.css" />" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
        }
        .navbar {
            padding-top: 0.3rem;
            padding-bottom: 0.3rem;
        }
        .navbar-brand img {
            height: 45px;
        }
        .navbar-nav .nav-link {
            margin-right: 15px;
            padding-top: 0.4rem;
            padding-bottom: 0.4rem;
        }
        .navbar-nav .nav-item:last-child .nav-link {
            margin-right: 0;
        }
        .welcome-text {
            margin: 0;
            padding: 0.4rem 0;
            display: inline-block;
        }
        .language-selector {
            margin-left: 15px;
        }
    </style>
    <script>
        function formSubmit() {
            document.getElementById("logoutForm").submit();
        }
    </script>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-success">
    <div class="container">
        <a class="navbar-brand" href="<c:url value='/' />">
            <img src="<c:url value='/resources/images/logo.png' />" alt="IClinic Logo">
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExample07" aria-controls="navbarsExample07" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarsExample07">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item active">
                    <a class="text-white nav-link" href="<c:url value='/' />">Home</a>
                </li>
                <sec:authorize access="hasRole('ROLE_ADMIN')">
                    <li class="nav-item">
                        <a class="text-white nav-link" href="<c:url value='/admin-panel' />"><spring:message code="label.admin-panel"/></a>
                    </li>
                </sec:authorize>
                <li class="nav-item">
                    <sec:authorize access="hasRole('ROLE_USER')">
                        <a class="text-white nav-link" href="<c:url value='/appUserManage' />"><spring:message code="label.manageaccount"/></a>
                    </sec:authorize>
                </li>
                <li class="nav-item">
                    <sec:authorize access="hasRole('ROLE_USER')">
                        <a class="text-white nav-link" href="<c:url value='/appointments' />"><spring:message code="label.appointments"/></a>
                    </sec:authorize>
                </li>
                <li class="nav-item">
                    <sec:authorize access="hasRole('ROLE_USER')">
                        <a class="text-white nav-link" href="<c:url value='/prescriptions' />"><spring:message code="label.prescriptions"/></a>
                    </sec:authorize>
                </li>
            </ul>

            <ul class="navbar-nav ms-auto">
                <sec:authorize access="isAnonymous()">
                    <li class="nav-item">
                        <a class="text-white nav-link" href="<c:url value='/login' />"><spring:message code="label.login"/></a>
                    </li>
                    <li class="nav-item">
                        <a class="text-white nav-link" href="<c:url value='/register' />"><spring:message code="label.register"/></a>
                    </li>
                </sec:authorize>
                <li class="nav-item">
                    <sec:authorize access="hasRole('ROLE_USER')">
                        <form action="/logout" method="post" id="logoutForm" class="d-inline">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                        </form>
                        <c:if test="${pageContext.request.userPrincipal.name != null}">
            <span class="text-white welcome-text">
                <spring:message code="label.welcome"/> : ${pageContext.request.userPrincipal.name} |
                <a class="text-white text-decoration-none" href="javascript:formSubmit()"><spring:message code="label.logout"/></a>
            </span>
                        </c:if>
                    </sec:authorize>
                </li>
                <li class="nav-item language-selector">
            <span>
                <a class="text-white text-decoration-none" href="?lang=pl">pl</a> |
                <a class="text-white text-decoration-none" href="?lang=en">en</a> |
                <a class="text-white text-decoration-none" href="?lang=de">de</a>
            </span>
                </li>
            </ul>
        </div>
    </div>
</nav>
</body>
</html>