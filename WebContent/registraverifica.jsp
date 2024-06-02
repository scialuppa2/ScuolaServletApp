<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Registra Verifica</title>
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
	<h1>Registra una nuova verifica</h1>

	<div class="container">
		<form action="ScuolaServlet" method="post">
			<input type="hidden" name="action" value="registraVerifica">
			<div class="mb-3">
				<label for="data_verifica" class="form-label">Data e ora
					Verifica:</label> <input class="form-control" type="datetime-local"
					id="data_verifica" name="data_verifica" required>
			</div>
			<div class="mb-3">
				<label for="cod_fiscale_allievo" class="form-label">Codice
					Fiscale Allievo:</label> <select class="form-select"
					name="cod_fiscale_allievo" id="cod_fiscale_allievo" required>
					<%
					List<String> codiciFiscaliAllievi = (List<String>) request.getAttribute("cod_fiscale_allievi");
					if (codiciFiscaliAllievi != null) {
						for (String codiceFiscale : codiciFiscaliAllievi) {
							out.println("<option value=\"" + codiceFiscale + "\">" + codiceFiscale + "</option>");
						}
					}
					%>
				</select>
			</div>
			<div class="mb-3">
				<label for="materia" class="form-label">Materia:</label> <select
					class="form-select" name="materia" id="materia" required>
					<%
					List<String> materie = (List<String>) request.getAttribute("materie");
					if (materie != null) {
						for (String materia : materie) {
							out.println("<option value=\"" + materia + "\">" + materia + "</option>");
						}
					}
					%>
				</select>
			</div>
			<div class="mb-3">
				<label class="form-label" for="cod_fiscale_docente">Codice
					Fiscale Docente:</label> <select class="form-select"
					name="cod_fiscale_docente" id="cod_fiscale_docente" required>
					<%
					List<String> codiciFiscaliDocenti = (List<String>) request.getAttribute("cod_fiscale_docenti");
					if (codiciFiscaliDocenti != null) {
						for (String codiceFiscale : codiciFiscaliDocenti) {
							out.println("<option value=\"" + codiceFiscale + "\">" + codiceFiscale + "</option>");
						}
					}
					%>
				</select>
			</div>
			<div class="mb-3">
				<label class="form-label" for="voto">Voto:</label> <select
					class="form-select" id="voto" name="voto" required>
					<option value="0">0</option>
					<option value="0.5">0.5</option>
					<option value="1">1</option>
					<option value="1.5">1.5</option>
					<option value="2">2</option>
					<option value="2.5">2.5</option>
					<option value="3">3</option>
					<option value="3.5">3.5</option>
					<option value="4">4</option>
					<option value="4.5">4.5</option>
					<option value="5">5</option>
					<option value="5.5">5.5</option>
					<option value="6">6</option>
					<option value="6.5">6.5</option>
					<option value="7">7</option>
					<option value="7.5">7.5</option>
					<option value="8">8</option>
					<option value="8.5">8.5</option>
					<option value="9">9</option>
					<option value="9.5">9.5</option>
					<option value="10">10</option>
				</select>
			</div>

			<button class="btn btn-primary" type="submit">Registra
				Verifica</button>
		</form>
	</div>
</body>
</html>
