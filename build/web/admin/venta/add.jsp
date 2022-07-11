
<%@page import="com.steep.dao.UsuarioDao"%>
<%@page import="com.steep.model.Usuario"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.steep.dao.VentaDao"%>
<%@page import="com.steep.model.Venta"%>
<%@page import="com.steep.utils.Utils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Agregar Venta</title>
    </head>
    <body>
        <%@include file="../../template/menu.jsp" %>
        <div class="container body">
            <h3>Venta : Crear</h3>            
            <br>

            <% if (!String.valueOf(request.getParameter("error")).equals("null")) {%>
            <div class="alert alert-danger alert-dismissable">
                <button type="button" class="close" data-dismiss="alert">&times;</button>
                <strong>¡Error!</strong> No se agregó el Venta. <%=Utils.MESSAGE%>
            </div> 
            <%}%>

            <form action="VentaController" method="POST">
                <div class="form-group">                        
                    <div class="col-md-12">
                        <label>usuario <b class="text-danger">*</b></label>
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
                        <label>Fecha <b class="text-danger">*</b></label>
                        <input class="form-control" type="date" name="fecha" required/>
                    </div>
                </div>
                <div class="form-group">                        
                    <div class="col-md-12">
                        <label>Monto total <b class="text-danger">*</b></label>
                        <input class="form-control" type="number" step="0.01", min="0.01" name="monto_total" required/>
                    </div>
                </div> 
                <div class="form-group">                        
                    <div class="col-md-12">
                        <label>Estado <b class="text-danger">*</b></label>
                        <select class="form-control" name="estado">
                            <option value="Completado">Completado</option>
                            <option value="Incompleto">Incompleto</option>
                        </select>
                    </div>
                </div> 
                <div class="col-md-12">
                    <input class="btn btn-primary" type="submit" name="accion" value="Registrar"/>
                    <a href="VentaController?accion=list" class="btn btn-danger"> Cancelar</a>
                </div>
            </form>
        </div>
    </body>
</html>