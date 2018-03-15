/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package codex;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import javax.swing.table.DefaultTableModel;

/**
 *
 * @author Sai
 */
public class MySQLQueries {

    private static Connection conn;
    private PreparedStatement pst = null;
    private Statement st = null;
    private ResultSet rs = null;

    private String query;

    private CodeSet codeset = null;

    // Log Colours
    //Red
    private static final String ANSI_RED = "\u001B[31m";
    //Green
    private static final String ANSI_GREEN = "\u001B[32m";
    //Reset
    public static final String ANSI_RESET = "\u001B[0m";

    public MySQLQueries(Connection conn) {
        this.conn = conn;
        codeset = new CodeSet();
    }

    //Login Staff Account
    public boolean LoginStaff(String username, String password) {
        try {
            query = "select * from staff_account where staff_id=? and password=?";
            pst = conn.prepareStatement(query);
            pst.setString(1, username);
            pst.setString(2, password);
            rs = pst.executeQuery();

            //Log
            if (rs.next()) {
                System.out.println(ANSI_GREEN + codeset.DateTime() + ": Account access attempt: Staff Account ID: " + username + ": Authentication status: Successful" + ANSI_RESET);
                return true;
            } else {
                System.out.println(ANSI_RED + codeset.DateTime() + ": Account access attempt: Staff Account ID: " + username + ": Authentication status: Failed" + ANSI_RESET);
                return false;
            }
        } catch (Exception e) {
            System.out.println("Exception: " + e);
            return false;
        }
    }

    //Staff Search
    public DefaultTableModel SearchStaff(String s) {

        //Log
        System.out.println(codeset.DateTime() + ": Searching in Staff Search : Keyword: " + s);
        try {
            if (s.endsWith("ID")) {
                String s1 = s.substring(0, s.length() - 2);
                if (s1.matches("\\d+")) {
                    query = "select staff_id,role,first_name,last_name,email from staff_account where  staff_id = " + Integer.parseInt(s1);
                } else {
                    query = "select staff_id,role,first_name,last_name,email from staff_account where first_name || last_name|| email like '%" + s + "%'";
                }
            } else {
                query = "select staff_id,role,first_name,last_name,email from staff_account where first_name || last_name|| email like '%" + s + "%'";
            }
            DefaultTableModel d = new DefaultTableModel();
            d.setColumnIdentifiers(new Object[]{"ID", "Role", "First Name", "Last Name", "emailID"});
            st = conn.createStatement();
            rs = st.executeQuery(query);
            Object[] obj = new Object[5];
            while (rs.next()) {
                obj[0] = rs.getInt("staff_id");
                obj[1] = rs.getString("role");
                obj[2] = rs.getString("first_name");
                obj[3] = rs.getString("last_name");
                obj[4] = rs.getString("email");
                d.addRow(obj);
            }
            return d;
        } catch (Exception e) {
            System.out.println("Exception in Staff List: " + e);
            return null;
        }
    }

    //Customer Search
    public DefaultTableModel SearchCustomer(String s) {

        //Log
        System.out.println(codeset.DateTime() + ": Searching in Customer Search : Keyword: " + s);
        try {

            DefaultTableModel d = new DefaultTableModel();
            d.setColumnIdentifiers(new Object[]{"First Name", "Last Name", "emailID"});
            query = "select first_name,last_name,email from customer_account where first_name || last_name|| email like '%" + s + "%'";
            st = conn.createStatement();
            rs = st.executeQuery(query);
            Object[] obj = new Object[3];
            while (rs.next()) {
                obj[0] = rs.getString("first_name");
                obj[1] = rs.getString("last_name");
                obj[2] = rs.getString("email");
                d.addRow(obj);
            }
            return d;
        } catch (Exception e) {
            System.out.println("Exception in Customer List: " + e);
            return null;
        }
    }

    //Create new staff account
    public void CreateStaff(String first_name, String last_name, String address_1, String address_2, String town_city, String county, String postcode, String country, String role, String email, long contact_no) {

        query = "insert into staff_account (first_name, last_name, address_1, address_2, town_city, county, postcode, country, role, email, contact_no)" + " value (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            pst = conn.prepareStatement(query);
            pst.setString(1, first_name);
            pst.setString(2, last_name);
            pst.setString(3, address_1);
            pst.setString(4, address_2);
            pst.setString(5, town_city);
            pst.setString(6, county);
            pst.setString(7, postcode);
            pst.setString(8, country);
            pst.setString(9, role);
            pst.setString(10, email);
            pst.setLong(11, contact_no);
            pst.executeUpdate();
            System.out.println(codeset.DateTime() + ": New staff account creation successful: Staff Last Name: " + last_name + " Staff Role: " + role);

        } catch (SQLException e) {
            System.out.println(codeset.DateTime() + ": New staff account creation failed");
            System.out.println("Exception in creating staff account: " + e);
        }
    }

    //Create new staff account
    public void CreateCustomer(String first_name, String last_name, String address_1, String address_2, String town_city, String county, String postcode, String country, String email, long contact_no) {

        query = "insert into customer_account (first_name, last_name, address_1, address_2, town_city, county, postcode, country, email, contact_no)" + " value (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            pst = conn.prepareStatement(query);
            pst.setString(1, first_name);
            pst.setString(2, last_name);
            pst.setString(3, address_1);
            pst.setString(4, address_2);
            pst.setString(5, town_city);
            pst.setString(6, county);
            pst.setString(7, postcode);
            pst.setString(8, country);
            pst.setString(9, email);
            pst.setLong(10, contact_no);
            pst.executeUpdate();
            System.out.println(codeset.DateTime() + ": New customer account creation successful: customer Last Name: " + last_name + " customer email: " + email);

        } catch (SQLException e) {
            System.out.println(codeset.DateTime() + ": New customer account creation failed");
            System.out.println("Exception in creating customer account: " + e);
        }
    }
}
