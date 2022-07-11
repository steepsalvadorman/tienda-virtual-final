<%@page import="com.steep.utils.Utils"%>
<%@page import="com.steep.dao.DetalleVentaDao"%>
<%@page import="com.steep.model.DetalleVenta"%>
<%@page import="java.util.Iterator"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Insert title here</title>
    </head>
    <body>
        <%@include file="../../template/menu.jsp" %>
        <div class="container body">
            <%
                String filter = "";
                if (!String.valueOf(request.getParameter("filter")).equals("null")) {
                    filter = String.valueOf(request.getParameter("filter")).trim();
                }
            %>
            <h1>Detalle Ventas</h1>

            <% if (!String.valueOf(request.getParameter("success")).equals("null")) {%>
            <div class="alert alert-success alert-dismissable">
                <button type="button" class="close" data-dismiss="alert">&times;</button>
                <strong>¡Éxito!</strong> DetalleVenta <%=request.getParameter("success")%> correctamente
            </div> 
            <%}%>

            <% if (!String.valueOf(request.getParameter("error")).equals("null")) {%>
            <div class="alert alert-danger alert-dismissable">
                <button type="button" class="close" data-dismiss="alert">&times;</button>
                <strong>¡Error!</strong> No se eliminó el DetalleVenta. <%=Utils.MESSAGE%>
            </div> 
            <%}%>

            <form action="DetalleVentaController" method="GET">
                <div class="form-row">
                    <div class="col-md-12">
                        <label class="control-label">Buscar por id Venta</label>                        
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-8">
                        <input class="form-control" type="text" name="filter" value="<%= filter%>"/>
                    </div>
                    <div class="col-md-2" >
                        <input type="submit" name="accion" value="Buscar" class="btn btn-danger col-md-10" />
                    </div>
                    <div class="col-md-2 text-right">
                        <a href="DetalleVentaController?accion=add" class="btn btn-success"><i class="fa fa-plus" aria-hidden="true"></i> Crear Nuevo</a>
                    </div>
                </div>
            </form>
            <br>
            <table class="table">
                <tr>
                    <th>Venta</th>
                    <th>Producto</th>                    
                    <th>Cantidad</th>
                    <th>Precio</th>
                    <th>Sub total</th>
                    <th></th>
                </tr>
                <%
                    Iterator<DetalleVenta> iterator = DetalleVentaDao.list(filter).iterator();
                    DetalleVenta item = null;
                    while (iterator.hasNext()) {
                        item = iterator.next();
                %>
                <tr>
                    <td><%= item.getVenta()%></td>
                    <td><%= item.getProducto()%></td>                    
                    <td><%= item.getCantidad()%></td>
                    <td><%= item.getPrecio() %></td>
                    <td><%= (item.getPrecio() * item.getCantidad()) %></td>
                    <td class="text-right">
                        <div class="dropdown">
                            <button class="btn btn-primary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                Opciones
                            </button>
                            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                <a class="dropdown-item" href="DetalleVentaController?accion=edit&id=<%= item.getId()%>">Editar</a>
                                <a class="dropdown-item" href="DetalleVentaController?accion=delete&id=<%= item.getId()%>">Eliminar</a>                                
                                <a class="dropdown-item" href="DetalleVentaController?accion=view&id=<%= item.getId()%>">Ver</a>
                            </div>
                        </div>
                    </td>
                </tr>
                <%}%>
            </table>
        </div>
    </body>

</html>