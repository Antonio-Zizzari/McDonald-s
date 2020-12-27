package it.unisa.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import it.unisa.bean.UtenteBean;

public class ResponsabilePersonaleDao {

	/**
	 * @return ritorna la lista contente tutti i corrieri presenti nel sistema
	 */
	public ArrayList<UtenteBean> corrieriRetrieveAll(){
		try {
			ArrayList<UtenteBean> corrieri = new ArrayList<UtenteBean>();
			
			Connection connection = null;
			PreparedStatement preparedStatement = null;
			PreparedStatement preparedStatement2 = null;
			
			String selectSQL="SELECT * FROM account WHERE tipo = 1";
			
			try {
				connection = DriverManagerConnectionPool.getConnection();
				preparedStatement = connection.prepareStatement(selectSQL);
				
				
				
				System.out.println("corrieriRetrieveAll:" + preparedStatement.toString());
				ResultSet rs = preparedStatement.executeQuery();
				
				while(rs.next()) {
					UtenteBean corriere = new UtenteBean();
					
				
					corriere.setNome(rs.getString("nome"));
					corriere.setCognome(rs.getString("cognome"));
					corriere.setMail(rs.getString("mail"));
					
					
					String selectSQL2="SELECT * FROM indirizzoAcc WHERE mail = ?";			
					
					
					preparedStatement2 = connection.prepareStatement(selectSQL2);
					preparedStatement2.setString(1, corriere.getMail());
					
					
					System.out.println("indirizzoCorriereRetrieve:" + preparedStatement2.toString());
					ResultSet rs2 = preparedStatement2.executeQuery();
					
					if(rs2.next()) {						
						corriere.setVia(rs2.getString("via"));
						corriere.setCap(rs2.getInt("cap"));
						corriere.setNumero(rs2.getInt("numero"));
					}		
					
					corrieri.add(corriere);
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
			
			return corrieri;
		} catch (Exception e) {return null;}
	}
	
	
	/**
	 * elimina il corriere che possiede la mail passata come parametro
	 * @param mail
	 * @return  ritorna true se l'eliminazione è stata effettuata con successo, 
	 * ritorna false se non è presente nessun correre con la mail passata come parametro
	 */
	public boolean corrieredoDelete(String mail){
		if(controlloCorriere(mail) == false)
			return false;
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
				
				System.out.println("corrieredoDelete: "+ preparedStatement.toString());
				preparedStatement.executeUpdate();
				
				
				preparedStatement2 = connection.prepareStatement(deleteSQL2);
				preparedStatement2.setString(1, mail);
				
				System.out.println("corriereMaildoDelete: "+ preparedStatement.toString());
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
		return true;
	}
	
	
	/**
	 * @param mail
	 * @return ritorna true se esiste un corriere con la mail passata come parametro,
	 * ritorna false altrimenti
	 */
	public boolean controlloCorriere(String mail) {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		boolean retVal=false;
		try {
			String selectSQL="SELECT * FROM account WHERE mail = ? and tipo = 1";
			connection = DriverManagerConnectionPool.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setString(1, mail);
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
}
