<%@page import="com.steep.dao.VentaDao"%>
<%@page import="com.steep.model.Venta"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.steep.utils.Utils"%>
<%@page import="com.steep.dao.PagoDao"%>
<%@page import="com.steep.model.Pago"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@page session="true"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Editar Pago</title>
    </head>
    <body>
        <%@include file="../../template/menu.jsp" %>
        <div class="container body">
            <h3>Pago: Editar</h3>
            <br>

            <%
                Pago object = PagoDao.search(Integer.parseInt(request.getParameter("id")));
            %>

            <% if (!String.valueOf(request.getParameter("error")).equals("null")) {%>
            <div class="alert alert-danger alert-dismissable">
                <button type="button" class="close" data-dismiss="alert">&times;</button>
                <strong>¡Error!</strong> No se actualizó el Pago. <%=Utils.MESSAGE%>
            </div> 
            <%}%>

            <form action="PagoController" method="POST">
                <div class="form-group">                        
                    <div class="col-md-12">
                        <input class="form-control" type="number" name="id" value="<%= object.getId()%>" required hidden="true"/>
                    </div>
                </div>  
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
                                    if (venta.getId() == object.getId()) {
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
                        <label>Monto <b class="text-danger">*</b></label>
                        <input class="form-control" type="number" step="0.01", min="0.01" name="monto" value="<%= object.getMonto()%>"  required/>
                    </div>
                </div> 
                        <div class="form-group">                        
                    <div class="col-md-12">
                        <label>Fecha <b class="text-danger">*</b></label>
                        <input class="form-control" type="date" name="fecha" value="<%= object.getFecha()%>"  required/>
                    </div>
                </div>     
                <div class="col-md-12">
                    <input class="btn btn-primary" type="submit" name="accion" value="Actualizar"/>
                    <a href="PagoController?accion=list" class="btn btn-danger"> Cancelar</a>
                </div>
            </form>
        </div>
    </body>
</html>