package it.unisa.bean;

import java.io.Serializable;

public class McDriveBean implements Serializable{
	

	private static final long serialVersionUID = 1L;
	
	String nome;
	String via;
	int cap;
	int numero;
	
	public McDriveBean() {
		nome="";
		via="";
		cap=-1;
		numero=-1;
	}
	
	public String getNome() {
		return nome;
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
	public void setNome(String nome) {
		this.nome = nome;
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

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		McDriveBean other = (McDriveBean) obj;
		if (nome == null) {
			if (other.nome != null)
				return false;
		} else if (!nome.equals(other.nome))
			return false;
		return true;
	}
	
	
	
}
