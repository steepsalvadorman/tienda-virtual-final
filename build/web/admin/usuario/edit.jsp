<%@page import="com.steep.dao.RolDao"%>
<%@page import="com.steep.model.Rol"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.steep.utils.Utils"%>
<%@page import="com.steep.dao.UsuarioDao"%>
<%@page import="com.steep.model.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@page session="true"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Editar Usuario</title>
    </head>
    <body>
        <%@include file="../../template/menu.jsp" %>
        <div class="container body">
            <h3>Usuario: Editar</h3>
            <br>

            <%
                Usuario object = UsuarioDao.search(Integer.parseInt(request.getParameter("id")));
            %>

            <% if (!String.valueOf(request.getParameter("error")).equals("null")) {%>
            <div class="alert alert-danger alert-dismissable">
                <button type="button" class="close" data-dismiss="alert">&times;</button>
                <strong>¡Error!</strong> No se actualizó el Usuario. <%=Utils.MESSAGE%>
            </div> 
            <%}%>

            <form action="UsuarioController" method="POST">
                <div class="form-group">                        
                    <div class="col-md-12">
                        <input class="form-control" type="number" name="id" value="<%= object.getId()%>" required hidden="true"/>
                    </div>
                </div> 
                <div class="form-group">                        
                    <div class="col-md-12">
                        <label>DNI <b class="text-danger">*</b></label>
                        <input class="form-control" type="text" name="dni" value="<%= object.getDni()%>" required/>
                    </div>
                </div>
                <div class="form-group">                        
                    <div class="col-md-12">
                        <label>Nombres <b class="text-danger">*</b></label>
                        <input class="form-control" type="text" name="nombres" value="<%= object.getNombres()%>" required/>
                    </div>
                </div> 
                <div class="form-group">                        
                    <div class="col-md-12">
                        <label>Apellidos <b class="text-danger">*</b></label>
                        <input class="form-control" type="text" name="apellidos" value="<%= object.getApellidos()%>" required/>
                    </div>
                </div> 
                <div class="form-group">                        
                    <div class="col-md-12">
                        <label>Dirección <b class="text-danger">*</b></label>
                        <input class="form-control" type="text" name="direccion" value="<%= object.getDireccion()%>" required/>
                    </div>
                </div> 
                <div class="form-group">                        
                    <div class="col-md-12">
                        <label>Email <b class="text-danger">*</b></label>
                        <input class="form-control" type="email" name="email" value="<%= object.getEmail()%>" required/>
                    </div>
                </div> 
                <div class="form-group">                        
                    <div class="col-md-12">
                        <label>Contraseña <b class="text-danger">*</b></label>
                        <input class="form-control" type="password" name="password" value="<%= object.getPassword()%>" required/>
                    </div>
                </div> 
                <div class="form-group">                        
                    <div class="col-md-12">
                        <label>Nombre <b class="text-danger">*</b></label>
                        <select class="form-control" name="rol_id" required>
                            <option value="">Seleccionar rol...</option>
                            <%
                                Iterator<Rol> listaRol = new RolDao().list("").iterator();
                                Rol rol = null;
                                while (listaRol.hasNext()) {
                                    rol = listaRol.next();
                                    if (rol.getId() == object.getRol().getId()) {
                            %>
                            <option value="<%= rol.getId()%>" selected><%= rol%></option>
                            <%
                            } else {
                            %>
                            <option value="<%= rol.getId()%>"><%= rol%></option>
                            <%}
                                }%>
                        </select>
                    </div>
                </div>

                <div class="col-md-12">
                    <input class="btn btn-primary" type="submit" name="accion" value="Actualizar"/>
                    <a href="UsuarioController?accion=list" class="btn btn-danger"> Cancelar</a>
                </div>
            </form>
        </div>
    </body>
</html>