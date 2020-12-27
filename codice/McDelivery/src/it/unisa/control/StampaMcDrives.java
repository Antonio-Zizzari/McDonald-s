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

import it.unisa.bean.McDriveBean;
import it.unisa.dao.CorriereDAO;


@WebServlet("/StampaMcDrives")
public class StampaMcDrives extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static CorriereDAO model = new CorriereDAO();

    public StampaMcDrives() {
        super();
        
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String ruolo=(String)request.getSession().getAttribute("ruolo");
		if(ruolo!=null){
			if(!ruolo.equals("Utente")){
				response.sendError(HttpServletResponse.SC_NOT_FOUND);
				return;
			}
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
		RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/Info.jsp");
		dispatcher.forward(request, response);
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
