package com.steep.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.steep.config.Conexion;
import com.steep.model.DetalleVenta;
import com.steep.model.Venta;
import com.steep.utils.Utils;
import java.sql.Statement;

public class VentaDao {

    public static ArrayList<Venta> executeQueryWithResult(String query) {
        ArrayList<Venta> lista = new ArrayList<>();
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
            System.out.println("Error in executeQueryWithResult Venta" + e.getMessage());
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
    
    public static int executeQueryId(String query) {
        Connection connection;
        PreparedStatement ps;
        int id = 0;
        try {
            connection = Conexion.getConnection();
            ps = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            if(ps.executeUpdate() > 0){
                ResultSet rs = ps.getGeneratedKeys();
                if(rs.next()){
                    id = rs.getInt(1);
                }
            }
            ps.close();
            connection.close();
        } catch (SQLException e) {
            Utils.MESSAGE = e.getMessage();
            System.out.println("Error in executeQuery: " + e.getMessage());
        }
        return id;
    }

    public static Venta toObject(ResultSet rs) {

        try {
            Venta objeto = new Venta();
            objeto.setId(rs.getInt(1));
            objeto.setFecha(rs.getDate(2));
            objeto.setEstado(rs.getString(3));
            objeto.setMonto_total(rs.getDouble(4));
            objeto.setUsuario(UsuarioDao.search(rs.getInt(5)));
            return objeto;
        } catch (SQLException e) {
            Utils.MESSAGE = e.getMessage();
            System.out.println("Error toObject Venta. " + e.getMessage());
        }

        return null;
    }

    public static ArrayList<Venta> list(String filter) {
        String query = "SELECT * FROM Venta WHERE fecha like '" + filter + "%'";
        return executeQueryWithResult(query);
    }

    public static Venta search(int id) {
        String query = "SELECT * FROM Venta WHERE Id = " + id;
        ArrayList<Venta> lista = executeQueryWithResult(query);
        return lista.isEmpty() ? null : lista.get(0);
    }

    public static boolean add(Venta objeto) {
        String query = "INSERT INTO Venta ("
                + "fecha, estado, monto_total, usuario_id"
                + ") VALUES ("
                + "'" + Utils.SDF.format(objeto.getFecha()) + "',"
                + "'" + objeto.getEstado() + "',"
                + "" + objeto.getMonto_total() + ","
                + "" + objeto.getUsuario().getId() + ")";
        return executeQuery(query);
    }
    
    public static int comprar(Venta objeto) {
        String query = "INSERT INTO Venta ("
                + "fecha, estado, monto_total, usuario_id"
                + ") VALUES ("
                + "'" + Utils.SDF.format(objeto.getFecha()) + "',"
                + "'" + objeto.getEstado() + "',"
                + "" + objeto.getMonto_total() + ","
                + "" + objeto.getUsuario().getId() + ")";
        return executeQueryId(query);
    }

    public static boolean edit(Venta objeto) {
        String query = "UPDATE Venta SET "
                + "fecha = '" + Utils.SDF.format(objeto.getFecha()) + "',"
                + "estado = '" + objeto.getEstado() + "',"
                + "monto_total = " + objeto.getMonto_total() + ","
                + "usuario_id = " + objeto.getUsuario().getId() + " "
                + "WHERE id = " + objeto.getId();
        return executeQuery(query);
    }

    public static boolean delete(int id) {
        String query = "DELETE FROM Venta WHERE Id = " + id;
        return executeQuery(query);
    }
    public static boolean updateTotal(int id){
        ArrayList<DetalleVenta> lista = DetalleVentaDao.list(id + "");
        double total = 0;
        for (DetalleVenta item : lista) {
            total += item.getCantidad() * item.getPrecio();
        }
        String query = "UPDATE Venta SET monto_total = " + total +" "
                + "WHERE id = " + id;
        return executeQuery(query);
    }
}
