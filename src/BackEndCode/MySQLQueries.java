/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BackEndCode;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.DefaultComboBoxModel;
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
                codeset.setStaffDetails(rs.getString("staff_id"), rs.getString("role"), rs.getString("department"), rs.getString("first_name"), rs.getString("last_name"));
                System.out.println(ANSI_GREEN + codeset.DateTime(true) + ": Account access attempt: Staff Account ID: " + username + ": Authentication status: Successful" + ANSI_RESET);
                return true;
            } else {
                System.out.println(ANSI_RED + codeset.DateTime(true) + ": Account access attempt: Staff Account ID: " + username + ": Authentication status: Failed" + ANSI_RESET);
                return false;
            }
        } catch (Exception e) {
            System.out.println("Exception: " + e);
            return false;
        }
    }

    //Staff Search
    public DefaultTableModel SearchStaff(String s) {

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

        try {
            if (s.endsWith("ID")) {
                String s1 = s.substring(0, s.length() - 2);
                if (s1.matches("\\d+")) {
                    query = "select customer_id,customer_type,first_name,last_name,email from customer_account where customer_id = " + Integer.parseInt(s1);
                } else {
                    query = "select customer_id,customer_type,first_name,last_name,email from customer_account where first_name || last_name|| email like '%" + s + "%'";
                }
            } else {
                query = "select customer_id,customer_type,first_name,last_name,email from customer_account where first_name || last_name|| email like '%" + s + "%'";
            }

            DefaultTableModel d = new DefaultTableModel();
            d.setColumnIdentifiers(new Object[]{"ID","Type", "First Name", "Last Name", "emailID"});
            st = conn.createStatement();
            rs = st.executeQuery(query);
            Object[] obj = new Object[5];
            while (rs.next()) {
                obj[0] = rs.getInt("customer_id");
                obj[1] = rs.getString("customer_type");
                obj[2] = rs.getString("first_name");
                obj[3] = rs.getString("last_name");
                obj[4] = rs.getString("email");
                d.addRow(obj);
            }
            return d;
        } catch (Exception e) {
            System.out.println("Exception in Customer List: " + e);
            return null;
        }
    }

    //Create new staff account
    public boolean CreateStaff(String first_name, String last_name, String address_1, String address_2, String town_city, String county, String postcode, String country, String role, String department, String email, long contact_no) {

        if (!(role.equals("Technician"))) {
            department = null;
        }
        query = "insert into staff_account (first_name, last_name, address_1, address_2, town_city, county, postcode, country, role, department, email, contact_no)" + " value (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
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
            pst.setString(10, department);
            pst.setString(11, email);
            pst.setLong(12, contact_no);
            pst.executeUpdate();
            System.out.println(codeset.DateTime(true) + ": New staff account creation successful: Staff Last Name: " + last_name + " Staff Role: " + role);
            return true;

        } catch (SQLException e) {
            System.out.println(codeset.DateTime(true) + ": New staff account creation failed");
            System.out.println("Exception in creating staff account: " + e);
            return false;
        }
    }

    //Create new staff account
    public boolean CreateCustomer(String first_name, String last_name, String address_1, String address_2, String town_city, String county, String postcode, String country, String type, String email, long contact_no) {

        query = "insert into customer_account (customer_type, first_name, last_name, address_1, address_2, town_city, county, postcode, country, email, contact_no)" + " value (?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?)";
        try {
            pst = conn.prepareStatement(query);
            pst.setString(1, type);
            pst.setString(2, first_name);
            pst.setString(3, last_name);
            pst.setString(4, address_1);
            pst.setString(5, address_2);
            pst.setString(6, town_city);
            pst.setString(7, county);
            pst.setString(8, postcode);
            pst.setString(9, country);
            pst.setString(10, email);
            pst.setLong(11, contact_no);
            pst.executeUpdate();
            System.out.println(codeset.DateTime(true) + ": New customer account creation successful: customer Last Name: " + last_name + " customer email: " + email);
            return true;

        } catch (SQLException e) {
            System.out.println(codeset.DateTime(true) + ": New customer account creation failed");
            System.out.println("Exception in creating customer account: " + e);
            return false;
        }
    }

    public CodeSet getCodeset() {
        return codeset;
    }

    public String getValuedCAccNo() {
        query = "select count(*) as type  from customer_account where type = \"valued\"";
        try {
            pst = conn.prepareStatement(query);
            rs = pst.executeQuery();
            if (rs.next()) {
                return String.valueOf((rs.getInt(1)));
            } else {
                return null;
            }
        } catch (SQLException e) {
            System.out.println("Exception in Stat valued account: " + e);
            return null;
        }
    }

    public String getsuspendedCAccNo(boolean s) {
        if (s) {
            query = "select count(*) as Suspended  from customer_account where Suspended = \"True\"";
        } else {
            query = "select count(*) as Suspended  from customer_account where Suspended = \"False\"";
        }
        try {
            pst = conn.prepareStatement(query);
            rs = pst.executeQuery();
            if (rs.next()) {
                return String.valueOf((rs.getInt(1)));
            } else {
                return null;
            }
        } catch (SQLException e) {
            System.out.println("Exception in Stat suspended account: " + e);
            return null;
        }
    }

    public void deleteAccount(String id, boolean s) {
        if (s) {
            query = "delete from staff_account where staff_id=" + id;
        } else {
            query = "delete from customer_account where customer_id=" + id;
        }
        try {
            st = conn.createStatement();
            st.executeUpdate(query);
            if (s) {
                System.out.println(codeset.DateTime(true) + " :Staff account " + id + " deleted");
            } else {
                System.out.println(codeset.DateTime(true) + " :Customer account " + id + " deleted");
            }

        } catch (SQLException e) {
            if (s) {
                System.out.println(codeset.DateTime(true) + " :Failed to delete Staff account");
            } else {
                System.out.println(codeset.DateTime(true) + " :Failed to delete customer account");
            }
            System.out.println("Exception in deleting account: " + e);
        }
    }

    public DefaultComboBoxModel populateTaskList() {
        try {
            query = "select * from task";
            DefaultComboBoxModel d = new DefaultComboBoxModel();
            st = conn.createStatement();
            rs = st.executeQuery(query);
            Object o = new Object();

            while (rs.next()) {
                o = rs.getString("description");
                d.addElement(o);
            }
            return d;
        } catch (SQLException e) {
            System.out.println("Exception in populating task list: " + e);
            return null;
        }
    }
    
    public String populateTaskPrice(String s){
        try {
            query = "select * from task where description ='" + s+"'";
            st = conn.createStatement();
            rs = st.executeQuery(query);

            while (rs.next()) {
                return String.valueOf(rs.getFloat("price"));
            }
            return null;
        } catch (SQLException e) {
            System.out.println("Exception in populating task price list: " + e);
            return null;
        }
    }
    
    public void updateTask(DefaultTableModel d, int cid){
        try{
            String jobID = codeset.DateTime(false);
            
            for(int i=0; i<d.getRowCount(); i++){
                query = "insert into job (job_id, customer_id, task_id, date, deadline, priority, status, special_instruction)"
                        + " values (?,?,(select task_id from task where description = ?),?,?,?,?,?)";
                pst = conn.prepareStatement(query);
                pst.setString(1, jobID);
                pst.setInt(2, cid);
                pst.setString(3, d.getValueAt(i, 0).toString());
                pst.setString(4, codeset.DateTime(true));
                pst.setString(5, codeset.convertStringToDataString(d.getValueAt(i, 3).toString()));
                pst.setString(6, d.getValueAt(i, 1).toString());
                pst.setString(7, "Pending");
                String x = d.getValueAt(i, 4).toString();
                pst.setString(8, x);
                pst.executeUpdate();
                System.out.println(codeset.DateTime(true) + ": New task added: customer id: " + String.valueOf(cid) + " task : " + d.getValueAt(i, 0).toString() );
            }
        } catch(SQLException e){
            System.out.println(codeset.DateTime(true) + ": New task adding failed: customer id: "+ String.valueOf(cid));
            System.out.println("Exception at adding task: "+e);
        } catch (ParseException ex) {
            Logger.getLogger(MySQLQueries.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public DefaultTableModel populateTask(String s){
        try {
            query = "select customer_id,customer_type,first_name,last_name,email from customer_account where first_name || last_name|| email like '%" + s + "%'";
            
            DefaultTableModel d = new DefaultTableModel();
            d.setColumnIdentifiers(new Object[]{"ID","Type", "First Name", "Last Name", "emailID"});
            st = conn.createStatement();
            rs = st.executeQuery(query);
            Object[] obj = new Object[5];
            while (rs.next()) {
                obj[0] = rs.getInt("customer_id");
                obj[1] = rs.getString("customer_type");
                obj[2] = rs.getString("first_name");
                obj[3] = rs.getString("last_name");
                obj[4] = rs.getString("email");
                d.addRow(obj);
            }
            return d;
        } catch (Exception e) {
            System.out.println("Exception in Customer List: " + e);
            return null;
        }
    }
    
    public DefaultTableModel populateCTask(String s) {

        try {
            query = "select job.job_id, task.description, job.status, job.deadline, task.price, if(COALESCE(receipt_jod.receipt_id,false) ,'Paid','Unpaid' ) as paid from job left join receipt_jod on job.prime_id = receipt_jod.prime_key left join task on job.task_id = task.task_id where customer_id = "+s;

            DefaultTableModel d = new DefaultTableModel();
            d.setColumnIdentifiers(new Object[]{"Job ID", "Task", "Status", "Duration", "Price", "Paid"});
            st = conn.createStatement();
            rs = st.executeQuery(query);
            Object[] obj = new Object[6];
            while (rs.next()) {
                obj[0] = rs.getLong("job_id");
                obj[1] = rs.getString("description");
                obj[2] = rs.getString("status");
                obj[3] = rs.getString("deadline");
                obj[4] = rs.getString("price");
                obj[5] = rs.getString("paid");
                d.addRow(obj);
            }
            return d;
        } catch (Exception e) {
            System.out.println("Exception in Customer task List: " + e);
            return null;
        }               
    }
}