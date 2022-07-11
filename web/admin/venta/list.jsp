<%@page import="com.steep.utils.Utils"%>
<%@page import="com.steep.dao.VentaDao"%>
<%@page import="com.steep.model.Venta"%>
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
            <h1>Ventas</h1>

            <% if (!String.valueOf(request.getParameter("success")).equals("null")) {%>
            <div class="alert alert-success alert-dismissable">
                <button type="button" class="close" data-dismiss="alert">&times;</button>
                <strong>¡Éxito!</strong> Venta <%=request.getParameter("success")%> correctamente
            </div> 
            <%}%>

            <% if (!String.valueOf(request.getParameter("error")).equals("null")) {%>
            <div class="alert alert-danger alert-dismissable">
                <button type="button" class="close" data-dismiss="alert">&times;</button>
                <strong>¡Error!</strong> No se eliminó el Venta. <%=Utils.MESSAGE%>
            </div> 
            <%}%>

            <form action="VentaController" method="GET">
                <div class="form-row">
                    <div class="col-md-12">
                        <label class="control-label">Buscar por Fecha (YYYY-MM-DD)</label>                        
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
                        <a href="VentaController?accion=add" class="btn btn-success"><i class="fa fa-plus" aria-hidden="true"></i> Crear Nuevo</a>
                    </div>
                </div>
            </form>
            <br>
            <table class="table">
                <tr>
                    <th>Usuario</th>
                    <th>Fecha</th>                    
                    <th>Monto total</th>
                    <th>Estado</th>
                    <th></th>
                </tr>
                <%
                    Iterator<Venta> iterator = VentaDao.list(filter).iterator();
                    Venta item = null;
                    while (iterator.hasNext()) {
                        item = iterator.next();
                %>
                <tr>
                    <td><%= item.getUsuario()%></td>
                    <td><%= item.getFecha()%></td>                    
                    <td><%= item.getMonto_total()%></td>
                    <td><%= item.getEstado()%></td>
                    <td class="text-right">
                        <div class="dropdown">
                            <button class="btn btn-primary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                Opciones
                            </button>
                            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                <a class="dropdown-item" href="VentaController?accion=edit&id=<%= item.getId()%>">Editar</a>
                                <a class="dropdown-item" href="VentaController?accion=delete&id=<%= item.getId()%>">Eliminar</a>                                
                                <a class="dropdown-item" href="VentaController?accion=view&id=<%= item.getId()%>">Ver</a>
                            </div>
                        </div>
                    </td>
                </tr>
                <%}%>
            </table>
        </div>
    </body>

</html>