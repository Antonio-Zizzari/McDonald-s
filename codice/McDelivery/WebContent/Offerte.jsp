<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="UTF-8" import="java.util.*,it.unisa.bean.ProductBean,it.unisa.bean.Cart"%>
<%

	String ruolo=(String)request.getSession().getAttribute("ruolo");
	if(ruolo!=null){
		if(!ruolo.equals("Utente")){
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
		}
	}

%> 
 <%
 	request.getSession().setAttribute("offerte", true);	
 
 	Collection<?> products = (Collection<?>) request.getAttribute("products");
 
 	String error = (String)request.getAttribute("error");
 	
 	if(products == null && error == null) {
 		response.sendRedirect(response.encodeRedirectURL("./ProductControl"));
 		return;
 	}
 	Cart cart = (Cart)request.getAttribute("cart");
	
 	if(cart == null) {
 		response.sendRedirect(response.encodeRedirectURL("./ProductControl"));
 		return;
 	}	
 	
 	ProductBean product = (ProductBean) request.getAttribute("product");
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
    <%@ include file="MenuBase.jsp"%>

    <main>
      <strong><h1>Offerte Attive</h1></strong>
      <br>
	<%
	String message = (String)request.getAttribute("message");
	if(message != null && !message.equals("")) {
%>
	<p style="color: green;"><%=message %></p>
	<%} %>

      <div id="Estetica" class="row row-cols-1 row-cols-md-6">
      
		<%
			if(products != null && products.size() > 0) {
				
				Iterator<?> it  = products.iterator();
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
	              <%
		              if(session.getAttribute("username")==null){%>
		              	<a href="#" class="btn btn-warning btn-lg text-center btn-block" data-toggle="modal" data-target=".bd-example-modal-sm">Aggiungi al carrello</a>
				          <div class="modal fade bd-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" style="display: none;" aria-hidden="true">
				            <div class="modal-dialog modal-sm">
				              <div class="modal-content">
				                <div class="modal-header">
				                  <h4 class="modal-title" id="mySmallModalLabel">Attenzione!</h4>
				                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				                    <span aria-hidden="true">×</span>
				                  </button>
				                </div>
				                <div class="modal-body">
				                  Effettua il login per poter ordinare i prodotti
				                </div>
				              </div>
				            </div>
				          </div>
		              	
		      		<%} else {%>
		      			<a href="<%=response.encodeURL("ProductControl?action=addCart&id=" + bean.getId())%>" class="btn btn-warning btn-lg text-center btn-block">Aggiungi al carrello</a>
		      		<%}
	              %>
	              <br>
	            </div>
	          </div>
	        </div>
	<% 		} 
	 	} else { %>
			<center>Non ci sono offerte disponibili</center>		   	
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
