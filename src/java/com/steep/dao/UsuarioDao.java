package com.steep.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.steep.config.Conexion;
import com.steep.model.Rol;
import com.steep.model.Usuario;
import com.steep.utils.Utils;

public class UsuarioDao {

    public static ArrayList<Usuario> executeQueryWithResult(String query) {
        ArrayList<Usuario> lista = new ArrayList<>();
        Connection connection;
        PreparedStatement ps;
        try {
            connection = Conexion.getConnection();
            ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                lista.add(toObject(rs));
            }
            ps.close();
            connection.close();
        } catch (SQLException e) {
            Utils.MESSAGE = e.getMessage();
            System.out.println("Error in executeQueryWithResult Usuario" + e.getMessage());
        }
        return lista;
    }

    public static boolean executeQuery(String query) {
        Connection connection;
        PreparedStatement ps;
        try {
            connection = Conexion.getConnection();
            ps = connection.prepareStatement(query);
            ps.executeUpdate();
            ps.close();
            connection.close();
            return true;
        } catch (SQLException e) {
            Utils.MESSAGE = e.getMessage();
            System.out.println("Error in executeQuery: " + e.getMessage());
        }
        return false;
    }

    public static Usuario toObject(ResultSet rs) {

        try {
            Usuario objeto = new Usuario();
            objeto.setId(rs.getInt(1));
            objeto.setDni(rs.getString(2));
            objeto.setNombres(rs.getString(3));
            objeto.setApellidos(rs.getString(4));
            objeto.setDireccion(rs.getString(5));
            objeto.setEmail(rs.getString(6));
            objeto.setPassword(rs.getString(7));
            objeto.setRol(RolDao.search(rs.getInt(8)));
            return objeto;
        } catch (SQLException e) {
            Utils.MESSAGE = e.getMessage();
            System.out.println("Error toObject Usuario. " + e.getMessage());
        }

        return null;
    }

    public static ArrayList<Usuario> list(String filter) {
        String query = "SELECT * FROM Usuario WHERE Dni like '" + filter + "%'";
        return executeQueryWithResult(query);
    }

    public static Usuario search(int id) {
        String query = "SELECT * FROM Usuario WHERE Id = " + id;
        ArrayList<Usuario> lista = executeQueryWithResult(query);
        return lista.isEmpty() ? null : lista.get(0);
    }

    public static boolean add(Usuario objeto) {
        String query = "INSERT INTO Usuario ("
                + "dni, nombres, apellidos, direccion, email, password, rol_id"
                + ") VALUES ("
                + "'" + objeto.getDni() + "',"
                + "'" + objeto.getNombres() + "',"
                + "'" + objeto.getApellidos() + "',"
                + "'" + objeto.getDireccion() + "',"
                + "'" + objeto.getEmail() + "',"
                + "'" + objeto.getPassword() + "',"
                + "" + objeto.getRol().getId() + ")";
        return executeQuery(query);
    }

    public static boolean edit(Usuario objeto) {
        String query = "UPDATE Usuario SET "
                + "dni = '" + objeto.getDni() + "',"
                + "nombres = '" + objeto.getNombres() + "',"
                + "apellidos = '" + objeto.getApellidos() + "',"
                + "direccion = '" + objeto.getDireccion() + "',"
                + "email = '" + objeto.getEmail() + "',"
                + "password = '" + objeto.getPassword() + "',"
                + "rol_id = " + objeto.getRol().getId() + " "
                + "WHERE id = " + objeto.getId();
        return executeQuery(query);
    }

    public static boolean delete(int id) {
        String query = "DELETE FROM Usuario WHERE Id = " + id;
        return executeQuery(query);
    }
    
    public static Usuario login(String email, String password){
        String query = "SELECT * FROM Usuario "
                + "WHERE email = '" + email + "' AND "
                + "password = '" +password + "'";
        ArrayList<Usuario> lista = executeQueryWithResult(query);
        return lista.isEmpty() ? null : lista.get(0);
    }
    public static void registerDefault(){
        if(list("").isEmpty()){
            if(RolDao.search("Administrador") == null){
                Rol rol = new Rol();
                rol.setNombre("Administrador");
                RolDao.add(rol);
                rol = new Rol();
                rol.setNombre("Cliente");
                RolDao.add(rol);
            }
            Usuario usuario = new Usuario();
            usuario.setEmail("admin@gmail.com");
            usuario.setPassword("admin");
            usuario.setRol(RolDao.search("Administrador"));
            add(usuario);
        }
    }
}
