package it.unisa.control;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.dao.UtenteDao;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

	private static final long serialVersionUID = -1747624156043800244L;
	static UtenteDao model = new UtenteDao();

    public RegisterServlet() {
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
		}
		
		String nome = request.getParameter("nome");
        String cognome = request.getParameter("cognome");
        String via = request.getParameter("via");
        String numero = request.getParameter("numero");
        String cap = request.getParameter("cap");
        String pwd1 = request.getParameter("pwd1");
        String pwd2 = request.getParameter("pwd2");
        String email = request.getParameter("email");
        
        
        if(nome == null || cognome == null || via == null || numero == null || cap == null || pwd1 == null || pwd2 == null || email == null ) {
        	 if(ruolo!=null) {
             	if(ruolo.equals("ResponsabilePersonale")) {
             		request.setAttribute("error", Boolean.TRUE);
                 	RequestDispatcher dispatcher = request.getRequestDispatcher("/Assumi.jsp");
                     dispatcher.forward(request, response);
                     return;
             	}
             } 
        	 else if(ruolo==null) {
             	request.setAttribute("error", Boolean.TRUE);
             	RequestDispatcher dispatcher = request.getRequestDispatcher("/Register.jsp");
                 dispatcher.forward(request, response);
                 return;
             }            
        }
        
        
        
        
        
        boolean controlli = false;
       
        if(!nome.matches("[A-Za-z ']{2,20}"))
        	controlli = true;
        if(!cognome.matches("[A-Za-z ']{2,20}"))
        	controlli = true;
        if(!via.matches("[A-Za-z ']{2,50}"))
        	controlli = true;
        if(!numero.matches("[0-9]{1,5}"))
        	controlli = true;
        if(!cap.matches("[0-9]{5}"))
        	controlli = true;
        if(!pwd1.matches("(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{8,30}"))
        	controlli = true;
        if(!pwd2.matches("(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{8,30}"))
        	controlli = true;
        if(!email.matches("[A-z 0-9\\.\\+_-]+@[A-z 0-9\\._-]+\\.[A-z]{1,3}"))
        	controlli = true;
        
        if(controlli) {
	       	 if(ruolo!=null) {
	            	if(ruolo.equals("ResponsabilePersonale")) {
	            		request.setAttribute("error", Boolean.TRUE);
	                	RequestDispatcher dispatcher = request.getRequestDispatcher("/Assumi.jsp");
	                    dispatcher.forward(request, response);
	                    return;
	            	}
	       	 } 
	       	 else if(ruolo==null) {
	        	request.setAttribute("error", Boolean.TRUE);
	        	RequestDispatcher dispatcher = request.getRequestDispatcher("/Register.jsp");
	            dispatcher.forward(request, response);
	            return;
	       	 }            
       }
        
        
        if(model.doRetrieveByMailPwd(email) != null) {
        	if(ruolo!=null) {
            	if(ruolo.equals("ResponsabilePersonale")) {
            		request.setAttribute("error", Boolean.TRUE);
                	RequestDispatcher dispatcher = request.getRequestDispatcher("/Assumi.jsp");
                    dispatcher.forward(request, response);
                    return;
            	}
       	 	} 
       	 	else if(ruolo==null) {
	        	request.setAttribute("error", Boolean.TRUE);
	        	RequestDispatcher dispatcher = request.getRequestDispatcher("/Register.jsp");
	            dispatcher.forward(request, response);
	            return;
       	 	} 
        }
        	
        
        
    
        
        int numero2=0;
        int cap2=0;
        
        try {
	        numero2 = Integer.parseInt(numero);
	        cap2 = Integer.parseInt(cap);
        } catch(NumberFormatException e) {
        	
        	 if(ruolo!=null) {
             	if(ruolo.equals("ResponsabilePersonale")) {
             		System.out.println("Error: "+ e.getMessage());
                	request.setAttribute("error", Boolean.TRUE);
                	RequestDispatcher dispatcher = request.getRequestDispatcher("/Assumi.jsp");
                    dispatcher.forward(request, response);
                    return;
             	}
             } else if(ruolo==null) {
            	 System.out.println("Error: "+ e.getMessage());
            	 request.setAttribute("error", Boolean.TRUE);
            	 RequestDispatcher dispatcher = request.getRequestDispatcher("/Register.jsp");
                 dispatcher.forward(request, response);
                 return;
             }
        	
        	
        }
        
        if(!pwd1.equals(pwd2)) {
        	 if(ruolo!=null) {
             	if(ruolo.equals("ResponsabilePersonale")) {
             		request.setAttribute("error", Boolean.TRUE);
                	RequestDispatcher dispatcher = request.getRequestDispatcher("/Assumi.jsp");
                    dispatcher.forward(request, response);
                    return;
             	}
             } else if(ruolo==null) {
            	 request.setAttribute("error", Boolean.TRUE);
            	 RequestDispatcher dispatcher = request.getRequestDispatcher("/Register.jsp");
                 dispatcher.forward(request, response);
                 return;
             }
        	
        	
        } 
        
        try {
        	
        	 if(ruolo!=null) {
             	if(ruolo.equals("ResponsabilePersonale")) {
             		model.doSaveUtente(email, sha256.getSha(pwd1), nome, cognome, 1, via, cap2, numero2);
             	}
             } else if(ruolo==null) {
            	 model.doSaveUtente(email, sha256.getSha(pwd1), nome, cognome, 0, via, cap2, numero2);
             }
			
        } catch(Exception e) {
        	
			System.out.println("Error: "+ e.getMessage());		
		}
        
        if(ruolo!=null) {
        	if(ruolo.equals("ResponsabilePersonale")) {
        		request.setAttribute("registrato", Boolean.TRUE);
            	RequestDispatcher dispatcher = request.getRequestDispatcher("/Assumi.jsp");
                dispatcher.forward(request, response);
        	}
        } else if(ruolo==null) {
        	request.setAttribute("registrato", Boolean.TRUE);
        	RequestDispatcher dispatcher = request.getRequestDispatcher("/Login.jsp");
            dispatcher.forward(request, response);
        }
        
	}

}
