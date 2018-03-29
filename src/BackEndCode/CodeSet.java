/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BackEndCode;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Locale;
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
    
    //Date for Logs
    public String DateTime() {
        DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        Calendar cal = Calendar.getInstance();
        return dateFormat.format(cal.getTime());
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
    
    public void setStaffDetails(String id, String role, String fName, String lName){
        ls = new ArrayList<String>();
        ls.add(id);
        ls.add(role);
        ls.add(fName);
        ls.add(lName);
    }
    
    public List<String> getStaffDetails(){
        return ls;
    }
    
}
