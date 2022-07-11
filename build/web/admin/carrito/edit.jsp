<%@page import="com.steep.dao.ProductoDao"%>
<%@page import="com.steep.model.Producto"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.steep.dao.UsuarioDao"%>
<%@page import="com.steep.model.Usuario"%>
<%@page import="com.steep.utils.Utils"%>
<%@page import="com.steep.dao.CarritoDao"%>
<%@page import="com.steep.model.Carrito"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@page session="true"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Editar Carrito</title>
    </head>
    <body>
        <%@include file="../../template/menu.jsp" %>
        <div class="container body">
            <h3>Carrito: Editar</h3>
            <br>

            <%
                Carrito object = CarritoDao.search(Integer.parseInt(request.getParameter("id")));
            %>

            <% if (!String.valueOf(request.getParameter("error")).equals("null")) {%>
            <div class="alert alert-danger alert-dismissable">
                <button type="button" class="close" data-dismiss="alert">&times;</button>
                <strong>¡Error!</strong> No se actualizó el Carrito. <%=Utils.MESSAGE%>
            </div> 
            <%}%>

            <form action="CarritoController" method="POST">
                <div class="form-group">                        
                    <div class="col-md-12">
                        <input class="form-control" type="number" name="id" value="<%= object.getId()%>" required hidden="true"/>
                    </div>
                </div>  
                <div class="form-group">                        
                    <div class="col-md-12">
                        <label>Nombre <b class="text-danger">*</b></label>
                        <select class="form-control" name="usuario_id" required>
                            <option value="">Seleccionar usuario...</option>
                            <%
                                Iterator<Usuario> listaUsuario = new UsuarioDao().list("").iterator();
                                Usuario usuario = null;
                                while (listaUsuario.hasNext()) {
                                    usuario = listaUsuario.next();
                                    if (usuario.getId() == object.getUsuario().getId()) {
                            %>
                            <option value="<%= usuario.getId()%>" selected><%= usuario%></option>
                            <%
                            } else {
                            %>
                            <option value="<%= usuario.getId()%>"><%= usuario%></option>
                            <%}
                                }%>
                        </select>
                    </div>
                </div>                     
                <div class="form-group">                        
                    <div class="col-md-12">
                        <label>Producto <b class="text-danger">*</b></label>
                        <select class="form-control" name="producto_id" required>
                            <option value="">Seleccionar producto...</option>
                            <%
                                Iterator<Producto> listaProducto = new ProductoDao().list("").iterator();
                                Producto producto = null;
                                while (listaProducto.hasNext()) {
                                    producto = listaProducto.next();
                                    if (producto.getId() == object.getProducto().getId()) {
                            %>
                            <option value="<%= producto.getId()%>" selected><%= producto%></option>
                            <%
                            } else {
                            %>
                            <option value="<%= producto.getId()%>"><%= producto%></option>
                            <%}
                                }%>
                        </select>
                    </div>
                </div> 
                <div class="form-group">                        
                    <div class="col-md-12">
                        <label>Cantidad <b class="text-danger">*</b></label>
                        <input class="form-control" type="number" name="cantidad" value="<%= object.getCantidad()%>" required/>
                    </div>
                </div>      
                <div class="col-md-12">
                    <input class="btn btn-primary" type="submit" name="accion" value="Actualizar"/>
                    <a href="CarritoController?accion=list" class="btn btn-danger"> Cancelar</a>
                </div>
            </form>
        </div>
    </body>
</html>