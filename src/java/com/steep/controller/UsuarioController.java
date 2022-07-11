package com.steep.controller;

import com.steep.dao.RolDao;
import com.steep.dao.UsuarioDao;
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
 * Servlet implementation class UsuarioController
 */
@WebServlet("/UsuarioController")
public class UsuarioController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    String list = "admin/usuario/list.jsp";
    String add = "admin/usuario/add.jsp";
    String edit = "admin/usuario/edit.jsp";
    String view = "admin/usuario/view.jsp";
    String login = "index.jsp";
    String shop = "client/shop.jsp";

    HttpSession session;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public UsuarioController() {
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO Auto-generated method stub
        String acceso = shop;
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
                        if (UsuarioDao.delete(Integer.parseInt(request.getParameter("id")))) {
                            acceso = list + "?success=eliminado";
                        } else {
                            acceso = list + "?error=true";
                        }
                        break;
                    case "logout":
                        session.removeAttribute("user");
                        acceso = login;
                        break;
                    default:
                        acceso = redirectTo();
                        break;
                }
            } catch (Exception e) {
                acceso = redirectTo();
            }
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO Auto-generated method stub
        String acceso;
        session = request.getSession();

        String action = request.getParameter("accion");
        if (Utils.isLogged(session)) {
            try {
                switch (action) {
                    case "Registrar":
                        if (UsuarioDao.add(createObject(request, true))) {
                            acceso = list + "?success=agregado";
                        } else {
                            acceso = add + "?error=true";
                        }
                        break;
                    case "Actualizar":
                        if (UsuarioDao.edit(createObject(request, false))) {
                            acceso = list + "?success=actualizado";
                        } else {
                            acceso = edit + "?error=true";
                        }
                        break;
                    case "Login":
                        acceso = actionLogin(request);
                        break;
                    default:
                        acceso = redirectTo();
                        break;
                }
            } catch (Exception e) {
                acceso = redirectTo();
            }
        } else {
            acceso = actionLogin(request);
        }
        RequestDispatcher vista = request.getRequestDispatcher(acceso);
        vista.forward(request, response);
    }

    private Usuario createObject(HttpServletRequest request, boolean register) {
        Usuario object = new Usuario();
        if (!register) {
            object.setId(Integer.parseInt(request.getParameter("id")));
        }
        System.out.println("AGREGANDO");
        object.setDni(request.getParameter("dni"));
        object.setNombres(request.getParameter("nombres"));
        object.setApellidos(request.getParameter("apellidos"));
        object.setDireccion(request.getParameter("direccion"));
        object.setEmail(request.getParameter("email"));
        object.setPassword(request.getParameter("password"));
        object.setRol(RolDao.search(Integer.parseInt(request.getParameter("rol_id"))));
        return object;
    }

    private String actionLogin(HttpServletRequest request) {
        String action = request.getParameter("accion");
        String acceso = login + "?error=true";
        try {
            if (action.equals("Login")) {
                UsuarioDao.registerDefault();
                String email = request.getParameter("username");
                String password = request.getParameter("password");
                Usuario usuario = UsuarioDao.login(email, password);
                if (usuario != null) {
                    session.setAttribute("user", usuario);
                    if (usuario.getRol().getNombre().equals("Administrador")) {
                        acceso = list;
                    } else {
                        acceso = shop;
                    }
                }
            }
        } catch (Exception e) {
        }
        return acceso;
    }

    private String redirectTo() {
        Usuario usuario = (Usuario) session.getAttribute("user");
        if (usuario.getRol().getNombre().equals("Administrador")) {
            return list;
        }
        return shop;
    }
}
