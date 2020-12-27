package it.unisa.control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.bean.McDriveBean;
import it.unisa.bean.OrdineBean;
import it.unisa.dao.CorriereDAO;


@WebServlet("/ConsegneServlet")
public class ConsegneServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static CorriereDAO model = new CorriereDAO();
	
    public ConsegneServlet() {
        super();
  
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		String ruolo=(String)request.getSession(false).getAttribute("ruolo");
		if(ruolo!=null){
			if(!ruolo.equals("Corriere")){
				response.sendError(HttpServletResponse.SC_NOT_FOUND);
			}
		}else if(ruolo==null){
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
		}
		
		ArrayList<McDriveBean> mcdrives= (ArrayList<McDriveBean>)request.getSession().getAttribute("mcdrives");
		if(mcdrives == null) {
			
			try {	
				mcdrives = new ArrayList<McDriveBean>();
				mcdrives = model.mcRetrieveAll();
			} catch(Exception e) {
				System.out.println("Error: "+ e.getMessage());
				request.setAttribute("error", e.getMessage());			
			}
			request.getSession().setAttribute("mcdrives", mcdrives);
		}
		String index = request.getParameter("mcdrive");
		if(index != null) {			
			request.getSession().setAttribute("indexArr", index);
		}
		String accetta = request.getParameter("accetta");
		ArrayList<OrdineBean> ordini= new ArrayList<OrdineBean>();
		String accettato = request.getParameter("accettato");
		
		try {
			if(index != null) {
				int num= Integer.parseInt((String)request.getSession().getAttribute("indexArr"));
				
				ordini=model.ordineRetrieve(mcdrives.get(num).getNome());
				
				
			}
			if(accetta !=null){
				
				
				ArrayList<OrdineBean> ordiniAccettati = (ArrayList<OrdineBean>) request.getSession().getAttribute("ordiniAccettati");
				ArrayList<OrdineBean> scontr = (ArrayList<OrdineBean>) request.getSession().getAttribute("ordini");
				ordiniAccettati.add(scontr.get(Integer.parseInt(accettato)));
				request.getSession().setAttribute("ordiniAccettati", ordiniAccettati);
				
				model.doUpdateOrdine(scontr.get(Integer.parseInt(accettato)));
								
				int num= Integer.parseInt((String)request.getSession().getAttribute("indexArr"));	
				ordini=model.ordineRetrieve(mcdrives.get(num).getNome());
				request.setAttribute("consegna", true);
				
				
			}
		} catch(Exception e) {
			System.out.println("Error: "+ e.getMessage());
			request.setAttribute("error", e.getMessage());			
		}
		
		request.getSession().setAttribute("ordini", ordini);
		
		RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/ConsegneAttive.jsp");
		dispatcher.forward(request, response);
	}

}
