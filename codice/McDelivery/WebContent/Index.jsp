<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="UTF-8"%>

<%
	
	String ruolo=(String)request.getSession().getAttribute("ruolo");
	if(ruolo!=null){
		if(ruolo.equals("ResponsabilePersonale") || ruolo.equals("Corriere") || ruolo.equals("ProductManager")){
			response.sendRedirect("Logged.jsp");
		}
	}

%>    
    
    
<!DOCTYPE html>
<html>
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
    <link rel="stylesheet" href="style.css"/>
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,700&display=swap" rel="stylesheet"/>

  </head>

  <body>
  	
    <%@ include file="MenuBase.jsp"%>
    <main>
      <strong><h1 >Benvento nel mondo del McDonald's®</h1></strong><br>
      <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
        <ol class="carousel-indicators">
          <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
          <li data-target="#carouselExampleIndicators" data-slide-to="1" class=""></li>
          <li data-target="#carouselExampleIndicators" data-slide-to="2" class=""></li>
        </ol>
        <div class="carousel-inner">
          <div class="carousel-item">
            <img class="d-block w-100" src="img/gelati.png" data-holder-rendered="true">
          </div>
          <div class="carousel-item active carousel-item-left">
            <img class="d-block w-100" src="img/panini.png" data-holder-rendered="true">
          </div>
          <div class="carousel-item carousel-item-next carousel-item-left">
            <img class="d-block w-100" src="img/pulizia.png" data-holder-rendered="true">
          </div>
        </div>
        <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
          <span class="carousel-control-prev-icon" aria-hidden="true"></span>
          <span class="sr-only">Previous</span>
        </a>
        <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
          <span class="carousel-control-next-icon" aria-hidden="true"></span>
          <span class="sr-only">Next</span>
        </a>
      </div>
      <ul class="homeprod">
        <li class="spazio">
          <a href="Prodotti.jsp" class="home">
            <img src="img/caffe.png" alt="caffè">
          </a>
        </li>
        <li class="spazio">
          <a href="" class="home">
            <img src="img/qualita.png" alt="qualità">
            
          </a>
        </li>
      </ul>
      <ul class="homeprod">
        <li class="spazio">
          <a href="Carrello.jsp" class="home">
            <img src="img/delivery.png" alt="delivery">
          </a>
        </li>


        <li class="spazio">

          <a href="#" class="home" data-toggle="modal" data-target=".bd-example-modal-sm">
            <img src="img/entra.png" alt="entra">

          </a>
          <div class="modal fade bd-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" style="display: none;" aria-hidden="true">
            <div class="modal-dialog modal-sm">
              <div class="modal-content">
                <div class="modal-header">
                  <h4 class="modal-title" id="mySmallModalLabel">Contattaci</h4>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                  </button>
                </div>
                <div class="modal-body">
                  McDrive@ristoranti.it
                </div>
              </div>
            </div>
          </div>
        </li>
      </ul>

      <hr>
      <footer>Copyright © 2020 McDonald's. All rights reserved</footer>
    </main>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
  </body>
</html>
    