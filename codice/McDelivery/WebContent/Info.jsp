<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="UTF-8" import="java.util.*,it.unisa.bean.McDriveBean"%>
<%
	String ruolo=(String)request.getSession().getAttribute("ruolo");
	if(ruolo!=null){
		if(!ruolo.equals("Utente")){
	response.sendError(HttpServletResponse.SC_NOT_FOUND);
		}
	}
%> 

<%
 	ArrayList<McDriveBean> mcdrives= (ArrayList<McDriveBean>)request.getSession().getAttribute("mcdrives");
 	if(mcdrives == null) {
  		response.sendRedirect(response.encodeRedirectURL("./StampaMcDrives"));
  		return;
  	}
 	
 	
  	int i2=0;
 %> 
<!DOCTYPE html>
<html>
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
    <link rel="stylesheet" href="style.css"/>
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,700&display=swap"
      rel="stylesheet"
    />

  </head>

  <body>
    <%@ include file="MenuBase.jsp"%>

    <main>
      <strong><h1>Dove trovarci</h1></strong>
      <br>
	  
      <label class="descrizione">Ecco a te l'elenco dei nostri McDrives:</label>
      <table class="table table-bordered">
      	<%
      		if(mcdrives == null || mcdrives.size()==0) {
      	%>
      	
      	<tr>
            <td colspan="5"><center>Non ci sono McDrive</center></td>
        </tr>
        <%
        	}else if(mcdrives.size()>0){
        %>
        	
        
	        <thead>
	          <tr>
	            <th scope="col">#</th>
	            <th scope="col">Nome</th>
	            <th scope="col">Via</th>
	            <th scope="col">Cap</th>
	            <th scope="col">Numero</th>
	          </tr>
	        </thead>
	     <%
	     	for(McDriveBean mcdrive: mcdrives){
	     %>
	        <tbody>
	          <tr>
	            <th scope="row"><%=i2+1%></th>
	            <td><%=mcdrive.getNome()%></td>
	            <td><%=mcdrive.getVia()%></td>
	            <td><%=mcdrive.getCap()%></td>
	            <td><%=mcdrive.getNumero()%></td>
	          </tr>
	          
	        </tbody>
        <% i2++;}} %>
      </table>
		
	  <center><h4>Non conosci il posto? Trovaci con l'app di Google!</h4></center>
	
		<iframe width="100%" height="400" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="https://maps.google.com/maps?width=520&height=400&hl=en&q=%20napoli+()&t=&z=9&ie=UTF8&iwloc=B&output=embed"></iframe> <a href='http://maps-generator.com/it'>Più informazioni</a> <script type='text/javascript' src='https://embedmaps.com/google-maps-authorization/script.js?id=1eae7a0a81ab4c122687939adc4c505148e9e5f0'></script>		      
     
      <hr>
      <footer>Copyright © 2020 McDonald's. All rights reserved</footer>
    </main>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
  </body>
</html>
    