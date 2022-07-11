<%@page import="com.steep.dao.DetalleVentaDao, com.steep.model.DetalleVenta, java.util.Iterator"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ver DetalleVenta</title>
    </head>
    <body>
        <%@include file="../../template/menu.jsp" %>
        <div class="container body">
            <h3>Detalle: Información</h3>

            <%
                DetalleVenta item = DetalleVentaDao.search(Integer.parseInt(request.getParameter("id")));
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
                    <label><b>Venta</b></label>
                </div>
                <%= item.getVenta()%>
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
                <div class="col-md-2">
                    <label><b>Precio</b></label>
                </div>
                <%= item.getPrecio()%>
            </div>
            <div class="form-row">
                <div class="col-md-2">
                    <label><b>Subtotal</b></label>
                </div>
                <%= (item.getCantidad() * item.getPrecio())%>
            </div>
            <div class="form-row">
                <div class="col-md-12">
                    <a href="DetalleVentaController?accion=list" class="btn btn-success"> Volver</a>
                </div>
            </div>
        </div>
    </body>
</html>