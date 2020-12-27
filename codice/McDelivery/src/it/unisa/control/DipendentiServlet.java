package it.unisa.control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.bean.UtenteBean;
import it.unisa.dao.ResponsabilePersonaleDao;


@WebServlet("/DipendentiServlet")
public class DipendentiServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static ResponsabilePersonaleDao model = new ResponsabilePersonaleDao();

    public DipendentiServlet() {
        super();
 
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String ruolo=(String)request.getSession(false).getAttribute("ruolo");
		if(ruolo!=null){
			if(!ruolo.equals("ResponsabilePersonale")){
				response.sendError(HttpServletResponse.SC_NOT_FOUND);
				return;
			}
		}else if(ruolo==null){
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
			return;
		}
		
		ArrayList<UtenteBean> corrieri= new ArrayList<UtenteBean>();
		
		String action = request.getParameter("action");
		String mail = request.getParameter("mail");
			
		
		try {
			if(action != null) {
				if(action.equals("delete")) {
					model.corrieredoDelete(mail);
					request.setAttribute("successo", true);
				} 
					
			}
		} catch(Exception e) {
			System.out.println("Error: "+ e.getMessage());
						
		}
		
		
		
		try {
			corrieri = model.corrieriRetrieveAll();
		} catch(Exception e) {
			System.out.println("Error: "+ e.getMessage());
				
		}
		
				
		request.setAttribute("corrieri", corrieri);
		RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/Dipendenti.jsp");
		dispatcher.forward(request, response);
	}

}
