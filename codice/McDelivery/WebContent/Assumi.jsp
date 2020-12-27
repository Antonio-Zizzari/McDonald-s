<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="UTF-8"%>
<%

	String ruolo=(String)request.getSession().getAttribute("ruolo");
	if(ruolo!=null){
		if(!ruolo.equals("ResponsabilePersonale")){
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
		}
	}else if(ruolo==null){
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
	<%@ include file="MenuResponsabilePersonale.jsp"%>
    <form class="form-signin" action="<%=response.encodeURL("RegisterServlet")%>" method="post">
      <div class="text-center ">
        <svg style='width: 60%;' aria-hidden="true" focusable="false" data-prefix="fad" data-icon="address-card" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512" class="svg-inline--fa fa-address-card fa-w-18 fa-2x"><g class="fa-group"><path fill="currentColor" d="M528 32H48A48 48 0 0 0 0 80v352a48 48 0 0 0 48 48h480a48 48 0 0 0 48-48V80a48 48 0 0 0-48-48zm-352 96a64 64 0 1 1-64 64 64.06 64.06 0 0 1 64-64zm112 236.8c0 10.6-10 19.2-22.4 19.2H86.4C74 384 64 375.4 64 364.8v-19.2c0-31.8 30.1-57.6 67.2-57.6h5a103 103 0 0 0 79.6 0h5c37.1 0 67.2 25.8 67.2 57.6zM512 312a8 8 0 0 1-8 8H360a8 8 0 0 1-8-8v-16a8 8 0 0 1 8-8h144a8 8 0 0 1 8 8zm0-64a8 8 0 0 1-8 8H360a8 8 0 0 1-8-8v-16a8 8 0 0 1 8-8h144a8 8 0 0 1 8 8zm0-64a8 8 0 0 1-8 8H360a8 8 0 0 1-8-8v-16a8 8 0 0 1 8-8h144a8 8 0 0 1 8 8z" class="fa-secondary" style='color: #264F36;;'></path><path fill="currentColor" d="M176 256a64 64 0 1 0-64-64 64.06 64.06 0 0 0 64 64zm44.8 32h-5a103 103 0 0 1-79.6 0h-5C94.1 288 64 313.8 64 345.6v19.2c0 10.6 10 19.2 22.4 19.2h179.2c12.4 0 22.4-8.6 22.4-19.2v-19.2c0-31.8-30.1-57.6-67.2-57.6z" class="fa-primary" style='color: #FFBC0D;;'></path></g></svg>
    <br>
    <br>
    <h3 style='color: orange;'>Register Corriere Page</h3>
    <br>
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
			
			
			
			
			/* The message box is shown when the user clicks on the password field */
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
			
			/* Add a green text color and a checkmark when the requirements are right */
			.valid {
			  color: green;
			}
			
			.valid:before {
			  position: relative;
			  left: -35px;
			  content: "v";
			}
			
			/* Add a red text color and an "x" when the requirements are wrong */
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
		      <input type="password" id="psw" class="form-control" placeholder="Password" required="" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,30}" title="Deve contenere un numero, una lettera minuscola ed una lettera maiuscola, e contenere almeno 8 caratteri, massimo 30" name="pwd1">
		    </div>
		    <div class="col-md-6 mb-3">
		      <label for="inputPassword">Ripeti Password</label>
		      <input type="password" id="psw2" class="form-control" placeholder="Ripeti Password" required="" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,30}" title="Deve contenere un numero, una lettera minuscola ed una lettera maiuscola, e contenere almeno 8 caratteri, massimo 30" name="pwd2">
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
		  <button class="btn btn-lg btn-primary btn-block" type="submit">Registralo</button>
			 <%
		  if(request.getAttribute("error") != null) {%>
		  	<p style='color: red;'>Le password non coincidono o hai sbagliato dei campi</p>
		  <% } %>
		  <%
		  if(request.getAttribute("registrato") != null) {%>
		  	<p style='color: green;'>Corriere registrato con successo!</p>
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

