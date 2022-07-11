<%@page import="com.steep.dao.ProductoDao"%>
<%@page import="com.steep.model.Producto"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.steep.dao.UsuarioDao"%>
<%@page import="com.steep.model.Usuario"%>
<%@page import="com.steep.utils.Utils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Agregar Carrito</title>
    </head>
    <body>
        <%@include file="../../template/menu.jsp" %>
        <div class="container body">
            <h3>Carrito : Crear</h3>            
            <br>

            <% if (!String.valueOf(request.getParameter("error")).equals("null")) {%>
            <div class="alert alert-danger alert-dismissable">
                <button type="button" class="close" data-dismiss="alert">&times;</button>
                <strong>¡Error!</strong> No se agregó el Carrito. <%=Utils.MESSAGE%>
            </div> 
            <%}%>

            <form action="CarritoController" method="POST">
                <div class="form-group">                        
                    <div class="col-md-12">
                        <label>Usuario <b class="text-danger">*</b></label>
                        <select class="form-control" name="usuario_id" required>
                            <option value="">Seleccionar usuario...</option>
                            <%
                                Iterator<Usuario> listaUsuario = new UsuarioDao().list("").iterator();
                                Usuario usuario = null;
                                while (listaUsuario.hasNext()) {
                                    usuario = listaUsuario.next();
                            %>
                            <option value="<%= usuario.getId()%>"><%= usuario%></option>
                            <%}%>
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
                            %>
                            <option value="<%= producto.getId()%>"><%= producto%></option>
                            <%}%>
                        </select>
                    </div>
                </div> 
                <div class="form-group">                        
                    <div class="col-md-12">
                        <label>Cantidad <b class="text-danger">*</b></label>
                        <input class="form-control" type="number" name="cantidad" required/>
                    </div>
                </div> 
                <div class="col-md-12">
                    <input class="btn btn-primary" type="submit" name="accion" value="Registrar"/>
                    <a href="CarritoController?accion=list" class="btn btn-danger"> Cancelar</a>
                </div>
            </form>
        </div>
    </body>
</html>