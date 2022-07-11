<%@page import="com.steep.utils.Utils"%>
<%@page import="com.steep.dao.ProductoDao"%>
<%@page import="com.steep.model.Producto"%>
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
            <h1>Productos</h1>

            <% if (!String.valueOf(request.getParameter("success")).equals("null")) {%>
            <div class="alert alert-success alert-dismissable">
                <button type="button" class="close" data-dismiss="alert">&times;</button>
                <strong>¡Éxito!</strong> Producto <%=request.getParameter("success")%> correctamente
            </div> 
            <%}%>

            <% if (!String.valueOf(request.getParameter("error")).equals("null")) {%>
            <div class="alert alert-danger alert-dismissable">
                <button type="button" class="close" data-dismiss="alert">&times;</button>
                <strong>¡Error!</strong> No se eliminó el Producto. <%=Utils.MESSAGE%>
            </div> 
            <%}%>

            <form action="ProductoController" method="GET">
                <div class="form-row">
                    <div class="col-md-12">
                        <label class="control-label">Buscar por Nombre</label>                        
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
                        <a href="ProductoController?accion=add" class="btn btn-success"><i class="fa fa-plus" aria-hidden="true"></i> Crear Nuevo</a>
                    </div>
                </div>
            </form>
            <br>
            <table class="table">
                <tr>
                    <th>Nombre</th>
                    <th>Descripcion</th>                    
                    <th>Precio</th>
                    <th>Stock</th>
                    <th>Imagen</th>
                    <th></th>
                </tr>
                <%
                    Iterator<Producto> iterator = ProductoDao.list(filter).iterator();
                    Producto item = null;
                    while (iterator.hasNext()) {
                        item = iterator.next();
                %>
                <tr>
                    <td><%= item.getNombre()%></td>
                    <td><%= item.getDescripcion()%></td>                    
                    <td><%= item.getPrecio()%></td>
                    <td><%= item.getStock()%></td>
                    <td><img src="ImageController?id=<%= item.getId()%>" width="80" height="80"></td>
                    <td class="text-right">
                        <div class="dropdown">
                            <button class="btn btn-primary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                Opciones
                            </button>
                            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                <a class="dropdown-item" href="ProductoController?accion=edit&id=<%= item.getId()%>">Editar</a>
                                <a class="dropdown-item" href="ProductoController?accion=delete&id=<%= item.getId()%>">Eliminar</a>                                
                                <a class="dropdown-item" href="ProductoController?accion=view&id=<%= item.getId()%>">Ver</a>
                            </div>
                        </div>
                    </td>

                </tr>
                <%}%>
            </table>
        </div>
    </body>

</html>