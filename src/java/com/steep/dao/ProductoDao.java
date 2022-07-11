package com.steep.dao;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletResponse;

import com.steep.config.Conexion;
import com.steep.model.Producto;
import com.steep.utils.Utils;

public class ProductoDao {

    public static ArrayList<Producto> executeQueryWithResult(String query) {
        ArrayList<Producto> lista = new ArrayList<>();
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
            System.out.println("Error in executeQueryWithResult Producto" + e.getMessage());
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

    public static Producto toObject(ResultSet rs) {

        try {
            Producto objeto = new Producto();
            objeto.setId(rs.getInt(1));
            objeto.setNombre(rs.getString(2));
            objeto.setFoto(rs.getBinaryStream(3));
            objeto.setDescripcion(rs.getString(4));
            objeto.setPrecio(rs.getDouble(5));
            objeto.setStock(rs.getInt(6));
            return objeto;
        } catch (SQLException e) {
            Utils.MESSAGE = e.getMessage();
            System.out.println("Error toObject Producto. " + e.getMessage());
        }

        return null;
    }

    public static ArrayList<Producto> list(String filter) {
        String query = "SELECT * FROM Producto WHERE Nombre like '" + filter + "%'";
        return executeQueryWithResult(query);
    }

    public static Producto search(int id) {
        String query = "SELECT * FROM Producto WHERE Id = " + id;
        ArrayList<Producto> lista = executeQueryWithResult(query);
        return lista.isEmpty() ? null : lista.get(0);
    }

    public static boolean add(Producto objeto) {
        Connection con;
        PreparedStatement ps;

        try {
            String query = "INSERT INTO Producto ("
                    + "nombre, foto, descripcion, precio, stock"
                    + ") VALUES ("
                    + "'" + objeto.getNombre() + "',"
                    + "?,"
                    + "'" + objeto.getDescripcion() + "',"
                    + "" + objeto.getPrecio() + ","
                    + "" + objeto.getStock() + ""
                    + ")";
            con = Conexion.getConnection();
            ps = con.prepareStatement(query);
            ps.setBlob(1, objeto.getFoto());
            ps.executeUpdate();
            ps.close();

            return true;
        } catch (SQLException e) {
            Utils.MESSAGE = e.getMessage();
            System.out.println("Error add Producto. " + e.getMessage());
        }
        return false;
    }

    public static boolean edit(Producto objeto) {
        Connection con;
        PreparedStatement ps;
        try {

            con = Conexion.getConnection();
            String query = "UPDATE Producto SET "
                    + "nombre = '" + objeto.getNombre() + "',"
                    + "descripcion = '" + objeto.getDescripcion() + "',"
                    + "precio = " + objeto.getPrecio() + ","
                    + "stock = " + objeto.getStock() + " ";
            if (objeto.getFoto() != null) {
                query += ", foto = ? WHERE id = " + objeto.getId();
                ps = con.prepareStatement(query);
                ps.setBlob(1, objeto.getFoto());
            } else {
                query += "WHERE id = " + objeto.getId();
                ps = con.prepareStatement(query);
            }

            ps.executeUpdate();
            ps.close();

            return true;
        } catch (SQLException e) {
            Utils.MESSAGE = e.getMessage();
            System.out.println("Error edit Producto. " + e.getMessage());
        }
        return false;
    }

    public static boolean delete(int id) {
        String query = "DELETE FROM Producto WHERE Id = " + id;
        return executeQuery(query);
    }
    
    public static boolean restarStock(int id, int cantidad){
        String query = "UPDATE Producto SET stock = stock - " + cantidad + " "
                + "WHERE id = " + id;
        return executeQuery(query);
    }

    public static void listarImagen(int id, HttpServletResponse response) {
        OutputStream outputStream = null;
        BufferedInputStream bufferedInputStream;
        BufferedOutputStream bufferedOutputStream;

        String query = "SELECT * FROM producto WHERE id = " + id;
        ArrayList<Producto> lista = executeQueryWithResult(query);

        try {
            if (!lista.isEmpty()) {
                response.setContentType("image/*");

                outputStream = response.getOutputStream();
                bufferedInputStream = new BufferedInputStream(lista.get(0).getFoto());
                bufferedOutputStream = new BufferedOutputStream(outputStream);
                int i;
                while ((i = bufferedInputStream.read()) != -1) {
                    bufferedOutputStream.write(i);
                }

            }
        } catch (Exception ex) {
            try {
                outputStream.close();
            } catch (IOException e) {
            }
            Utils.MESSAGE = ex.getMessage();
        }
    }
}
