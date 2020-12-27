package it.unisa.control;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.bean.Cart;
import it.unisa.bean.ProductBean;
import it.unisa.dao.ProdottoDao;


@WebServlet("/ProductControl")
public class ProductControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static ProdottoDao model = new ProdottoDao();

    public ProductControl() {
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
		
		String sort = (String) request.getSession().getAttribute("sort");
		String action = request.getParameter("action");
		String tipo = (String) request.getSession().getAttribute("tipo");
	
		
		try {
			if(action != null) {
				if(action.equals("addCart")) {
					String id = request.getParameter("id");
					ProductBean bean = model.doRetrieveByKey(id);
					if(bean != null && !bean.isEmpty()) {
						cart.addItem(bean);
						request.setAttribute("message", "Product "+ bean.getNome()+" aggiunto al Carrello");
					}
				}
			}
		} catch(Exception e) {
			System.out.println("Error: "+ e.getMessage());
			request.setAttribute("error", e.getMessage());			
		}
		
		request.setAttribute("cart", cart);
		
		try {
			if((boolean) request.getSession().getAttribute("offerte")) {
				request.removeAttribute("products");
				request.setAttribute("products", model.doRetrieveAllOfferta());
			}else {
				request.removeAttribute("products");
				request.setAttribute("products", model.doRetrieveAll(tipo));
			}
		} catch(Exception e) {
			System.out.println("Error: "+ e.getMessage());
			request.setAttribute("error", e.getMessage());
		}
		if((boolean) request.getSession().getAttribute("offerte")) {
			RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/Offerte.jsp");
			dispatcher.forward(request, response);
		} else {
			RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/ElencoProdotti.jsp");
			dispatcher.forward(request, response);
		}
		
		
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
