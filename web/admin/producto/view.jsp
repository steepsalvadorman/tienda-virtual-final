<%@page import="com.steep.dao.ProductoDao"%>
<%@page import="com.steep.model.Producto"%>
<%@page import="java.util.Iterator"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ver Producto</title>
    </head>
    <body>
        <%@include file="../../template/menu.jsp" %>
        <div class="container body">
            <h3>Detalle: Información</h3>

            <%
                Producto item = ProductoDao.search(Integer.parseInt(request.getParameter("id")));
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
                    <label><b>Nombre</b></label>
                </div>
                <%= item.getNombre()%>
            </div>
            <div class="form-row">
                <div class="col-md-2">
                    <label><b>Descripción</b></label>
                </div>
                <p><%= item.getDescripcion()%></p>
            </div>
            <div class="form-row">
                <div class="col-md-2">
                    <label><b>Stock</b></label>
                </div>
                <%= item.getStock()%>
            </div>
            <div class="form-row">
                <div class="col-md-2">
                    <label><b>Precio</b></label>
                </div>
                <%= item.getPrecio()%>
            </div>
            <div class="form-row">
                <div class="col-md-2">
                    <label><b>Imagen</b></label>
                </div>
                <img src="ImageController?id=<%= item.getId()%>" height="200">
            </div>
            <br>
            <div class="form-row">
                <div class="col-md-12">
                    <a href="ProductoController?accion=list" class="btn btn-success"> Volver</a>
                </div>
            </div>
        </div>
    </body>
</html>