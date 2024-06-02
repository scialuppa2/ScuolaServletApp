<!-- navbar.jsp -->
<nav class="navbar navbar-expand-lg bg-body-secondary">
	<div class="container-fluid">
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarNav" aria-controls="navbarNav"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarNav">
			<ul class="navbar-nav">
				<li class="nav-item"><a
					class="nav-link <%=request.getRequestURI().endsWith("homepage.jsp") ? "active" : ""%>"
					href="homepage.jsp">Home</a></li>
				<li class="nav-item"><a class="nav-link"
					href="ScuolaServlet?action=listAllievi">Lista Allievi</a></li>
				<li class="nav-item"><a class="nav-link"
					href="ScuolaServlet?action=listDocenti">Lista Docenti</a></li>
				<%
				if ("amministratore".equals(session.getAttribute("ruolo"))) {
				%>
				<li class="nav-item"><a class="nav-link"
					href="ScuolaServlet?action=listVerifiche">Lista Verifiche</a></li>
				<li class="nav-item"><a class="nav-link"
					href="registraallievo.jsp">Registra Allievo</a></li>
				<li class="nav-item"><a class="nav-link"
					href="registradocente.jsp">Registra Docente</a></li>
				<%
				}
				%>
				<%
				if ("docente".equals(session.getAttribute("ruolo"))) {
				%>
				<li class="nav-item"><a class="nav-link"
					href="ScuolaServlet?action=registerVerifiche">Registra Verifica</a></li>
				<%
				}
				%>
				<li class="nav-item"><a class="nav-link"
					href="ScuolaServlet?action=loadSearchForm">Ricerca Allievi</a></li>
			</ul>
			<div class="ms-auto">
				<div class="d-flex align-items-center">
					<span class="navbar-text">
    <%
    String nomeUtente = (String) session.getAttribute("nomeUtente");
    String ruolo = (String) session.getAttribute("ruolo");
    if (nomeUtente != null) {
    %>
    Salve, <a href="ScuolaServlet?action=caricaProfilo"><%= nomeUtente %></a> (<%= ruolo %>)
    <%
    }
    %>
</span>
					

					<form action="ScuolaServlet" method="post" class="ms-3">
						<input type="hidden" name="action" value="logout">
						<button class="btn btn-primary" type="submit">Logout</button>
					</form>
				</div>
			</div>
		</div>
	</div>
</nav>
