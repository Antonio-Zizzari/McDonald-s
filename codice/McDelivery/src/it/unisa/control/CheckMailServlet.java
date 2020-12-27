package it.unisa.control;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.bean.UtenteBean;
import it.unisa.dao.UtenteDao;

@WebServlet("/CheckMailServlet")
public class CheckMailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static UtenteDao model = new UtenteDao();

    public CheckMailServlet() {
        super();

    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String mail = request.getParameter("mail");
		
		if(mail == null) {
			
			response.sendRedirect("./Error404.jsp");
		}
		
		Boolean verifica=false;
		
		try {
			System.out.println(mail);
			
			verifica = model.maildoRetrieveByKey(mail);			
		}
		catch(Exception e) {
			
			System.out.println("Error: "+ e.getMessage());		
		}
		if(mail.equals("")|| !(mail.contains("@") && mail.contains("."))) {
			response.getWriter().write("vuoto");
		}else if(verifica) {
			response.getWriter().write("unfree");
		}else {
			response.getWriter().write("free");
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
