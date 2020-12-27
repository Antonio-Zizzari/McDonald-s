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


@WebServlet("/ModificaDatiUtenteServlet")
public class ModificaDatiUtenteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static UtenteDao model = new UtenteDao();
 
    public ModificaDatiUtenteServlet() {
        super();
    
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String ruolo=(String)request.getSession(false).getAttribute("ruolo");
		if(ruolo==null){		
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
			return;
		}
		
		UtenteBean temp=(UtenteBean)request.getSession().getAttribute("utente");
		UtenteBean utente=new UtenteBean();
		
		utente.setNome(temp.getNome());
		utente.setCognome(temp.getCognome());
		utente.setVia(temp.getVia());
		utente.setCap(temp.getCap());
		utente.setNumero(temp.getNumero());
		utente.setMail(temp.getMail());
		utente.setNumeroOrdini(temp.getNumeroOrdini());
		
		String nome = request.getParameter("nome");
		String cognome = request.getParameter("cognome");
		String via = request.getParameter("via");
		String cap = request.getParameter("cap");
		String numero = request.getParameter("numero");
		String pwd = request.getParameter("pwd");
		
		String action = request.getParameter("action");
		
		try {
			
			if(action!=null) {
				if(action.equals("nome_cognome")) {
					
					if((nome != null) && (nome.matches("[A-Za-z ']{2,20}"))) {
						utente.setNome(nome);
					}
					if((cognome != null) && (cognome.matches("[A-Za-z ']{2,20}"))) {
						utente.setCognome(cognome);
					}
					model.utentedoUpdate(utente);
					
				} else if(action.equals("indirizzo")) {
					
					if((via != null) && (via.matches("[A-Za-z ']{2,50}"))) {
						utente.setVia(via);
					}
					if((cap != null) && (cap.matches("[0-9]{5}"))) {
						utente.setCap(Integer.parseInt(cap));
					}
					if((numero != null) && (numero.matches("[0-9]{1,5}"))) {
						utente.setNumero(Integer.parseInt(numero));
					}
					model.utentedoUpdate(utente);	
				}else if(action.equals("pwd")) {
					
					if((pwd != null) && (pwd.matches("(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{8,30}"))) {
						model.pwddoUpdate(utente.getMail(), sha256.getSha(pwd));
					}
					
					
				}
			}
			
			
		} catch(Exception e) {
        	
			System.out.println("Error: "+ e.getMessage());		
		}
		
		
		request.getSession().setAttribute("utente", utente);
	    request.getSession().setAttribute("username", utente.getNome());
	    
	    
	    response.sendRedirect("Logged.jsp");
	}

}
