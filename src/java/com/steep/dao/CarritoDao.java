package com.steep.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.steep.config.Conexion;
import com.steep.model.Carrito;
import com.steep.utils.Utils;

public class CarritoDao {

    public static ArrayList<Carrito> executeQueryWithResult(String query) {
        ArrayList<Carrito> lista = new ArrayList<>();
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
            System.out.println("Error in executeQueryWithResult Carrito" + e.getMessage() + "|" + query);
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

    public static Carrito toObject(ResultSet rs) {

        try {
            Carrito objeto = new Carrito();
            objeto.setId(rs.getInt(1));
            objeto.setUsuario(UsuarioDao.search(rs.getInt(2)));
            objeto.setProducto(ProductoDao.search(rs.getInt(3)));
            objeto.setCantidad(rs.getInt(4));
            return objeto;
        } catch (SQLException e) {
            Utils.MESSAGE = e.getMessage();
            System.out.println("Error toObject Carrito. " + e.getMessage());
        }

        return null;
    }

    public static ArrayList<Carrito> list(String filter) {
        String query = "SELECT * FROM Carrito ";
        if (!filter.isEmpty()) {
            query = "SELECT c.* FROM Carrito c "
                    + "INNER JOIN Usuario u ON u.id = c.usuario_id "
                    + "WHERE u.dni LIKE '" + filter + "%'";
        }
        return executeQueryWithResult(query);
    }
    
    public static ArrayList<Carrito> listByUser(int usuario_id) {
        String query = "SELECT * FROM Carrito WHERE usuario_id = " + usuario_id;
        return executeQueryWithResult(query);
    }

    public static Carrito search(int id) {
        String query = "SELECT * FROM Carrito WHERE Id = " + id;
        ArrayList<Carrito> lista = executeQueryWithResult(query);
        return lista.isEmpty() ? null : lista.get(0);
    }
    
    public static Carrito searchByProducto(int usuario_id, int producto_id) {
        String query = "SELECT * FROM Carrito "
                + "WHERE producto_id = " + producto_id + " AND "
                + "usuario_id = " + usuario_id;
        ArrayList<Carrito> lista = executeQueryWithResult(query);
        return lista.isEmpty() ? null : lista.get(0);
    }

    public static boolean add(Carrito objeto) {
        if (objeto.getProducto().getStock() < objeto.getCantidad()) {
            Utils.MESSAGE = "No hay suficiente stock del producto. Stock actual "
                    + "(" + objeto.getProducto().getStock() + ") unidades";
            return false;
        }
        Carrito carrito = searchByProducto(objeto.getUsuario().getId(), objeto.getProducto().getId());
        if(carrito != null){
            carrito.setCantidad(objeto.getCantidad());
            return edit(carrito);
        }
        String query = "INSERT INTO Carrito ("
                + "usuario_id, producto_id, cantidad"
                + ") VALUES ("
                + "" + objeto.getUsuario().getId() + ","
                + "" + objeto.getProducto().getId() + ","
                + "" + objeto.getCantidad() + ")";
        return executeQuery(query);
    }
    public static boolean addCar(Carrito objeto) {
        if (objeto.getProducto().getStock() < objeto.getCantidad()) {
            Utils.MESSAGE = "No hay suficiente stock del producto. Stock actual "
                    + "(" + objeto.getProducto().getStock() + ") unidades";
            return false;
        }
        Carrito carrito = searchByProducto(objeto.getUsuario().getId(), objeto.getProducto().getId());
        if(carrito != null){
            carrito.setCantidad(carrito.getCantidad() + 1);
            return edit(carrito);
        }else{
            objeto.setCantidad(1);
        }
        String query = "INSERT INTO Carrito ("
                + "usuario_id, producto_id, cantidad"
                + ") VALUES ("
                + "" + objeto.getUsuario().getId() + ","
                + "" + objeto.getProducto().getId() + ","
                + "" + objeto.getCantidad() + ")";
        return executeQuery(query);
    }

    public static boolean edit(Carrito objeto) {
        if (objeto.getProducto().getStock() < objeto.getCantidad()) {
            Utils.MESSAGE = "No hay suficiente stock del producto. Stock actual "
                    + "(" + objeto.getProducto().getStock() + ") unidades";
            return false;
        }
        String query = "UPDATE Carrito SET "
                + "usuario_id = " + objeto.getUsuario().getId() + ","
                + "producto_id = " + objeto.getProducto().getId() + ","
                + "cantidad = " + objeto.getCantidad() + " "
                + "WHERE id = " + objeto.getId();
        return executeQuery(query);
    }

    public static boolean delete(int id) {
        String query = "DELETE FROM Carrito WHERE Id = " + id;
        return executeQuery(query);
    }

    public static boolean clearShopCar(int usuario_id) {
        String query = "DELETE FROM Carrito WHERE usuario_id = " + usuario_id;
        return executeQuery(query);
    }
}
