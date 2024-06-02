package servlet;

import java.time.*;

public class Persona {
	
	// Attributi:
	protected String nome;
	protected String cognome;
	protected LocalDate dataDiNascita;
	protected String luogoDiNascita;
	protected String email;
	
	
	// Costruttore:
		Persona(String nome, String cognome, LocalDate dataDiNascita, String luogoDiNascita, String email) {
			this.nome = nome;
			this.cognome = cognome;
			this.dataDiNascita = dataDiNascita;
			this.luogoDiNascita = luogoDiNascita;
			this.email = email;
		}

		public String getNome() {
			return nome;
		}

		public void setNome(String nome) {
			this.nome = nome;
		}

		public String getCognome() {
			return cognome;
		}

		public void setCognome(String cognome) {
			this.cognome = cognome;
		}

		public LocalDate getDataDiNascita() {
			return dataDiNascita;
		}

		public void setDataDiNascita(LocalDate dataDiNascita) {
			this.dataDiNascita = dataDiNascita;
		}

		public String getLuogoDiNascita() {
			return luogoDiNascita;
		}

		public void setLuogoDiNascita(String luogoDiNascita) {
			this.luogoDiNascita = luogoDiNascita;
		}

		public String getEmail() {
			return email;
		}

		public void setEmail(String email) {
			this.email = email;
		}

		
		
		// Dovrei fare altri costruttori per i casi in cui conosco i dati solo parzialmente

		
} // chiusura classe