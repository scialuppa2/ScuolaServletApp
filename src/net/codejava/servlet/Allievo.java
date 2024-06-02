package servlet;

import java.time.LocalDate;
import java.util.ArrayList;

public class Allievo extends Persona {
	
	//Variabili d'istanza:
	private int id;
	private String codiceFiscale;
	private String classe;
	private String sezione;

	// Costruttore: 
	public Allievo(String nome, String cognome, LocalDate dataDiNascita, String luogoDiNascita, String email, String classe, String sezione) {
		super(nome, cognome, dataDiNascita, luogoDiNascita, email);
		this.classe = classe;
		this.sezione = sezione;
	}
	
	//Costruttore come la tabella del database
	public Allievo(int id,String codiceFiscale, String nome, String cognome, LocalDate dataDiNascita, String luogoDiNascita, String email) {
	    super(nome, cognome, dataDiNascita, luogoDiNascita, email);
	    this.id = id;
	    this.codiceFiscale = codiceFiscale;
	}

	
	
	
	
	
	
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getCodiceFiscale() {
		return codiceFiscale;
	}

	public void setCodiceFiscale(String codiceFiscale) {
		this.codiceFiscale = codiceFiscale;
	}

	public String getClasse() {
		return classe;
	}

	public void setClasse(String classe) {
		this.classe = classe;
	}

	public String getSezione() {
		return sezione;
	}

	public void setSezione(String sezione) {
		this.sezione = sezione;
	}

	@Override
	public String toString() {
	    return nome + cognome + dataDiNascita + luogoDiNascita + email + classe + sezione;
	}

	

}