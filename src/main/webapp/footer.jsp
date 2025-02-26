<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-aFq/bzH65dt+w6FI2ooMVUpc+21e0SRygnTpmBvdBgSdnuTN7QbdgL+OapgHtvPp" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/js/bootstrap.bundle.min.js" integrity="sha384-qKXV1j0HvMUeCBQ+QVp7JcfGl760yU08IQ+GpUo5hlbpg51QRiuqHAJz8+BrxE/N" crossorigin="anonymous"></script>
    <link href="<c:url value="/resources/css/home.css" />" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.11.2/css/all.css" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" />
</head>
<body>
<%--<div class="footer">--%>
<%--    <footer class="py-3 my-4">--%>
<%--        <ul class="nav justify-content-center border-bottom pb-3 mb-3">--%>
<%--            <li class="nav-item"><a href="#" class="nav-link px-2 text-body-secondary">Home</a></li>--%>
<%--            <li class="nav-item"><a href="#" class="nav-link px-2 text-body-secondary">Features</a></li>--%>
<%--            <li class="nav-item"><a href="#" class="nav-link px-2 text-body-secondary">Pricing</a></li>--%>
<%--            <li class="nav-item"><a href="#" class="nav-link px-2 text-body-secondary">FAQs</a></li>--%>
<%--            <li class="nav-item"><a href="#" class="nav-link px-2 text-body-secondary">About</a></li>--%>
<%--        </ul>--%>
<%--        <p class="text-center text-body-secondary">© 2024 Company, Inc</p>--%>
<%--    </footer>--%>
<%--</div>--%>
<!-- Remove the container if you want to extend the Footer to full width. -->
<footer class="bg-dark text-center text-white">
    <div class="container p-4 pb-0">
        <section class="mb-4">
            <a class="btn btn-outline-light btn-floating m-1" href="#!" role="button"
            ><i class="fab fa-facebook-f"></i
            ></a>
            <a class="btn btn-outline-light btn-floating m-1" href="#!" role="button"
            ><i class="fab fa-twitter"></i
            ></a>
            <a class="btn btn-outline-light btn-floating m-1" href="#!" role="button"
            ><i class="fab fa-google"></i
            ></a>
            <a class="btn btn-outline-light btn-floating m-1" href="#!" role="button"
            ><i class="fab fa-instagram"></i
            ></a>
            <a class="btn btn-outline-light btn-floating m-1" href="#!" role="button"
            ><i class="fab fa-linkedin-in"></i
            ></a>
            <a class="btn btn-outline-light btn-floating m-1" href="#!" role="button"
            ><i class="fab fa-github"></i
            ></a>
        </section>
    </div>
    <div class="text-center p-3" style="background-color: rgba(0, 0, 0, 0.2);">
        © 2020 Copyright:
        <a class="text-white" href="http://localhost:8080/">IClinic.com</a>
    </div>
</footer>
</body>
</html>
