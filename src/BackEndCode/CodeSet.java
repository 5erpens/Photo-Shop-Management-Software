/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BackEndCode;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;
import java.io.IOException;
import java.net.URISyntaxException;
import java.security.CodeSource;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.swing.JOptionPane;
import javax.swing.JTable;
import javax.swing.Timer;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.TableModel;

/**
 *
 * @author Sai
 */
public class CodeSet {

    //Staff Identify 
    private List<String> ls = null;

    private List<String> prime = new ArrayList<String>();

    //All country list from Stack Overflow
    public String[] getAllCountries() {
        String[] countries = new String[Locale.getISOCountries().length];
        String[] countryCodes = Locale.getISOCountries();
        for (int i = 0; i < countryCodes.length; i++) {
            Locale obj = new Locale("", countryCodes[i]);
            countries[i] = obj.getDisplayCountry();
        }
        return countries;
    }

    //Codesnip taken from stackoverflow
    //Date for Logs
    public String DateTime(boolean n) {
        DateFormat dateFormat;
        if (n) {
            dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        } else {
            dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
        }
        Calendar cal = Calendar.getInstance();
        return dateFormat.format(cal.getTime());
    }

    //Codesnip taken from stackoverflow
    //https://stackoverflow.com/questions/16426703/how-to-convert-a-date-dd-mm-yyyy-to-yyyy-mm-dd-hhmmss-android#16426777
    public String convertStringToDataString(String stringData, boolean n) {

        SimpleDateFormat sdf;
        if (n) {
            sdf = new SimpleDateFormat("dd-MM-yyyy");
        } else {
            sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        }
        SimpleDateFormat output = new SimpleDateFormat("yyyy-MM-dd");
        Date data = null;
        try {
            data = sdf.parse(stringData);
        } catch (ParseException ex) {
            Logger.getLogger(CodeSet.class.getName()).log(Level.SEVERE, null, ex);
        }
        String formattedTime = output.format(data);
        return formattedTime;
    }

    public String filename(String stringData, boolean n) {

        SimpleDateFormat sdf;
        if (n) {
            sdf = new SimpleDateFormat("dd-MM-yyyy");
        } else {
            sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        }
        SimpleDateFormat output = new SimpleDateFormat("dd-MM-yyyy_HH-mm-ss");
        Date data = null;
        try {
            data = sdf.parse(stringData);
        } catch (ParseException ex) {
            Logger.getLogger(CodeSet.class.getName()).log(Level.SEVERE, null, ex);
        }
        String formattedTime = output.format(data);
        return formattedTime;
    }

    //Email validater from third party library 
    //https://stackoverflow.com/questions/624581/what-is-the-best-java-email-address-validation-method
    //https://javaee.github.io/javamail/
    public static boolean isValidEmailAddress(String email) {
        boolean result = true;
        try {
            InternetAddress emailAddr = new InternetAddress(email);
            emailAddr.validate();
        } catch (AddressException ex) {
            result = false;
        }
        return result;
    }

    public java.sql.Date mysqlDate(String date, boolean n) {
        DateFormat formatter;
        if (n) {
            formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        } else {
            formatter = new SimpleDateFormat("yyyy-MM-dd");
        }

        Date myDate;
        try {
            myDate = formatter.parse(date);
            return new java.sql.Date(myDate.getTime());
        } catch (ParseException ex) {
            Logger.getLogger(CodeSet.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }

    public void setStaffDetails(String id, String role, String department, String fName, String lName) {
        ls = new ArrayList<>();
        ls.add(id);
        ls.add(role);
        ls.add(department);
        ls.add(fName);
        ls.add(lName);
    }

    public List<String> getStaffDetails() {
        return ls;
    }

    public float calculateVAT(float f) {
        return f * (1f + .20f);
    }

    public List<String> getPrime() {
        return prime;
    }

    public void addPrime(int i) {
        prime.add(String.valueOf(i));
    }

    public String Backupdbtosql() {
        String path = "E:/Projects/Photo-Shop-Management-Software/src/backup/";
        path = path + new CodeSet().filename(new CodeSet().DateTime(true), false) + ".sql";
        String k = "C:/Program Files/MySQL/MySQL Server 5.7/bin/mysqldump.exe -uroot -pQwerty@1234 --add-drop-database -B bapers -r" + path;
        Process p = null;
        try {
            Runtime rt = Runtime.getRuntime();
            p = rt.exec(k);
            int pc = p.waitFor();
            if (pc == 0) {
                return "Backup taken successfull";
            } else {
                return "Backup taken failed";
            }

        } catch (Exception e) {

            System.out.println(DateTime(true) + ": Backup taken failed");
            System.out.println(" Exception while taking backup : " + e);
            return "Backup taken failed";
        }
    }

    public DefaultTableModel populateBackup() {

        File folder = new File(getClass().getResource("/backup").getFile());
        File[] file = folder.listFiles();
        DefaultTableModel d = new DefaultTableModel();
        d.setColumnIdentifiers(new Object[]{"Backup List"});
        Object[] o = new Object[1];
        for (int i = 0; i < file.length; i++) {
            o[0] = file[i].getName();
            d.addRow(o);
        }
        return d;
    }

    public String Restoresql(String s) {
        String path = "E:/Projects/Photo-Shop-Management-Software/src/backup/";
        path = path + s;
        String[] k = new String[]{"C:/Program Files/MySQL/MySQL Server 5.7/bin/mysql.exe", "--user=root", "--password=Qwerty@1234", "-e", "source " + path};
        Process p = null;
        try {
            Runtime rt = Runtime.getRuntime();
            p = rt.exec(k);
            int pc = p.waitFor();
            if (pc == 0) {
                System.out.println(DateTime(true) + ": file: "+s+": Data restoring successfull");
                return "Data restoring successfull";
            } else {
                System.out.println(DateTime(true) + ": file: "+s+": Data restoring failed");
                return "Data restoring failed";
            }
        } catch (Exception e) {

            System.out.println(DateTime(true) + ": Data restoring failed");
            System.out.println(" Exception while taking backup : " + e);
            return "Backup taken failed";
        }
    }
}
