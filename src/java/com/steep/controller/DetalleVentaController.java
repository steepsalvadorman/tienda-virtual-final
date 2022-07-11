/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.steep.controller;

import com.steep.dao.DetalleVentaDao;
import com.steep.dao.ProductoDao;
import com.steep.dao.VentaDao;
import com.steep.model.DetalleVenta;
import com.steep.utils.Utils;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author PC
 */
public class DetalleVentaController extends HttpServlet {

    String list = "admin/detalleventa/list.jsp";
    String add = "admin/detalleventa/add.jsp";
    String edit = "admin/detalleventa/edit.jsp";
    String view = "admin/detalleventa/view.jsp";
    String login = "index.jsp";
    String miscompras = "client/miscompras.jsp";

    HttpSession session;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet DetalleVentaController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DetalleVentaController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
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
        String acceso = login;
        session = request.getSession();

        if (Utils.isLogged(session)) {
            try {
                String action = request.getParameter("accion");
                switch (action) {
                    case "list":
                        acceso = list;
                        break;
                    case "add":
                        acceso = add;
                        break;
                    case "edit":
                        acceso = edit;
                        break;
                    case "view":
                        acceso = view;
                        break;
                    case "delete":
                        if (DetalleVentaDao.delete(Integer.parseInt(request.getParameter("id")))) {
                            acceso = list + "?success=eliminado";
                        } else {
                            acceso = list + "?error=true";
                        }
                        break;
                    default:
                        acceso = list;
                        break;
                }
            } catch (Exception e) {
                acceso = list;
            }
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
        String acceso = login;
        session = request.getSession();

        if (Utils.isLogged(session)) {
            try {
                String action = request.getParameter("accion");
                switch (action) {
                    case "Registrar":
                        if (DetalleVentaDao.add(createObject(request, true))) {
                            acceso = list + "?success=agregado";
                        } else {
                            acceso = add + "?error=true";
                        }
                        break;
                    case "Actualizar":
                        if (DetalleVentaDao.edit(createObject(request, false))) {
                            acceso = list + "?success=actualizado";
                        } else {
                            acceso = edit + "?error=true";
                        }
                        break;
                    default:
                        acceso = list;
                        break;
                }
            } catch (Exception e) {
                acceso = list;
            }
        }
        RequestDispatcher vista = request.getRequestDispatcher(acceso);
        vista.forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private DetalleVenta createObject(HttpServletRequest request, boolean register) {
        DetalleVenta object = new DetalleVenta();
        if (!register) {
            object = DetalleVentaDao.search(Integer.parseInt(request.getParameter("id")));
        }
        
        object.setCantidad(Integer.parseInt(request.getParameter("cantidad")));
        object.setVenta(VentaDao.search(Integer.parseInt(request.getParameter("venta_id"))));
        object.setProducto(ProductoDao.search(Integer.parseInt(request.getParameter("producto_id"))));        
        if (register) {
            object.setPrecio(object.getProducto().getPrecio());
        }
        return object;
    }
}
