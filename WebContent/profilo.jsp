<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.ParseException"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Profilo Utente</title>
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

a {
	color: black;
	text-decoration: none; /* Rimuove la sottolineatura predefinita */
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
	<h1>Profilo Personale</h1>
	<div class="container">
		<%
		Map<String, String> userInfo = (Map<String, String>) request.getAttribute("userInfo");
		if (userInfo != null) {
		%>
		<div class="m-3">
			<h2>Informazioni</h2>
			<p>
				<strong>Nome :</strong>
				<%=userInfo.get("nome")%></p>
			<p>
				<strong>Cognome :</strong>
				<%=userInfo.get("cognome")%></p>
			<p>
				<strong>Codice Fiscale :</strong>
				<%=userInfo.get("cod_fiscale")%></p>
			<p>
				<strong>Data di Nascita :</strong>
				<%=formatDate(userInfo.get("data_nascita"))%></p>
			<p>
				<strong>Luogo di Nascita :</strong>
				<%=userInfo.get("luogo_nascita")%></p>
			<p>
				<strong>Email :</strong>
				<%=userInfo.get("email")%></p>
			<%
			if ("amministratore".equalsIgnoreCase(ruolo)) {
			%>
			<p>
				<strong>Ufficio :</strong><%=userInfo.get("ufficio")%></p>
			<%
			}
			%>
		</div>
		<%
		}
		%>

		<%
		if (!"amministratore".equalsIgnoreCase(ruolo)) {
		%>
		<div class="m-3">
			<h2>Verifiche personali</h2>
			<table class="table">
				<thead>
					<tr>
						<th>Data e Ora</th>
						<th>Materia</th>
						<th>Voto</th>
						<%
						if ("docente".equalsIgnoreCase(ruolo)) {
						%>
						<th>Allievo</th>
						<%
						}
						%>

					</tr>
				</thead>
				<tbody>
					<%
					List<Map<String, String>> verifiche = (List<Map<String, String>>) request.getAttribute("verifiche");
					if (verifiche != null) {
						for (Map<String, String> verifica : verifiche) {
					%>
					<tr>
						<td><%=formatDateWithTime(verifica.get("data_verifica"))%></td>
						<td><%=verifica.get("materia")%></td>
						<td><%=verifica.get("voto")%></td>
						<%
						if ("docente".equalsIgnoreCase(ruolo)) {
						%>
						<td><%=verifica.get("cod_fiscale_allievo")%></td>
						<%
						}
						%>
					</tr>
					<%
					}
					}
					%>
				</tbody>
			</table>

		</div>
		<%
		}
		%>
	</div>

	<%!private String formatDate(String dateString) {
		String formattedDate = "";
		try {
			SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd");
			SimpleDateFormat outputFormat = new SimpleDateFormat("dd/MM/yyyy");
			Date date = inputFormat.parse(dateString);
			formattedDate = outputFormat.format(date);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return formattedDate;
	}%>
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
