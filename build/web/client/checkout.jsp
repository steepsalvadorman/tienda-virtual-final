
<%@page import="com.steep.model.Usuario"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.steep.dao.CarritoDao"%>
<%@page import="com.steep.model.Carrito"%>
<%@page import="com.steep.model.Carrito"%>
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
                <br>
                <h1>Carrito de Compra</h1>
                <% if (!String.valueOf(request.getParameter("success")).equals("null")) {%>
                <div class="alert alert-success alert-dismissable">
                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                    <strong>¡Éxito!</strong> Producto eliminado correctamente
                </div> 
                <%}%>
                <% if (!String.valueOf(request.getParameter("finish")).equals("null")) {%>
                <div class="alert alert-success alert-dismissable">
                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                    <strong>¡Éxito!</strong> La compra fue exitosa
                </div> 
                <%}%>
                <table class="table">
                    <tr>
                        <th></th>
                        <th>Producto</th>
                        <th>Precio</th>
                        <th>Cantidad</th>
                        <th>Costo</th>
                        <th></th>
                    </tr>
                    <%
                        Iterator<Carrito> iterator = new CarritoDao().listByUser(usuario.getId()).iterator();
                        Carrito item = null;
                        int cont = 0;
                        double subtotal = 0;
                        while (iterator.hasNext()) {
                            item = iterator.next();
                            double costo = item.getProducto().getPrecio() * item.getCantidad();
                            subtotal += costo;
                            cont++;
                    %>
                    <tr>
                        <td><img src="ImageController?id=<%= item.getProducto().getId()%>" width="80" height="80"></td>
                        <td><%= item.getProducto()%></td>
                        <td><%= item.getProducto().getPrecio()%></td>
                        <td><%= item.getCantidad()%></td>
                        <td><%= costo%></td>                    
                        <td class="text-right">
                            <a class="btn btn-danger" href="HomeController?accion=deleteproduct&id=<%= item.getId()%>">Eliminar</a> 
                        </td>

                    </tr>
                    <%}
                        if (cont > 0) {
                    %>
                    <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td><b>TOTAL</b></td>
                        <td><b><%=subtotal%></b></td>
                        <td class="text-right"><a class="btn btn-success" href="HomeController?accion=pagar">Pagar</a></td>
                    </tr>
                    <%}%>
                </table>
                <%if (cont<= 0) {%>
                <p>Carrito de compras vacío</p>
                <%}%>
                
            </div>
        </div>
    </body>
</html>
