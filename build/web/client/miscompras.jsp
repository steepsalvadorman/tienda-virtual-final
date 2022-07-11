
<%@page import="com.steep.model.Usuario"%>
<%@page import="com.steep.dao.DetalleVentaDao"%>
<%@page import="com.steep.model.DetalleVenta"%>
<%@page import="java.util.Iterator"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%@include file="../template/menu_cliente.jsp" %>
        <div class="main">
            <div class="container">
                <table class="table">
                <tr>
                    <th>Venta</th>
                    <th>Producto</th>
                    <th>Cantidad</th>
                    <th>Precio</th>
                    <th>Costo</th>
                    <th></th>
                </tr>
                <%
                    Iterator<DetalleVenta> iterator = new DetalleVentaDao().listByUser(usuario.getId() + "").iterator();
                    DetalleVenta item = null;
                    while (iterator.hasNext()) {
                        item = iterator.next();
                %>
                <tr>
                    <td><%= item.getVenta()%></td>
                    <td><%= item.getProducto()%></td>
                    <td><%= item.getCantidad()%></td>
                    <td><%= item.getPrecio()%></td>
                    <td><%= (item.getCantidad()* item.getPrecio())%></td>
                    <td class="text-right">
                        <img src="ImageController?id=<%= item.getProducto().getId()%>" width="80" height="80">
                    </td>

                </tr>
                <%}%>
            </table>
            </div>
        </div>
    </body>
</html>
