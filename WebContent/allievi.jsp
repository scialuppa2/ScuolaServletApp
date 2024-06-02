<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="java.util.List"%>
<%@ page import="servlet.Allievo"%>


<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Allievi</title>
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

	<h1>Elenco Allievi</h1>
	<div class="container">
		<table border="1" class="table">
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
				List<Allievo> allievi = (List<Allievo>) request.getAttribute("allievi");
				if (allievi != null && !allievi.isEmpty()) {
					for (Allievo allievo : allievi) {
				%>
				<tr>
					<td><%=allievo.getId()%></td>
					<td><%=allievo.getCodiceFiscale()%></td>
					<td><%=allievo.getNome()%></td>
					<td><%=allievo.getCognome()%></td>
					<td><%=allievo.getDataDiNascita().format(formatter)%></td>
					<td><%=allievo.getLuogoDiNascita()%></td>
					<td><%=allievo.getEmail()%></td>
				</tr>
				<%
				}
				} else {
				%>
				<tr>
					<td colspan="7">Nessun allievo trovato.</td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>

	</div>
</body>

</html>