package com.steep.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.steep.config.Conexion;
import com.steep.model.Pago;
import com.steep.utils.Utils;

public class PagoDao {

    public static ArrayList<Pago> executeQueryWithResult(String query) {
        ArrayList<Pago> lista = new ArrayList<>();
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
            System.out.println("Error in executeQueryWithResult Pago" + e.getMessage());
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

    public static Pago toObject(ResultSet rs) {

        try {
            Pago objeto = new Pago();
            objeto.setId(rs.getInt(1));
            objeto.setMonto(rs.getDouble(2));
            objeto.setFecha(rs.getDate(3));
            objeto.setVenta(VentaDao.search(rs.getInt(4)));
            return objeto;
        } catch (SQLException e) {
            Utils.MESSAGE = e.getMessage();
            System.out.println("Error toObject Pago. " + e.getMessage());
        }

        return null;
    }

    public static ArrayList<Pago> list(String filter) {
        String query = "SELECT * FROM Pago WHERE fecha like '" + filter + "%'";
        return executeQueryWithResult(query);
    }

    public static Pago search(int id) {
        String query = "SELECT * FROM Pago WHERE Id = " + id;
        ArrayList<Pago> lista = executeQueryWithResult(query);
        return lista.isEmpty() ? null : lista.get(0);
    }

    public static boolean add(Pago objeto) {
        String query = "INSERT INTO Pago ("
                + "monto, fecha, venta_id"
                + ") VALUES ("
                + "" + objeto.getMonto() + ","
                + "'" + Utils.SDF.format(objeto.getFecha()) + "',"
                + "" + objeto.getVenta().getId() + ")";
        return executeQuery(query);
    }

    public static boolean edit(Pago objeto) {
        String query = "UPDATE Pago SET "
                + "monto = " + objeto.getMonto() + ","
                + "fecha = '" + Utils.SDF.format(objeto.getFecha()) + "',"
                + "venta_id = " + objeto.getVenta().getId() + " "
                + "WHERE id = " + objeto.getId();
        return executeQuery(query);
    }

    public static boolean delete(int id) {
        String query = "DELETE FROM Pago WHERE Id = " + id;
        return executeQuery(query);
    }
}
