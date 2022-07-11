
<%@page import="com.steep.dao.RolDao"%>
<%@page import="com.steep.model.Rol"%>
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
        <title>Agregar Usuario</title>
    </head>
    <body>
        <%@include file="../../template/menu.jsp" %>
        <div class="container body">
            <h3>Usuario : Crear</h3>            
            <br>

            <% if (!String.valueOf(request.getParameter("error")).equals("null")) {%>
            <div class="alert alert-danger alert-dismissable">
                <button type="button" class="close" data-dismiss="alert">&times;</button>
                <strong>¡Error!</strong> No se agregó el Usuario. <%=Utils.MESSAGE%>
            </div> 
            <%}%>

            <form action="UsuarioController" method="POST">                                
                <div class="form-group">                        
                    <div class="col-md-12">
                        <label>DNI <b class="text-danger">*</b></label>
                        <input class="form-control" type="text" name="dni" required/>
                    </div>
                </div>
                <div class="form-group">                        
                    <div class="col-md-12">
                        <label>Nombres <b class="text-danger">*</b></label>
                        <input class="form-control" type="text" name="nombres" required/>
                    </div>
                </div> 
                <div class="form-group">                        
                    <div class="col-md-12">
                        <label>Apellidos <b class="text-danger">*</b></label>
                        <input class="form-control" type="text" name="apellidos" required/>
                    </div>
                </div> 
                <div class="form-group">                        
                    <div class="col-md-12">
                        <label>Dirección <b class="text-danger">*</b></label>
                        <input class="form-control" type="text" name="direccion" required/>
                    </div>
                </div> 
                <div class="form-group">                        
                    <div class="col-md-12">
                        <label>Email <b class="text-danger">*</b></label>
                        <input class="form-control" type="email" name="email" required/>
                    </div>
                </div> 
                <div class="form-group">                        
                    <div class="col-md-12">
                        <label>Contraseña <b class="text-danger">*</b></label>
                        <input class="form-control" type="password" name="password" required/>
                    </div>
                </div>                 
                <div class="form-group">                        
                    <div class="col-md-12">
                        <label>Rol <b class="text-danger">*</b></label>
                        <select class="form-control" name="rol_id" required>
                            <option value="">Seleccionar rol...</option>
                            <%
                                Iterator<Rol> listaRol = new RolDao().list("").iterator();
                                Rol rol = null;
                                while (listaRol.hasNext()) {
                                    rol = listaRol.next();
                            %>
                            <option value="<%= rol.getId()%>"><%= rol%></option>
                            <%}%>
                        </select>
                    </div>
                </div> 
                <div class="col-md-12">
                    <input class="btn btn-primary" type="submit" name="accion" value="Registrar"/>
                    <a href="UsuarioController?accion=list" class="btn btn-danger"> Cancelar</a>
                </div>
            </form>
        </div>
    </body>
</html>