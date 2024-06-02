<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Ricerca Allievi</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	defer></script>
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
	<h1>Ricerca Allievi per Classe</h1>
	<div class="container mt-5">
		<form action="ScuolaServlet" method="get">
			<input type="hidden" name="action" value="searchAllievi">
			<div class="mb-3">
				<label for="livello" class="form-label">Livello</label> <select
					class="form-select" id="livello" name="livello">
					<%
					List<String> livelli = (List<String>) request.getAttribute("livelli");
					if (livelli != null) {
						for (String livello : livelli) {
							out.println("<option value=\"" + livello + "\">" + livello + "</option>");
						}
					}
					%>
				</select>
			</div>
			<div class="mb-3">
				<label for="sezione" class="form-label">Sezione</label> <select
					class="form-select" id="sezione" name="sezione">
					<%
					List<String> sezioni = (List<String>) request.getAttribute("sezioni");
					if (sezioni != null) {
						for (String sezione : sezioni) {
							out.println("<option value=\"" + sezione + "\">" + sezione + "</option>");
						}
					}
					%>
				</select>
			</div>
			<div class="mb-3">
				<label for="anno_scolastico" class="form-label">Anno
					Scolastico</label> <select class="form-select" id="anno_scolastico"
					name="anno_scolastico">
					<%
					List<String> anniScolastici = (List<String>) request.getAttribute("anniScolastici");
					if (anniScolastici != null) {
						for (String anno : anniScolastici) {
							out.println("<option value=\"" + anno + "\">" + anno + "</option>");
						}
					}
					%>
				</select>
			</div>
			<button type="submit" class="btn btn-primary">Cerca</button>
		</form>
	</div>
</body>
</html>
