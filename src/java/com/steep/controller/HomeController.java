package com.steep.controller;

import com.steep.dao.CarritoDao;
import com.steep.dao.DetalleVentaDao;
import com.steep.dao.RolDao;
import com.steep.dao.UsuarioDao;
import com.steep.dao.VentaDao;
import com.steep.model.Carrito;
import com.steep.model.DetalleVenta;
import com.steep.model.Usuario;
import com.steep.model.Venta;
import com.steep.utils.Utils;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class HomeController
 */
@WebServlet("/HomeController")
public class HomeController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    String login = "index.jsp";
    String register = "client/register.jsp";
    String shop = "client/shop.jsp";

    String account = "client/account.jsp";
    String miscompras = "client/miscompras.jsp";
    String checkout = "client/checkout.jsp";
    String search = "cliente/shop.jsp";

    HttpSession session;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public HomeController() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO Auto-generated method stub
        String acceso = shop;
        session = request.getSession();
        try {
            String action = request.getParameter("accion");
            if (Utils.isLogged(session)) {
                switch (action) {
                    case "shop":
                    case "Buscar":
                        acceso = shop;
                        break;
                    case "login":
                        acceso = login;
                        break;
                    case "register":
                        acceso = register;
                        break;
                    case "account":
                        acceso = account;
                        break;
                    case "miscompras":
                        acceso = miscompras;
                        break;
                    case "deleteproduct":
                        if (CarritoDao.delete(Integer.parseInt(request.getParameter("id")))) {
                            acceso = checkout + "?success=eliminado";
                        } else {
                            acceso = checkout + "?success=true";
                        }
                        break;
                    case "checkout":
                        acceso = checkout;
                        break;
                    case "pagar":
                        Usuario usuario = (Usuario) session.getAttribute("user");
                        Venta venta = new Venta();
                        venta.setEstado("Completado");
                        venta.setFecha(new Date());
                        venta.setUsuario(usuario);

                        int venta_id = VentaDao.comprar(venta);
                        if (venta_id > 0) {
                            venta.setId(venta_id);
                            ArrayList<Carrito> data = CarritoDao.listByUser(usuario.getId());
                            for (Carrito item : data) {
                                DetalleVenta detalle = new DetalleVenta();
                                detalle.setVenta(venta);
                                detalle.setProducto(item.getProducto());
                                detalle.setPrecio(item.getProducto().getPrecio());
                                detalle.setCantidad(item.getCantidad());

                                if (DetalleVentaDao.add(detalle)) {
                                    CarritoDao.delete(item.getId());
                                }
                            }
                        }
                        acceso = checkout + "?finish=true";
                        break;
                    default:
                        acceso = login;
                        break;
                }
            } else {
                switch (action) {
                    case "shop":
                    case "Buscar":
                        acceso = shop;
                        break;
                    case "login":
                        acceso = login;
                        break;
                    case "register":
                        acceso = register;
                        break;
                }
            }
        } catch (Exception e) {
            acceso = login;
        }
        RequestDispatcher vista = request.getRequestDispatcher(acceso);
        vista.forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO Auto-generated method stub
        String acceso = register;
        try {
            String action = request.getParameter("accion");
            switch (action) {
                case "Registrarse":
                    Usuario usuario = new Usuario();
                    usuario.setDni(String.valueOf(request.getParameter("dni")));
                    usuario.setNombres(String.valueOf(request.getParameter("nombres")));
                    usuario.setApellidos(String.valueOf(request.getParameter("apellidos")));
                    usuario.setEmail(String.valueOf(request.getParameter("email")));
                    usuario.setDireccion(String.valueOf(request.getParameter("direccion")));
                    usuario.setPassword(String.valueOf(request.getParameter("password")));
                    usuario.setRol(RolDao.search("Cliente"));
                    if (UsuarioDao.add(usuario)) {
                        acceso = login;
                    } else {
                        acceso = register + "?error=true";
                    }
                    break;
            }
        } catch (Exception e) {
            acceso = register;
        }
        RequestDispatcher vista = request.getRequestDispatcher(acceso);
        vista.forward(request, response);
    }

}
