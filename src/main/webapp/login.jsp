<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
	<title>Login Page</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-aFq/bzH65dt+w6FI2ooMVUpc+21e0SRygnTpmBvdBgSdnuTN7QbdgL+OapgHtvPp" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/js/bootstrap.bundle.min.js" integrity="sha384-qKXV1j0HvMUeCBQ+QVp7JcfGl760yU08IQ+GpUo5hlbpg51QRiuqHAJz8+BrxE/N" crossorigin="anonymous"></script>
<%--	<link href="<c:url value="/resources/css/home.css" />" rel="stylesheet">--%>
	<style>
		.main-content {
			display: flex;
			justify-content: center;
			align-items: center;
			height: 75%;
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
		.back-button {
			position: absolute;
			top: 10px;
			right: 10px;
			z-index: 10;
		}
	</style>
</head>
<body onload='document.loginForm.username.focus();'>
<%--<jsp:include page="header.jsp" />--%>
<a href="/" class="btn btn-secondary back-button">Home</a>
<div class="main-content container mb-4 mt-4">
	<div class="form-container">
		<ul class="nav nav-pills nav-justified mb-3" id="ex1" role="tablist">
			<li class="nav-item" role="presentation">
				<a class="nav-link active" id="tab-login" data-mdb-pill-init href="/login" role="tab"
				   aria-controls="pills-login" aria-selected="true">Login</a>
			</li>
			<li class="nav-item" role="presentation">
				<a class="nav-link" id="tab-register" data-mdb-pill-init href="/register" role="tab"
				   aria-controls="pills-register" aria-selected="false">Register</a>
			</li>
		</ul>
		<c:if test="${not empty error}">
			<div class="alert alert-danger" role="alert">${error}</div>
		</c:if>
		<c:if test="${not empty msg}">
			<div class="alert alert-success" role="alert">${msg}</div>
		</c:if>
		<form class="form-signin" name="loginForm" action="<c:url value='/login' />" method="POST">
			<div class="form-group mb-3">
				<label for="inputEmail">Login</label>
				<input type="text" name="login" id="inputEmail" class="form-control" placeholder="Login" required autofocus>
			</div>
			<div class="form-group mb-3">
				<label for="inputPassword">Password</label>
				<input type="password" name="password" id="inputPassword" class="form-control" placeholder="Password" required>
			</div>
			<button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		</form>
	</div>
</div>
<%--<jsp:include page="footer.jsp" />--%>
</body>
</html>
