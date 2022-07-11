<%@page import="com.steep.dao.VentaDao"%>
<%@page import="com.steep.model.Venta"%>
<%@page import="com.steep.dao.ProductoDao"%>
<%@page import="com.steep.model.Producto"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.steep.dao.UsuarioDao"%>
<%@page import="com.steep.model.Usuario"%>
<%@page import="com.steep.utils.Utils"%>
<%@page import="com.steep.dao.DetalleVentaDao"%>
<%@page import="com.steep.model.DetalleVenta"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@page session="true"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Editar DetalleVenta</title>
    </head>
    <body>
        <%@include file="../../template/menu.jsp" %>
        <div class="container body">
            <h3>DetalleVenta: Editar</h3>
            <br>

            <%
                DetalleVenta object = DetalleVentaDao.search(Integer.parseInt(request.getParameter("id")));
            %>

            <% if (!String.valueOf(request.getParameter("error")).equals("null")) {%>
            <div class="alert alert-danger alert-dismissable">
                <button type="button" class="close" data-dismiss="alert">&times;</button>
                <strong>¡Error!</strong> No se actualizó el DetalleVenta. <%=Utils.MESSAGE%>
            </div> 
            <%}%>

            <form action="DetalleVentaController" method="POST">
                <div class="form-group">                        
                    <div class="col-md-12">
                        <input class="form-control" type="number" name="id" value="<%= object.getId()%>" required hidden="true"/>
                    </div>
                </div>  
                <div class="form-group">                        
                    <div class="col-md-12">
                        <label>Nombre <b class="text-danger">*</b></label>
                        <select class="form-control" name="venta_id" required>
                            <option value="">Seleccionar venta...</option>
                            <%
                                Iterator<Venta> listaVenta = new VentaDao().list("").iterator();
                                Venta venta = null;
                                while (listaVenta.hasNext()) {
                                    venta = listaVenta.next();
                                    if (venta.getId() == object.getVenta().getId()) {
                            %>
                            <option value="<%= venta.getId()%>" selected><%= venta%></option>
                            <%
                            } else {
                            %>
                            <option value="<%= venta.getId()%>"><%= venta%></option>
                            <%}}%>
                        </select>
                    </div>
                </div>                     
                <div class="form-group">                        
                    <div class="col-md-12">
                        <label>Descripción <b class="text-danger">*</b></label>
                        <select class="form-control" name="producto_id" required>
                            <option value="">Seleccionar usuario...</option>
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
                    <a href="DetalleVentaController?accion=list" class="btn btn-danger"> Cancelar</a>
                </div>
            </form>
        </div>
    </body>
</html>