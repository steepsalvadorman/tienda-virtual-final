<%@page import="com.steep.dao.VentaDao"%>
<%@page import="com.steep.model.Venta"%>
<%@page import="java.util.Iterator"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ver Venta</title>
    </head>
    <body>
        <%@include file="../../template/menu.jsp" %>
        <div class="container body">
            <h3>Detalle: Información</h3>

            <%
                Venta item = VentaDao.search(Integer.parseInt(request.getParameter("id")));
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
                    <label><b>Usuario</b></label>
                </div>
                <%= item.getUsuario()%>
            </div>
            <div class="form-row">
                <div class="col-md-2">
                    <label><b>Fecha</b></label>
                </div>
                <p><%= item.getFecha()%></p>
            </div>
            <div class="form-row">
                <div class="col-md-2">
                    <label><b>Monto total</b></label>
                </div>
                <%= item.getMonto_total()%>
            </div>            
            <div class="form-row">
                <div class="col-md-2">
                    <label><b>Estado</b></label>
                </div>
                <%= item.getEstado()%>
            </div>
            <div class="form-row">
                <div class="col-md-12">
                    <a href="VentaController?accion=list" class="btn btn-success"> Volver</a>
                </div>
            </div>
        </div>
    </body>
</html>