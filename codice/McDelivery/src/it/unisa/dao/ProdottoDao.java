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


public class ProdottoDao {

	/**
	 * @param id
	 * @return ritorna il ProductBean del prodotto presente nel sistema avente come id 
	 * l'id passato come parametro, ritorna null se viene passato un id che non appartiene a 
	 * nessun prodotto presente nel sistema
	 */
	public ProductBean doRetrieveByKey(String id) {
		if(controlloProdotto(Integer.parseInt(id)) == false)
			return null;
		try {
			Connection connection = null;
			PreparedStatement preparedStatement = null;

			ProductBean bean = new ProductBean();
			
			String selectSQL = "SELECT * FROM prodotto WHERE id = ?";
			
			try {
				connection = DriverManagerConnectionPool.getConnection();
				preparedStatement = connection.prepareStatement(selectSQL);
				preparedStatement.setInt(1, Integer.parseInt(id));
				
				System.out.println("doRetrieveByKey: "+ preparedStatement.toString());
				ResultSet rs = preparedStatement.executeQuery();
				
				while(rs.next()) {
					
					bean.setId(rs.getInt("id"));
					bean.setNome(rs.getString("nome"));
					bean.setPrezzo(rs.getInt("prezzo"));
					bean.setTipo(rs.getInt("tipo"));
					bean.setSconto(rs.getInt("sconto"));
					bean.setPhoto(rs.getString("photo"));
									
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
			
			return bean;
		} catch (Exception e) {return null;}
	}

	
	/**
	 * @return ritorna la collection di ProductBean avente i prodotti in offerta, cioè i prodotti 
	 * che hanno l'attributo sconto > 0
	 */
	public Collection<ProductBean> doRetrieveAllOfferta() {
		try {
			Connection connection = null;
			PreparedStatement preparedStatement = null;
			
			Collection<ProductBean> products = new LinkedList<ProductBean>();
			String selectSQL="";
			
			selectSQL += "SELECT * FROM prodotto WHERE NOT sconto = 0";
			
			try {
				connection = DriverManagerConnectionPool.getConnection();
				preparedStatement = connection.prepareStatement(selectSQL);
							
				
				System.out.println("doRetrieveAll:" + preparedStatement.toString());
				ResultSet rs = preparedStatement.executeQuery();
				
				while(rs.next()) {
					ProductBean bean = new ProductBean();
					
					bean.setId(rs.getInt("id"));
					bean.setNome(rs.getString("nome"));
					bean.setPrezzo(rs.getInt("prezzo"));
					bean.setTipo(rs.getInt("tipo"));
					bean.setSconto(rs.getInt("sconto"));
					bean.setPhoto(rs.getString("photo"));
					
					
					
					products.add(bean);
				}
			} finally {
				try {
					if(preparedStatement != null) 
						preparedStatement.close();
				} finally {
					DriverManagerConnectionPool.releaseConnection(connection);
				}
			}
			
			return products;
		} catch (Exception e) {return null;}
	}
	
	
	/**
	 * @param mail
	 * @param lista
	 * @param mcdrive
	 * @param totale
	 * @return inserisce un ordine nel sistema, ritorna true se l'ordine è stato inserito con successo,
	 * ritorna false se la mail passata come parametro non è associata a nessun utente 
	 * presente nel sistema oppure ritorna false se il nome del mcdrive passato come parametro 
	 * non è presente nel sistema oppure ritorna false se la lista dei ProductBean passati come 
	 * parametro è vuota, infine ritorna false se il totale del carrello passato come parametro è 
	 * <= 0
	 */
	public boolean addOrdine(String mail,List<ProductBean> lista,String mcdrive,int totale){
		UtenteDao ud = new UtenteDao();
		CorriereDAO cd = new CorriereDAO();
		if(ud.doRetrieveByMailPwd(mail) == null)
			return false;
		if(cd.controlloMc(mcdrive) == false)
			return false;
		if(lista.size() == 0)
			return false;
		if(totale <= 0)
			return false;
		boolean retVal = false;
		try {
			int numero=1;
			
			LocalDate date = LocalDate.now();
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			String data =date.format(formatter);
			
			Connection connection = null;
			PreparedStatement preparedStatement = null;
			
			try {
				String selectSQL1 = "SELECT MAX(numero) as num FROM ordine WHERE data= ? ";
			
				connection = DriverManagerConnectionPool.getConnection();
				preparedStatement = connection.prepareStatement(selectSQL1);
				
				preparedStatement.setString(1, data);
				

				System.out.println("doRetrieve:" + preparedStatement.toString());
				ResultSet rs = preparedStatement.executeQuery();
				
				while(rs.next()) {
									
					numero=rs.getInt("num")+1;
					
				}
				
				String updateSQL = "UPDATE account SET " +
						"num_ordini = num_ordini+1 WHERE mail = ?";
				
				preparedStatement = connection.prepareStatement(updateSQL);	
				
				preparedStatement.setString(1, mail);
				
				
				System.out.println("doUpdate: "+ preparedStatement.toString());
				preparedStatement.executeUpdate();
				
				String insertSQL2 = "INSERT INTO ordine" +
						" (data, numero, totale, mail, mc_nome, preso_in_carico) VALUES (?, ?, ?, ?, ?, ?)";

				preparedStatement = connection.prepareStatement(insertSQL2);			
					
				preparedStatement.setString(1, data);
				preparedStatement.setInt(2, numero);
				preparedStatement.setInt(3, totale);
				preparedStatement.setString(4, mail);
				preparedStatement.setString(5, mcdrive);
				preparedStatement.setInt(6, 0);
				
				System.out.println("doSave: "+ preparedStatement.toString());
				preparedStatement.executeUpdate();
					
				for(ProductBean it: lista) {
					
					String insertSQL3 = "INSERT INTO possiede" +
							" (data, numero, id, quantita) VALUES (?, ?, ?, ?)";

					preparedStatement = connection.prepareStatement(insertSQL3);			
						
					preparedStatement.setString(1, data);
					preparedStatement.setInt(2, numero);
					preparedStatement.setInt(3, it.getId());
					preparedStatement.setInt(4, it.getQuantita());
					
					System.out.println("doSave: "+ preparedStatement.toString());
					preparedStatement.executeUpdate();			
				}
				
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
		} catch (Exception e) {retVal = false;e.printStackTrace();}
		return retVal;
	}
	
	
	/**
	 * @param tipo
	 * @return ritorna la collection contenente tutti i prodotti del tipo passato come parametro
	 */
	public Collection<ProductBean> doRetrieveAll(String tipo)  {
		try {
			Connection connection = null;
			PreparedStatement preparedStatement = null;
			
			Collection<ProductBean> products = new LinkedList<ProductBean>();
			String selectSQL="";
			if(tipo != null) {
				selectSQL += "SELECT * FROM prodotto WHERE tipo = ?";
			}else {
				selectSQL += "SELECT * FROM prodotto";
			}
			
			try {
				connection = DriverManagerConnectionPool.getConnection();
				preparedStatement = connection.prepareStatement(selectSQL);
				if(tipo != null) {
					preparedStatement.setInt(1, Integer.parseInt(tipo));
				}
				
				
				System.out.println("doRetrieveAll:" + preparedStatement.toString());
				ResultSet rs = preparedStatement.executeQuery();
				
				while(rs.next()) {
					ProductBean bean = new ProductBean();
					
					bean.setId(rs.getInt("id"));
					bean.setNome(rs.getString("nome"));
					bean.setPrezzo(rs.getInt("prezzo"));
					bean.setTipo(rs.getInt("tipo"));
					bean.setSconto(rs.getInt("sconto"));
					bean.setPhoto(rs.getString("photo"));
					
					
					
					products.add(bean);
				}
			} finally {
				try {
					if(preparedStatement != null) 
						preparedStatement.close();
				} finally {
					DriverManagerConnectionPool.releaseConnection(connection);
				}
			}
			
			return products;
		} catch (Exception e) {return null;}
	}

	
	/**
	 * @param id
	 * @return ritorna true se è presente nel sistema un prodotto avente l'id passato come 
	 * parametro, ritorna false altrimenti
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
	
}
