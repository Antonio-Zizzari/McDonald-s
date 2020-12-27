<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="UTF-8"%>
    
<%
	
	String ruolo=(String)request.getSession().getAttribute("ruolo");
	if(ruolo!=null){
		response.sendError(HttpServletResponse.SC_NOT_FOUND);
	}
%>
 
    
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Register McDrive</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
    <!-- Custom styles for this template -->
    <link href="login.css" rel="stylesheet">
    <link href="style.css" rel="stylesheet">
	<script>						
			function checkMail(){
				var xhr = new XMLHttpRequest();
				
				xhr.onreadystatechange = function(){
					if(xhr.readyState == 4 && xhr.status == 200){
						var result = xhr.responseText;
						if(result == 'unfree'){
							$("#inputEmail").focus();
							$("#inputEmail").css("background-color","#E95858");
							$("#labelmail").html("Email address: Nome mail non disponibile");
						}
						else if(result == 'free'){
							$("#inputEmail").css("background-color","#63C94A");
							$("#labelmail").html("Email address: mail utente disponibile");
						}else if(result == 'vuoto'){
							$("#inputEmail").css("background-color","white");
							$("#labelmail").html("Email address");
						}
					}
				}
				
				var mail = $("#inputEmail").val();
				xhr.open("get","./CheckMailServlet?mail=" + mail,true);
				xhr.setRequestHeader("connection","close");
				xhr.send();
			}
		
		</script>
	
  </head>
  <body>
	<%@ include file="MenuBase.jsp"%>
    <form class="form-signin" action="<%=response.encodeURL("RegisterServlet")%>" method="post">
      <div class="text-center mb-4">
        <svg width=200px xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" id="Layer_1" x="0px" y="0px" viewBox="0 0 139.5 139.5" style="enable-background:new 0 0 139.5 139.5;" xml:space="preserve">
          <style type="text/css">
            .st0{fill:#264F36;}
            .st1{fill:#FFBC0D;}
          </style>
          <g>
            <path class="st0" d="M12.1,139.5c0,0-12.1,0-12.1-12.1V12.1C0,12.1,0,0,12.1,0h115.3c0,0,12.1,0,12.1,12.1v115.3   c0,0,0,12.1-12.1,12.1H12.1z"/>
            <g>
              <path class="st1" d="M90,28.7c-8.2,0-15.5,10.9-20.3,27.9c-4.8-17-12.1-27.9-20.3-27.9c-14.4,0-26,36.3-26,81H35    c0-41.5,6.5-75.2,14.5-75.2c8,0,14.5,31.1,14.5,69.4h11.6c0-38.3,6.5-69.4,14.5-69.4c8,0,14.5,33.7,14.5,75.2H116    C116,64.9,104.4,28.7,90,28.7z"/>
              <g>
                <path class="st1" d="M121.8,103.9c-1.6,0-2.9,1.2-2.9,2.9c0,1.7,1.3,2.9,2.9,2.9c1.6,0,2.9-1.2,2.9-2.9     C124.7,105.1,123.4,103.9,121.8,103.9z M121.8,109.2c-1.3,0-2.4-1.1-2.4-2.5c0-1.4,1-2.5,2.4-2.5c1.3,0,2.4,1.1,2.4,2.5     C124.2,108.2,123.2,109.2,121.8,109.2z"/>
                <path class="st1" d="M123.2,106c0-0.6-0.4-1-1.2-1h-1.3v3.4h0.5V107h0.6l0.9,1.5h0.6l-1-1.5C122.8,106.9,123.2,106.7,123.2,106z      M121.8,106.6h-0.5v-1.1h0.7c0.4,0,0.7,0.1,0.7,0.5C122.7,106.6,122.2,106.6,121.8,106.6z"/>
              </g>
            </g>
          </g>
          </svg>
    <h1>Register Page</h1>
	  </div>
		  <div class="form-row">
		    <div class="col-md-6 mb-3">
		      <label for="validationDefault01">Nome</label>
		      <input type="text" class="form-control" id="validationDefault01" placeholder="Andrea" required name="nome" pattern="[A-Za-z ']{2,20}" title="il campo nome può avere dai 2 ai 20 caratteri">
		    </div>
		
		    <div class="col-md-6 mb-3">
		      <label for="validationDefault02">Cognome</label>
		      <input type="text" class="form-control" id="validationDefault02" placeholder="Di Chiodo" required name="cognome" pattern="[A-Za-z ']{2,20}" title="il campo cognome può avere dai 2 ai 20 caratteri">
		    </div>
		  </div>
		   <div class="form-row">
		    <div class="form-group col-md-6">
		      <label for="inputCity">Indirizzo</label>
		      <input type="text" class="form-control"  placeholder="Via della lode" required name="via" pattern="[A-Za-z ']{2,50}" title="il campo indirizzo può avere dai 2 ai 50 caratteri">
		    </div>
		    <div class="form-group col-md-3">
		      <label for="inputState">N° Civico</label>
		      <input type="text" class="form-control"  placeholder="30" required name="numero" pattern="[0-9]{1,5}" title="inserire un numero civico valido, massimo 5 caratteri numerici">
		    </div>
		    <div class="form-group col-md-3">
		      <label for="inputZip">Cap</label>
		      <input type="text" class="form-control"  placeholder="80050" required name="cap" pattern="[0-9]{5}" title="un cap valido contiene 5 numeri">
		    </div>
		  </div>
		  <div class="form-group">
		      <label for="inputEmail" id="labelmail">Email address</label>
		      <input type="email" id="inputEmail" class="form-control" placeholder="Esempio@google.com" required="" autofocus="" name="email" onblur="checkMail()" pattern="[A-z 0-9\.\+_-]+@[A-z 0-9\._-]+\.[A-z]{1,3}" title="inserire un'email valida">
		   
		  </div>
		  
		  
		  <style>
			
			
			
			
			/* Mostra un messaggio quando l'utente ci clicca sopra''*/
			#message {
			  display:none;
			  background: #f1f1f1;
			  color: #000;
			  position: relative;
			  padding: 20px;
			  margin-top: 10px;
			}
			
			#message p {
			  padding: 10px 35px;
			  font-size: 18px;
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
			  font-size: 18px;
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
		  
		  
		  
		  <div class="form-row">
		    <div class="col-md-6 mb-3">
		      <label for="inputPassword">Password</label>
		      <input type="password" id="psw" class="form-control" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,30}" title="Deve contenere un numero, una lettera minuscola ed una lettera maiuscola, e contenere almeno 8 caratteri, massimo 30" placeholder="Password" required="" name="pwd1">
		    </div>
		    <div class="col-md-6 mb-3">
		      <label for="inputPassword">Ripeti Password</label>
		      <input type="password" id="psw2" class="form-control" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,30}" title="Deve contenere un numero, una lettera minuscola ed una lettera maiuscola, e contenere almeno 8 caratteri, massimo 30" placeholder="Ripeti Password" required="" name="pwd2">
		    </div>
		  </div>
		  <div class="form-row">
			  <div id="message">
				  <h3>La Password deve avere le seguenti regole:</h3>
				  <p id="letter" class="invalid">Una lettera<b> minuscola</b></p>
				  <p id="capital" class="invalid">Una lettera<b> maiuscola</b></p>
				  <p id="number" class="invalid">Un <b>numero</b></p>
				  <p id="length" class="invalid">Minimo <b>8 caratteri</b></p>
			  </div>
		  </div>
		  <div class="form-row">
			  <div id="message2">
				  <h3>La Password deve avere le seguenti regole:</h3>
				  	<p id="same" class="invalid">Le password<b> coincidono</b></p>  
			  </div>
		  </div>
		  <div class="form-group">
		    <div class="form-check">
		      <input class="form-check-input" type="checkbox" value="" id="invalidCheck2" required>
		      <label class="form-check-label" for="invalidCheck2">
		        Accetta i termini e le condizioni <a href="TeC.html" target="_blank">leggi</a>
		      </label>
		    </div>
		  </div>
		  <button class="btn btn-lg btn-primary btn-block" type="submit">Registrati</button>
			 <%
		  if(request.getAttribute("error") != null) {%>
		  	<p style='color: red;'>Le password non coincidono o hai sbagliato dei campi</p>
		  <% } %>
		  
		  <p class="mt-5 mb-3 text-muted text-center">Copyright © 2020 McDonald's. All rights reserved</p>
		</form>
			
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
