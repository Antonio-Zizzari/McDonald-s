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
 	
 
 
 	
 
 	Cart cart = (Cart)request.getAttribute("cart");
	
 	if(cart == null) {
 		response.sendRedirect(response.encodeRedirectURL("./ProductControlCarrello"));
 		return;
 	}	
 	
 	
 	
 	int totale=0;
 %>   
<!DOCTYPE html>
<html>
  <head>

   
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Carrello</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
	
    <link rel="stylesheet" href="cart.css" media="screen" title="no title" charset="utf-8">
    <script src="https://code.jquery.com/jquery-2.2.4.js" charset="utf-8"></script>
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
	 <link rel="stylesheet" href="style.css"/>
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,700&display=swap"
      rel="stylesheet"
    />
  </head>

  <body>
    <%@ include file="MenuBase.jsp"%>

    <main>
    
		    <%
			List<ProductBean> prodcart = cart.getItems();
		
			if(prodcart.size() > 0) {
			%>
			
			
				
				
		<%  } %>
			<div class="shopping-cart">
			<%
			if(prodcart.size() > 0) {
			%>
			
			<form  id="my_form" action="<%=response.encodeURL("ProductControlCarrello")%>" method="post">
				<a class="btn btn-warning mb-1" href="<%=response.encodeURL("ProductControlCarrello?action=clearCart")%>">Pulisci Carrello		</a>
				<input type="hidden" name="action" value="aggiorna">
				<a class="btn btn-warning float-right mb-1 " href="javascript:{}" onclick="document.getElementById('my_form').submit(); return false;">Aggiorna Carrello</a>
				<br>	
				
				
		<%  } %>
			
			
		      <!-- Title -->
		      <div class="title">
		        Carrello
		        
	      </div>
			<%
				if(prodcart.size() > 0) {
					int i=0;%>
					
					<%for(ProductBean prod: prodcart) {
						
						totale += (prod.getPrezzo()-(prod.getPrezzo()*prod.getSconto()/100))*prod.getQuantita();
			%>
					<!-- Product -->
					
				      <div class="item">
				        <a href="<%=response.encodeURL("ProductControlCarrello?action=deleteCart&id=" + prod.getId())%>"><div class="buttons">
				          <span class="delete-btn"></span></a>
				        </div>
				
				        <div class="image">
				          <img width=70% src="<%=prod.getPhoto()%>" alt="No image">
				        </div>
				
				        <div class="description">
				          <span><%=prod.getNome()%></span>
				          <%
				          	if(prod.getTipo()==1){
				          %>
				          	<span>bevanda</span>
				          	<%} %>
				          <%
				          	if(prod.getTipo()==2){
				          %>
				          	<span>gelato/dessert</span>
				          	<%} %>
				          	
				          	<%
				          	if(prod.getTipo()==3){
				          %>
				          	<span>insalata</span>
				          	<%} %>
				          <%
				          	if(prod.getTipo()==4){
				          %>
				          	<span>menu</span>
				          	<%} %>
				          <%
				          	if(prod.getTipo()==5){
				          %>
				          	<span>panino</span>
				          	<%} %>
				          	
				          <%
				          	if(prod.getTipo()==6){
				          %>
				          	<span>sfiziosità</span>
				          	<%} %>
				          	
				        </div>
				
				        <div class="quantity">
				          <button class="minus-btn" type="button" name="button">
				            <img src="minus.svg" alt="">
				           </button>
				          <input type="text" name="quant<%=i%>" value="<%=prod.getQuantita()%>">
				          <button class="plus-btn" type="button" name="button">
				            <img src="plus.svg" alt="">
				          
				          
				          </button>
				        </div>
				
				        <div class="total-price"><%=(prod.getPrezzo()-(prod.getPrezzo()*prod.getSconto()/100))*prod.getQuantita()%> $</div>
				      </div>
			<% 		i++;}%>
					<h3 style="text-align:right; padding:10px">Totale=<%=totale%> $</h3>
					<a class="btn btn-warning btn-lg mb-1 btn-block" href="<%=response.encodeURL("ProductControlCarrello?action=conferma&totale="+totale)%>">
						Conferma ordine
					</a>
					</form>
				
			<%	} else {
			%>
				<div class="title"><center>NON CI SONO PRODOTTI</center>   </div>   
			<%
				}
			%>      
      </div>
	<%
					String message = (String)request.getAttribute("message");
					if(message != null && !message.equals("")) {
				%>
					<center><h5 style="color: green;"><%=message %></h5></center>
					<%} %>
    <script type="text/javascript">
      $('.minus-btn').on('click', function(e) {
    		e.preventDefault();
    		var $this = $(this);
    		var $input = $this.closest('div').find('input');
    		var value = parseInt($input.val());

    		if (value > 1) {
    			value = value - 1;
    		}

        $input.val(value);

    	});

    	$('.plus-btn').on('click', function(e) {
    		e.preventDefault();
    		var $this = $(this);
    		var $input = $this.closest('div').find('input');
    		var value = parseInt($input.val());

    		if (value < 100) {
      		value = value + 1;
    		} else {
    			value =100;
    		}

    		$input.val(value);
    	});
    </script>
    <br>
    <br>
    <hr>
    <footer>Copyright © 2020 McDonald's. All rights reserved</footer>
   </main>
    
    </body>
</html>
    