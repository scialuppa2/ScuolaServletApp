package servlet;

import java.time.LocalDate;
import java.util.ArrayList;

public class Docente extends Persona{
	private int id;
	private String codiceFiscale;
	private ArrayList<String> materie;

    public Docente(int id, String codiceFiscale, String nome, String cognome, LocalDate dataDiNascita, String luogoDiNascita, String email) {
        super(nome, cognome, dataDiNascita, luogoDiNascita, email);
        this.id = id;
        this.codiceFiscale = codiceFiscale;
    }

	public ArrayList<String> getMaterie() {
		return materie;
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

	public void setMaterie(ArrayList<String> materie) {
		this.materie = materie;
	}
	
	public void aggiungiMateria(String materia) {
        materie.add(materia);
    }

    public void rimuoviMateria(String materia) {
        materie.remove(materia);
    }
    
    @Override
    public String toString() {
        return nome + cognome + dataDiNascita + luogoDiNascita + email + materie;
    }


}
