package com.steep.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {

    private static String database = "carrito_compras";
    private static String user = "root";
    private static String password = "";

    public static Connection getConnection() {

        Connection conexion = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + database + "?useSSL=false", user, password);

        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println("Error." + ex.getMessage());
        }
        return conexion;
    }

}
