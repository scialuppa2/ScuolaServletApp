package QueryApp;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.sql.Statement;

import com.mysql.cj.jdbc.exceptions.CommunicationsException;

import librerie.ConfigReader;
import librerie.ManageDb;
import librerie.ManageTextFile;

public class ManageQueryDB {

    private String filePath;
    private String dbHost;
    private int dbPort;
    private String dbName;
    private String dbUser;
    private String dbPassword;

    public ManageQueryDB() throws IOException {
        ConfigReader configReader = new ConfigReader("config.properties");

        // Recupera le proprietà del config.properties
        this.filePath = configReader.getProperty("failed_queries_path");
        this.dbHost = configReader.getProperty("db.host");
        this.dbPort = configReader.getIntProperty("db.port");
        this.dbName = configReader.getProperty("db.name");
        this.dbUser = configReader.getProperty("db.user");
        this.dbPassword = configReader.getProperty("db.password");
    }
    
    //Stampa le proprietà del config.properties
    public void printConfig() {
        System.out.println("File Path: " + filePath);
        System.out.println("DB Host: " + dbHost);
        System.out.println("DB Port: " + dbPort);
        System.out.println("DB Name: " + dbName);
        System.out.println("DB User: " + dbUser);
        System.out.println("DB Password: " + dbPassword);
    }
    
    //Legge il file, passa le query ad executeQuery() ed elimina la riga
    protected void executeAndRemoveSavedQueries() {
        ManageTextFile textFile = new ManageTextFile(filePath);
        ManageDb mioDB = new ManageDb();

        boolean bRet = mioDB.Connect(dbHost, dbPort, dbName, dbUser, dbPassword);
        if (bRet) {
            try {
                textFile.openFile(1, false);
                String query;
                while ((query = textFile.readNextLine()) != null) {
                    if (query.trim().isEmpty()) {
                        continue; // Passa alla prossima iterazione del ciclo se la query è vuota
                    }
                    boolean querySuccess = mioDB.executeQuery(query);
                    if (querySuccess) {
                        textFile.removeFirstLine();
                        System.out.println("Query eseguita e rimossa: " + query);
                    } else {
                        System.out.println("Errore nell'esecuzione della query: " + query);
                    }
                }
                System.out.println("Tutte le query salvate sono state eseguite e rimosse.");
            } catch (SQLException e) {
                e.printStackTrace();
                System.out.println("Errore nell'esecuzione delle query salvate: " + e.getMessage());
            } finally {
                mioDB.Disconnect();
                textFile.closeFile(); // Chiudi il file dopo aver eseguito tutte le query
            }
        } else {
            System.out.println("Connessione al database non riuscita, le query salvate non possono essere eseguite.");
        }
    }

    // Metodo per eseguire una singola query
	protected boolean executeQuery(ManageDb mioDB, String query) {
        try (PreparedStatement pstmt = mioDB.myConn.prepareStatement(query)) {
            int rows = pstmt.executeUpdate();
            System.out.println("Query eseguita correttamente");
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
	
	//Metodo alternativo da implementare
	public int WriteInDBx(ManageDb mioDB, String sSqlQuery) {
        try {
            Statement stm = mioDB.myConn.createStatement();
            stm.execute(sSqlQuery);
            return 0;
        } catch (SQLIntegrityConstraintViolationException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            return 3;
        }  catch (CommunicationsException e) {
            return 1;
        }
        catch (SQLException e) {

            e.printStackTrace();
            return 2; // Altro errore SQL

        }
    }
}
