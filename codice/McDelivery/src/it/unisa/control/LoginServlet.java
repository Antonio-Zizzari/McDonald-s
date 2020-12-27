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

import it.unisa.bean.OrdineBean;
import it.unisa.bean.UtenteBean;
import it.unisa.dao.UtenteDao;


@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = -6988336709533753202L;
	static UtenteDao model = new UtenteDao();

	public LoginServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String ruolo=(String)request.getSession(false).getAttribute("ruolo");
		if(ruolo!=null){			
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
			return;
		}
		
        String email = request.getParameter("email");
        String pwd = request.getParameter("pwd");
        String remember = request.getParameter("remember");
        
        if(email == null || pwd == null) {
        	request.setAttribute("error", Boolean.TRUE);
        	RequestDispatcher dispatcher = request.getRequestDispatcher("/Login.jsp");
            dispatcher.forward(request, response);
            return;
        }

        	UtenteBean utente=new UtenteBean();
			try {
				utente = model.doRetrieveByMailPwd(email);
			} catch (Exception e) {
				e.printStackTrace();
			}			
			if(utente != null) {
				if (utente.getPwd().equals(sha256.getSha(pwd))) {
					request.getSession().setAttribute("utente", utente);
				    request.getSession().setAttribute("username", utente.getNome());
				    
				    if(remember!=null) {
				    	request.getSession().setMaxInactiveInterval(60*60*10);
				    }else {
				    	request.getSession().setMaxInactiveInterval(60*60*5);
				    }
				    	
				    if(utente.getTipo()==0) {
				    	request.getSession().setAttribute("ruolo", "Utente");
				    	response.sendRedirect("Logged.jsp");
					    return;
				    } else if(utente.getTipo()==1) {
				    	request.getSession().setAttribute("ruolo", "Corriere");
				    	ArrayList<OrdineBean> ordiniAccettati= new ArrayList<OrdineBean>();
						request.getSession().setAttribute("ordiniAccettati", ordiniAccettati);
				    	response.sendRedirect("Logged.jsp");
					    return;
				    }
				    else if(utente.getTipo()==2){
				    	request.getSession().setAttribute("ruolo", "ResponsabilePersonale");
				    	response.sendRedirect("Logged.jsp");
					    return;
				    }
				    else if(utente.getTipo()==3){
				    	request.getSession().setAttribute("ruolo", "ProductManager");
				    	response.sendRedirect("Logged.jsp");
					    return;
				    }
				}
			}
			
       
        request.setAttribute("error", Boolean.TRUE);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/Login.jsp");
        dispatcher.forward(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	} 
	


}
