
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
        <title>Agregar Pago</title>
    </head>
    <body>
        <%@include file="../../template/menu.jsp" %>
        <div class="container body">
            <h3>Pago : Crear</h3>            
            <br>

            <% if (!String.valueOf(request.getParameter("error")).equals("null")) {%>
            <div class="alert alert-danger alert-dismissable">
                <button type="button" class="close" data-dismiss="alert">&times;</button>
                <strong>¡Error!</strong> No se agregó el Pago. <%=Utils.MESSAGE%>
            </div> 
            <%}%>

            <form action="PagoController" method="POST">
                <div class="form-group">                        
                    <div class="col-md-12">
                        <label>Venta <b class="text-danger">*</b></label>
                        <select class="form-control" name="venta_id" required>
                            <option value="">Seleccionar venta...</option>
                            <%
                                Iterator<Venta> listaVenta = new VentaDao().list("").iterator();
                                Venta venta = null;
                                while (listaVenta.hasNext()) {
                                    venta = listaVenta.next();
                            %>
                            <option value="<%= venta.getId()%>"><%= venta%></option>
                            <%}%>
                        </select>
                    </div>
                </div> 
                <div class="form-group">                        
                    <div class="col-md-12">
                        <label>Monto <b class="text-danger">*</b></label>
                        <input class="form-control" type="number" step="0.01", min="0.01" name="monto" required/>
                    </div>
                </div> 
                        <div class="form-group">                        
                    <div class="col-md-12">
                        <label>Fecha <b class="text-danger">*</b></label>
                        <input class="form-control" type="date" name="fecha" required/>
                    </div>
                </div> 
                <div class="col-md-12">
                    <input class="btn btn-primary" type="submit" name="accion" value="Registrar"/>
                    <a href="PagoController?accion=list" class="btn btn-danger"> Cancelar</a>
                </div>
            </form>
        </div>
    </body>
</html>