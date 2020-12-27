package it.unisa.control;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import it.unisa.bean.Cart;
import it.unisa.bean.ProductBean;
import it.unisa.dao.ProdottoDao;
import it.unisa.dao.ProductManagerDao;


@WebServlet("/ProductControlManager")
@MultipartConfig(maxFileSize = 1024 * 1024 * 10)//10MB

public class ProductControlManager extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static ProductManagerDao model = new ProductManagerDao();
	static ProdottoDao model2 = new ProdottoDao();
	
    public ProductControlManager() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		if(action!=null) {
			if(action.equals("insert") || action.equals("update")) {
				response.sendRedirect("ModificaProdTipo.jsp");
				return;
			}
		}
		doPost(request, response);
		

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String ruolo=(String)request.getSession(false).getAttribute("ruolo");
		if(ruolo!=null){
			if(!ruolo.equals("ProductManager")){
				response.sendError(HttpServletResponse.SC_NOT_FOUND);
			}
		}else if(ruolo==null){
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
		}
		
		
		String pagina= "/"+request.getParameter("pagina")+".jsp";
		
		String sort = (String) request.getSession().getAttribute("sort");
		String action = request.getParameter("action");
		String tipo = (String) request.getSession().getAttribute("tipo");
		String sconto= request.getParameter("sconto");
		String id = request.getParameter("id");
		
		try {
			if(action != null) {
				
				if(action.equals("sconto")) {
					pagina= "/ElencoSetOfferte.jsp";
					if(sconto!=null) {						
						boolean controlli = false;
						if(!sconto.matches("[0-9]{1,2}"))
							controlli = true;
						
						if((!controlli) && (Integer.parseInt(sconto)>=0 && Integer.parseInt(sconto)<100)) {
							model.scontidoUpdate(Integer.parseInt(id), Integer.parseInt(sconto));	
							request.setAttribute("message", "Sconto aggiornato correttamente");	
						}							
						else {
							request.setAttribute("message", "Sconto inserito non valido!");
							request.setAttribute("colore", "red");
						}
					}		
										
				} else if(action.equals("insert")) {	
					pagina= "/ElencoModProd.jsp";
					boolean controlli = false;
					if(!(request.getParameter("nome").matches("[A-Za-z ]{2,40}")))
						controlli = true;
					if(!(request.getParameter("prezzo").matches("[0-9]{1,3}")))
						controlli = true;
					
					
					if((!controlli) && (Integer.parseInt(request.getParameter("prezzo")) > 0)){
						ProductBean bean= new ProductBean();
						bean.setNome(request.getParameter("nome"));
						bean.setPrezzo(Integer.parseInt(request.getParameter("prezzo")));
						bean.setTipo(Integer.parseInt(tipo));
						bean.setPhoto("");
						
						Part filePart = request.getPart("photo2"); // Retrieves <input type="file" name="photo">
					    String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); // MSIE fix.
					    
					    //C:\Users\Orcolus\Desktop\TSW\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\McDelivery\
					    if(!fileName.equals("")) {
					    	
					    	String directory=request.getServletContext().getRealPath("");
					    	
					    	
					    	String urlDB="";
						    
						    if(tipo.equals("1")) {
						    	
						    	urlDB="img/prodotti/bevande";
						    	directory+="img\\prodotti\\bevande";
						    	
						    }else if(tipo.equals("2")) {
						    	
						    	urlDB="img/prodotti/gelati_e_dessert";
						    	directory+="img\\prodotti\\gelati_e_dessert";
						    	
						    }else if(tipo.equals("3")) {
						    	
						    	urlDB="img/prodotti/insalate";
						    	directory+="img\\prodotti\\insalate";
						    	
						    }else if(tipo.equals("4")) {
						    	
						    	urlDB="img/prodotti/menu";
						    	directory+="img\\prodotti\\menu";
						    	
						    }else if(tipo.equals("5")) {
						    	
						    	urlDB="img/prodotti/panini";
						    	directory+="img\\prodotti\\panini";
						    	
						    }else if(tipo.equals("6")) {
						    	
						    	urlDB="img/prodotti/sfiziosita";
						    	directory+="img\\prodotti\\sfiziosita";
						    	
						    }
					    	//System.out.println(directory);
						    
						    File fileDelete = new File(directory+"\\"+fileName);
						    fileDelete.delete();
						    
						    File uploads = new File(directory);
						    
						    File file = new File(uploads, fileName);
		
						    try (InputStream fileContent = filePart.getInputStream()) {
						        Files.copy(fileContent, file.toPath());
						    }
						    
						    		    
						    
						    bean.setPhoto(urlDB+"/"+fileName);
						    
					    }			
						
						model.doSave(bean);
						
						request.setAttribute("message", bean.getNome()+" inserito correttamente!");	
					    
					}
					else {
						request.setAttribute("message", "prezzo o nome non valido!");
						request.setAttribute("colore", "red");
					}
					
					
					
				} else if(action.equals("delete")) {
					
					model.doDelete(Integer.parseInt(id));
					request.setAttribute("message", "Prodotto eliminato correttamente");	
				    pagina= "/ElencoModProd.jsp";
				    
				    String directory=request.getServletContext().getRealPath("");
			    	
			    			    
				    if(tipo.equals("1")) {				    	
				    	
				    	directory+="img\\prodotti\\bevande";
				    	
				    }else if(tipo.equals("2")) {
				    	
				    	
				    	directory+="img\\prodotti\\gelati_e_dessert";
				    	
				    }else if(tipo.equals("3")) {
				    	
				    	
				    	directory+="img\\prodotti\\insalate";
				    	
				    }else if(tipo.equals("4")) {
				    	
				    	
				    	directory+="img\\prodotti\\menu";
				    	
				    }else if(tipo.equals("5")) {
				    	
				    	
				    	directory+="img\\prodotti\\panini";
				    	
				    }else if(tipo.equals("6")) {
				    	
				    	
				    	directory+="img\\prodotti\\sfiziosita";				    	
				    }
				    String fileName=request.getParameter("fileName");
				    int i=fileName.length()-1;
				    
				    while(i!=0) {
				    	if(fileName.charAt(i)=='/') {
				    		break;
				    	}
				    	i--;
				    }
				    System.out.println(fileName);
				    fileName=fileName.substring(i+1);
				    File fileDelete = new File(directory+"\\"+fileName);
				    fileDelete.delete();
				    System.out.println(directory+"\\"+fileName);
				    
					
				} else if(action.equals("update")) {
					boolean controlli = false;
					if(!(request.getParameter("nome").matches("[A-Za-z ]{2,40}")))
						controlli = true;
					if(!(request.getParameter("prezzo").matches("[0-9]{1,3}")))
						controlli = true;
					
					
					
					pagina= "/ElencoModProd.jsp";
					if((!controlli) && (Integer.parseInt(request.getParameter("prezzo")) > 0)) {
						String nome = request.getParameter("nome");
						String prezzo = request.getParameter("prezzo");					
						
						
					    Part filePart = request.getPart("photo"); // Retrieves <input type="file" name="photo">
					    String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); // MSIE fix.
					    
					    //C:\Users\Orcolus\Desktop\TSW\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\McDelivery\
					    if(!fileName.equals("")) {
					    	
					    	String directory=request.getServletContext().getRealPath("");
					    	
					    	
					    	String urlDB="";
						    
						    if(tipo.equals("1")) {
						    	
						    	urlDB="img/prodotti/bevande";
						    	directory+="img\\prodotti\\bevande";
						    	
						    }else if(tipo.equals("2")) {
						    	
						    	urlDB="img/prodotti/gelati_e_dessert";
						    	directory+="img\\prodotti\\gelati_e_dessert";
						    	
						    }else if(tipo.equals("3")) {
						    	
						    	urlDB="img/prodotti/insalate";
						    	directory+="img\\prodotti\\insalate";
						    	
						    }else if(tipo.equals("4")) {
						    	
						    	urlDB="img/prodotti/menu";
						    	directory+="img\\prodotti\\menu";
						    	
						    }else if(tipo.equals("5")) {
						    	
						    	urlDB="img/prodotti/panini";
						    	directory+="img\\prodotti\\panini";
						    	
						    }else if(tipo.equals("6")) {
						    	
						    	urlDB="img/prodotti/sfiziosita";
						    	directory+="img\\prodotti\\sfiziosita";
						    	
						    }
					    	
					    	
					    	//System.out.println(directory);
						    File fileDelete = new File(directory+"\\"+fileName);
						    fileDelete.delete();
					        
						    
						    File uploads = new File(directory);
						    
						    File file = new File(uploads, fileName);
		
						    try (InputStream fileContent = filePart.getInputStream()) {
						        Files.copy(fileContent, file.toPath());
						    }
						    
						    
						    
						    
						    
						    model.doUpdate(Integer.parseInt(id),nome,Integer.parseInt(prezzo),urlDB+"/"+fileName);
					    }else {
					    	model.doUpdate(Integer.parseInt(id),nome,Integer.parseInt(prezzo),null);
					    }
					    
					    
					    request.setAttribute("message", nome+" aggiornato correttamente!");	
					}
					else {
						request.setAttribute("message", "prezzo o nome non valido!");
						request.setAttribute("colore", "red");
					}
				    
				}
			}
		} catch(Exception e) {
			System.out.println("Error: "+ e.getMessage());
			request.setAttribute("error", e.getMessage());			
		}
		
		
		
		try {
			
			request.removeAttribute("products");
			request.setAttribute("products", model2.doRetrieveAll(tipo));
			
		} catch(Exception e) {
			System.out.println("Error: "+ e.getMessage());
			request.setAttribute("error", e.getMessage());
		}
		
		
		RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher(pagina);
		dispatcher.forward(request, response);
	}

}





