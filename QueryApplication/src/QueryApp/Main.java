package QueryApp;

import java.io.IOException;

public class Main {

	public static void main(String[] args) throws IOException {
		//Lancio dell'applicazione per registrare le query salvate
		ManageQueryDB queryManager = new ManageQueryDB();
        queryManager.printConfig();
        queryManager.executeAndRemoveSavedQueries();

	}

}
