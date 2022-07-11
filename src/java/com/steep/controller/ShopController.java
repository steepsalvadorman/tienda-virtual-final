package com.steep.controller;

import com.steep.dao.CarritoDao;
import com.steep.dao.ProductoDao;
import com.steep.model.Carrito;
import com.steep.model.Usuario;
import com.steep.utils.Utils;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class ShopController
 */
@WebServlet("/ShopController")
public class ShopController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    String shop = "client/shop.jsp";
    String login = "index.jsp";

    HttpSession session;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public ShopController() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
     * response)
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        String acceso = login;
        session = request.getSession();
        try {
            String action = request.getParameter("accion");
            switch (action) {
                case "Buscar":
                case "shop":
                    acceso = shop;
                    break;
                case "addcar":
                    if (Utils.isLogged(session)) {
                        System.out.println("AGRENADO");
                        Carrito carrito = new Carrito();
                        carrito.setProducto(ProductoDao.search(Integer.parseInt(request.getParameter("producto_id"))));
                        carrito.setUsuario((Usuario) session.getAttribute("user"));
                        if (CarritoDao.addCar(carrito)) {
                            acceso = shop + "?success=agregado";
                            System.out.println("AGREGADO");
                        } else {
                            acceso = shop + "?error=true";
                        }
                    }
                    break;
                default:
                    acceso = login;
                    break;
            }
        } catch (Exception e) {
            acceso = login;

        }
        RequestDispatcher vista = request.getRequestDispatcher(acceso);
        vista.forward(request, response);
    }

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
     * response)
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        doGet(request, response);
    }

}
