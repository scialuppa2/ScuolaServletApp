<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.ParseException"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>


<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Lista Verifiche</title>
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

	<h1>Elenco delle Verifiche</h1>
	<div class="container">
		<table border="1" class="table">
			<thead>
				<tr>
					<th>Data e Ora</th>
					<th>Docente</th>
					<th>Materia</th>
					<th>Allievo</th>
					<th>Voto</th>
				</tr>
			</thead>
			<tbody>
				<%
				List<Map<String, String>> verifiche = (List<Map<String, String>>) request.getAttribute("verificheComplete");
				if (verifiche != null) {
					for (Map<String, String> verifica : verifiche) {
				%>
				<tr>
					<td><%=formatDateWithTime(verifica.get("data_verifica"))%></td>
					<td><%=verifica.get("cod_fiscale_docente")%></td>
					<td><%=verifica.get("materia")%></td>
					<td><%=verifica.get("cod_fiscale_allievo")%></td>
					<td><%=verifica.get("voto")%></td>
				</tr>
				<%
				}
				} else {
				%>
				<tr>
					<td colspan="5">Nessuna verifica trovata.</td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>

	</div>

	<%!private String formatDateWithTime(String dateTimeString) {
		String formattedDateTime = "";
		try {
			SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			SimpleDateFormat outputFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
			Date dateTime = inputFormat.parse(dateTimeString);
			formattedDateTime = outputFormat.format(dateTime);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return formattedDateTime;
	}%>
</body>

</html>