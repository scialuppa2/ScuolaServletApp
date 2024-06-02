<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous" defer></script>
<style>
body {
	font-family: Arial, Helvetica, sans-serif;
	background-color: cadetblue;
}

.container {
	width: 30rem;
	margin-left: 10rem;
}

h1 {
	text-align: center;
	font-size: 64px;
	margin: 20px;
}

#azzarita {
	width: 1200px;
	height: auto;
}

.navbar-text a {
	text-decoration: none;
}
</style>
</head>

<body>
	<header>
		<%@ include file="navbar.jsp"%>
	</header>
	<h1>Benvenuti al Liceo M.Azzarita</h1>
	<div class="container">
		<img id="azzarita"
			src="https://d1r24rnv05eqx4.cloudfront.net/uploads/vr/5fecfa7c86b4ff32a304dbe2/asset/1610396376-0.jpg"
			alt="foto_scuola">
	</div>
</body>

</html>
