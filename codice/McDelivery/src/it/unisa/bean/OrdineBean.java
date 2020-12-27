package it.unisa.bean;

import java.io.Serializable;

public class OrdineBean implements Serializable {

	private static final long serialVersionUID = 1L;
	
	String data;
	int numero;
	int totale;
	String mail;
	int presoInCarico;
	String nome;
	String cognome;
	String indirizzo;
	
	public OrdineBean() {
		data="";
		numero=-1;
		totale=-1;
		mail="";
		presoInCarico=-1;
		nome="";
		cognome="";
		indirizzo="";
	}
	

	public String getIndirizzo() {
		return indirizzo;
	}


	public void setIndirizzo(String indirizzo) {
		this.indirizzo = indirizzo;
	}


	public String getNome() {
		return nome;
	}

	public String getCognome() {
		return cognome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public void setCognome(String cognome) {
		this.cognome = cognome;
	}

	public String getData() {
		return data;
	}

	public int getNumero() {
		return numero;
	}

	public int getTotale() {
		return totale;
	}

	public String getMail() {
		return mail;
	}

	

	public int getPresoInCarico() {
		return presoInCarico;
	}

	public void setData(String data) {
		this.data = data;
	}

	public void setNumero(int numero) {
		this.numero = numero;
	}

	public void setTotale(int totale) {
		this.totale = totale;
	}

	public void setMail(String mail) {
		this.mail = mail;
	}

	
	public void setPresoInCarico(int presoInCarico) {
		this.presoInCarico = presoInCarico;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		OrdineBean other = (OrdineBean) obj;
		
		if (!data.equals(other.data))
			return false;
		
		if (numero != other.numero)
			return false;
		return true;
	}
	
	

}
