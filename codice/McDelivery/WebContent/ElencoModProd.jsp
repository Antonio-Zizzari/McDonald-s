<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="UTF-8" import="java.util.*,it.unisa.bean.ProductBean,it.unisa.bean.Cart"%>
    
<%

	String ruolo=(String)request.getSession().getAttribute("ruolo");
	if(ruolo!=null){
		if(!ruolo.equals("ProductManager")){
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
		}
	}else if(ruolo==null){
		response.sendError(HttpServletResponse.SC_NOT_FOUND);
	}

%> 
 <%
 	
 
 	Collection<?> products = (Collection<?>) request.getAttribute("products");
 
 	String error = (String)request.getAttribute("error");
 	
 	if(products == null && error == null) {
 		response.sendRedirect(response.encodeRedirectURL("./ProductControlManager?pagina=ElencoModProd"));
 		return;
 	}
 	
 	
 	
 %>   
<!DOCTYPE html>
<html>
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
    <link rel="stylesheet" href="style.css"/>
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,700&display=swap"
      rel="stylesheet" />

  </head>

  <body>    
    <%@ include file="MenuProductManager.jsp"%>

    <main>
      <strong><h1>Prodotti</h1></strong>
      <br>
      <a href="" data-toggle="modal" data-target="#exampleModalCenter" class="btn btn-success btn-lg text-center float-left">+ Inserisci Nuovo Prodotto</a>
			<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
			  <div class="modal-dialog modal-dialog-centered" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" id="exampleModalLongTitle">Aggiungi Prodotto</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
			      </div>
			      <form class="form-signin" action="<%=response.encodeURL("ProductControlManager")%>" method="post" enctype="multipart/form-data">
			      	<input type="text" name="action" value="insert" style='display: none;'>
			     	 <div class="modal-body">
			      	
					      <div class="form-group">
						      <label for="validationDefault01">Nome</label>
										  <input type="text" class="form-control" id="validationDefault01" name="nome" required pattern="[A-Za-z ]{2,40}" title="il nome del prodotto può avere da 2 a 40 caratteri">										   
						  </div>
						  
						  <div class="form-group">
						      <label for="validationDefault01">Prezzo</label>
										  <input type="text" class="form-control" id="validationDefault01" name="prezzo" required pattern="[0-9]{1,3}" title="il prezzo del prodotto può variare da 1$ a 999$">										   
						  </div>
						  
						  <div class="form-group">
						      <label >Foto</label>
						       
								<input type="file" accept="image/png, image/jpeg" id="myfile" name="photo2">
								<br><br>
								<input type="reset" value="Reset Image">										   
						  </div>
						 
			  	   </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-secondary" data-dismiss="modal">Chiudi</button>
			        <button type="submit" class="btn btn-primary">Salva</button>
			      </div>
			      </form>
			    </div>
			  </div>
			</div>
      
      <br>
      <br>
      
      
	<%
	String message = (String)request.getAttribute("message");
	String colore = (String)request.getAttribute("colore");
	if(message != null && !message.equals("")) {
		if(colore != null && !colore.equals("")){
%>
			<p style="color: red;"><%=message %></p>
	<%
		}else{%>
			
			<p style="color: green;"><%=message %></p>
	<%	}
	} %>



      <div id="Estetica" class="row row-cols-1 row-cols-md-6">
      
		<%
			if(products != null && products.size() > 0) {
				
				Iterator<?> it  = products.iterator();
				int i=0;
				while(it.hasNext()) {
					ProductBean bean = (ProductBean)it.next();	
		%>
			<div class="col mb-4">
	          <div class="h-100">
	            <img src="<%=bean.getPhoto()%>" class="card-img-top" alt="No Image">
	            <div class="card-body ">
	              <h5 class="card-title text-center"><%=bean.getNome()%></h5>
	              <center >
	              <%
	              if(bean.getSconto()>0) {%>
	              	
	              		<del><%=bean.getPrezzo()%>$</del> <span style="color: red;">-<%=bean.getSconto()%>% </span>
						<%int x=(bean.getPrezzo()*bean.getSconto())/100;
						
						bean.setPrezzo(bean.getPrezzo()-x);
						%> <%=bean.getPrezzo()%>$
					<%}else{
	              %>
	                <%=bean.getPrezzo()%>$
	                <%} %>
	              </center>
	              <br>
	              
		      		<a href="" data-toggle="modal" data-target="#exampleModalCenter<%=i%>" class="btn btn-warning btn-lg text-center btn-block mb-1">Modifica</a>
				          <div class="modal fade" id="exampleModalCenter<%=i%>" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
							  <div class="modal-dialog modal-dialog-centered" role="document">
							    <div class="modal-content">
							      <div class="modal-header">
							        <h5 class="modal-title" id="exampleModalLongTitle">Modifica Prodotto</h5>
							        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
							          <span aria-hidden="true">&times;</span>
							        </button>
							      </div>
							      <form class="form-signin" action="<%=response.encodeURL("ProductControlManager")%>" method="post" enctype="multipart/form-data">
							      	<input type="text" name="action" value="update" style='display: none;'>
							      	<input type="text" name="id" value="<%=bean.getId()%>" style='display: none;'>
							     	 <div class="modal-body">
							      	
									      <div class="form-group">
										      <label for="validationDefault01">Nome</label>
		    								  <input type="text" class="form-control" id="validationDefault01" name="nome" required value="<%=bean.getNome()%>" pattern="[A-Za-z ]{2,40}" title="il nome del prodotto può avere da 2 a 40 caratteri">										   
										  </div>
										  
										  <div class="form-group">
										      <label for="validationDefault01">Prezzo</label>
		    								  <input type="text" class="form-control" id="validationDefault01" name="prezzo" required value="<%=bean.getPrezzo()%>" pattern="[0-9]{1,3}" title="il prezzo del prodotto può variare da 1$ a 999$">										   
										  </div>
										  
										  <div class="form-group">
										      <label >Foto attuale</label>
										      <img width="150px" alt="..." src="<%=bean.getPhoto()%>">
		    								  
  												<input type="file" accept="image/png, image/jpeg" id="myfile" name="photo">
  												<br><br>
  												<input type="reset" value="Reset Image">										   
										  </div>
										 
							  	   </div>
							      <div class="modal-footer">
							        <button type="button" class="btn btn-secondary" data-dismiss="modal">Chiudi</button>
							        <button type="submit" class="btn btn-primary">Salva</button>
							      </div>
							      </form>
							    </div>
							  </div>
							</div>
					<a href="<%=response.encodeURL("ProductControlManager?action=delete&id="+bean.getId())+"&fileName="+bean.getPhoto()%>" class="btn btn-danger btn-lg text-center btn-block">Elimina</a>
	              <br>
	            </div>
	          </div>
	        </div>
	<% 		i++;} 
	 	} else { %>
		
		    <center>Non ci sono prodotti disponibili</center>	
	<% } %>
      
      
      
        
		
      </div>

      <hr>
      <footer>Copyright © 2020 McDonald's. All rights reserved</footer>
    </main>
    <script>
	    function myFunction1(x) {
			  if (x.matches) { // If media query matches
					document.getElementById('Estetica').className = 'row row-cols-1 row-cols-md-6';
			  }
	    }
		
		function myFunction2(x) {
			  if (x.matches) { // If media query matches
					document.getElementById('Estetica').className = 'row row-cols-1 row-cols-md-4';
			  }
		}
		
		function myFunction3(x) {
			  if (x.matches) { // If media query matches
					document.getElementById('Estetica').className = 'row row-cols-1 row-cols-md-3';
			  }
		
		}
		var x = window.matchMedia("(min-width: 1250px)");
		var y = window.matchMedia("(max-width: 1250px)");
		var z = window.matchMedia("(max-width: 900px)");
		
		myFunction1(x);
		x.addListener(myFunction1);
		
		myFunction2(y);
		y.addListener(myFunction2);
		
		myFunction3(z);
		z.addListener(myFunction3);
		
	</script>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
  </body>
</html>
