<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="UTF-8" import="java.util.*,it.unisa.bean.McDriveBean,it.unisa.bean.OrdineBean"%>
    
    
<%
        	String ruolo=(String)request.getSession().getAttribute("ruolo");
        	if(ruolo!=null){
        		if(!ruolo.equals("Corriere")){
        	response.sendError(HttpServletResponse.SC_NOT_FOUND);
        		}
        	}else if(ruolo==null){
        		response.sendError(HttpServletResponse.SC_NOT_FOUND);
        	}
        %> 
<%
 	ArrayList<OrdineBean> ordini= (ArrayList<OrdineBean>)request.getSession().getAttribute("ordiniAccettati");
  	
  	
  	
  	int i2=0;
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
    <%@ include file="MenuCorriere.jsp"%>

    <main>
      <strong><h1>Ecco le tue consegne che hai effettuato in questa sessione</h1></strong>
    </main>
      <br>
      
	  <main>
      <label class="descrizione">Elenco:</label>
      <table class="table table-bordered">
      	<%
      		if(ordini == null || ordini.size()==0) {
      	%>
      	
      	<tr>
            <td colspan="5"><center>Non hai effettuato consegne in questa sessione</center></td>
        </tr>
        <%
        	}else if(ordini.size()>0){
        %>
        	
        
	        <thead>
	          <tr>
	            <th scope="col">#</th>
	            <th scope="col">Codice Ordine</th>
	            <th scope="col">Indirizzo Cliente</th>
	            <th scope="col">Nome Cliente</th>
	            <th scope="col">Stato</th>
	          </tr>
	        </thead>
	     <%
	     	for(OrdineBean ordine: ordini){
	     %>
	        <tbody>
	          <tr>
	            <th scope="row"><%=i2+1%></th>
	            <td><%=ordine.getData()%>-<%=ordine.getNumero()%></td>
	            <td><%=ordine.getIndirizzo()%></td>
	            <td><%=ordine.getNome()%> <%=ordine.getCognome()%></td>
	            <td>
	              Accettato <svg style="width:16px;" aria-hidden="true" focusable="false" data-prefix="fad" data-icon="check-circle" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" class="svg-inline--fa fa-check-circle fa-w-16 fa-2x"><g class="fa-group"><path fill="currentColor" d="M256 8C119 8 8 119 8 256s111 248 248 248 248-111 248-248S393 8 256 8zm155.31 195.31l-184 184a16 16 0 0 1-22.62 0l-104-104a16 16 0 0 1 0-22.62l22.62-22.63a16 16 0 0 1 22.63 0L216 308.12l150.06-150.06a16 16 0 0 1 22.63 0l22.62 22.63a16 16 0 0 1 0 22.62z" class="fa-secondary" style="color:#aaff00;"></path><path fill="currentColor" d="M227.31 387.31a16 16 0 0 1-22.62 0l-104-104a16 16 0 0 1 0-22.62l22.62-22.63a16 16 0 0 1 22.63 0L216 308.12l150.06-150.06a16 16 0 0 1 22.63 0l22.62 22.63a16 16 0 0 1 0 22.62l-184 184z" class="fa-primary" style="color:green;"></path></g></svg>
	            </td>
	          </tr>
	
	          
	        </tbody>
        <% i2++;}} %>
      </table>

		
      <hr>
      <footer>Copyright © 2020 McDonald's. All rights reserved</footer>
    </main>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
  </body>
</html>

