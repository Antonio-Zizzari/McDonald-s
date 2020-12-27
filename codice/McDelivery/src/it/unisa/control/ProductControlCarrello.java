package it.unisa.control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Random;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.bean.Cart;
import it.unisa.bean.McDriveBean;
import it.unisa.bean.ProductBean;
import it.unisa.bean.UtenteBean;
import it.unisa.dao.CorriereDAO;
import it.unisa.dao.ProdottoDao;
import it.unisa.dao.UtenteDao;


@WebServlet("/ProductControlCarrello")
public class ProductControlCarrello extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static ProdottoDao model = new ProdottoDao();
	static CorriereDAO model2 = new CorriereDAO();
	
    public ProductControlCarrello() {
        super();

    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String ruolo=(String)request.getSession(false).getAttribute("ruolo");
		if(ruolo!=null){
			if(!ruolo.equals("Utente")){
				response.sendError(HttpServletResponse.SC_NOT_FOUND);
				return;
			}
		}
		
		Cart cart = (Cart)request.getSession().getAttribute("carrello");
		if(cart == null) {
			cart = new Cart();
			request.getSession().setAttribute("carrello", cart);
		}
		
		String action = request.getParameter("action");
	
		
		try {
			if(action != null) {
				if(action.equals("clearCart")) {
					cart.deleteItems();
					request.setAttribute("message", "Cart cleaned");
				} else if(action.equals("deleteCart")) {
					String id = request.getParameter("id");
					ProductBean bean = model.doRetrieveByKey(id);
					if(bean != null && !bean.isEmpty()) {
						cart.deleteItem(bean);
						request.setAttribute("message", "Product "+ bean.getNome()+" rimosso dal Carrello");
					}
				}else if(action.equals("aggiorna")) {
					int i;
					int n=cart.getSize();
					for(i=0; i<n;i++) {
						cart.setItemCart(i, Integer.parseInt(request.getParameter("quant"+i)));
					}
				}else if(action.equals("conferma")) {
					
					try {
						Random rand = new Random();
						ArrayList<McDriveBean> mc= model2.mcRetrieveAll();
						int max=mc.size();
						int n = rand.nextInt(max);
					
						String nome=mc.get(n).getNome();
						List<ProductBean> list=cart.getItems();
						UtenteBean utente= (UtenteBean)request.getSession().getAttribute("utente");	
						
						model.addOrdine(utente.getMail(), list, nome,Integer.parseInt (request.getParameter("totale")));
						utente.setNumeroOrdini(utente.getNumeroOrdini()+1);
						request.getSession().setAttribute("utente", utente);
						cart.deleteItems();
						request.setAttribute("message", "Grazie dell'ordine! Il tuo acquisto andato a buon fine.");
						
												
						
					} catch(Exception e) {
						System.out.println("Error: "+ e.getMessage());
						request.setAttribute("error", e.getMessage());
					}
					
				}
			}
		} catch(Exception e) {
			System.out.println("Error: "+ e.getMessage());
			request.setAttribute("error", e.getMessage());			
		}
		
		request.setAttribute("cart", cart);
		
		
		RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/Carrello.jsp");
		dispatcher.forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
