package it.unisa.control;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ProdottiOutputServlet")
public class ProdottiOutputServlet extends HttpServlet {
      
	private static final long serialVersionUID = 8460606920861196242L;

	public ProdottiOutputServlet() {
        super();

    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String ruolo=(String)request.getSession().getAttribute("ruolo");
		if(ruolo!=null){
			if(!(ruolo.equals("ProductManager") || ruolo.equals("Utente"))){
				response.sendError(HttpServletResponse.SC_NOT_FOUND);
				return;
			}
		}
		
		
		if(ruolo!=null) {
			if(ruolo.equals("ProductManager")) {
				if(request.getParameter("modifica")==null) {
					request.getSession(true).setAttribute("tipo", request.getParameter("prodotto"));
					RequestDispatcher dispatcher = request.getRequestDispatcher("/ElencoSetOfferte.jsp");
			        dispatcher.forward(request, response);
					return;
				} else {
					request.getSession(true).setAttribute("tipo", request.getParameter("prodotto"));
					RequestDispatcher dispatcher = request.getRequestDispatcher("/ElencoModProd.jsp");
			        dispatcher.forward(request, response);
					return;
				}
			}
			
		}
		
		request.getSession(true).setAttribute("tipo", request.getParameter("prodotto"));
		RequestDispatcher dispatcher = request.getRequestDispatcher("/ElencoProdotti.jsp");
        dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		doGet(request, response);
	}

}
