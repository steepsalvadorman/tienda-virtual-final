<%@page import="com.steep.dao.ProductoDao"%>
<%@page import="com.steep.model.Producto"%>
<%@page import="java.util.Iterator"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Shop</title>
    </head>
    <body>
        <%@include file="../template/menu_cliente.jsp"%>
        <div class="main">
            <div class="shop_top">
                <div class="container">
                    <%
                        String filter = "";
                        if (!String.valueOf(request.getParameter("filter")).equals("null")) {
                            filter = request.getParameter("filter");
                        }
                    %>
                    <div class="row col-md-12">
                        <%
                            if (!String.valueOf(request.getParameter("success")).equals("null")) {
                        %>
                        <div class="alert alert-success alert-dismissable">
                            <button type="button" class="close" data-dismiss="alert">&times;</button>
                            <strong>¡Éxito!</strong> Producto agregado al carrito
                        </div>
                        <%
                            }
                        %>

                        <%
                            if (!String.valueOf(request.getParameter("error")).equals("null")) {
                        %>
                        <div class="alert alert-danger alert-dismissable">
                            <button type="button" class="close" data-dismiss="alert">&times;</button>
                            <strong>¡Error!</strong> No se pudo agregar el producto al carrito
                        </div>
                        <%
                            }
                        %>
                    </div>
                    <div>
                        <form action="ShopController" method="GET">
                            <div class="form-row">
                                <div class="col-md-10">
                                    <input class="form-control" type="text" name="filter"
                                           value="<%=filter%>" placeholder="Buscar porducto por nombre" />
                                </div>
                                <div class="col-md-2">
                                    <input type="submit" name="accion" value="Buscar"
                                           class="btn btn-danger col-md-10" />
                                </div>
                            </div>
                        </form>
                    </div>
                    <br>
                    <%
                        Iterator<Producto> iterator = ProductoDao.list(filter).iterator();
                        Producto item = null;
                        while (iterator.hasNext()) {
                    %>
                    <div class="row shop_box-top">
                        <%
                            for (int i = 0; i < 4; i++) {
                                if (iterator.hasNext()) {
                                    item = iterator.next();
                        %>
                        <div class="col-md-3 shop_box">
                            <div class="text-center">
                                <img src="ImageController?id=<%=item.getId()%>"
                                     class="img-fluid" alt="" />
                            </div>
                            <div class="shop_desc">
                                <h3>
                                    <a href="#"><%=item.getNombre()%></a>
                                </h3>
                                <p> <%=item.getDescripcion()%></p>
                                <span class="actual">$<%=item.getPrecio()%></span><br>
                                <span class="actual">Stock: <%=item.getStock()%></span><br>
                                <ul class="buttons">
                                    <li class="cart"><a href="ShopController?accion=addcar&producto_id=<%=item.getId()%>">Add To Cart</a></li>
                                    <div class="clear"></div>
                                </ul>
                            </div>
                        </div>
                        <%
                                }
                            }
                        %>
                    </div>
                    <%
                        }
                    %>
                </div>
            </div>
        </div>
        <div class="footer"></div>
    </body>
</html>