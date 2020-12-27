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

import it.unisa.bean.McDriveBean;
import it.unisa.bean.ProductBean;
import it.unisa.bean.UtenteBean;



public class UtenteDao {
	/**
	 * 
	 * @param mail email dell'utente che si vuole ottenere
	 * @return ritorna l'UtenteBean associato all'email data in input, ritorna null se non esiste nessun utente associato alla mail data in input
	 */
	public UtenteBean doRetrieveByMailPwd(String mail) {
		try {
			Connection connection = null;
			PreparedStatement preparedStatement = null;

			UtenteBean utente= new UtenteBean();
			
			String selectSQL = "SELECT * FROM account WHERE mail = ?";
			
			try {
				connection = DriverManagerConnectionPool.getConnection();
				preparedStatement = connection.prepareStatement(selectSQL);
				preparedStatement.setString(1, mail);
				
				System.out.println("doRetrieveByMailPwd: "+ preparedStatement.toString());
				ResultSet rs = preparedStatement.executeQuery();

				if (rs.next()) {
					utente.setMail(rs.getString("mail"));
					utente.setPwd(rs.getString("pwd"));
					utente.setNome(rs.getString("nome"));
					utente.setCognome(rs.getString("cognome"));
					utente.setTipo(rs.getInt("tipo"));
					utente.setNumeroOrdini(rs.getInt("num_ordini"));
				}
				else { 
					return null;
				}
				
				String selectSQL2 = "SELECT * FROM indirizzoAcc WHERE mail = ?";
				
				preparedStatement = connection.prepareStatement(selectSQL2);
				preparedStatement.setString(1, mail);
				
				System.out.println("doRetrieveByIndirizzo: "+ preparedStatement.toString());
				rs = preparedStatement.executeQuery();			
				if (rs.next()) {
					utente.setVia(rs.getString("via"));
					utente.setCap(rs.getInt("cap"));
					utente.setNumero(rs.getInt("numero"));
				}
				else {
					return null;
				}
				
				
			}catch(Exception e) {return null;}
			finally {
				try {
					if(preparedStatement != null) 
						preparedStatement.close();
				} finally {
					DriverManagerConnectionPool.releaseConnection(connection);
				}
			}
			
			return utente;
		}catch(Exception e) {return null;}
	}
	
	/**
	 * @return ritorna true se la registrazione è andata a buon fine, false altrimenti
	 */
	public boolean doSaveUtente(String mail, String pwd, String nome, String cognome, int tipo, String via, int cap, int numero){
		try {
			Connection connection = null;
			PreparedStatement preparedStatement = null;
			
			String insertSQL = "INSERT INTO account" +
					" (mail, pwd, nome, cognome, tipo, num_ordini) VALUES (?, ?, ?, ?, ?, ?)";
			boolean retVal = false;
			try {
				connection = DriverManagerConnectionPool.getConnection();
				preparedStatement = connection.prepareStatement(insertSQL);
				
				preparedStatement.setString(1, mail);
				preparedStatement.setString(2, pwd);
				preparedStatement.setString(3, nome);
				preparedStatement.setString(4, cognome);
				preparedStatement.setInt(5, tipo);
				preparedStatement.setInt(6, 0);
				
				System.out.println("doSave: "+ preparedStatement.toString());
				preparedStatement.executeUpdate();
				
				String insertSQL2 = "INSERT INTO indirizzoAcc" +
						" (via, cap, numero, mail) VALUES (?, ?, ?, ?)";
				
				preparedStatement = connection.prepareStatement(insertSQL2);
				
				preparedStatement.setString(1, via);
				preparedStatement.setInt(2, cap);
				preparedStatement.setInt(3, numero);
				preparedStatement.setString(4, mail);
				
				System.out.println("doSave: "+ preparedStatement.toString());
				preparedStatement.executeUpdate();
			
				connection.commit();
				retVal = true;
			} finally {
					try {
						if(preparedStatement != null) 
							preparedStatement.close();
					} finally {
						DriverManagerConnectionPool.releaseConnection(connection);
					}
				}
			return retVal;
		}catch(Exception e) {return false;}
	}
	/**
	 * 
	 * ritorna true se la modifica dei dati utente presenti nel UtenteBean passato come parametro è stata effettuata con successo per l'utente avente come email la mail presente nel UtenteBean passato come parametro(non è possibile modificare la mail), ritorna false altrimenti 
	 */
	public boolean utentedoUpdate(UtenteBean utente) {
		if(doRetrieveByMailPwd(utente.getMail()) == null)
			return false;
		try {
			boolean retVal = false;
			Connection connection = null;
			PreparedStatement preparedStatement = null;
			PreparedStatement preparedStatement2 = null;
			
			String updateSQL = "UPDATE account SET " +
					"nome = ?, cognome = ? WHERE mail = ?";
			
			String updateSQL2 = "UPDATE indirizzoAcc SET " +
					"via = ?, cap = ?, numero = ? WHERE mail = ?";
			
			try {
				connection = DriverManagerConnectionPool.getConnection();
				preparedStatement = connection.prepareStatement(updateSQL);	
				
				preparedStatement.setString(1, utente.getNome());
				preparedStatement.setString(2, utente.getCognome());
				preparedStatement.setString(3, utente.getMail());
				
				System.out.println("nomeCognomedoUpdate: "+ preparedStatement.toString());
				preparedStatement.executeUpdate();
				
				preparedStatement2 = connection.prepareStatement(updateSQL2);	
				
				preparedStatement2.setString(1, utente.getVia());
				preparedStatement2.setInt(2, utente.getCap());
				preparedStatement2.setInt(3, utente.getNumero());
				preparedStatement2.setString(4, utente.getMail());
				
				System.out.println("indirizzodoUpdate: "+ preparedStatement2.toString());
				preparedStatement2.executeUpdate();
				
				
				connection.commit();
				retVal = true;
			} finally {
				try {
					if(preparedStatement != null) 
						preparedStatement.close();
					if(preparedStatement2 != null) 
						preparedStatement2.close();
				} finally {
					DriverManagerConnectionPool.releaseConnection(connection);
				}
			}	
			return retVal;
		}catch (Exception e) {return false;}
	}
	/**
	 * 
	 * ritorna true se ma modifica della password è stata effettuata con successo, ritona false altrimenti
	 */
	public boolean pwddoUpdate(String mail, String pwd){
		if(doRetrieveByMailPwd(mail) == null)
			return false;
		try {
			Connection connection = null;
			PreparedStatement preparedStatement = null;
			String updateSQL = "UPDATE account SET " +
					"pwd = ? WHERE mail = ?";
			boolean retVal = false;	
			try {
				connection = DriverManagerConnectionPool.getConnection();
				preparedStatement = connection.prepareStatement(updateSQL);	
				
				preparedStatement.setString(1, pwd);
				preparedStatement.setString(2, mail);
				
				
				
				System.out.println("pwddoUpdate: "+ preparedStatement.toString());
				preparedStatement.executeUpdate();
				
				connection.commit();
				retVal = true;
			} finally {
				try {
					if(preparedStatement != null) 
						preparedStatement.close();
				} finally {
					DriverManagerConnectionPool.releaseConnection(connection);
				}
			}	
			return retVal;
		} catch (Exception e) {return false;}
	}
	
	/**
	 * ritorna true se esiste nel DB un utente con la mail data come parametro. ritorna false altrimenti
	 */
	public Boolean maildoRetrieveByKey(String mail){//Ajax
		try {
			Connection connection = null;
			PreparedStatement preparedStatement = null;

			ProductBean bean = new ProductBean();
			
			String selectSQL = "SELECT * FROM account WHERE mail = ?";
			
			Boolean verifica=false;
			
			try {
				connection = DriverManagerConnectionPool.getConnection();
				preparedStatement = connection.prepareStatement(selectSQL);
				preparedStatement.setString(1, mail);
				
				System.out.println("maildoRetrieveByKey: "+ preparedStatement.toString());
				ResultSet rs = preparedStatement.executeQuery();
				
				if(rs.next()) {	
					verifica=true;				
				}			
				
				System.out.println(bean);
			} finally {
				try {
					if(preparedStatement != null) 
						preparedStatement.close();
				} finally {
					DriverManagerConnectionPool.releaseConnection(connection);
				}
			}
			
			return verifica;
		} catch (Exception e) {return false;}
	}
	
	//usato solo nel test di unità
	public void deleteUtente(String mail) {
		if(doRetrieveByMailPwd(mail) == null)
			return;
		try {
			Connection connection = null;
			PreparedStatement preparedStatement = null;
			PreparedStatement preparedStatement2 = null;
			
			String deleteSQL = "DELETE FROM indirizzoAcc WHERE mail = ?";
			String deleteSQL2 = "DELETE FROM account WHERE mail = ?";
			
			
			try {
				connection = DriverManagerConnectionPool.getConnection();
				preparedStatement = connection.prepareStatement(deleteSQL);
				preparedStatement.setString(1, mail);
				
				preparedStatement.executeUpdate();
				
				
				preparedStatement2 = connection.prepareStatement(deleteSQL2);
				preparedStatement2.setString(1, mail);
				
				preparedStatement2.executeUpdate();
				
				connection.commit();
				
			} finally {
				try {
					if(preparedStatement != null) 
						preparedStatement.close();
					if(preparedStatement2 != null) 
						preparedStatement2.close();
				} finally {
					DriverManagerConnectionPool.releaseConnection(connection);
				}
			}
		} catch (Exception e) {}
	}
}
