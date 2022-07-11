
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%@include file="../template/menu_cliente.jsp" %>
        <div class="main">
            <div class="shop_top">
                <div class="container">
                    <% if (!String.valueOf(request.getParameter("error")).equals("null")) {%>
                    <div class="alert alert-danger alert-dismissable">
                        <button type="button" class="close" data-dismiss="alert">&times;</button>
                        <strong>¡Error!</strong> No se creó el Usuario. <%=Utils.MESSAGE%>
                    </div> 
                    <%}%>
                    <form  action="HomeController" method="POST"> 
                        <div class="register-top-grid">
                            <h3>INFORMACION PERSONAL</h3>
                            <div class="">
                                <span>DNI <label><b class="text-danger"> *</b></label></span>
                                <input class="form-control" type="text" name="dni" required> 
                            </div>
                            <div>
                                <span>NOMBRES <label><b class="text-danger"> *</b></label></span>
                                <input class="form-control" type="text" name="nombres" required> 
                            </div>
                            <div>
                                <span>APELLIDOS <label><b class="text-danger"> *</b></label></span>
                                <input class="form-control" type="text" name="apellidos" required> 
                            </div>                            
                            <div>
                                <span>DIRECCIÓN <label><b class="text-danger"> *</b></label></span>
                                <input class="form-control" type="text" name="direccion" required> 
                            </div>
                            <div class="clear"> </div>
                        </div>
                        <div class="clear"> </div>
                        <div class="register-bottom-grid">
                            <h3>INFORMACION PARA INICIAR SESIÓN</h3>
                            <div>
                                <span>EMAIL <label><b class="text-danger"> *</b></label></span>
                                <input class="form-control" type="email" name="email" required> 
                            </div>
                            <div>
                                <span>PASSWORD <label><b class="text-danger"> *</b></label></span>
                                <input class="form-control" type="password" name="password" required>
                            </div>
                            <div class="clear"> </div>
                        </div>
                        <div class="clear"> </div>
                        <input class="btn btn-primary" type="submit" name="accion" value="Registrarse">
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
