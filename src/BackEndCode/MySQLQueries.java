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
import java.sql.Types;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.DefaultComboBoxModel;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.TableModel;

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
                logAdd(codeset.DateTime(true) + ": Account access attempt: Staff Account ID: " + username + ": Authentication status: Successful");
                return true;
            } else {
                System.out.println(ANSI_RED + codeset.DateTime(true) + ": Account access attempt: Staff Account ID: " + username + ": Authentication status: Failed" + ANSI_RESET);
                logAdd(codeset.DateTime(true) + ": Account access attempt: Staff Account ID: " + username + ": Authentication status: Failed");
                return false;
            }
        } catch (SQLException e) {
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
                    query = "select staff_id,role,first_name,last_name,email from staff_account where first_name like '%" + s + "%' || last_name like '%" + s + "%' || email like '%" + s + "%'";
                }
            } else {
                query = "select staff_id,role,first_name,last_name,email from staff_account where first_name like '%" + s + "%' || last_name like '%" + s + "%' || email like '%" + s + "%'";
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
        } catch (NumberFormatException | SQLException e) {
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
                    query = "select customer_id,customer_type,first_name,last_name,email from customer_account where first_name like '%" + s + "%' || last_name like '%" + s + "%'|| email like '%" + s + "%'";
                }
            } else {
                query = "select customer_id,customer_type,first_name,last_name,email from customer_account where customer_type like '%" + s + "%' || first_name like '%" + s + "%' || last_name like '%" + s + "%'|| email like '%" + s + "%'";
            }

            DefaultTableModel d = new DefaultTableModel();
            d.setColumnIdentifiers(new Object[]{"ID", "Type", "First Name", "Last Name", "emailID"});
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
        } catch (NumberFormatException | SQLException e) {
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
            if (!role.equals("Technician")) {
                pst.setNull(10, Types.VARCHAR);
            } else {
                pst.setString(10, department);
            }
            pst.setString(11, email);
            pst.setLong(12, contact_no);
            pst.executeUpdate();
            System.out.println(codeset.DateTime(true) + ": New staff account creation successful: Staff Last Name: " + last_name + " Staff Role: " + role);
            logAdd(codeset.DateTime(true) + ": New staff account creation successful: Staff Last Name: " + last_name + " Staff Role: " + role);
            return true;

        } catch (SQLException e) {
            System.out.println(codeset.DateTime(true) + ": New staff account creation failed");
            logAdd(codeset.DateTime(true) + ": New staff account creation failed");
            System.out.println("Exception in creating staff account: " + e);
            return false;
        }
    }

    //Create new staff account
    public boolean CreateCustomer(String first_name, String last_name, String address_1, String address_2, String town_city, String county, String postcode, String country, String type, String email, long contact_no, String acctype, String dt, float per) {

        query = "insert into customer_account (customer_type, first_name, last_name, address_1, address_2, town_city, county, postcode, country, email, contact_no, type, discount_type, percentage)" + " value (?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?, ?, ?, ?)";
        try {
            pst = conn.prepareStatement(query);
            pst.setString(1, type);
            pst.setString(2, first_name);
            if (type.equals("Organisation")) {
                pst.setNull(3, Types.VARCHAR);
            } else {
                pst.setString(3, last_name);
            }
            pst.setString(4, address_1);
            pst.setString(5, address_2);
            pst.setString(6, town_city);
            pst.setString(7, county);
            pst.setString(8, postcode);
            pst.setString(9, country);
            pst.setString(10, email);
            pst.setLong(11, contact_no);
            pst.setString(12, acctype);
            pst.setString(13, dt);
            pst.setFloat(14, per);
            pst.executeUpdate();
            System.out.println(codeset.DateTime(true) + ": New customer account creation successful: customer Last Name: " + last_name + " customer email: " + email);
            logAdd(codeset.DateTime(true) + ": New customer account creation successful: customer Last Name: " + last_name + " customer email: " + email);
            return true;

        } catch (SQLException e) {
            System.out.println(codeset.DateTime(true) + ": New customer account creation failed");
            logAdd(codeset.DateTime(true) + ": New customer account creation failed");
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
            EjectSeq3(id);
            query = "delete from staff_account where staff_id=" + id;
        } else {
            DeleteCard(id);
            EjectSeq1(id);
            query = "delete from customer_account where customer_id=" + id;

        }
        try {
            if (s) {
                st = conn.createStatement();
                st.executeUpdate(query);
            } else {
                st = conn.createStatement();
                st.executeUpdate(query);
            }

            if (s) {
                System.out.println(codeset.DateTime(true) + " :Staff account " + id + " deleted");
                logAdd(codeset.DateTime(true) + " :Staff account " + id + " deleted");
            } else {
                System.out.println(codeset.DateTime(true) + " :Customer account " + id + " deleted");
                logAdd(codeset.DateTime(true) + " :Customer account " + id + " deleted");
            }

        } catch (SQLException e) {
            if (s) {
                System.out.println(codeset.DateTime(true) + " :Failed to delete Staff account");
                logAdd(codeset.DateTime(true) + " :Failed to delete Staff account");
            } else {
                System.out.println(codeset.DateTime(true) + " :Failed to delete customer account");
                logAdd(codeset.DateTime(true) + " :Failed to delete customer account");
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

    public String populateTaskPrice(String s) {
        try {
            query = "select * from task where description ='" + s + "'";
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

    public String updateTask(DefaultTableModel d, int cid, ArrayList<String> a) {
        try {
            String jobID = codeset.DateTime(false);

            for (int i = 0; i < d.getRowCount(); i++) {
                query = "insert into job (job_id, customer_id, task_id, date, deadline, priority, status, special_instruction,price,discount)"
                        + " values (?,?,(select task_id from task where description = ?),?,?,?,?,?,?,?)";
                pst = conn.prepareStatement(query);
                pst.setString(1, jobID);
                pst.setInt(2, cid);
                pst.setString(3, d.getValueAt(i, 0).toString());
                pst.setString(4, codeset.DateTime(true));
                pst.setString(5, d.getValueAt(i, 3).toString());
                pst.setString(6, d.getValueAt(i, 1).toString());
                pst.setString(7, "Pending");
                String x = d.getValueAt(i, 4).toString();
                pst.setString(8, x);
                pst.setFloat(9, Float.parseFloat(d.getValueAt(i, 2).toString()));
                pst.setFloat(10, Float.parseFloat(a.get(i)));
                pst.executeUpdate();
                System.out.println(codeset.DateTime(true) + ": New task added: customer id: " + String.valueOf(cid) + " task : " + d.getValueAt(i, 0).toString());
                logAdd(codeset.DateTime(true) + ": New task added: customer id: " + String.valueOf(cid) + " task : " + d.getValueAt(i, 0).toString() + " Job-id: " + jobID);
            }
            notificationAdd(codeset.DateTime(true) + ": New Job added: customer id: " + String.valueOf(cid) + " Job-id: " + jobID, "OS", "G");
            return jobID;
        } catch (SQLException e) {
            System.out.println(codeset.DateTime(true) + ": New task adding failed: customer id: " + String.valueOf(cid));
            logAdd(codeset.DateTime(true) + ": New task adding failed: customer id: " + String.valueOf(cid));
            System.out.println("Exception at adding task: " + e);
            return null;
        }
    }

    /**
     *
     * @param d
     * @param cid
     * @return
     */
    public String updateTask(DefaultTableModel d, int cid) {
        try {
            String jobID = codeset.DateTime(false);

            for (int i = 0; i < d.getRowCount(); i++) {
                query = "insert into job (job_id, customer_id, task_id, date, deadline, priority, status, special_instruction,price)"
                        + " values (?,?,(select task_id from task where description = ?),?,?,?,?,?,?)";
                pst = conn.prepareStatement(query);
                pst.setString(1, jobID);
                pst.setInt(2, cid);
                pst.setString(3, d.getValueAt(i, 0).toString());
                pst.setString(4, codeset.DateTime(true));
                pst.setString(5, codeset.convertStringToDataString(d.getValueAt(i, 3).toString(), true));
                pst.setString(6, d.getValueAt(i, 1).toString());
                pst.setString(7, "Pending");
                String x = d.getValueAt(i, 4).toString();
                pst.setString(8, x);
                pst.setFloat(9, Float.parseFloat(d.getValueAt(i, 2).toString()));
                pst.executeUpdate();
                System.out.println(codeset.DateTime(true) + ": New task added: customer id: " + String.valueOf(cid) + " task : " + d.getValueAt(i, 0).toString());
                logAdd(codeset.DateTime(true) + ": New task added: customer id: " + String.valueOf(cid) + " task : " + d.getValueAt(i, 0).toString() + " Job-id: " + jobID);
            }

            notificationAdd(codeset.DateTime(true) + ": New Job added: customer id: " + String.valueOf(cid) + " Job-id: " + jobID, "OS", "G");

            return jobID;
        } catch (SQLException e) {
            System.out.println(codeset.DateTime(true) + ": New task adding failed: customer id: " + String.valueOf(cid));
            logAdd(codeset.DateTime(true) + ": New task adding failed: customer id: " + String.valueOf(cid));
            System.out.println("Exception at adding task: " + e);
            return null;
        }
    }

    public DefaultTableModel populateCTask(String s) {

        try {
            query = "select job.job_id, task.description, job.status, job.deadline, job.price, if(COALESCE(receipt.receipt_id,false) ,'Paid','Unpaid' ) as paid from job left join receipt on job.prime_id = receipt.prime_id left join task on job.task_id = task.task_id where customer_id = " + s;

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
        } catch (SQLException e) {
            System.out.println("Exception in Customer task List: " + e);
            return null;
        }
    }

    public DefaultComboBoxModel populateCardList(int i) {
        try {
            query = "select * from card where customer_id =" + String.valueOf(i);
            DefaultComboBoxModel d = new DefaultComboBoxModel();
            st = conn.createStatement();
            rs = st.executeQuery(query);
            Object o = new Object();

            while (rs.next()) {
                o = rs.getString("number");
                d.addElement(o);
            }
            return d;
        } catch (SQLException e) {
            System.out.println("Exception in populating card list: " + e);
            return null;
        }
    }

    public void addCard(String cn, String name, String date, String ccv, int cid) {
        try {
            query = "INSERT INTO card (number, name, expire_date, ccv, customer_id) VALUES (?,?,?,?,?)";
            pst = conn.prepareStatement(query);
            pst.setString(1, cn);
            pst.setString(2, name);
            pst.setString(3, date);
            pst.setString(4, ccv);
            pst.setInt(5, cid);
            pst.executeUpdate();
            System.out.println(codeset.DateTime(true) + ": New card added: customer id: " + String.valueOf(cid) + " card number : " + cn);
            logAdd(codeset.DateTime(true) + ": New card added: customer id: " + String.valueOf(cid) + " card number : " + cn);
        } catch (SQLException e) {
            System.out.println("Exception in adding new card: " + e);
            System.out.println("Failed to adding new card: " + cn + "to the customer account : " + String.valueOf(cid));
            logAdd(codeset.DateTime(true) + ":Failed to adding new card: " + cn + "to the customer account : " + String.valueOf(cid));
        }
    }

    public ArrayList<String> getPrime(String s) {
        try {
            query = "select prime_id from job where job_id = " + s;
            st = conn.createStatement();
            rs = st.executeQuery(query);
            ArrayList<String> ls = new ArrayList<String>();
            while (rs.next()) {
                ls.add(rs.getString("prime_id"));
            }
            return ls;
        } catch (SQLException e) {
            System.out.println("Exception while getting prime id" + e);
            return null;
        }

    }

    public void generateReceipt(String type, String cardno, ArrayList<String> primeList) {
        if (type.equals("Cash")) {
            query = "INSERT INTO receipt (type,date,prime_id) VALUES('" + type + "','" + new CodeSet().convertStringToDataString(new CodeSet().DateTime(true), false) + "',?)";
        } else {
            query = "INSERT INTO receipt (type,card_id,date,prime_id,card_number) VALUES('" + type + "',(SELECT card_id from card where number = '" + cardno + "'),'" + new CodeSet().convertStringToDataString(new CodeSet().DateTime(true), false) + "',?,'" + cardno + "')";
        }
        for (int i = 0; i < primeList.size(); i++) {

            try {
                pst = conn.prepareStatement(query);
                pst.setInt(1, Integer.parseInt(primeList.get(i)));
                pst.executeUpdate();

                System.out.println(codeset.DateTime(true) + ": Payment Completed for job-task id: " + String.valueOf(primeList.get(i)));

            } catch (SQLException e) {
                System.out.println(codeset.DateTime(true) + ": Payment failed for job-task id: " + String.valueOf(primeList.get(i)));
                logAdd(codeset.DateTime(true) + ": Payment failed for job-task id: " + String.valueOf(primeList.get(i)));
                System.out.println("Exception while generating receipt" + e);
            }
        }
        for (int i = 0; i < primeList.size(); i++) {
            logAdd(codeset.DateTime(true) + ": Payment Completed for job-task id: " + String.valueOf(primeList.get(i)));
        }

    }

    public DefaultTableModel paymentTask(CodeSet cs, int cid, TableModel t) {
        query = "select job.prime_id, task.description, job.price, job.discount from job left join receipt on job.prime_id = receipt.prime_id left join task on job.task_id = task.task_id where COALESCE(receipt.receipt_id,false) = false and customer_id = " + cid + " order by job.prime_id asc";
        try {
            st = conn.createStatement();
            rs = st.executeQuery(query);
            Object[] obj = new Object[4];
            DefaultTableModel d = (DefaultTableModel) t;
            while (rs.next()) {
                obj[0] = false;
                obj[1] = rs.getString("description");
                obj[2] = rs.getString("price");
                obj[3] = String.valueOf(rs.getFloat("discount"));
                cs.addPrime(rs.getInt("prime_id"));
                d.addRow(obj);
            }
            return d;
        } catch (SQLException e) {
            System.out.println("Failed to potulate tasks for payment");
            System.out.println("Exception while populating payment task");
            return null;
        }
    }

    /**
     *
     * @param b
     * @param cid
     */
    public void setAccountStatus(boolean b, int cid) {
        String s = String.valueOf(cid);
        try {
            query = "UPDATE customer_account SET Suspended = ? WHERE customer_id =" + s;
            pst = conn.prepareStatement(query);
            pst.setString(1, String.valueOf(b));
            pst.executeUpdate();
            if (b) {
                System.out.println(codeset.DateTime(true) + ": Customer account: " + s + " Deactivated");
                logAdd(codeset.DateTime(true) + ": Customer account: " + s + " Deactivated");
            } else {
                System.out.println(codeset.DateTime(true) + ": Customer account: " + s + " Activated");
                logAdd(codeset.DateTime(true) + ": Customer account: " + s + " Activated");
            }
        } catch (SQLException ex) {
            Logger.getLogger(MySQLQueries.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     *
     * @param ls
     * @return
     */
    public boolean editStaff(ArrayList<String> ls) {
        try {
            query = "UPDATE staff_account SET first_name = ?, last_name = ?, address_1 = ?, address_2 = ?, town_city = ?, county = ?, postcode = ?, country = ?, role = ?, department = ?, email = ?, contact_no = ? WHERE staff_id = " + ls.get(0);
            pst = conn.prepareStatement(query);
            pst.setString(1, ls.get(1));
            pst.setString(2, ls.get(2));
            pst.setString(3, ls.get(3));
            pst.setString(4, ls.get(4));
            pst.setString(5, ls.get(5));
            pst.setString(6, ls.get(6));
            pst.setString(7, ls.get(7));
            pst.setString(8, ls.get(8));
            pst.setString(9, ls.get(9));
            if (!ls.get(10).equals("Technician")) {
                pst.setNull(10, Types.VARCHAR);
            } else {
                pst.setString(10, ls.get(10));
            }
            pst.setString(11, ls.get(11));
            pst.setLong(12, Long.parseLong(ls.get(12)));
            pst.executeUpdate();
            System.out.println(codeset.DateTime(true) + ": Staff account: " + ls.get(0) + " profile update successfull");
            logAdd(codeset.DateTime(true) + ": Staff account: " + ls.get(0) + " profile update successfull");
            return true;
        } catch (NumberFormatException | SQLException e) {
            System.out.println(codeset.DateTime(true) + ": Staff account: " + ls.get(0) + " profile update failed");
            logAdd(codeset.DateTime(true) + ": Staff account: " + ls.get(0) + " profile update failed");
            System.out.println("Exception while updating Staff profile :" + e);
            return false;
        }
    }

    /**
     *
     * @param ls
     * @return
     */
    public boolean editCust(ArrayList<String> ls) {
        try {
            query = "UPDATE customer_account SET first_name=?, last_name=?, address_1=?, address_2=?, town_city=?, county=?, postcode=?, country=?, customer_type=?, email=?, contact_no=?, type=?, discount_type= ?, percentage = ? WHERE customer_id = " + ls.get(0);
            pst = conn.prepareStatement(query);
            pst.setString(1, ls.get(1));
            if (ls.get(9).equals("Organisation")) {
                pst.setNull(2, Types.VARCHAR);
            } else {
                pst.setString(2, ls.get(2));
            }
            pst.setString(3, ls.get(3));
            pst.setString(4, ls.get(4));
            pst.setString(5, ls.get(5));
            pst.setString(6, ls.get(6));
            pst.setString(7, ls.get(7));
            pst.setString(8, ls.get(8));
            pst.setString(9, ls.get(9));
            pst.setString(10, ls.get(10));
            pst.setLong(11, Long.parseLong(ls.get(11)));
            pst.setString(12, ls.get(12));
            pst.setString(13, ls.get(13));
            pst.setFloat(14, Float.parseFloat(ls.get(14)));
            pst.executeUpdate();
            System.out.println(codeset.DateTime(true) + ": Customer account: " + ls.get(0) + " profile update successfull");
            logAdd(codeset.DateTime(true) + ": Customer account: " + ls.get(0) + " profile update successfull");
            return true;
        } catch (NumberFormatException | SQLException e) {
            System.out.println(codeset.DateTime(true) + ": Customer account: " + ls.get(0) + " profile update failed");
            logAdd(codeset.DateTime(true) + ": Customer account: " + ls.get(0) + " profile update failed");
            System.out.println("Exception while updating Customer profile :" + e);
            return false;
        }
    }

    public DefaultTableModel notification(String s) {

        try {
            if (s.equals("Shift Manager")) {
                query = "select message from notification where (access = 'S' || access = 'OS')";
            } else if (s.equals("Office Manager")) {
                query = "select message from notification where (access = 'O' || access = 'OS')";
            } else {
                return null;
            }

            DefaultTableModel d = new DefaultTableModel();
            d.setColumnIdentifiers(new Object[]{"List"});
            st = conn.createStatement();
            rs = st.executeQuery(query);
            Object[] o = new Object[1];

            while (rs.next()) {
                o[0] = rs.getString("message");
                d.addRow(o);
            }
            return d;
        } catch (SQLException ex) {
            Logger.getLogger(MySQLQueries.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }

    }

    public void notificationClear(String s) {

        try {
            if (s.equals("Shift Manager")) {
                query = "delete from notification where (access = 'S' || access = 'OS')";
            } else if (s.equals("Office Manager")) {
                query = "delete from notification where (access = 'O' || access = 'OS')";
            } else {
            }
            st = conn.createStatement();
            st.executeUpdate(query);
        } catch (SQLException ex) {
            Logger.getLogger(MySQLQueries.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public void notificationAdd(String s, String a, String c) {
        try {
            query = "INSERT INTO notification (message, access, code) VALUES (?,?,?)";
            pst = conn.prepareStatement(query);
            pst.setString(1, s);
            pst.setString(2, a);
            pst.setString(3, c);
            pst.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(MySQLQueries.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public boolean IsExist(String s) {
        try {
            query = "select count(*) as rs from staff_account where staff_id = " + s;
            st = conn.createStatement();
            rs = st.executeQuery(query);
            if (rs.next()) {
                return rs.getInt("rs") > 0;
            }
            return false;
        } catch (SQLException e) {
            System.out.println("Exception while getting prime id" + e);
            return false;
        }

    }

    public DefaultTableModel log() {

        try {
            query = "select logger from log";

            DefaultTableModel d = new DefaultTableModel();
            d.setColumnIdentifiers(new Object[]{"Logger"});
            st = conn.createStatement();
            rs = st.executeQuery(query);
            Object[] o = new Object[1];

            while (rs.next()) {
                o[0] = rs.getString("logger");
                d.addRow(o);
            }
            return d;
        } catch (SQLException ex) {
            Logger.getLogger(MySQLQueries.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }

    }

    public void logClear() {

        try {
            query = "delete from log";
            st = conn.createStatement();
            st.executeUpdate(query);
        } catch (SQLException ex) {
            Logger.getLogger(MySQLQueries.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public void logAdd(String s) {
        try {
            query = "INSERT INTO log (logger) VALUES (?)";
            pst = conn.prepareStatement(query);
            pst.setString(1, s);
            pst.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(MySQLQueries.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public String getJobID(String s) {

        try {
            query = "select job_id from job where prime_id = " + s;
            st = conn.createStatement();
            rs = st.executeQuery(query);
            if (rs.next()) {
                return rs.getString("job_id");
            }
            return null;
        } catch (SQLException ex) {
            Logger.getLogger(MySQLQueries.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }

    public void addTask(ArrayList<String> ls) {
        try {
            query = "INSERT INTO task (description, Department, `Shelf slot`, price, duration,percentage) VALUES (?, ?, ?, ?, ?,?)";
            pst = conn.prepareStatement(query);
            pst.setString(1, ls.get(0));
            pst.setString(2, ls.get(1));
            pst.setString(3, ls.get(2));
            pst.setFloat(4, Float.parseFloat(ls.get(3)));
            pst.setString(5, ls.get(4));
            pst.setFloat(6, Float.parseFloat(ls.get(5)));
            pst.executeUpdate();
            logAdd(codeset.DateTime(true) + ": New Task: " + ls.get(0) + " : Added to task list");
        } catch (SQLException ex) {
            Logger.getLogger(MySQLQueries.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public DefaultTableModel JobList(String s) {

        try {
            if (s.endsWith("ID")) {
                String s1 = s.substring(0, s.length() - 2);
                if (s1.matches("\\d+")) {
                    query = "select j.prime_id,j.job_id,j.customer_id,j.staff_id,(select description from task as t where t.task_id = j.task_id) as task, j.date,j.deadline,j.priority,j.status,j.start_time,j.special_instruction, j.staff_instruction from job as j where j.prime_id =" + Integer.parseInt(s1);
                }
            } else if (s.equals("Standard") || s.equals("standard") || s.equals("Urgent") || s.equals("urgent")) {
                query = "select  j.prime_id,j.job_id,j.customer_id,j.staff_id,(select description from task as t where t.task_id = j.task_id) as task, j.date,j.deadline,j.priority,j.status,j.start_time,j.special_instruction, j.staff_instruction from job as j where j.priority like '%" + s + "%'";
            } else if (s.equals("Pending") || s.equals("pending") || s.equals("finished") || s.equals("Finished")) {
                query = "select  j.prime_id,j.job_id,j.customer_id,j.staff_id,(select description from task as t where t.task_id = j.task_id) as task, j.date,j.deadline,j.priority,j.status,j.start_time,j.special_instruction, j.staff_instruction from job as j where j.status like '%" + s + "%'";
            } else if (s.equals("In-Progress") || s.equals("in-progress") || s.equals("InProgress") || s.equals("inprogress") || s.equals("in-Progress") || s.equals("In-progress") || s.equals("Inprogress") || s.equals("inProgress")) {
                query = "select  j.prime_id,j.job_id,j.customer_id,j.staff_id,(select description from task as t where t.task_id = j.task_id) as task, j.date,j.deadline,j.priority,j.status,j.start_time,j.special_instruction, j.staff_instruction from job as j where j.status = 'In-Progress'";
            } else if (s.equals("Enter Keywords") || s.isEmpty()) {
                query = "select  j.prime_id,j.job_id,j.customer_id,j.staff_id,(select description from task as t where t.task_id = j.task_id) as task, j.date,j.deadline,j.priority,j.status,j.start_time,j.special_instruction, j.staff_instruction from job as j";
            } else if (s.startsWith("2")) {
                query = "select  j.prime_id,j.job_id,j.customer_id,j.staff_id,(select description from task as t where t.task_id = j.task_id) as task, j.date,j.deadline,j.priority,j.status,j.start_time,j.special_instruction, j.staff_instruction from job as j where j.job_id like '%" + s + "%'";
            } else {
                query = "select  j.prime_id,j.job_id,j.customer_id,j.staff_id,t.description as task, j.date,j.deadline,j.priority,j.status,j.start_time,j.special_instruction, j.staff_instruction from job as j inner join task t on j.task_id = t.task_id where t.description like '%" + s + "%'";
            }

            DefaultTableModel d = new DefaultTableModel();
            d.setColumnIdentifiers(new Object[]{"Job-Task ID", "Job ID", "Customer ID", "Staff ID", "Task", "Date", "Deadline", "Priority", "Status", "Start Time", "Special Instruction", "Staff Instruction"});
            st = conn.createStatement();
            rs = st.executeQuery(query);
            Object[] obj = new Object[12];
            while (rs.next()) {
                obj[0] = rs.getInt(1);
                obj[1] = rs.getLong(2);
                obj[2] = rs.getString(3);
                obj[3] = rs.getString(4);
                obj[4] = rs.getString(5);
                obj[5] = rs.getString(6);
                obj[6] = rs.getString(7);
                obj[7] = rs.getString(8);
                obj[8] = rs.getString(9);
                obj[9] = rs.getString(10);
                obj[10] = rs.getString(11);
                obj[10] = rs.getString(12);
                d.addRow(obj);
            }
            return d;
        } catch (NumberFormatException | SQLException e) {
            System.out.println("Exception in Job List: " + e);
            return null;
        }
    }

    public DefaultTableModel deadline() {
        try {
            query = "select j.prime_id,j.job_id,j.customer_id,t.description,j.date,t.price from job as j left join receipt as r on j.prime_id = r.prime_id left join task as t on j.task_id = t.task_id where (j.date < '" + new CodeSet().monthDeadline() + "') and (r.receipt_id is null )";

            DefaultTableModel d = new DefaultTableModel();
            d.setColumnIdentifiers(new Object[]{"ID", "Job ID", "Customer ID", "Task", "Date", "Price"});
            st = conn.createStatement();
            rs = st.executeQuery(query);
            Object[] obj = new Object[10];
            while (rs.next()) {
                obj[0] = rs.getLong(1);
                obj[1] = rs.getString(2);
                obj[2] = rs.getString(3);
                obj[3] = rs.getString(4);
                obj[4] = rs.getString(5);
                obj[5] = rs.getString(6);
                d.addRow(obj);
            }

            if (d.getRowCount() > 0) {
                notificationAdd(new CodeSet().DateTime(true) + ": " + String.valueOf(d.getRowCount()) + " due payment left: Please check due list", "OS", "R");
            }
            return d;
        } catch (SQLException ex) {
            Logger.getLogger(MySQLQueries.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }

    public String Jobs(int s) {
        switch (s) {
            case 1:
                query = "select count(*) as count from job where status = 'In-Progress' || status = 'Pending'";
                break;
            case 2:
                query = "select count(*) as count from job where status = 'Finished'";
                break;
            case 3:
                query = "select count(*) as count from job where status = 'On_Hold'";
                break;
            default:
                break;
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

    public ArrayList<String> techPopulate(String i) {
        query = "select j.prime_id,j.job_id,j.deadline,j.customer_id, t.description,j.special_instruction from job as j join task as t on j.task_id = t.task_id where j.status = 'In-Progress' and staff_id =" + i;

        try {
            pst = conn.prepareStatement(query);
            rs = pst.executeQuery();
            ArrayList<String> ls = new ArrayList<>();
            if (rs.next()) {
                ls.add(String.valueOf(rs.getInt(1)));
                ls.add(rs.getString(2));
                ls.add(rs.getString(3));
                ls.add(rs.getString(4));
                ls.add(rs.getString(5));
                ls.add(rs.getString(6));
                return ls;
            } else {
                return null;
            }
        } catch (SQLException e) {
            System.out.println("Exception Technician " + e);
            return null;
        }
    }

    public void updateTaskStatus(String s, String tid, String status, String inst) {

        if (inst == null || inst.isEmpty()) {
            inst = "";
        }
        try {

            if (status.equals("On-Hold") || status.equals("Pending")) {
                query = "update job set status = '" + status + "', staff_instruction = '" + inst + "' where prime_id = " + tid;
            } else {
                query = "update job set status = '" + status + "', staff_instruction = '" + inst + "', end_time = '" + new CodeSet().DateTime(true) + "' where prime_id = " + tid;
            }
            pst = conn.prepareStatement(query);
            pst.executeUpdate();
            logAdd(new CodeSet().DateTime(true) + ": Job-Task: " + tid + ": status updated: " + status + ": by Staff id: " + s);
        } catch (SQLException ex) {
            Logger.getLogger(MySQLQueries.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public boolean checkStaff(String s) {
        try {
            query = "select count(*) as result from job where  status = 'In-Progress'  and staff_id = " + s;
            pst = conn.prepareStatement(query);
            rs = pst.executeQuery();
            if (rs.next()) {
                if (rs.getLong(1) == 0) {
                    return false;
                } else {
                    return true;
                }
            }
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(MySQLQueries.class.getName()).log(Level.SEVERE, null, ex);
            return true;
        }
    }

    public void assignToStaff(String id, String area) {
        try {
            query = "select j.prime_id as prime from job as j join task as t on j.task_id = t.task_id where t.Department = '" + area + "' and status = 'Pending' order by deadline asc, prime_id ASC limit 1";

            pst = conn.prepareStatement(query);
            rs = pst.executeQuery();

            if (rs.next()) {
                logAdd("Job-Task id: " + String.valueOf(rs.getLong("prime")) + " : assigned to the staff_id: " + id);
                query = "update job set staff_id = " + id + " , status = 'In-Progress', start_time = '" + new CodeSet().DateTime(true) + "' where prime_id = " + String.valueOf(rs.getLong("prime"));
                pst = conn.prepareStatement(query);
                pst.executeUpdate();
            }
        } catch (SQLException ex) {
            Logger.getLogger(MySQLQueries.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public ArrayList<String> discount(String cid) {
        try {
            query = "select discount_type, percentage from customer_account where customer_id = " + cid;
            pst = conn.prepareStatement(query);
            rs = pst.executeQuery();
            ArrayList<String> ld = new ArrayList<>();
            if (rs.next()) {
                ld.add(rs.getString(1));
                if (ld.get(0).equals("Fixed")) {
                    ld.add(String.valueOf(rs.getFloat(2)));
                    return ld;
                }
                return ld;
            }
            return null;
        } catch (SQLException ex) {
            Logger.getLogger(MySQLQueries.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }

    public float monthlySpending(String cid) {

        try {
            query = "select sum(price) as sum from job  where customer_id = ? and date < ? and date > ?";
            pst = conn.prepareStatement(query);
            pst.setInt(1, Integer.parseInt(cid));
            pst.setString(2, new CodeSet().monthDeadlineUpperLimit());
            pst.setString(3, new CodeSet().monthDeadline());
            rs = pst.executeQuery();
            if (rs.next()) {
                return (rs.getFloat("sum"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(MySQLQueries.class.getName()).log(Level.SEVERE, null, ex);
            return 0f;
        }
        System.out.println("aaa");
        return 0;
    }

    public float FlexibleDiscount(String cid) {
        try {
            float f = monthlySpending(cid);
            query = "select discount_rate from band";
            st = conn.createStatement();
            rs = st.executeQuery(query);
            float[] fl = new float[3];
            int i = 0;
            while (rs.next()) {
                fl[i] = rs.getFloat(1);
                i++;
            }

            if (f < 1000f) {
                return fl[0];
            } else if (f < 2000f) {
                return fl[1];
            } else {
                return fl[2];
            }
        } catch (SQLException ex) {
            Logger.getLogger(MySQLQueries.class.getName()).log(Level.SEVERE, null, ex);
            return 0f;
        }
    }

    public float VariabeDiscount(String des) {
        try {
            query = "select percentage from task where description = '" + des + "'";
            pst = conn.prepareStatement(query);
            rs = pst.executeQuery();
            if (rs.next()) {
                return rs.getFloat(1);
            } else {
                return -1f;
            }
        } catch (SQLException ex) {
            Logger.getLogger(MySQLQueries.class.getName()).log(Level.SEVERE, null, ex);
            return -1f;
        }
    }

    public DefaultTableModel TaskList(String s) {
        try {
            query = " select description, Department, `Shelf Slot`, price, duration, percentage from task where description like '%" + s + "%' || Department like '%" + s + "%' || `Shelf Slot` like '%" + s + "%'";
            DefaultTableModel d = new DefaultTableModel();
            d.setColumnIdentifiers(new Object[]{"description", "Department", "Shelf Slot", "price", "duration", "percentage"});
            st = conn.createStatement();
            rs = st.executeQuery(query);
            Object[] obj = new Object[6];
            while (rs.next()) {
                obj[0] = rs.getString(1);
                obj[1] = rs.getString(2);
                obj[2] = rs.getString(3);
                obj[3] = rs.getString(4);
                obj[4] = rs.getString(5);
                obj[5] = rs.getString(6);
                d.addRow(obj);
            }
            return d;
        } catch (SQLException ex) {
            Logger.getLogger(MySQLQueries.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }

    public void ModifyTable(ArrayList<String> ls, ArrayList<String> l) {
        try {
            query = "update task set description = ?, Department = ?, `Shelf Slot`= ?, price = ?, duration = ?, percentage = ? where  description = '" + l.get(0) + "' and `Shelf Slot` = '" + l.get(2) + "'";
            pst = conn.prepareStatement(query);
            pst.setString(1, ls.get(0));
            pst.setString(2, ls.get(1));
            pst.setString(3, ls.get(2));
            pst.setFloat(4, Float.parseFloat(ls.get(3)));
            pst.setString(5, ls.get(4));
            pst.setFloat(6, Float.parseFloat(ls.get(5)));
            pst.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(MySQLQueries.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void DeleteTask(ArrayList<String> l) {
        try {
            query = "delete from task where description = '" + l.get(0) + "' and `Shelf Slot` = '" + l.get(2) + "'";
            st = conn.createStatement();
            st.executeUpdate(query);
        } catch (SQLException ex) {
            Logger.getLogger(MySQLQueries.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void DeleteCard(String cid) {
        try {
            query = "delete from card where customer_id =" + cid;
            st = conn.createStatement();
            st.executeUpdate(query);
        } catch (SQLException ex) {
            Logger.getLogger(MySQLQueries.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void EjectSeq1(String cid) {
        try {
            query = " select prime_id from job where customer_id = " + cid + " and (status ='Pending' || status ='In-Progress' || status ='On-Hold')";
            st = conn.createStatement();
            rs = st.executeQuery(query);
            ArrayList<String> l = new ArrayList<>();
            while (rs.next()) {
                l.add(String.valueOf(rs.getInt(1)));
            }
            EjectSeq2(l);
        } catch (SQLException ex) {
            Logger.getLogger(MySQLQueries.class.getName()).log(Level.SEVERE, null, ex);

        }
    }

    public void EjectSeq2(ArrayList<String> l) {
        try {
            for (int i = 0; i < l.size(); i++) {
                query = "update job set status = 'Customer-Removed' where prime_id = " + l.get(i);
                pst = conn.prepareStatement(query);
                pst.executeUpdate();
            }

        } catch (SQLException ex) {
            Logger.getLogger(MySQLQueries.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void EjectSeq3(String sid) {
        try {
            query = " select prime_id from job where staff_id = " + sid + " and status ='In-Progress' ";
            st = conn.createStatement();
            rs = st.executeQuery(query);
            String s = null;
            if (rs.next()) {
                s = String.valueOf(rs.getInt(1));
            }
            EjectSeq4(s);
        } catch (SQLException ex) {
            Logger.getLogger(MySQLQueries.class.getName()).log(Level.SEVERE, null, ex);

        }
    }

    public void EjectSeq4(String l) {
        try {
            query = "update job set status = 'Pending' where prime_id = " + l;
            pst = conn.prepareStatement(query);
            pst.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(MySQLQueries.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public DefaultTableModel statusUpdate() {
        try {
            query = "select j.prime_id,j.job_id,j.customer_id,t.description,j.date,j.staff_instruction from job as j left join receipt as r on j.prime_id = r.prime_id left join task as t on j.task_id = t.task_id where j.status = 'On-Hold'";

            DefaultTableModel d = new DefaultTableModel();
            d.setColumnIdentifiers(new Object[]{"ID", "Job ID", "Customer ID", "Task", "Date", "staff_instruction"});
            st = conn.createStatement();
            rs = st.executeQuery(query);
            Object[] obj = new Object[10];
            while (rs.next()) {
                obj[0] = rs.getLong(1);
                obj[1] = rs.getString(2);
                obj[2] = rs.getString(3);
                obj[3] = rs.getString(4);
                obj[4] = rs.getString(5);
                obj[5] = rs.getString(6);
                d.addRow(obj);
            }
            return d;
        } catch (SQLException ex) {
            Logger.getLogger(MySQLQueries.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }  
    }

    public void initPassword(String s) {
        try {
            query = "update staff_account set password_reset = 1 where staff_id= " + s;
            pst = conn.prepareStatement(query);
            pst.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(MySQLQueries.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public DefaultTableModel passwordUpdate() {
        try {
            query = "select staff_id, first_name, last_name,  role, email, contact_no from staff_account where password_reset = 1";

            DefaultTableModel d = new DefaultTableModel();
            d.setColumnIdentifiers(new Object[]{"ID","First Name", "Last Name", "Role", "Email", "Phone"});
            st = conn.createStatement();
            rs = st.executeQuery(query);
            Object[] obj = new Object[6];
            while (rs.next()) {
                obj[0] = rs.getLong(1);
                obj[1] = rs.getString(2);
                obj[2] = rs.getString(3);
                obj[3] = rs.getString(4);
                obj[4] = rs.getString(5);
                obj[5] = rs.getString(6);
                d.addRow(obj);
            }
            return d;
        } catch (SQLException ex) {
            Logger.getLogger(MySQLQueries.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
    
     public void initPassword(String s, String pass) {
        try {
            query = "update staff_account set password_reset = 0, password = '"+pass+"' where staff_id= " + s;
            pst = conn.prepareStatement(query);
            pst.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(MySQLQueries.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
