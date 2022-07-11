package com.steep.controller;

import java.io.IOException;
import java.io.InputStream;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.steep.dao.ProductoDao;
import com.steep.model.Producto;

/**
 * Servlet implementation class ProductoController
 */
@MultipartConfig
@WebServlet("/ProductoController")
public class ProductoController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    String list = "admin/producto/list.jsp";
    String add = "admin/producto/add.jsp";
    String edit = "admin/producto/edit.jsp";
    String view = "admin/producto/view.jsp";

    Producto object = new Producto();
    Part part;
    InputStream inputStream;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductoController() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @param request
     * @param response
     * @throws javax.servlet.ServletException
     * @throws java.io.IOException
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
     * response)
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO Auto-generated method stub
        String acceso;
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
                if (ProductoDao.delete(Integer.parseInt(request.getParameter("id")))) {
                    acceso = list + "?success=eliminado";
                } else {
                    acceso = list + "?error=true";
                }
                break;
            case "Buscar":
                acceso = list;
                break;
            default:
                acceso = list;
                break;
        }

        RequestDispatcher vista = request.getRequestDispatcher(acceso);
        vista.forward(request, response);
    }

    /**
     * @param request
     * @param response
     * @throws javax.servlet.ServletException
     * @throws java.io.IOException
     * @see
     * @param requestHttpServlet#doPost(HttpServletRequest request,
     * HttpServletResponse response)
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO Auto-generated method stub
        String acceso = "";
        //try {
        String action = request.getParameter("accion");
        switch (action) {
            case "Registrar":
                object = new Producto();
                object.setNombre(request.getParameter("nombre"));
                object.setDescripcion(request.getParameter("descripcion"));
                object.setPrecio(Double.parseDouble(request.getParameter("precio")));
                object.setStock(Integer.parseInt(request.getParameter("stock")));

                part = request.getPart("fileFoto");
                inputStream = part.getInputStream();
                object.setFoto(inputStream);

                if (ProductoDao.add(object)) {
                    acceso = list + "?success=agregado";
                } else {
                    acceso = add + "?error=true";
                }
                break;
            case "Actualizar":
                object = new Producto();
                object.setId(Integer.parseInt(request.getParameter("id")));
                object.setNombre(request.getParameter("nombre"));
                object.setDescripcion(request.getParameter("descripcion"));
                object.setStock(Integer.parseInt(request.getParameter("stock")));
                object.setPrecio(Double.parseDouble(request.getParameter("precio")));

                part = request.getPart("fileFoto");
                inputStream = part.getInputStream();

                if (part.getSize() > 0) {
                    object.setFoto(inputStream);
                } else {
                    object.setFoto(null);
                }

                if (ProductoDao.edit(object)) {
                    acceso = list + "?success=actualizado";
                } else {
                    acceso = edit + "?error=true";
                }
                break;
            default:
                acceso = list;
                break;
        }
        /*} catch (Exception e) {
			acceso = list;
		}*/
        RequestDispatcher vista = request.getRequestDispatcher(acceso);
        vista.forward(request, response);
    }

}
