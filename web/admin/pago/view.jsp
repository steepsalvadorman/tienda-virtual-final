<%@page import="com.steep.dao.PagoDao"%>
<%@page import="com.steep.model.Pago"%>
<%@page import="java.util.Iterator"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ver Pago</title>
    </head>
    <body>
        <%@include file="../../template/menu.jsp" %>
        <div class="container body">
            <h3>Detalle: Información</h3>

            <%
                Pago item = PagoDao.search(Integer.parseInt(request.getParameter("id")));
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
                    <label><b>Venta</b></label>
                </div>
                <%= item.getVenta()%>
            </div>
            <div class="form-row">
                <div class="col-md-2">
                    <label><b>Fecha</b></label>
                </div>
                <p><%= item.getFecha()%></p>
            </div>
            <div class="form-row">
                <div class="col-md-2">
                    <label><b>Monto</b></label>
                </div>
                <%= item.getMonto()%>
            </div>
            <div class="form-row">
                <div class="col-md-12">
                    <a href="PagoController?accion=list" class="btn btn-success"> Volver</a>
                </div>
            </div>
        </div>
    </body>
</html>