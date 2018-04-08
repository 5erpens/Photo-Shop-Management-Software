/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BackEndCode;

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

/**
 *
 * @author Sai
 */
public class CodeSet {

    //Staff Identify 
    List<String> ls = null;

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
    public String convertStringToDataString(String stringData)
            throws ParseException {

        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
        SimpleDateFormat output = new SimpleDateFormat("yyyy-MM-dd");
        Date data = sdf.parse(stringData);
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

    // public void 
}
