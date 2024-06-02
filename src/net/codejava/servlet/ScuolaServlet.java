package servlet;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import librerie.ManageDb;
import librerie.ManageTextFile;

public class ScuolaServlet extends HttpServlet {
	private ManageDb mioDB;

	/**
	 * this life-cycle method is invoked when this servlet is first accessed by the
	 * client
	 */
	public void init(ServletConfig config) {
		System.out.println("Servlet is being initialized");
	}

	/**
	 * handles HTTP GET request
	 */

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {
	    String action = request.getParameter("action");

	    // Connessione al database
	    mioDB = new ManageDb();
	    boolean bRet = mioDB.Connect("localhost", 3306, "scuola_db", "server_scuola", "server_scuola123");

	    if (bRet) {
	        System.out.println("Connessione al DB avvenuta correttamente");

	        try {
	            if ("listAllievi".equals(action)) {
	                List<Allievo> allievi = getAllievi(mioDB);
	                request.setAttribute("allievi", allievi);
	                RequestDispatcher dispatcher = request.getRequestDispatcher("allievi.jsp");
	                dispatcher.forward(request, response);

	            } else if ("listDocenti".equals(action)) {
	                List<Docente> docenti = getDocenti(mioDB);
	                request.setAttribute("docenti", docenti);
	                RequestDispatcher dispatcher = request.getRequestDispatcher("docenti.jsp");
	                dispatcher.forward(request, response);

	            } else if ("searchAllievi".equals(action)) {
	                String livello = request.getParameter("livello");
	                String sezione = request.getParameter("sezione");
	                String annoScolastico = request.getParameter("anno_scolastico");
	                List<Allievo> allievi = searchAllievi(mioDB, livello, sezione, annoScolastico);
	                request.setAttribute("allievi", allievi);
	                RequestDispatcher dispatcher = request.getRequestDispatcher("allievi.jsp");
	                dispatcher.forward(request, response);

	            } else if ("listVerifiche".equals(action)) {
	                List<Map<String, String>> verificheComplete = getVerifiche(mioDB, null, "amministratore");
	                request.setAttribute("verificheComplete", verificheComplete);
	                RequestDispatcher dispatcher = request.getRequestDispatcher("verifiche.jsp");
	                dispatcher.forward(request, response);
	                
	            } else if ("loadSearchForm".equals(action)) {
	                List<String> livelli = getLivelli(mioDB);
	                List<String> sezioni = getSezioni(mioDB);
	                List<String> anniScolastici = getAnniScolastici(mioDB);

	                request.setAttribute("livelli", livelli);
	                request.setAttribute("sezioni", sezioni);
	                request.setAttribute("anniScolastici", anniScolastici);

	                RequestDispatcher dispatcher = request.getRequestDispatcher("ricerca_allievi.jsp");
	                dispatcher.forward(request, response);

	            } else if ("registerVerifiche".equals(action)) {
	                List<String> codiciFiscaliAllievi = getCodiciFiscaliAllievi(mioDB);
	                List<String> codiciFiscaliDocenti = getCodiciFiscaliDocenti(mioDB);
	                List<String> materie = getMaterie(mioDB);

	                request.setAttribute("cod_fiscale_allievi", codiciFiscaliAllievi);
	                request.setAttribute("cod_fiscale_docenti", codiciFiscaliDocenti);
	                request.setAttribute("materie", materie);

	                RequestDispatcher dispatcher = request.getRequestDispatcher("registraverifica.jsp");
	                dispatcher.forward(request, response);

	            } else if ("loadRegisterForm".equals(action)) {
	                List<String> codiciFiscaliAllievi = getCodiciFiscaliAllievi(mioDB);
	                List<String> codiciFiscaliDocenti = getCodiciFiscaliDocenti(mioDB);
	                List<String> codiciFiscali = new ArrayList<>(codiciFiscaliAllievi);
	                codiciFiscali.addAll(codiciFiscaliDocenti);

	                request.setAttribute("codiciFiscali", codiciFiscali);

	                RequestDispatcher dispatcher = request.getRequestDispatcher("register.jsp");
	                dispatcher.forward(request, response);

	            } else if ("caricaProfilo".equals(action)) {
	                HttpSession session = request.getSession();
	                String nomeUtente = (String) session.getAttribute("nomeUtente");
	                String ruolo = (String) session.getAttribute("ruolo");

	                if (nomeUtente != null && ruolo != null) {
	                    String codFiscale = getCodFiscaleFromUsername(mioDB, nomeUtente); // Metodo per recuperare il codice fiscale dall'username

	                    if (codFiscale != null) {
	                        Map<String, String> userInfo = getUserInfo(mioDB, codFiscale, ruolo);
	                        List<Map<String, String>> verifiche = getVerifiche(mioDB, codFiscale, ruolo);

	                        request.setAttribute("userInfo", userInfo);
	                        request.setAttribute("verifiche", verifiche);

	                        RequestDispatcher dispatcher = request.getRequestDispatcher("profilo.jsp");
	                        dispatcher.forward(request, response);
	                    } else {
	                        // Nel caso in cui il codice fiscale non può essere recuperato
	                        response.sendRedirect("error.jsp");
	                    }
	                } else {
	                    // Nel caso in cui la connessione al database non riesce
	                    System.out.println("Connessione al DB non riuscita");
	                    response.getWriter().println("Errore: Connessione al database non riuscita");
	                }
	            }

	        } finally {
	            mioDB.Disconnect(); //Chiusura della connessione
	        }
	    } else {
	        // Nel caso in cui la connessione al database non riesce
	        System.out.println("Connessione al DB non riuscita");
	        response.getWriter().println("Errore: Connessione al database non riuscita");
	    }
	}


	//METODI RICHIAMATI DAL doGET
	
	private List<Allievo> getAllievi(ManageDb mioDB) {
		List<Allievo> allievi = new ArrayList<>();
		String query = "SELECT * FROM Allievo";
		ResultSet resultSet = mioDB.ReadInDB(query);

		try {
			while (resultSet.next()) {
				int id = resultSet.getInt("ID");
				String codiceFiscale = resultSet.getString("Cod_fiscale");
				String nome = resultSet.getString("nome");
				String cognome = resultSet.getString("cognome");
				LocalDate dataNascita = resultSet.getDate("data_di_nascita").toLocalDate();
				String luogoNascita = resultSet.getString("luogo_di_nascita");
				String email = resultSet.getString("email");

				Allievo allievo = new Allievo(id, codiceFiscale, nome, cognome, dataNascita, luogoNascita, email);
				allievi.add(allievo);
			}
			resultSet.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return allievi;
	}

	private List<Docente> getDocenti(ManageDb mioDB) {
		List<Docente> docenti = new ArrayList<>();
		String query = "SELECT * FROM Docente";
		ResultSet resultSet = mioDB.ReadInDB(query);

		try {
			while (resultSet.next()) {
				int id = resultSet.getInt("ID");
				String codiceFiscale = resultSet.getString("Cod_fiscale");
				String nome = resultSet.getString("nome");
				String cognome = resultSet.getString("cognome");
				LocalDate dataNascita = resultSet.getDate("data_di_nascita").toLocalDate();
				String luogoNascita = resultSet.getString("luogo_di_nascita");
				String email = resultSet.getString("email");

				Docente docente = new Docente(id, codiceFiscale, nome, cognome, dataNascita, luogoNascita, email);
				docenti.add(docente);
			}
			resultSet.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return docenti;
	}

	private List<Allievo> searchAllievi(ManageDb mioDB, String livello, String sezione, String annoScolastico) {
		List<Allievo> allievi = new ArrayList<>();
		String query = "SELECT a.* FROM Allievo a JOIN allievo_classe ac ON a.Cod_fiscale = ac.cod_fiscale_allievo WHERE ac.livello_classe = '"
				+ livello + "' AND ac.sezione_classe = '" + sezione + "' AND ac.anno_scolastico = '" + annoScolastico
				+ "'";
		ResultSet resultSet = mioDB.ReadInDB(query);

		try {
			while (resultSet.next()) {
				int id = resultSet.getInt("ID");
				String codiceFiscale = resultSet.getString("Cod_fiscale");
				String nome = resultSet.getString("nome");
				String cognome = resultSet.getString("cognome");
				LocalDate dataNascita = resultSet.getDate("data_di_nascita").toLocalDate();
				String luogoNascita = resultSet.getString("luogo_di_nascita");
				String email = resultSet.getString("email");

				Allievo allievo = new Allievo(id, codiceFiscale, nome, cognome, dataNascita, luogoNascita, email);
				allievi.add(allievo);
			}
			resultSet.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return allievi;
	}

	private List<String> getLivelli(ManageDb mioDB) {
		List<String> livelli = new ArrayList<>();
		String query = "SELECT DISTINCT livello_classe FROM allievo_classe";
		ResultSet resultSet = mioDB.ReadInDB(query);
		try {
			while (resultSet.next()) {
				livelli.add(resultSet.getString("livello_classe"));
			}
			resultSet.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return livelli;
	}

	private List<String> getSezioni(ManageDb mioDB) {
		List<String> sezioni = new ArrayList<>();
		String query = "SELECT DISTINCT sezione_classe FROM allievo_classe";
		ResultSet resultSet = mioDB.ReadInDB(query);
		try {
			while (resultSet.next()) {
				sezioni.add(resultSet.getString("sezione_classe"));
			}
			resultSet.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return sezioni;
	}

	private List<String> getAnniScolastici(ManageDb mioDB) {
		List<String> anniScolastici = new ArrayList<>();
		String query = "SELECT DISTINCT anno_scolastico FROM allievo_classe";
		ResultSet resultSet = mioDB.ReadInDB(query);
		try {
			while (resultSet.next()) {
				anniScolastici.add(resultSet.getString("anno_scolastico"));
			}
			resultSet.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// Ordina gli anni scolastici in ordine decrescente
		Collections.sort(anniScolastici, Collections.reverseOrder());
		return anniScolastici;
	}

	private List<String> getCodiciFiscaliAllievi(ManageDb mioDB) {
		List<String> codiciFiscaliAllievi = new ArrayList<>();
		String query = "SELECT Cod_fiscale FROM allievo";
		ResultSet resultSet = mioDB.ReadInDB(query);
		try {
			while (resultSet.next()) {
				codiciFiscaliAllievi.add(resultSet.getString("Cod_fiscale"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (resultSet != null) {
				try {
					resultSet.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return codiciFiscaliAllievi;
	}

	private List<String> getCodiciFiscaliDocenti(ManageDb mioDB) {
		List<String> codiciFiscaliDocenti = new ArrayList<>();
		String query = "SELECT Cod_fiscale FROM docente";
		ResultSet resultSet = mioDB.ReadInDB(query);
		try {
			while (resultSet.next()) {
				codiciFiscaliDocenti.add(resultSet.getString("Cod_fiscale"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (resultSet != null) {
				try {
					resultSet.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return codiciFiscaliDocenti;
	}

	private List<String> getMaterie(ManageDb mioDB) {
		List<String> materie = new ArrayList<>();
		String query = "SELECT nome FROM materia";
		ResultSet resultSet = mioDB.ReadInDB(query);
		try {
			while (resultSet.next()) {
				materie.add(resultSet.getString("nome"));
			}
			resultSet.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return materie;
	}
	
	private String getCodFiscaleFromUsername(ManageDb mioDB, String username) {
	    String codFiscale = null;
	    String query = "SELECT Codice_Fiscale FROM utente WHERE nome_utente = ?";
	    try {
	        PreparedStatement pstmt = mioDB.myConn.prepareStatement(query);
	        pstmt.setString(1, username);
	        ResultSet rs = pstmt.executeQuery();
	        if (rs.next()) {
	            codFiscale = rs.getString("Codice_Fiscale");
	        }
	        rs.close();
	    } catch (SQLException e) {
	        e.printStackTrace();
	        // Gestisci l'eccezione in base alle tue esigenze
	    }
	    return codFiscale;
	}


	private Map<String, String> getUserInfo(ManageDb mioDB, String codFiscale, String ruolo) {
	    Map<String, String> userInfo = new HashMap<>();
	    String query = "";
	    if ("allievo".equalsIgnoreCase(ruolo)) {
	        query = "SELECT u.Codice_Fiscale, a.nome, a.cognome, a.data_di_nascita, a.luogo_di_nascita, a.email "
	              + "FROM utente u JOIN allievo a ON u.Codice_Fiscale = a.Cod_fiscale "
	              + "WHERE u.Codice_Fiscale = ?";
	    } else if ("docente".equalsIgnoreCase(ruolo)) {
	        query = "SELECT u.Codice_Fiscale, d.nome, d.cognome, d.data_di_nascita, d.luogo_di_nascita, d.email "
	              + "FROM utente u JOIN docente d ON u.Codice_Fiscale = d.Cod_fiscale "
	              + "WHERE u.Codice_Fiscale = ?";
	    } else if ("amministratore".equalsIgnoreCase(ruolo)) {
	        query = "SELECT u.Codice_Fiscale, a.nome, a.cognome, a.data_di_nascita, a.luogo_di_nascita, a.email, a.ufficio_di_competenza "
	              + "FROM utente u JOIN amministrativo a ON u.Codice_Fiscale = a.Cod_fiscale "
	              + "WHERE u.Codice_Fiscale = ?";
	    }

	    try (PreparedStatement pstmt = mioDB.myConn.prepareStatement(query)) {
	        pstmt.setString(1, codFiscale);
	        try (ResultSet rs = pstmt.executeQuery()) {
	            if (rs.next()) {
	                userInfo.put("cod_fiscale", rs.getString("Codice_Fiscale"));
	                userInfo.put("nome", rs.getString("nome"));
	                userInfo.put("cognome", rs.getString("cognome"));
	                userInfo.put("data_nascita", rs.getString("data_di_nascita"));
	                userInfo.put("luogo_nascita", rs.getString("luogo_di_nascita"));
	                userInfo.put("email", rs.getString("email"));
	                if ("amministratore".equalsIgnoreCase(ruolo)) {
	                    userInfo.put("ufficio", rs.getString("ufficio_di_competenza"));
	                }
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return userInfo;
	}


	private List<Map<String, String>> getVerifiche(ManageDb mioDB, String codFiscale, String ruolo) {
	    List<Map<String, String>> verifiche = new ArrayList<>();
	    String query = "";
	    try {
	        PreparedStatement pstmt;
	        if ("allievo".equalsIgnoreCase(ruolo)) {
	            query = "SELECT data_verifica, materia, voto FROM verifica WHERE cod_fiscale_allievo = ?";
	            pstmt = mioDB.myConn.prepareStatement(query);
	            pstmt.setString(1, codFiscale);
	        } else if ("docente".equalsIgnoreCase(ruolo)) {
	            query = "SELECT data_verifica, materia, voto, cod_fiscale_allievo FROM verifica WHERE cod_fiscale_docente = ?";
	            pstmt = mioDB.myConn.prepareStatement(query);
	            pstmt.setString(1, codFiscale);
	        } else if ("amministratore".equalsIgnoreCase(ruolo)) {
	            query = "SELECT * FROM verifica";
	            pstmt = mioDB.myConn.prepareStatement(query);
	        } else {
	            throw new IllegalArgumentException("Ruolo non supportato: " + ruolo);
	        }

	        ResultSet rs = pstmt.executeQuery();
	        while (rs.next()) {
	            Map<String, String> verifica = new HashMap<>();
	            verifica.put("data_verifica", rs.getString("data_verifica"));
	            verifica.put("materia", rs.getString("materia"));
	            verifica.put("voto", rs.getString("voto"));
	            if ("docente".equalsIgnoreCase(ruolo) || "amministratore".equalsIgnoreCase(ruolo)) {
	                verifica.put("cod_fiscale_allievo", rs.getString("cod_fiscale_allievo"));
	            }
	            if ("amministratore".equalsIgnoreCase(ruolo)) {
	                verifica.put("cod_fiscale_docente", rs.getString("cod_fiscale_docente"));
	            }
	            verifiche.add(verifica);
	        }
	        rs.close();
	        pstmt.close();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return verifiche;
	}


	/**
	 * handles HTTP POST request
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
	    // Connessione al database
	    mioDB = new ManageDb();
	    boolean bRet = mioDB.Connect("localhost", 3306, "scuola_db", "server_scuola", "server_scuola123");

	    if (bRet) {
	        // Recupera il valore del parametro "action" per determinare l'azione richiesta
	        String action = request.getParameter("action");

	        try {
	            if (action != null && action.equals("registraUtente")) {
	                registraUtente(request, response, mioDB);
	            } else if (action != null && action.equals("registraAllievo")) {
	                registraAllievo(request, response, mioDB);
	            } else if (action != null && action.equals("registraDocente")) {
	                registraDocente(request, response, mioDB);
	            } else if (action != null && action.equals("registraVerifica")) {
	                registraVerifica(request, response, mioDB);
	            } else if (action != null && action.equals("doLogin")) {
	                doLogin(request, response, mioDB);
	            } else if (action != null && action.equals("logout")) {
	                doLogout(request, response, mioDB);
	            }
	        } catch (SQLException e) {
	            // In caso di eccezione durante l'insert, salva la query nel file
	            String failedQuery = extractQueryFromRequest(request, action);
	            saveQueryToFile(request, failedQuery);
	            e.printStackTrace();
	            response.getWriter().println("Errore: Impossibile eseguire l'operazione sul database. La query è stata salvata.");
	        } finally {
	            mioDB.Disconnect(); // Chiusura della connessione
	        }
	    } else {
	        // Se la connessione al database fallisce, salva la query nel file
	        String action = request.getParameter("action");
	        if (action != null) {
	            String failedQuery = extractQueryFromRequest(request, action);
	            saveQueryToFile(request, failedQuery);
	        }
	        System.out.println("Connessione al DB non riuscita");
	        response.getWriter().println("Errore: Connessione al database non riuscita. La query è stata salvata.");
	    }
	    
	}

	// Metodo per estrarre la query dalla request
	private String extractQueryFromRequest(HttpServletRequest request, String action) {
	    StringBuilder query = new StringBuilder();
	    if (action.equals("registraUtente")) {
	        query.append("INSERT INTO utente (nome_utente, password, connesso, ruolo, Codice_Fiscale) VALUES ('")
	             .append(request.getParameter("username")).append("', '")
	             .append(request.getParameter("password")).append("', ")
	             .append("false, '")
	             .append(request.getParameter("ruolo")).append("', '")
	             .append(request.getParameter("codice_fiscale")).append("')");
	    } else if (action.equals("registraAllievo")) {
	        query.append("INSERT INTO allievo (cod_fiscale, nome, cognome, data_di_nascita, luogo_di_nascita, email) VALUES ('")
	             .append(request.getParameter("cod_fiscale")).append("', '")
	             .append(request.getParameter("nome")).append("', '")
	             .append(request.getParameter("cognome")).append("', '")
	             .append(request.getParameter("data_nascita")).append("', '")
	             .append(request.getParameter("luogo_nascita")).append("', '")
	             .append(request.getParameter("email")).append("')");
	    } else if (action.equals("registraDocente")) {
	        query.append("INSERT INTO docente (cod_fiscale, nome, cognome, data_di_nascita, luogo_di_nascita, email) VALUES ('")
	             .append(request.getParameter("cod_fiscale")).append("', '")
	             .append(request.getParameter("nome")).append("', '")
	             .append(request.getParameter("cognome")).append("', '")
	             .append(request.getParameter("data_nascita")).append("', '")
	             .append(request.getParameter("luogo_nascita")).append("', '")
	             .append(request.getParameter("email")).append("')");
	    } else if (action.equals("registraVerifica")) {
	        query.append("INSERT INTO verifica (data_verifica, cod_fiscale_allievo, materia, cod_fiscale_docente, voto) VALUES ('")
	             .append(request.getParameter("data_verifica")).append("', '")
	             .append(request.getParameter("cod_fiscale_allievo")).append("', '")
	             .append(request.getParameter("materia")).append("', '")
	             .append(request.getParameter("cod_fiscale_docente")).append("', '")
	             .append(request.getParameter("voto")).append("')");
	    }
	    System.out.println("Estrazione riuscita");
	    return query.toString();
	}

	// Metodo per salvare la query su file utilizzando ManageTextFile
	private void saveQueryToFile(HttpServletRequest request, String query) {
		String absoluteDiskPath = request.getServletContext().getRealPath("./");
	    String sFilePath = absoluteDiskPath + "../FileGestiti/failed_queries.txt";
	    System.out.println(sFilePath);

	    ManageTextFile textFile = new ManageTextFile(sFilePath);
	    if (textFile.openFile(2, true)) {
	        textFile.writeInFile(query);
	        textFile.closeFile();
	        System.out.println("Query salvata su file");
	    } else {
	        System.out.println("Impossibile aprire il file per salvare la query");
	    }
	}
	
	

    //METODI DEL doPost
	
	private void registraUtente(HttpServletRequest request, HttpServletResponse response, ManageDb mioDB) throws SQLException, IOException {
	    // Recupera i parametri inviati dal form HTML per la registrazione
	    String codiceFiscale = request.getParameter("codice_fiscale");
	    String username = request.getParameter("username");
	    String password = request.getParameter("password");
	    String ruolo = request.getParameter("ruolo");

	    // Esegui una query SQL per inserire i dati del nuovo utente nel database
	    String query = "INSERT INTO utente (nome_utente, password, connesso, ruolo, Codice_Fiscale) VALUES (?, ?, ?, ?, ?)";

	    try (PreparedStatement pstmt = mioDB.myConn.prepareStatement(query)) {
	        pstmt.setString(1, username);
	        pstmt.setString(2, password);
	        pstmt.setBoolean(3, false); // Imposta "connesso" a false di default
	        pstmt.setString(4, ruolo);
	        pstmt.setString(5, codiceFiscale);

	        int rowsInserted = pstmt.executeUpdate();
	        if (rowsInserted > 0) {
	            System.out.println("Nuovo utente registrato con successo: " + username);
	            response.sendRedirect("index.html");
	        } else {
	            System.out.println("Errore durante la registrazione dell'utente: " + username);
	            response.sendRedirect("error.html");
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	        saveQueryToFile(request, query);
	       System.out.println("Vado a salvare la query fallita");
	        response.sendRedirect("error.html");
	    }
	}

	private void registraAllievo(HttpServletRequest request, HttpServletResponse response, ManageDb mioDB) throws SQLException, IOException {
	    // Recupera i parametri inviati dal form HTML per la registrazione
	    String codiceFiscale = request.getParameter("cod_fiscale");
	    String nome = request.getParameter("nome");
	    String cognome = request.getParameter("cognome");
	    String dataNascita = request.getParameter("data_nascita");
	    String luogoNascita = request.getParameter("luogo_nascita");
	    String email = request.getParameter("email");

	    // Esegui una query SQL per inserire i dati del nuovo allievo nel database
	    String query = "INSERT INTO allievo (cod_fiscale, nome, cognome, data_di_nascita, luogo_di_nascita, email) VALUES (?, ?, ?, ?, ?, ?)";
	    try (PreparedStatement pstmt = mioDB.myConn.prepareStatement(query)) {
	        pstmt.setString(1, codiceFiscale);
	        pstmt.setString(2, nome);
	        pstmt.setString(3, cognome);
	        pstmt.setString(4, dataNascita);
	        pstmt.setString(5, luogoNascita);
	        pstmt.setString(6, email);

	        int rowsInserted = pstmt.executeUpdate();
	        if (rowsInserted > 0) {
	            System.out.println("Nuovo allievo registrato con successo: " + nome + " " + cognome);
	            response.sendRedirect("homepage.jsp");
	        } else {
	            System.out.println("Errore durante la registrazione dell'allievo: " + nome + " " + cognome);
	            response.sendRedirect("error.html");
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	        saveQueryToFile(request, query); // Salva la query fallita su un file
	        response.sendRedirect("error.html");
	    }
	}

	private void registraDocente(HttpServletRequest request, HttpServletResponse response, ManageDb mioDB) throws SQLException, IOException {
	    // Recupera i parametri inviati dal form HTML per la registrazione
	    String codiceFiscale = request.getParameter("cod_fiscale");
	    String nome = request.getParameter("nome");
	    String cognome = request.getParameter("cognome");
	    String dataNascita = request.getParameter("data_nascita");
	    String luogoNascita = request.getParameter("luogo_nascita");
	    String email = request.getParameter("email");

	    // Esegui una query SQL per inserire i dati del nuovo docente nel database
	    String query = "INSERT INTO docente (cod_fiscale, nome, cognome, data_di_nascita, luogo_di_nascita, email) VALUES (?, ?, ?, ?, ?, ?)";
	    try (PreparedStatement pstmt = mioDB.myConn.prepareStatement(query)) {
	        pstmt.setString(1, codiceFiscale);
	        pstmt.setString(2, nome);
	        pstmt.setString(3, cognome);
	        pstmt.setString(4, dataNascita);
	        pstmt.setString(5, luogoNascita);
	        pstmt.setString(6, email);

	        int rowsInserted = pstmt.executeUpdate();
	        if (rowsInserted > 0) {
	            System.out.println("Nuovo docente registrato con successo: " + nome + " " + cognome);
	            response.sendRedirect("homepage.jsp");
	        } else {
	            System.out.println("Errore durante la registrazione del docente: " + nome + " " + cognome);
	            response.sendRedirect("error.html");
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	        saveQueryToFile(request, query); // Salva la query fallita su un file
	        response.sendRedirect("error.html");
	    }
	}

	private void registraVerifica(HttpServletRequest request, HttpServletResponse response, ManageDb mioDB) throws SQLException, IOException {
	    // Recupera i parametri inviati dal form HTML per la registrazione della verifica
	    String dataVerifica = request.getParameter("data_verifica");
	    String codiceFiscaleAllievo = request.getParameter("cod_fiscale_allievo");
	    String materia = request.getParameter("materia");
	    String codiceFiscaleDocente = request.getParameter("cod_fiscale_docente");
	    String voto = request.getParameter("voto");

	    // Esegui una query SQL per inserire i dati della nuova verifica nel database
	    String query = "INSERT INTO verifica (data_verifica, cod_fiscale_allievo, materia, cod_fiscale_docente, voto) VALUES (?, ?, ?, ?, ?)";
	    try (PreparedStatement pstmt = mioDB.myConn.prepareStatement(query)) {
	        pstmt.setString(1, dataVerifica);
	        pstmt.setString(2, codiceFiscaleAllievo);
	        pstmt.setString(3, materia);
	        pstmt.setString(4, codiceFiscaleDocente);
	        pstmt.setString(5, voto);

	        int rowsInserted = pstmt.executeUpdate();
	        if (rowsInserted > 0) {
	            System.out.println("Nuova verifica registrata con successo.");
	            response.sendRedirect("homepage.jsp");
	        } else {
	            System.out.println("Errore durante la registrazione della verifica.");
	            response.sendRedirect("error.html");
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	        saveQueryToFile(request, query); // Salva la query fallita su un file
	        response.sendRedirect("error.html");
	    }
	}



	private void doLogin(HttpServletRequest request, HttpServletResponse response, ManageDb mioDB) throws IOException {
		// Verifica se l'utente è già loggato
		HttpSession session = request.getSession(false);
		if (session != null && session.getAttribute("nomeUtente") != null) {
			// Utente già loggato, reindirizza alla homepage o ad una pagina appropriata
			response.sendRedirect("homepage.jsp");
			return;
		}

		// Recupera i parametri di login dal form HTML
		String username = request.getParameter("user");
		String password = request.getParameter("password");

		// Verifica se i parametri sono validi
		if (username == null || username.isEmpty() || password == null || password.isEmpty()) {
			// Parametri non validi, reindirizza alla pagina di login con un messaggio di
			// errore
			response.sendRedirect("index.html?error=Invalid credentials");
			return;
		}

		// Esegui una query SQL per verificare le credenziali dell'utente
		String query = "SELECT * FROM utente WHERE nome_utente = ? AND password = ?";
		try (PreparedStatement pstmt = mioDB.myConn.prepareStatement(query)) {
			pstmt.setString(1, username);
			pstmt.setString(2, password);

			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				// Credenziali valide, imposta l'utente come loggato
				session = request.getSession(true);
				session.setAttribute("nomeUtente", username);
				session.setAttribute("ruolo", rs.getString("ruolo"));
				// Chiamata al metodo doPut() per impostare lo stato "connesso" a true
				doPut(username, true, mioDB);
				// Reindirizza alla homepage o ad una pagina appropriata
				response.sendRedirect("homepage.jsp");
			} else {
				// Credenziali non valide, reindirizza alla pagina di login con un messaggio di
				// errore
				response.sendRedirect("login.jsp?error=Invalid credentials");
			}
		} catch (SQLException e) {
			e.printStackTrace();
			// Gestisci l'errore e reindirizza l'utente a una pagina di errore o a un'altra
			// pagina appropriata
			response.sendRedirect("error.html");
		}
	}

	public void doPut(String nomeUtente, boolean connesso, ManageDb mioDB) {

		boolean bRet = mioDB.Connect("localhost", 3306, "scuola_db", "server_scuola", "server_scuola123");
		if (bRet) {
			System.out.println("Connessione al DB avvenuta correttamente,ADESSO");

			String updateQuery = "UPDATE utente SET connesso = ? WHERE nome_utente = ?";
			try {
				PreparedStatement pstmt = mioDB.myConn.prepareStatement(updateQuery);
				pstmt.setBoolean(1, connesso);
				pstmt.setString(2, nomeUtente);
				int rowsUpdated = pstmt.executeUpdate();
				if (rowsUpdated > 0) {
					System.out.println("Stato 'connesso' aggiornato per l'utente: " + nomeUtente);
				} else {
					System.out.println("Impossibile aggiornare lo stato 'connesso' per l'utente: " + nomeUtente);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				mioDB.Disconnect();
			}
		}
	}

	public void doLogout(HttpServletRequest request, HttpServletResponse response, ManageDb mioDB) throws IOException {
		// Verifica se l'utente è già autenticato
		HttpSession session = request.getSession(false);
		if (session != null && session.getAttribute("nomeUtente") != null) {
			// Recupera il nome utente dell'utente attualmente connesso dalla sessione
			String nomeUtente = (String) session.getAttribute("nomeUtente");

			// Chiamata al metodo doPut() per impostare lo stato "connesso" a false
			doPut(nomeUtente, false, mioDB);

			// Rimuovi eventuali attributi di sessione
			session.invalidate();

			// Reindirizza l'utente alla pagina di login o a un'altra pagina dopo il logout
			response.sendRedirect("index.html");

			// Registra l'attività di logout nel log del server
			System.out.println("Logout eseguito per l'utente: " + nomeUtente);
		} else {
			// Reindirizza l'utente alla pagina di login o a un'altra pagina appropriata
			response.sendRedirect("index.html");
		}
	}

	/**
	 * this life-cycle method is invoked when the application or the server is
	 * shutting down
	 */
	public void destroy() {
		System.out.println("Servlet is being destroyed");
	}
}
