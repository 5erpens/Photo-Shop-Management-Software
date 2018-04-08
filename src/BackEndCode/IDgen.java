/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BackEndCode;

/**
 *
 * @author Sai
 */

public class IDgen {
    
    private String staff = "STF";
    private String customer = "ACC";
    private String job = "JOB";

    public String getStaff() {
        return staff;
    }

    public void setStaff(String staff) {
        this.staff = staff;
    }

    public String getCustomer() {
        return customer;
    }

    public void setCustomer(String customer) {
        this.customer = customer;
    }

    public String getJob() {
        return job;
    }

    public void setJob(String job) {
        this.job = job;
    }
    
    public String generate(int id, int n){
        String str = null;
        switch (n) {
            case 1:
                str = staff;
                break;
            case 2:
                str = customer;
                break;
            case 3:
                str = job;
                break;
            default:
                break;
        }
        
        for(int i = 3; i>String.valueOf(id).length();i--){
            str = str + "0";
        }
        str = str + String.valueOf(id);
        return str;
    }
}
