package com.steep.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.steep.config.Conexion;
import com.steep.model.Rol;
import com.steep.utils.Utils;

public class RolDao {

    public static ArrayList<Rol> executeQueryWithResult(String query) {
        ArrayList<Rol> lista = new ArrayList<>();
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
            System.out.println("Error in executeQueryWithResult Rol" + e.getMessage());
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

    public static Rol toObject(ResultSet rs) {

        try {
            Rol objeto = new Rol();
            objeto.setId(rs.getInt(1));
            objeto.setNombre(rs.getString(2));
            return objeto;
        } catch (SQLException e) {
            Utils.MESSAGE = e.getMessage();
            System.out.println("Error toObject Rol. " + e.getMessage());
        }

        return null;
    }

    public static ArrayList<Rol> list(String filter) {
        String query = "SELECT * FROM Rol WHERE Nombre like '" + filter + "%'";
        return executeQueryWithResult(query);
    }

    public static Rol search(int id) {
        String query = "SELECT * FROM Rol WHERE Id = " + id;
        ArrayList<Rol> lista = executeQueryWithResult(query);
        return lista.isEmpty() ? null : lista.get(0);
    }
    
    public static Rol search(String nombre) {
        String query = "SELECT * FROM Rol WHERE nombre = '" + nombre + "'";
        ArrayList<Rol> lista = executeQueryWithResult(query);
        return lista.isEmpty() ? null : lista.get(0);
    }

    public static boolean add(Rol objeto) {
        String query = "INSERT INTO Rol ("
                + "nombre"
                + ") VALUES ("
                + "'" + objeto.getNombre() + "')";
        return executeQuery(query);
    }

    public static boolean edit(Rol objeto) {
        String query = "UPDATE Rol SET "
                + "nombre = '" + objeto.getNombre() + "' "
                + "WHERE id = " + objeto.getId();
        return executeQuery(query);
    }

    public static boolean delete(int id) {
        String query = "DELETE FROM Rol WHERE Id = " + id;
        return executeQuery(query);
    }
}
