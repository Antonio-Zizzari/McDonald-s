package it.unisa.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collection;
import java.util.LinkedList;
import java.util.List;

import it.unisa.bean.ProductBean;
import it.unisa.bean.UtenteBean;


public class ProductManagerDao {

	/**
	 * aggiorna lo sconto del prodotto avente come id l'id passato come parametro e imposta
	 * come percentuale di sconto il valore del parametro sconto
	 * @param id
	 * @param sconto
	 * @return ritorna true se l'aggiornamento è stato effettuato con successo, ritorna false 
	 * se l'id passato come parametro non appartiene a nessun prodotto presente nel sistema
	 * oppure ritorna false se il parametro sconto è <0 o >=100 
	 */
	public boolean scontidoUpdate(int id, int sconto) {
		if((sconto < 0) || (sconto >= 100))
			return false;
		if(controlloProdotto(id) == false)
			return false;
		try {
			Connection connection = null;
			PreparedStatement preparedStatement = null;
			
			String updateSQL = "UPDATE prodotto SET " +
					"sconto = ? WHERE id = ?";
			
			try {
				connection = DriverManagerConnectionPool.getConnection();
				preparedStatement = connection.prepareStatement(updateSQL);	
				
				preparedStatement.setInt(1, sconto);
				preparedStatement.setInt(2, id);
				
				
				
				System.out.println("scontidoUpdate: "+ preparedStatement.toString());
				preparedStatement.executeUpdate();
				
				connection.commit();
				
			} finally {
				try {
					if(preparedStatement != null) 
						preparedStatement.close();
				} finally {
					DriverManagerConnectionPool.releaseConnection(connection);
				}
			}	
		} catch (Exception e) {}
		return true;
	}
	
	
	/**
	 * inserisce nel sistema un nuovo prodotto
	 * @param product bean del prodotto da inserire nel sistema
	 * @return ritorna true se l'inserimento è avvenuto con successo, ritorna false altrimenti
	 */
	public boolean doSave(ProductBean product){
		if(controlloProdotto(product.getId()) == true)
			return false;
		try {
			Connection connection = null;
			PreparedStatement preparedStatement = null;
			
			String insertSQL = "INSERT INTO prodotto" +
					" (nome, prezzo, tipo, sconto, photo) VALUES (?, ?, ?, ?, ?)";
			
			try {
				connection = DriverManagerConnectionPool.getConnection();
				preparedStatement = connection.prepareStatement(insertSQL);
				
				
				preparedStatement.setString(1, product.getNome());
				preparedStatement.setInt(2, product.getPrezzo());
				preparedStatement.setInt(3, product.getTipo());
				preparedStatement.setInt(4, 0);
				preparedStatement.setString(5, product.getPhoto());
				
				System.out.println("doSave: "+ preparedStatement.toString());
				preparedStatement.executeUpdate();
			
				connection.commit();

			} finally {
					try {
						if(preparedStatement != null) 
							preparedStatement.close();
					} finally {
						DriverManagerConnectionPool.releaseConnection(connection);
					}
				}	
		} catch (Exception e) {}
		return true;
	}
	
	
	/**
	 * aggiorna il prodotto con l'id passato come parametro, presente nel sistema, con i 
	 * nuovi valori nome, prezzo e directory(url foto del prodotto) passati come parametro
	 * @param id
	 * @param nome
	 * @param prezzo
	 * @param directory
	 * @return ritorna true se l'aggiornamento è stato effettuato con successo,
	 * ritorna false altrimenti
	 */
	public boolean doUpdate(int id, String nome, int prezzo, String directory){
		if(prezzo <= 0)
			return false;
		if(controlloProdotto(id) == false)
			return false;
		try {
			Connection connection = null;
			PreparedStatement preparedStatement = null;
			String updateSQL;
			
			if(directory!=null) {
				updateSQL = "UPDATE prodotto SET " +
						"nome = ?, prezzo = ?, photo = ? WHERE id = ?";
			}else {
				updateSQL = "UPDATE prodotto SET " +
						"nome = ?, prezzo = ? WHERE id = ?";
			}
			
			try {
				connection = DriverManagerConnectionPool.getConnection();
				preparedStatement = connection.prepareStatement(updateSQL);	
				
				if(directory!=null) {
					preparedStatement.setString(1, nome);
					preparedStatement.setInt(2, prezzo);
					preparedStatement.setString(3, directory);
					preparedStatement.setInt(4, id);
					
				}else {
					preparedStatement.setString(1, nome);
					preparedStatement.setInt(2, prezzo);
					preparedStatement.setInt(3, id);
				}
				
				
				
				System.out.println("doUpdate: "+ preparedStatement.toString());
				preparedStatement.executeUpdate();
				
				connection.commit();
				
			} finally {
				try {
					if(preparedStatement != null) 
						preparedStatement.close();
				} finally {
					DriverManagerConnectionPool.releaseConnection(connection);
				}
			}	
		} catch (Exception e) {}
		return true;
	}
	
	
	/**
	 * elimina dal sistema il prodotto con l'id passato per parametro
	 * @param id
	 * @return ritorna true se l'eliminazione è stata effettuata con successo,
	 * ritorna false altrimenti
	 */
	public boolean doDelete(int id){
		if(controlloProdotto(id) == false)
			return false;
		try {
			Connection connection = null;
			PreparedStatement preparedStatement = null;
			
			String deleteSQL = "DELETE FROM prodotto WHERE id = ?";
			
			try {
				connection = DriverManagerConnectionPool.getConnection();
				preparedStatement = connection.prepareStatement(deleteSQL);
				preparedStatement.setInt(1, id);
				
				System.out.println("doDelete: "+ preparedStatement.toString());
				preparedStatement.executeUpdate();
				
				connection.commit();
				
			} finally {
				try {
					if(preparedStatement != null) 
						preparedStatement.close();
				} finally {
					DriverManagerConnectionPool.releaseConnection(connection);
				}
			}
		} catch (Exception e) {}
		return true;
	}
	
	/**
	 * @param id
	 * @return ritorna true se è presente nel sistema un prodotto avente l'id passato 
	 * come parametro, ritorna false altrimenti
	 */
	public boolean controlloProdotto(int id) {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		boolean retVal=false;
		try {
			String selectSQL="SELECT * FROM prodotto WHERE id = ?";
			connection = DriverManagerConnectionPool.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setInt(1, id);
			ResultSet rs = preparedStatement.executeQuery();
			if(rs.next())
				retVal = true;
			else
				retVal = false;
		}catch(Exception e) {e.printStackTrace();}	
		finally {
			try {
				if(preparedStatement != null) 
					preparedStatement.close();
				if(preparedStatement != null) 
					preparedStatement.close();
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				try {
					DriverManagerConnectionPool.releaseConnection(connection);
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return retVal;
	}
	
	
	
	//usato solo nel testing
	public void doSave1(ProductBean product) {
		if(controlloProdotto(product.getId()))
			return;
		try {
			Connection connection = null;
			PreparedStatement preparedStatement = null;
			
			String insertSQL = "INSERT INTO prodotto VALUES (?, ?, ?, ?, ?, ?)";
			
			try {
				connection = DriverManagerConnectionPool.getConnection();
				preparedStatement = connection.prepareStatement(insertSQL);
				
				preparedStatement.setInt(1, product.getId());
				preparedStatement.setString(2, product.getNome());
				preparedStatement.setInt(3, product.getPrezzo());
				preparedStatement.setInt(4, product.getTipo());
				preparedStatement.setInt(5, 0);
				preparedStatement.setString(6, product.getPhoto());
				
				System.out.println("doSave: "+ preparedStatement.toString());
				preparedStatement.executeUpdate();
			
				connection.commit();

			} finally {
					try {
						if(preparedStatement != null) 
							preparedStatement.close();
					} finally {
						DriverManagerConnectionPool.releaseConnection(connection);
					}
				}	
		} catch (Exception e) {}
		return;
	}
}
