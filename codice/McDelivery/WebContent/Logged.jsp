<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="UTF-8" import="java.util.*,it.unisa.bean.UtenteBean"%>
    
<%
	if(session.getAttribute("username")==null){
		response.sendError(HttpServletResponse.SC_NOT_FOUND);
	}

	UtenteBean utente= (UtenteBean)request.getSession().getAttribute("utente");
%>
<!DOCTYPE html>
<html>
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
    <link rel="stylesheet" href="style.css"/>
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,700&display=swap" rel="stylesheet"/>
	<link rel="stylesheet" href="dati.css"/>
  </head>
  <body>
  <style>
			
			
			
			
			/* Mostra un messaggio quando l'utente ci clicca sopra''*/
			#message {
			  display:none;
			  background: #f1f1f1;
			  color: #000;
			  position: relative;
			  padding: 20px;
			  margin-top: 10px;
			  margin-left: 10px;
			}
			
			#message p {
			  padding: 10px 35px;
			  font-size: 14px;
			}
			
			#message2 {
			  display:none;
			  background: #f1f1f1;
			  color: #000;
			  position: relative;
			  padding: 20px;
			  margin-top: 10px;
			}
			
			#message2 p {
			  padding: 10px 35px;
			  font-size: 14px;
			}
			
			/* Se l'input è corretto, il testo diventa verde' */
			.valid {
			  color: green;
			}
			
			.valid:before {
			  position: relative;
			  left: -35px;
			  content: "v";
			}
			
			/* Se l'input è scorretto, il testo diventa rosso */
			.invalid {
			  color: red;
			}
			
			.invalid:before {
			  position: relative;
			  left: -35px;
			  content: "x";
			}
			</style>
  <% if(session.getAttribute("ruolo").equals("ResponsabilePersonale")){ %>
 	   <%@ include file="MenuResponsabilePersonale.jsp"%>
   <%} else if(session.getAttribute("ruolo").equals("ProductManager")){ %>
 	   <%@ include file="MenuProductManager.jsp"%>
  <%} else if(session.getAttribute("ruolo").equals("Corriere")){ %>
 	   <%@ include file="MenuCorriere.jsp"%>
  <%} else if(session.getAttribute("ruolo").equals("Utente")){ %>
 	   <%@ include file="MenuBase.jsp"%>
  <%} %>
    <div class="dati">
      <strong><h1>I tuoi dati personali</h1></strong>
      <br>
    	<center><h2>Benvenuto <%=request.getSession().getAttribute("username") %></h3></center>
    	
    	
    	<div class="a-box">
    		<div class="item">
    			<div class="testo">
    				Nome e Cognome 
    				<a href="" class="" data-toggle="modal" data-target="#exampleModalCenter"><svg  style='width: 25px;'aria-hidden="true" focusable="false" data-prefix="fad" data-icon="user-edit" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512" class="svg-inline--fa fa-user-edit fa-w-20 fa-2x"><g class="fa-group"><path fill="currentColor" d="M358.9 433.3l-6.8 61a15.92 15.92 0 0 0 17.6 17.6l60.9-6.8 137.9-137.9-71.7-71.7zM633 268.9L595.1 231a24 24 0 0 0-33.8 0l-37.8 37.8-4.1 4.1 71.8 71.7 41.8-41.8a24.08 24.08 0 0 0 0-33.9z" class="fa-secondary" style='color: orange;'></path><path fill="currentColor" d="M313.6 288h-16.7a174.08 174.08 0 0 1-145.8 0h-16.7A134.43 134.43 0 0 0 0 422.4V464a48 48 0 0 0 48 48h274.9a48 48 0 0 1-2.6-21.3l6.8-60.9 1.2-11.1 85.2-85.2c-24.5-27.7-60-45.5-99.9-45.5zM224 256A128 128 0 1 0 96 128a128 128 0 0 0 128 128z" class="fa-primary" style='color: #0000ff;'></path></g></svg></a>
				          <div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
							  <div class="modal-dialog modal-dialog-centered" role="document">
							    <div class="modal-content">
							      <div class="modal-header">
							        <h5 class="modal-title" id="exampleModalLongTitle">Cambio Nome e Cognome</h5>
							        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
							          <span aria-hidden="true">&times;</span>
							        </button>
							      </div>
							      <form class="form-signin" action="<%=response.encodeURL("ModificaDatiUtenteServlet")%>" method="post">
							      	<input type="text" name="action" value="nome_cognome" style='display: none;'>
							     	 <div class="modal-body">
							      	
									      <div class="form-row">
										    <div class="col-md-6 mb-3">
										      <label for="validationDefault01">Nome</label>
										      <input type="text" class="form-control" id="validationDefault01" name="nome" required value="<%=utente.getNome()%>" pattern="[A-Za-z ']{2,20}" title="il campo nome può avere dai 2 ai 20 caratteri">
										    </div>
										
										    <div class="col-md-6 mb-3">
										      <label for="validationDefault02">Cognome</label>
										      <input type="text" class="form-control" id="validationDefault02" name="cognome" required value="<%=utente.getCognome()%>" pattern="[A-Za-z ']{2,20}" title="il campo cognome può avere dai 2 ai 20 caratteri">
										    </div>
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
    				<div class="descrizione">
    					<%=utente.getNome()%> <%=utente.getCognome()%>    					
    				</div>
    			</div>
    			
    		</div>
    		
    		<div class="item">
    			<div class="testo">
    				Indirizzo
    				<a href="" class="" data-toggle="modal" data-target="#exampleModalCenter2"><svg  style='width: 25px;'aria-hidden="true" focusable="false" data-prefix="fad" data-icon="user-edit" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512" class="svg-inline--fa fa-user-edit fa-w-20 fa-2x"><g class="fa-group"><path fill="currentColor" d="M358.9 433.3l-6.8 61a15.92 15.92 0 0 0 17.6 17.6l60.9-6.8 137.9-137.9-71.7-71.7zM633 268.9L595.1 231a24 24 0 0 0-33.8 0l-37.8 37.8-4.1 4.1 71.8 71.7 41.8-41.8a24.08 24.08 0 0 0 0-33.9z" class="fa-secondary" style='color: orange;'></path><path fill="currentColor" d="M313.6 288h-16.7a174.08 174.08 0 0 1-145.8 0h-16.7A134.43 134.43 0 0 0 0 422.4V464a48 48 0 0 0 48 48h274.9a48 48 0 0 1-2.6-21.3l6.8-60.9 1.2-11.1 85.2-85.2c-24.5-27.7-60-45.5-99.9-45.5zM224 256A128 128 0 1 0 96 128a128 128 0 0 0 128 128z" class="fa-primary" style='color: #0000ff;'></path></g></svg></a>
				          <div class="modal fade" id="exampleModalCenter2" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
							  <div class="modal-dialog modal-dialog-centered" role="document">
							    <div class="modal-content">
							      <div class="modal-header">
							        <h5 class="modal-title" id="exampleModalLongTitle">Cambio Nome e Cognome</h5>
							        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
							          <span aria-hidden="true">&times;</span>
							        </button>
							      </div>
							      <form class="form-signin" action="<%=response.encodeURL("ModificaDatiUtenteServlet")%>" method="post">
							      	<input type="text" name="action" value="indirizzo" style='display: none;'>
							     	 <div class="modal-body">
							      	
									      <div class="form-row">
										    <div class="form-group col-md-6">
										      <label for="inputCity">Indirizzo</label>
										      <input type="text" class="form-control" name="via" required value="<%=utente.getVia()%>" pattern="[A-Za-z ']{2,50}" title="il campo indirizzo può avere dai 2 ai 50 caratteri">
										    </div>
										    <div class="form-group col-md-3">
										      <label for="inputState">N° Civico</label>
										      <input type="text" class="form-control" name="numero" required value="<%=utente.getNumero()%>" pattern="[0-9]{1,5}" title="inserire un numero civico valido, massimo 5 caratteri numerici">
										    </div>
										    <div class="form-group col-md-3">
										      <label for="inputZip">Cap</label>
										      <input type="text" class="form-control" name="cap" required value="<%=utente.getCap()%>" pattern="[0-9]{5}" title="un cap valido contiene 5 numeri">
										    </div>
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
    				<div class="descrizione">
    					<%=utente.getVia()%>, <%=utente.getNumero()%> - <%=utente.getCap() %>
    				</div>
    			</div>
    			
    		</div>
    		
    		<div class="item">
    			<div class="testo">
    				E-mail
    				
    				<center class="descrizione">
    					<%=utente.getMail()%>
    				</center>
    			</div>
    			
    		</div>
    		
    		<div class="item">
    			<div class="testo">
    				Password
    				<a href="" class="" data-toggle="modal" data-target="#exampleModalCenter3"><svg  style='width: 25px;'aria-hidden="true" focusable="false" data-prefix="fad" data-icon="user-edit" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512" class="svg-inline--fa fa-user-edit fa-w-20 fa-2x"><g class="fa-group"><path fill="currentColor" d="M358.9 433.3l-6.8 61a15.92 15.92 0 0 0 17.6 17.6l60.9-6.8 137.9-137.9-71.7-71.7zM633 268.9L595.1 231a24 24 0 0 0-33.8 0l-37.8 37.8-4.1 4.1 71.8 71.7 41.8-41.8a24.08 24.08 0 0 0 0-33.9z" class="fa-secondary" style='color: orange;'></path><path fill="currentColor" d="M313.6 288h-16.7a174.08 174.08 0 0 1-145.8 0h-16.7A134.43 134.43 0 0 0 0 422.4V464a48 48 0 0 0 48 48h274.9a48 48 0 0 1-2.6-21.3l6.8-60.9 1.2-11.1 85.2-85.2c-24.5-27.7-60-45.5-99.9-45.5zM224 256A128 128 0 1 0 96 128a128 128 0 0 0 128 128z" class="fa-primary" style='color: #0000ff;'></path></g></svg></a>
				          <div class="modal fade" id="exampleModalCenter3" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
							  <div class="modal-dialog modal-dialog-centered" role="document">
							    <div class="modal-content">
							      <div class="modal-header">
							        <h5 class="modal-title" id="exampleModalLongTitle">Cambio password</h5>
							        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
							          <span aria-hidden="true">&times;</span>
							        </button>
							      </div>
							      <form class="form-signin" action="<%=response.encodeURL("ModificaDatiUtenteServlet")%>" method="post">
							      	<label for="psw">Inserisci password nuova
							      		<br>
						     			<input type="password" id="psw" name="pwd" class="form-control" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,30}" title="Deve contenere un numero, una lettera minuscola ed una lettera maiuscola, e contenere almeno 8 caratteri" placeholder="Password" required="" >
							      	</label>
							      	<input type="text" name="action" value="pwd" style='display: none;'>
							     	 <div class="modal-body">
							      	
									      <div class="form-row">
										    									
										    
										     <!--<label for="validationDefault02">Inserisci password nuova</label>
										      <input type="password" class="form-control" id="validationDefault02" name="pwd" required>  --> 
										    
										  </div>
							  	   </div>
							      <div class="modal-footer">
							        <button type="button" class="btn btn-secondary" data-dismiss="modal">Chiudi</button>
							        <button type="submit" class="btn btn-primary">Salva</button>
							      </div>
							      </form>
							       <div class="form-row">
									  <div id="message">
										  <h4>La Password deve avere le seguenti regole:</h3>
										  <p id="letter" class="invalid">Una lettera<b> minuscola</b></p>
										  <p id="capital" class="invalid">Una lettera<b> maiuscola</b></p>
										  <p id="number" class="invalid">Un <b>numero</b></p>
										  <p id="length" class="invalid">Minimo <b>8 caratteri</b></p>
									  </div>
								  </div>
							    </div>
							  </div>
							</div>
    				<center class="descrizione">
    					***********
    				</center>
    			</div>
    			
    		</div>
    		
    		<div class="item">
    			<div class="testo">
    				Ruolo
    				<div class="descrizione">
    					<%=session.getAttribute("ruolo") %>
    				</div>
    			</div>
    			
    		</div>
    		<% if(session.getAttribute("ruolo").equals("Utente")){ %>
	    		<div class="item">
	    			<div class="testo">
	    				Numero ordini
	    				<div class="descrizione">
	    					<%=utente.getNumeroOrdini()%>
	    				</div>
	    			</div>
	    	<%} %>
	    		</div>
    	</div>
    	
    	<div class="logout">
	      <form action="<%=response.encodeURL("LogoutServlet")%>" method="post">
	      	<button type="submit" class="btn btn-danger mb-3 btn-block">Logout</button>
	      </form>
	    </div>
    </div>	
     <hr>
      <footer>Copyright © 2020 McDonald's. All rights reserved</footer>
    <script>
		var myInput = document.getElementById("psw");
		var letter = document.getElementById("letter");
		var capital = document.getElementById("capital");
		var number = document.getElementById("number");
		var length = document.getElementById("length");
		
		//Quando l'utente clicca sul campo password, mostra il testo
		myInput.onfocus = function() {
		  document.getElementById("message").style.display = "block";
		}
		
		// Quando l'utente esce dal campo password, nasconde il testo
		myInput.onblur = function() {
		  document.getElementById("message").style.display = "none";
		}
		
		// Funzione invocata quando l'utente scrive nel campo
		myInput.onkeyup = function() {
		  // Controllo minuscole
		  var lowerCaseLetters = /[a-z]/g;
		  if(myInput.value.match(lowerCaseLetters)) {  
		    letter.classList.remove("invalid");
		    letter.classList.add("valid");
		  } else {
		    letter.classList.remove("valid");
		    letter.classList.add("invalid");
		  }
		  
		  // Controllo maiuscole
		  var upperCaseLetters = /[A-Z]/g;
		  if(myInput.value.match(upperCaseLetters)) {  
		    capital.classList.remove("invalid");
		    capital.classList.add("valid");
		  } else {
		    capital.classList.remove("valid");
		    capital.classList.add("invalid");
		  }
		
		  // Controllo numeri
		  var numbers = /[0-9]/g;
		  if(myInput.value.match(numbers)) {  
		    number.classList.remove("invalid");
		    number.classList.add("valid");
		  } else {
		    number.classList.remove("valid");
		    number.classList.add("invalid");
		  }
		  
		  // Controllo lunghezza
		  if(myInput.value.length >= 8) {
		    length.classList.remove("invalid");
		    length.classList.add("valid");
		  } else {
		    length.classList.remove("valid");
		    length.classList.add("invalid");
		  }
		}
		
		var myInput2 = document.getElementById("psw2");
		var same = document.getElementById("same");
		
		myInput2.onfocus = function() {
		  document.getElementById("message2").style.display = "block";
		}
		
		// Quando l'utente esce dal campo password nasconde il testo
		myInput2.onblur = function() {
		  document.getElementById("message2").style.display = "none";
		}
		
		
		myInput2.onkeyup = function() {
			  // Controllo se uguali
			  if(myInput.value==myInput2.value) {  
			    same.classList.remove("invalid");
			    same.classList.add("valid");
			  } else {
			    same.classList.remove("valid");
			    same.classList.add("invalid");
			  }
			 
		}
		</script>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
  </body>
</html>