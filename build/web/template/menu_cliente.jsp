<%@page import="java.util.Iterator"%>
<%@page import="com.steep.dao.CarritoDao"%>
<%@page import="com.steep.model.Carrito"%>
<%@page import="com.steep.utils.Utils"%>
<%@page import="com.steep.model.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true"%>
<!DOCTYPE html>

<html>
    <head>
        <title>Free Snow Bootstrap Website Template | Shop :: w3layouts</title>
        <link href="css/style.css" rel='stylesheet' type='text/css' />
        
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">

        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700,800' rel='stylesheet' type='text/css'>
        <script
        type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
        <script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>

        <script type="text/javascript">
            $(document).ready(function () {
                $(".dropdown img.flag").addClass("flagvisibility");

                $(".dropdown dt a").click(function () {
                    $(".dropdown dd ul").toggle();
                });

                $(".dropdown dd ul li a").click(function () {
                    var text = $(this).html();
                    $(".dropdown dt a span").html(text);
                    $(".dropdown dd ul").hide();
                    $("#result").html("Selected value is: " + getSelectedValue("sample"));
                });

                function getSelectedValue(id) {
                    return $("#" + id).find("dt a span.value").html();
                }

                $(document).bind('click', function (e) {
                    var $clicked = $(e.target);
                    if (!$clicked.parents().hasClass("dropdown"))
                        $(".dropdown dd ul").hide();
                });


                $("#flagSwitcher").click(function () {
                    $(".dropdown img.flag").toggleClass("flagvisibility");
                });
            });
        </script>
    </head>

    <body>
        <%
            Usuario usuario = null;
            if (Utils.isLogged(session)) {
                usuario = (Usuario) session.getAttribute("user");
            }
        %>
        <div class="header">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="header-left">
                            <div class="logo">
                                <a href="ShopController?accion=shop"><img src="images/logo.png" alt="" /></a>
                            </div>
                            <div class="menu">
                                <a class="toggleMenu" href="HomeController?accion=shop"><img src="images/nav.png" alt="" /></a>
                                <ul class="nav" id="nav">
                                    <li><a href="HomeController?accion=shop">WEB PROJECT</a></li>
                                    <li class="current"><a href="ShopController?accion=shop">Tienda</a></li>
                                        <% if (usuario != null) { %>
                                    <li><a href="HomeController?accion=miscompras">Mis compras</a></li>
                                    <li><a href="UsuarioController?accion=logout">Cerrar sesión</a></li>
                                        <%}else{%>
                                    <li><a href="HomeController?accion=login">Iniciar sesión</a></li>
                                    <li><a href="HomeController?accion=register">Crear cuenta </a></li>
                                    <%}%>
                                    <div class="clear"></div>
                                </ul>
                                <script type="text/javascript" src="js/responsive-nav.js"></script>
                            </div>
                            <div class="clear"></div>
                        </div>
                        <div class="header_right">
                            <ul class="icon1 sub-icon1 profile_img">
                                <%if(usuario != null){%>
                                <li><a class="active-icon c1" href="#"> </a>
                                    <ul class="sub-icon1 list">
                                        <div class="product_control_buttons">
                                            <a href="#"><img src="images/close_edit.png" alt="" /></a>
                                        </div>
                                        <div class="clear"></div>
                                        <%
                                            Iterator<Carrito> iteratorCarrito = new CarritoDao().listByUser(usuario.getId()).iterator();
                                            Carrito itemCarrito = null;
                                            while (iteratorCarrito.hasNext()) {
                                                itemCarrito = iteratorCarrito.next();
                                        %>
                                        <li class="list_img"><img src="ImageController?id=<%= itemCarrito.getProducto().getId()%>" alt="" width="50" height="50"/></li>
                                        <li class="list_desc">                                            
                                            <h4><a href="#"><%=itemCarrito.getProducto().getNombre()%></a></h4>
                                            <span class="actual"><%=itemCarrito.getCantidad()%> x $<%=itemCarrito.getProducto().getPrecio()%></span>
                                        </li>
                                        <%}%>
                                        
                                        <div class="login_buttons">
                                            <div class="check_button"><a href="HomeController?accion=checkout">Pagar</a></div>
                                            <div class="clear"></div>
                                        </div>
                                        <div class="clear"></div>
                                    </ul>
                                </li>
                                <%}%>
                            </ul>
                            <div class="clear"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>

</html>