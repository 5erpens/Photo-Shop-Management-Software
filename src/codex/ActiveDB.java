/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package codex;

import java.sql.*;
import java.sql.SQLException;

/**
 *
 * @author Sai
 */
public class ActiveDB {

    private static Connection conn;

    public static Connection initiate() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bapers", "root", "Qwerty@1234");
            return conn;
        } catch (ClassNotFoundException e) {
            System.out.println("Driver connection failed: " + e);
            return null;
        } catch (SQLException e) {
            System.out.println("No Database " + e);
            return null;
        }
    }

}
