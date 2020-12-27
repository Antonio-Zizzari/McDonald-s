<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="UTF-8"%>
<%

	String ruolo=(String)request.getSession().getAttribute("ruolo");
	if(ruolo!=null){
		if(!ruolo.equals("ProductManager")){
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
		}
	}else if(ruolo==null){
		response.sendError(HttpServletResponse.SC_NOT_FOUND);
	}

%>     

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
    <link rel="stylesheet" href="style.css"/>
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,700&display=swap"
      rel="stylesheet"
    />

  </head>

  <body>
    <%@ include file="MenuProductManager.jsp"%>

    <main>
      <strong><h1>Scegli quale catalogo vuoi modificare</h1></strong>
      <br>

      <div class="row row-cols-1 row-cols-md-3">
        <div class="col mb-4">
          <div class="h-100 prodotti">
            <a href="<%=response.encodeURL("ProdottiOutputServlet?prodotto=4&modifica=1")%>">
                <img src="img/menu_iniz/menu.png" class="card-img-top image" alt="...">
                <div class="middle">
                  <div class="text">Menu</div>
                </div>
            </a>
          </div>
        </div>

        <div class="col mb-4">
          <div class="h-100 prodotti">
            <a href="<%=response.encodeURL("ProdottiOutputServlet?prodotto=5&modifica=1")%>">
              <img src="img/menu_iniz/panini.png" class="card-img-top  image" alt="...">
              <div class="middle">
                <div class="text">Panini</div>
              </div>
            </a>
          </div>
        </div>

        <div class="col mb-4">
          <div class="h-100 prodotti">
            <a href="<%=response.encodeURL("ProdottiOutputServlet?prodotto=6&modifica=1")%>">
              <img src="img/menu_iniz/sfiziosità.png" class="card-img-top image" alt="...">
              <div class="middle">
                <div class="text">Sfiziosità</div>
              </div>
            </a>
          </div>
        </div>

        <div class="col mb-4">
          <div class="h-100 prodotti">
            <a href="<%=response.encodeURL("ProdottiOutputServlet?prodotto=3&modifica=1")%>">
              <img src="img/menu_iniz/insalate.png" class="card-img-top image" alt="...">
              <div class="middle">
                <div class="text">Insalate</div>
              </div>
            </a>
          </div>
        </div>

        <div class="col mb-4">
          <div class="h-100 prodotti">
            <a href="<%=response.encodeURL("ProdottiOutputServlet?prodotto=1&modifica=1")%>">
              <img src="img/menu_iniz/bevande.png" class="card-img-top image" alt="...">
              <div class="middle">
                <div class="text">Bevande</div>
              </div>
            </a>
          </div>
        </div>

        <div class="col mb-4">
          <div class="h-100 prodotti">
            <a href="<%=response.encodeURL("ProdottiOutputServlet?prodotto=2&modifica=1")%>">
              <img src="img/menu_iniz/gelati2.png" class="card-img-top image" alt="...">
              <div class="middle">
                <div class="text">Gelati</div>
              </div>
            </a>
          </div>
        </div>

      </div>



      <hr>
      <footer>Copyright © 2020 McDonald's. All rights reserved</footer>
    </main>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
  </body>
</html>
    