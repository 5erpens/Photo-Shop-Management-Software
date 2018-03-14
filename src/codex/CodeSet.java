/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package codex;

import java.util.Locale;

/**
 *
 * @author Sai
 */
public class CodeSet {
    
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
    
}
