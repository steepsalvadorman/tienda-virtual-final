<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%@include file="template/menu_login.jsp" %>
        <div class="main">
            <div class="shop_top">
                <div class="container">
                    <div class="col-md-8">
                        <div class="login-title">
                            <h4 class="title">Inicio de Sesión</h4>
                            <div id="loginbox" class="loginbox">
                                <form action="UsuarioController" method="post" name="login" id="login-form">
                                    <% if (!String.valueOf(request.getParameter("error")).equals("null")) {%>
                                    <div class="alert alert-danger alert-dismissable">
                                        <button type="button" class="close" data-dismiss="alert">&times;</button>
                                        <strong>¡Error!</strong> Credenciales incorrectas. <br>
                                        Usuario default: <br>
                                        email [admin@gmail.com] <br>
                                        password [admin]
                                    </div> 
                                    <%}%>
                                    <fieldset class="input">
                                        <p id="login-form-username">
                                            <label for="modlgn_username">Username</label>
                                            <input id="modlgn_username" type="email" name="username" class="inputbox" size="18" autocomplete="off" required>
                                        </p>
                                        <p id="login-form-password">
                                            <label for="modlgn_passwd">Password</label>
                                            <input id="modlgn_passwd" type="password" name="password" class="inputbox" size="18" autocomplete="off" required>
                                        </p>
                                        <div class="remember">
                                            <p id="login-form-remember">
                                                <label for="modlgn_remember"><a href="HomeController?accion=register">Crear cuenta </a></label>
                                            </p>
                                            <input type="submit" name="accion" class="button" value="Login"><div class="clear"></div>
                                        </div>
                                    </fieldset>
                                </form>
                            </div>
                        </div>
                        <div class="clear"></div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>