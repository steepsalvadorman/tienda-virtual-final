<%@page import="com.steep.dao.CarritoDao"%>
<%@page import="com.steep.model.Carrito"%>
<%@page import="java.util.Iterator"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ver Carrito</title>
    </head>
    <body>
        <%@include file="../../template/menu.jsp" %>
        <div class="container body">
            <h3>Detalle: Información</h3>

            <%
                Carrito item = CarritoDao.search(Integer.parseInt(request.getParameter("id")));
            %>

            <br>
            <div class="form-row">
                <div class="col-md-2">
                    <label><b>Id</b></label>
                </div>
                <%= item.getId()%>
            </div>  
            <div class="form-row">
                <div class="col-md-2">
                    <label><b>Usuario</b></label>
                </div>
                <%= item.getUsuario()%>
            </div>
            <div class="form-row">
                <div class="col-md-2">
                    <label><b>Producto</b></label>
                </div>
                <p><%= item.getProducto()%></p>
            </div>
            <div class="form-row">
                <div class="col-md-2">
                    <label><b>Cantidad</b></label>
                </div>
                <%= item.getCantidad()%>
            </div>
            <div class="form-row">
                <div class="col-md-12">
                    <a href="CarritoController?accion=list" class="btn btn-success"> Volver</a>
                </div>
            </div>
        </div>
    </body>
</html>