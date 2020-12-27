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
import it.unisa.bean.OrdineBean;


public class CorriereDAO {

	/**
	 * @param mc 
	 * @return restituisce un ArrayList contenente tutti gli ordini, relativi al McDrive 
	 * passato come parametro, che non sono stati presi in carico da nessun corriere
	 */
	public ArrayList<OrdineBean> ordineRetrieve(String mc){
		if(controlloMc(mc) == false)
			return null;
		try {
			ArrayList<OrdineBean> ordini = new ArrayList<OrdineBean>();
			
			Connection connection = null;
			PreparedStatement preparedStatement = null;
			PreparedStatement preparedStatement2 = null;
			PreparedStatement preparedStatement3 = null;
			
			String selectSQL="SELECT * FROM ordine WHERE preso_in_carico=0 AND mc_nome = ?";
			
			try {
				connection = DriverManagerConnectionPool.getConnection();
				preparedStatement = connection.prepareStatement(selectSQL);
				preparedStatement.setString(1, mc);
				
				
				System.out.println("ordineRetrieve:" + preparedStatement.toString());
				ResultSet rs = preparedStatement.executeQuery();
				
				while(rs.next()) {
					OrdineBean ordine = new OrdineBean();
				
					ordine.setData(rs.getString("data"));
					ordine.setNumero(rs.getInt("numero"));
					ordine.setTotale(rs.getInt("totale"));
					ordine.setMail(rs.getString("mail"));
					ordine.setPresoInCarico(rs.getInt("preso_in_carico"));
					
					String selectSQL2="SELECT * FROM indirizzoAcc WHERE mail = ?";
					
					
					
						preparedStatement2 = connection.prepareStatement(selectSQL2);
						preparedStatement2.setString(1, ordine.getMail());
						
						
						System.out.println("indirizzoRetrieve:" + preparedStatement2.toString());
						ResultSet rs2 = preparedStatement2.executeQuery();
						
						if(rs2.next()) {						
							ordine.setIndirizzo(rs2.getString("via")+", "+rs2.getInt("numero")+" - "+rs2.getInt("cap"));
						}
						
					String selectSQL3="SELECT * FROM account WHERE mail = ?";
						
						
						
						preparedStatement3 = connection.prepareStatement(selectSQL3);
						preparedStatement3.setString(1, ordine.getMail());
						
						
						System.out.println("nomecognomeRetrieve:" + preparedStatement3.toString());
						ResultSet rs3 = preparedStatement3.executeQuery();
						
						if(rs3.next()) {						
							ordine.setNome(rs3.getString("nome"));
							ordine.setCognome(rs3.getString("cognome"));
						}
						
					ordini.add(ordine);
				}
				
					
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
			return ordini;
		} catch (Exception e) {return null;}
	}
	
	
	/**
	 * imposta il campo il preso in carico a 1 dell'ordine dato in input
	 * @param ordine 
	 * @return ritona true se l'aggiornamento è stato effettuato con successo,
	 * ritorna false se l'ordine dato in input non è presente nel sistema o se è gia stato 
	 * preso in carico
	 */
	public boolean doUpdateOrdine(OrdineBean ordine) {
		if(controlloOrdine(ordine.getData(), ordine.getNumero()) == false)
			return false;
		try {
			Connection connection = null;
			PreparedStatement preparedStatement = null;
			
			String updateSQL = "UPDATE ordine SET " +
					"preso_in_carico = 1 WHERE data = ? AND numero = ?";
			
			try {
				connection = DriverManagerConnectionPool.getConnection();
				preparedStatement = connection.prepareStatement(updateSQL);	
				
				preparedStatement.setString(1, ordine.getData());
				preparedStatement.setInt(2, ordine.getNumero());
				
					
				System.out.println("doUpdateOrdine: "+ preparedStatement.toString());
				preparedStatement.executeUpdate();
				
				
				ordine.setPresoInCarico(1);
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
	 * @return restituisce un ArrayList contenente tutti i McDrive presenti nel sistema
	 */
	public ArrayList<McDriveBean> mcRetrieveAll(){
		try {
			ArrayList<McDriveBean> mcdrives = new ArrayList<McDriveBean>();
			
			Connection connection = null;
			PreparedStatement preparedStatement = null;
			
			String selectSQL="SELECT * FROM indirizzo";
			
			try {
				connection = DriverManagerConnectionPool.getConnection();
				preparedStatement = connection.prepareStatement(selectSQL);
				
				
				
				System.out.println("mcRetrieveAll:" + preparedStatement.toString());
				ResultSet rs = preparedStatement.executeQuery();
				
				while(rs.next()) {
					McDriveBean mcdrive = new McDriveBean();
					
				
					mcdrive.setNome(rs.getString("nome"));
					mcdrive.setVia(rs.getString("via"));
					mcdrive.setCap(rs.getInt("cap"));
					mcdrive.setNumero(rs.getInt("numero"));
					
					
					mcdrives.add(mcdrive);
				}
			} finally {
				try {
					if(preparedStatement != null) 
						preparedStatement.close();
				} finally {
					DriverManagerConnectionPool.releaseConnection(connection);
				}
			}
			
			return mcdrives;
		} catch (Exception e) {return null;}
	}

	
	/**
	 * @param mc
	 * @return ritorna true se esiste un mcdrive con il nome passato come parametro
	 */
	public boolean controlloMc(String mc) {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		try {
			String selectSQL="SELECT * FROM mcdrive WHERE nome = ?";
			connection = DriverManagerConnectionPool.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setString(1, mc);
			ResultSet rs = preparedStatement.executeQuery();
			if(rs.next())
				return true;
			else
				return false;
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
		return false;
	}
	
	
	/**
	 * @param data
	 * @param numero
	 * @return ritorna true se esiste un ordine non ancora preso in carico avente la data e il numero 
	 * passati come paramentro, ritorna false altrimenti 
	 */
	public boolean controlloOrdine(String data, int numero) {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		try {
			String SQL = "SELECT * FROM ORDINE WHERE data = ? and numero = ? and preso_in_carico = 0";
			connection = DriverManagerConnectionPool.getConnection();
			preparedStatement = connection.prepareStatement(SQL);	
			preparedStatement.setString(1, data);
			preparedStatement.setInt(2, numero);
			ResultSet rs = preparedStatement.executeQuery();
			if(rs.next())
				return true;
			else
				return false;
				
		}catch (Exception e) {} 
		finally {
			try {
				if(preparedStatement != null) 
					preparedStatement.close();
			} catch (SQLException e) {
				e.printStackTrace();
			} 
			finally {
					try {
						DriverManagerConnectionPool.releaseConnection(connection);
					} 
					catch (SQLException e) {
						e.printStackTrace();
					}
			}
		}
		return false;
	}
	
	
	
	
	//usato solo nel testing
	public void resetOrdine(OrdineBean ordine) {
		
		try {
			Connection connection = null;
			PreparedStatement preparedStatement = null;
			
			String updateSQL = "UPDATE ordine SET " +
					"preso_in_carico = 0 WHERE data = ? AND numero = ?";
			
			try {
				connection = DriverManagerConnectionPool.getConnection();
				preparedStatement = connection.prepareStatement(updateSQL);	
				
				preparedStatement.setString(1, ordine.getData());
				preparedStatement.setInt(2, ordine.getNumero());
				
				preparedStatement.executeUpdate();
				
				ordine.setPresoInCarico(0);
				connection.commit();
				
			} finally {
				try {
					if(preparedStatement != null) 
						preparedStatement.close();
				} finally {
					DriverManagerConnectionPool.releaseConnection(connection);
				}
			}	
		} catch (Exception e) {e.printStackTrace();}
	}
}
