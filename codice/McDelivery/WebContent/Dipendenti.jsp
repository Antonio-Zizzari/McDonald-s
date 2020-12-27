<%@page import="it.unisa.bean.UtenteBean"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="UTF-8" import="java.util.*,it.unisa.bean.UtenteBean"%>
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
<%
 	
 
 
 	
	ArrayList<UtenteBean> corrieri= (ArrayList<UtenteBean>)request.getAttribute("corrieri");
	if(corrieri == null) {
 		response.sendRedirect(response.encodeRedirectURL("./DipendentiServlet"));
 		return;
 	}
	
	
 	
 	
 	
 	int i=0;
 %>   
<!DOCTYPE html>
<html>
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
    <link rel="stylesheet" href="style.css"/>
    <link rel="stylesheet" href="dati.css"/>
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,700&display=swap"
      rel="stylesheet"/>

  </head>

  <body>
    <%@ include file="MenuResponsabilePersonale.jsp"%>

    <main>
      <strong><h1>Ecco i nostri dipendenti del McDonald's®</h1></strong>
    </main>
      <br>
      
	  <main>
	  <%
		  if(request.getAttribute("successo") != null) {%>
		  	<p style='color: green;'>Corriere licenziato con successo!</p>
		  <% } %>
      <label class="descrizione">Elenco Corrieri:</label>
      <table class="table table-bordered">
      	<% if(corrieri == null || corrieri.size()==0) { %>
      	
      	<tr>
            <td colspan="5"><center>Non ci sono corrieri nell'azienda</center></td>
        </tr>
        <%}else if(corrieri.size()>0){
        	
        
        %>
        	
        
	        <thead>
	          <tr>
	            <th scope="col">#</th>
	            <th scope="col">Nome e Cognome</th>
	            <th scope="col">Indirizzo Corrieri</th>
	            <th scope="col">Email</th>
	            <th scope="col">Licenzia</th>
	          </tr>
	        </thead>
	     <%for(UtenteBean corriere: corrieri){ %>
	        <tbody>
	          <tr>
	            <th scope="row"><%=i+1%></th>
	            <td><%=corriere.getNome()%> <%=corriere.getCognome()%></td>	           
	            <td><%=corriere.getVia()%>, <%=corriere.getNumero()%> - <%=corriere.getCap() %></td>
	            <td><%=corriere.getMail()%></td>
	            <td><a href="<%=response.encodeURL("DipendentiServlet?action=delete&mail=" + corriere.getMail())%>"><svg style='width: 26px;'aria-hidden="true" focusable="false" data-prefix="fad" data-icon="user-slash" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512" class="svg-inline--fa fa-user-slash fa-w-20 fa-2x"><g class="fa-group"><path fill="currentColor" d="M192.47 117a128 128 0 1 1 170.32 131.66zM96 422.4V464a48 48 0 0 0 48 48h350.2L207.37 290.3C144.17 301.3 96 356 96 422.4z" class="fa-secondary" style='color: orange;'></path><path fill="currentColor" d="M636.67 480.4l-19.6 25.3a16.06 16.06 0 0 1-22.5 2.8L6.17 53.8a15.93 15.93 0 0 1-2.8-22.4L23 6.2a16.06 16.06 0 0 1 22.5-2.8l588.3 454.7a15.85 15.85 0 0 1 2.87 22.3z" class="fa-primary" style='color: red;'></path></g></svg></a></td>
	          </tr>
	
	          
	        </tbody>
        <% i++;}} %>
      </table>

		
      <hr>
      <footer>Copyright © 2020 McDonald's. All rights reserved</footer>
    </main>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
  </body>
</html>

