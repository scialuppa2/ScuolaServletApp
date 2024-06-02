Applicazione ScuolaServlet

Questo progetto è un'applicazione web sviluppata utilizzando Java Servlet per la gestione di una scuola e l'esecuzione di query salvate da un file di testo su un database MySQL.

Funzionalità
- Registrazione di nuovi utenti con ruoli diversi come studente, insegnante o amministratore.
- Gestione di corsi, studenti, insegnanti e registrazioni agli esami.
- Salvataggio di query non registrate in un file per garantire la coerenza dei dati nel database.
- Esecuzione delle query salvate in un file per garantire la coerenza dei dati nel database.

Requisiti
- Apache Tomcat o un server web compatibile con Java Servlet.
- Un'istanza di database MySQL o un altro database relazionale compatibile.

Configurazione
- Assicurati di avere un'istanza di Apache Tomcat installata sul tuo sistema.
- Crea un database MySQL con il nome scuola_db (o un altro nome a tua scelta) e importa lo schema del database fornito con l'applicazione.
- Assicurati di avere il driver JDBC MySQL (mysql-connector-java) aggiunto al classpath del progetto.
