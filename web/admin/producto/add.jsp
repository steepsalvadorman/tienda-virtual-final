<%@page import="com.steep.utils.Utils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Agregar Producto</title>
    </head>
    <body>
        <%@include file="../../template/menu.jsp" %>
        <div class="container body">
            <h3>Producto : Crear</h3>            
            <br>

            <% if (!String.valueOf(request.getParameter("error")).equals("null")) {%>
            <div class="alert alert-danger alert-dismissable">
                <button type="button" class="close" data-dismiss="alert">&times;</button>
                <strong>¡Error!</strong> No se agregó el Producto. <%=Utils.MESSAGE%>
            </div> 
            <%}%>

            <form action="ProductoController" method="POST" enctype="multipart/form-data">
                <div class="form-group">                        
                    <div class="col-md-12">
                        <label>Nombre <b class="text-danger">*</b></label>
                        <input class="form-control" type="text" name="nombre" required/>
                    </div>
                </div>                 
                <div class="form-group">                        
                    <div class="col-md-12">
                        <label>Descripción <b class="text-danger">*</b></label>
                        <input class="form-control" type="text" name="descripcion"/>
                    </div>
                </div> 
                <div class="form-group">                        
                    <div class="col-md-12">
                        <label>Stock <b class="text-danger">*</b></label>
                        <input class="form-control" type="number" name="stock" required/>
                    </div>
                </div> 
                <div class="form-group">                        
                    <div class="col-md-12">
                        <label>Precio <b class="text-danger">*</b></label>
                        <input class="form-control" type="number" name="precio" step="0.01" required/>
                    </div>
                </div> 
                <div class="form-group">                        
                    <div class="col-md-12">
                        <label>Imagen <b class="text-danger">*</b></label>
                        <input class="form-control" type="file" name="fileFoto" />
                    </div>
                </div>
                <div class="col-md-12">
                    <input class="btn btn-primary" type="submit" name="accion" value="Registrar"/>
                    <a href="ProductoController?accion=list" class="btn btn-danger"> Cancelar</a>
                </div>
            </form>
        </div>
    </body>
</html>