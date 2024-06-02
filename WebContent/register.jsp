<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html lang="it">
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
	width: 30rem;
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
<header>
	<nav class="navbar navbar-expand-lg bg-body-secondary">
		<div class="container-fluid">
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarNav"
				aria-controls="navbarNav" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarNav">
				<ul class="navbar-nav">
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="index.html">Home</a></li>
				</ul>
			</div>
		</div>
	</nav>
</header>
<body>
	<h1>Benvenuti al Liceo M.Azzarita</h1>

	<div class="container">
		<h2>Registrazione</h2>
		<p>Effettua la registrazione per accedere</p>
		<hr>

		<form action="ScuolaServlet?action=registraUtente" method="post">

			<div class="mb-3">
				<label class="form-label" for="codice_fiscale"><b>Codice
						Fiscale:</b></label> <select class="form-control" id="codice_fiscale"
					name="codice_fiscale" required>
					<option value="">Seleziona Codice Fiscale</option>
					<% 
                List<String> codiciFiscali = (List<String>) request.getAttribute("codiciFiscali");
                for (String codiceFiscale : codiciFiscali) {
            %>
					<option value="<%= codiceFiscale %>"><%= codiceFiscale %></option>
					<% } %>
				</select>
			</div>

			<div class="mb-3">
				<label class="form-label" for="username"><b>Nome Utente:</b></label>
				<input class="form-control" type="text" placeholder="Username..."
					id="username" name="username" required>
			</div>
			<div class="mb-3">
				<label class="form-label" for="password"><b>Password:</b></label> <input
					class="form-control" type="password" placeholder="Password..."
					id="password" name="password" required>
			</div>

			<div class="mb-3">
				<label for="ruolo" class="form-label"><b>Ruolo: </b></label> <select
					class="form-control" id="ruolo" name="ruolo" required>
					<option value="allievo">Allievo</option>
					<option value="docente">Docente</option>
					<option value="amministratore">Amministratore</option>
				</select>
			</div>

			<hr>

			<button type="submit" class="btn btn-primary">Registrati</button>
		</form>

		<p>
			Hai già un account? <a href="index.html">Accedi qui</a>
		</p>
	</div>
</body>
</html>
