<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Scuola</title>
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
	width: 35rem;
	margin-left: 10rem;
}

h1 {
	text-align: center;
	font-size: 64px;
	margin: 20px;
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
	<h1 class="text-center">Registra un nuovo allievo</h1>


	<div class="container">
		<form action="ScuolaServlet?action=registraAllievo" method="post"
			class="m-5">
			<div class="mb-3">
				<label for="codice_fiscale" class="form-label">Codice
					fiscale: </label> <input type="text" class="form-control" id="cod_fiscale"
					name="cod_fiscale" required>
			</div>
			<div class="mb-3">
				<label for="nome" class="form-label">Nome: </label> <input
					type="text" class="form-control" id="nome" name="nome" required>
			</div>
			<div class="mb-3">
				<label for="cognome" class="form-label">Cognome: </label> <input
					type="text" class="form-control" id="cognome" name="cognome"
					required>
			</div>
			<div class="mb-3">
				<label for="data_nascita" class="form-label">Data di
					nascita: </label> <input type="date" class="form-control" id="data_nascita"
					name="data_nascita" required>
			</div>
			<div class="mb-3">
				<label for="luogo_nascita" class="form-label">Luogo di
					nascita: </label> <input type="text" class="form-control"
					id="luogo_nascita" name="luogo_nascita" required>
			</div>
			<div class="mb-3">
				<label for="email" class="form-label">Email: </label> <input
					type="email" class="form-control" id="email" name="email" required>
			</div>

			<button type="submit" class="btn btn-primary">Registra</button>
		</form>

	</div>
</body>

</html>