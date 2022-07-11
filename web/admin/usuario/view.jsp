<%@page import="com.steep.dao.UsuarioDao"%>
<%@page import="com.steep.model.Usuario"%>
<%@page import="java.util.Iterator"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ver Usuario</title>
    </head>
    <body>
        <%@include file="../../template/menu.jsp" %>
        <div class="container body">
            <h3>Detalle: Información</h3>

            <%
                Usuario item = UsuarioDao.search(Integer.parseInt(request.getParameter("id")));
            %>

            <br>
            <div class="form-row">
                <div class="col-md-2">
                    <label><b>Id</b></label>
                </div>
                <%= item.getId()%>
            </div>  
            <div class="form-row">
                <div class="col-md-2">
                    <label><b>DNI</b></label>
                </div>
                <%= item.getDni()%>
            </div>
            <div class="form-row">
                <div class="col-md-2">
                    <label><b>Nombres</b></label>
                </div>
                <p><%= item.getNombres()%></p>
            </div>
            <div class="form-row">
                <div class="col-md-2">
                    <label><b>Apellidos</b></label>
                </div>
                <%= item.getApellidos()%>
            </div>            
            <div class="form-row">
                <div class="col-md-2">
                    <label><b>Dirección</b></label>
                </div>
                <%= item.getDireccion()%>
            </div>
            <div class="form-row">
                <div class="col-md-2">
                    <label><b>Email</b></label>
                </div>
                <%= item.getEmail()%>
            </div>
            <div class="form-row">
                <div class="col-md-2">
                    <label><b>Rol</b></label>
                </div>
                <%= item.getRol()%>
            </div>
            <div class="form-row">
                <div class="col-md-12">
                    <a href="UsuarioController?accion=list" class="btn btn-success"> Volver</a>
                </div>
            </div>
        </div>
    </body>
</html>