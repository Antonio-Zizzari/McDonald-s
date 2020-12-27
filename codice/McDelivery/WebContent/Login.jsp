<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="UTF-8"%>
<%
	if(session.getAttribute("username")!=null){
		response.sendError(HttpServletResponse.SC_NOT_FOUND);
	}

%>
<!DOCTYPE html>
<html >
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Login McDrive</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">

    <link href="login.css" rel="stylesheet">
    <link href="style.css" rel="stylesheet">
  </head>
  <body>
	<%@ include file="MenuBase.jsp"%>
	    <form class="form-signin" action="LoginServlet" method="post">
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
	    <h1>Login Page</h1>
		  </div>
		  <div class="form-label-group">
		    <input type="email" id="inputEmail" class="form-control" placeholder="Email address" required="" autofocus="" name="email" pattern="[A-z 0-9\.\+_-]+@[A-z 0-9\._-]+\.[A-z]{1,3}" title="inserire un'email valida">
		    <label for="inputEmail">Email address</label>
		  </div>
		
		  <div class="form-label-group">
		    <input type="password" id="inputPassword" class="form-control" placeholder="Password" required="" name="pwd" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,30}" title="Deve contenere un numero, una lettera minuscola ed una lettera maiuscola, e contenere almeno 8 caratteri, massimo 30">
		    <label for="inputPassword">Password</label>
		  </div>
		
		  <div class="checkbox mb-3">
		    <label>
		      <input type="checkbox" name="remember" value="1"> Remember me
		    </label>
		    <p>Sei nuovo da queste parti? <a href="Register.jsp">Registrati qui</a></p>
		  </div>
		  <button class="btn btn-lg btn-primary btn-block" type="submit">Accedi</button>
		  <%
		  if(request.getAttribute("error") != null) {%>
		  	<p style='color: red;'>Email o Password Sbagliate!!!</p>
		  <% } %>
		  <%
		  if(request.getAttribute("registrato") != null) {%>
		  	<p style='color: green;'>Usa le credenziali che hai inserito per fare il tuo primo login!</p>
		  <% } %>
		  <p class="mt-5 mb-3 text-muted text-center">Copyright © 2020 McDonald's. All rights reserved</p>
		</form>
	</body>
</html>
