package com.steep.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.steep.config.Conexion;
import com.steep.model.DetalleVenta;
import com.steep.utils.Utils;

public class DetalleVentaDao {

    public static ArrayList<DetalleVenta> executeQueryWithResult(String query) {
        ArrayList<DetalleVenta> lista = new ArrayList<>();
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
            System.out.println("Error in executeQueryWithResult DetalleVenta" + e.getMessage());
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

    public static DetalleVenta toObject(ResultSet rs) {

        try {
            DetalleVenta objeto = new DetalleVenta();
            objeto.setId(rs.getInt(1));
            objeto.setCantidad(rs.getInt(2));
            objeto.setPrecio(rs.getDouble(3));
            objeto.setVenta(VentaDao.search(rs.getInt(4)));
            objeto.setProducto(ProductoDao.search(rs.getInt(5)));
            return objeto;
        } catch (SQLException e) {
            Utils.MESSAGE = e.getMessage();
            System.out.println("Error toObject DetalleVenta. " + e.getMessage());
        }

        return null;
    }

    public static ArrayList<DetalleVenta> list(String filter) {
        String query = "SELECT * FROM DetalleVenta";
        if(!filter.isEmpty()){
            query = "SELECT * FROM DetalleVenta where venta_id = " +filter;
        }        
        return executeQueryWithResult(query);
    }

    public static ArrayList<DetalleVenta> listByUser(String filter) {
        String query = "SELECT dv.* FROM DetalleVenta dv "
                + "inner join venta v on v.id = dv.venta_id "
                + "where v.usuario_id = "+filter;
                
        return executeQueryWithResult(query);
    }
    
    public static DetalleVenta search(int id) {
        String query = "SELECT * FROM DetalleVenta WHERE Id = " + id;
        ArrayList<DetalleVenta> lista = executeQueryWithResult(query);
        return lista.isEmpty() ? null : lista.get(0);
    }

    public static boolean add(DetalleVenta objeto) {
        if(objeto.getProducto().getStock() < objeto.getCantidad()){
            Utils.MESSAGE = "No hay suficiente stock del producto. Stock actual "
                    + "(" + objeto.getProducto().getStock() + ") unidades";
            return false;
        }
        String query = "INSERT INTO DetalleVenta ("
                + "cantidad, precio, venta_id, producto_id"
                + ") VALUES ("
                + "" + objeto.getCantidad() + ","
                + "" + objeto.getPrecio() + ","
                + "" + objeto.getVenta().getId() + ","
                + "" + objeto.getProducto().getId() + ")";
        if(executeQuery(query)){
            ProductoDao.restarStock(objeto.getProducto().getId(), objeto.getCantidad());
            VentaDao.updateTotal(objeto.getVenta().getId());
            return true;
        }
        return false;
    }

    public static boolean edit(DetalleVenta objeto) {
        String query = "UPDATE DetalleVenta SET "
                + "cantidad = " + objeto.getCantidad() + ","
                + "precio = " + objeto.getPrecio() + ","
                + "venta_id = " + objeto.getVenta().getId() + ","
                + "producto_id = " + objeto.getProducto().getId() + " "
                + "WHERE id = " + objeto.getId();
        return executeQuery(query)? VentaDao.updateTotal(objeto.getVenta().getId()) : false;
    }

    public static boolean delete(int id) {
        String query = "DELETE FROM DetalleVenta WHERE Id = " + id;
        return executeQuery(query) ;
    }
}
