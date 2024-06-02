<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="java.util.List"%>
<%@ page import="servlet.Docente"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Docenti</title>
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

	<h1>Elenco Docenti</h1>
	<div class="container">
		<table class="table table-bordered">
			<thead>
				<tr>
					<th>ID</th>
					<th>Codice Fiscale</th>
					<th>Nome</th>
					<th>Cognome</th>
					<th>Data di nascita</th>
					<th>Luogo di nascita</th>
					<th>Email</th>
				</tr>
			</thead>
			<tbody>
				<%
				DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
				List<Docente> docenti = (List<Docente>) request.getAttribute("docenti");
				if (docenti != null) {
					for (Docente docente : docenti) {
				%>
				<tr>
					<td><%=docente.getId()%></td>
					<td><%=docente.getCodiceFiscale()%></td>
					<td><%=docente.getNome()%></td>
					<td><%=docente.getCognome()%></td>
					<td><%=docente.getDataDiNascita().format(formatter)%></td>
					<td><%=docente.getLuogoDiNascita()%></td>
					<td><%=docente.getEmail()%></td>
				</tr>
				<%
				}
				}
				%>
			</tbody>
		</table>

	</div>
</body>

</html>