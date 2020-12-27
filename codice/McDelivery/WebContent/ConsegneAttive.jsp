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
 	ArrayList<McDriveBean> mcdrives= (ArrayList<McDriveBean>)request.getSession().getAttribute("mcdrives");
  	if(mcdrives == null) {
   		response.sendRedirect(response.encodeRedirectURL("./ConsegneServlet"));
   		return;
   	}
  	
  	ArrayList<OrdineBean> ordini= (ArrayList<OrdineBean>)request.getSession().getAttribute("ordini");
  	
   	
   	
   	
   	int i=0;
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
      <strong><h1>McDonald's® premia le consegne veloci</h1></strong>
    </main>
      <br>
      <div class="dati linea">
      <label>Presso quale luogo ti trovi?</label>
	      <form  id="my_form" action="<%=response.encodeURL("ConsegneServlet")%>" method="post">
		      <select class="custom-select mb-3" name="mcdrive">
		    	  <option selected>Scegli</option>
		      <%
		      	for(McDriveBean mc:mcdrives){
		      %>
		          <option value="<%=i%>"><%=mc.getNome()%></option>
		      <%
		      	i++;}
		      %>
		          
		
		      </select>
		      <div class="logout">
		      	<a class="btn btn-warning btn-lg mb-1" href="javascript:{}" onclick="document.getElementById('my_form').submit(); return false;"">Cerca</a>
		      </div>
	     </form>
	  </div>
	  <main>
	  <%
	  	if(request.getAttribute("consegna") != null) {
	  %>
		  	<p style='color: green;'>Consegna accettata con successo!!!</p>
		  <%
		  	}
		  %>
      <label class="descrizione">Scegli quale ordine consegnare:</label>
      <table class="table table-bordered">
      	<%
      		if(ordini == null || ordini.size()==0) {
      	%>
      	
      	<tr>
            <td colspan="5"><center>Non ci sono consegne da effettuare in questo luogo</center></td>
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
	            <th scope="col">Accetta</th>
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
	              <a class="btn btn-primary align-middle" href="<%=response.encodeURL("ConsegneServlet?accetta=accetta&accettato=" + i2)%>">Accetta</a>
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

