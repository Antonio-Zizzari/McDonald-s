package it.unisa.bean;

import java.io.Serializable;

public class ProductBean implements Serializable {

	private static final long serialVersionUID = 1L;
	
	int id;
	String nome;
	int prezzo;
	int tipo;
	int sconto;
	String photo;
	int quantita;
	
	public ProductBean() {
		id=-1;
		nome="";
		prezzo=0;
		tipo=-1;
		sconto=0;
		photo="";
		quantita=1;
	}
	
	public int getId() {
		return id;
	}



	public String getNome() {
		return nome;
	}



	public int getPrezzo() {
		return prezzo;
	}



	public int getTipo() {
		return tipo;
	}



	public int getSconto() {
		return sconto;
	}



	public String getPhoto() {
		return photo;
	}

	
	public int getQuantita() {
		return quantita;
	}
	

	public void setId(int id) {
		this.id = id;
	}



	public void setNome(String nome) {
		this.nome = nome;
	}



	public void setPrezzo(int prezzo) {
		this.prezzo = prezzo;
	}



	public void setTipo(int tipo) {
		this.tipo = tipo;
	}



	public void setSconto(int sconto) {
		this.sconto = sconto;
	}



	public void setPhoto(String photo) {
		this.photo = photo;
	}
	


	public void setQuantita(int quantita) {
		this.quantita = quantita;
	}

	public boolean isEmpty() {
		return id == -1;
	}

	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ProductBean other = (ProductBean) obj;
		if (id != other.id)
			return false;
		if (nome == null) {
			if (other.nome != null)
				return false;
		} else if (!nome.equals(other.nome))
			return false;
		if (photo == null) {
			if (other.photo != null)
				return false;
		} else if (!photo.equals(other.photo))
			return false;
		if (prezzo != other.prezzo)
			return false;
		if (sconto != other.sconto)
			return false;
		if (tipo != other.tipo)
			return false;
		return true;
	}

	
	
	
}
