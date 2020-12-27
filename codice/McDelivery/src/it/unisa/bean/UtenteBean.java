package it.unisa.bean;

import java.io.Serializable;

public class UtenteBean implements Serializable{

	private static final long serialVersionUID = 1L;
	
	String mail;
	String nome;
	String cognome;
	int numeroOrdini;
	int tipo;
	String via;
	int cap;
	int numero;
	String pwd;
	
	public UtenteBean() {
		mail="";
		nome="";
		cognome="";
		numeroOrdini=-1;
		tipo=-1;
		via="";
		cap=-1;
		numero=-1;
		pwd="";
	}
	

	public String getPwd() {
		return pwd;
	}


	public void setPwd(String pwd) {
		this.pwd = pwd;
	}


	public String getVia() {
		return via;
	}


	public int getCap() {
		return cap;
	}


	public int getNumero() {
		return numero;
	}


	public void setVia(String via) {
		this.via = via;
	}


	public void setCap(int cap) {
		this.cap = cap;
	}


	public void setNumero(int numero) {
		this.numero = numero;
	}


	public int getTipo() {
		return tipo;
	}


	public void setTipo(int tipo) {
		this.tipo = tipo;
	}


	public String getMail() {
		return mail;
	}

	public String getNome() {
		return nome;
	}

	public String getCognome() {
		return cognome;
	}

	public int getNumeroOrdini() {
		return numeroOrdini;
	}

	public void setMail(String mail) {
		this.mail = mail;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public void setCognome(String cognome) {
		this.cognome = cognome;
	}

	public void setNumeroOrdini(int numeroOrdini) {
		this.numeroOrdini = numeroOrdini;
	}


	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		UtenteBean other = (UtenteBean) obj;
		if (mail == null) {
			if (other.mail != null)
				return false;
		} else if (!mail.equals(other.mail))
			return false;
		return true;
	}


	

	
	
	

}
