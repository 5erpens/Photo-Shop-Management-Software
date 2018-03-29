/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package FrontEndGUI;

import BackEndCode.CodeSet;
import BackEndCode.MySQLQueries;
import java.awt.Color;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.swing.JFrame;

/**
 *
 * @author Sai
 */
public class Payment extends javax.swing.JFrame {

    /**
     * Creates new form staffAccount
     */
    private static Connection conn = null;

    private PreparedStatement pst = null;

    private ResultSet rs = null;

    private CodeSet codeset = null;

    private MySQLQueries SQuery = null;
    
    private String query;
    
    private static String s;
    
    int mouseX;
    int mouseY;
    public Payment(Connection conn, String s) {
        this.conn = conn;
        this.setUndecorated(true);
        initComponents();
        SQuery = new MySQLQueries(conn);
        setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        initiateData(s);
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        bevelBorder1 = (javax.swing.border.BevelBorder)javax.swing.BorderFactory.createBevelBorder(javax.swing.border.BevelBorder.RAISED);
        jPanel1 = new javax.swing.JPanel();
        jPanel9 = new javax.swing.JPanel();
        jLabel2 = new javax.swing.JLabel();
        exit1 = new javax.swing.JButton();
        jLabel1 = new javax.swing.JLabel();
        jPanel3 = new javax.swing.JPanel();
        jScrollPane1 = new javax.swing.JScrollPane();
        fName3 = new javax.swing.JLabel();
        jCheckBox1 = new javax.swing.JCheckBox();
        jPanel4 = new javax.swing.JPanel();
        fName2 = new javax.swing.JLabel();
        fName4 = new javax.swing.JLabel();
        fName5 = new javax.swing.JLabel();
        fName6 = new javax.swing.JLabel();
        fName7 = new javax.swing.JLabel();
        fName8 = new javax.swing.JLabel();
        jSeparator1 = new javax.swing.JSeparator();
        fName9 = new javax.swing.JLabel();
        fName10 = new javax.swing.JLabel();
        fName11 = new javax.swing.JLabel();
        jSeparator2 = new javax.swing.JSeparator();
        fName12 = new javax.swing.JLabel();
        jRadioButton1 = new javax.swing.JRadioButton();
        addTask = new javax.swing.JButton();
        jFormattedTextField1 = new javax.swing.JFormattedTextField();
        jRadioButton2 = new javax.swing.JRadioButton();
        jPanel2 = new javax.swing.JPanel();
        jLabel22 = new javax.swing.JLabel();
        jButton1 = new javax.swing.JButton();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        getContentPane().setLayout(new org.netbeans.lib.awtextra.AbsoluteLayout());

        jPanel1.setBackground(new java.awt.Color(204, 204, 204));
        jPanel1.setBorder(javax.swing.BorderFactory.createBevelBorder(javax.swing.border.BevelBorder.RAISED));

        jPanel9.setBackground(new java.awt.Color(59, 63, 66));
        jPanel9.setForeground(new java.awt.Color(59, 63, 66));
        jPanel9.addMouseMotionListener(new java.awt.event.MouseMotionAdapter() {
            public void mouseDragged(java.awt.event.MouseEvent evt) {
                jPanel9MouseDragged(evt);
            }
        });
        jPanel9.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mousePressed(java.awt.event.MouseEvent evt) {
                jPanel9MousePressed(evt);
            }
        });
        jPanel9.setLayout(new org.netbeans.lib.awtextra.AbsoluteLayout());

        jLabel2.setBackground(new java.awt.Color(171, 172, 173));
        jLabel2.setFont(new java.awt.Font("Dialog", 1, 24)); // NOI18N
        jLabel2.setForeground(new java.awt.Color(171, 172, 173));
        jLabel2.setText("Order Summary");
        jPanel9.add(jLabel2, new org.netbeans.lib.awtextra.AbsoluteConstraints(40, 20, 280, -1));

        exit1.setBackground(new java.awt.Color(255, 0, 0));
        exit1.setForeground(new java.awt.Color(255, 255, 255));
        exit1.setText("X");
        exit1.setHorizontalTextPosition(javax.swing.SwingConstants.LEFT);
        exit1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                exit1ActionPerformed(evt);
            }
        });
        jPanel9.add(exit1, new org.netbeans.lib.awtextra.AbsoluteConstraints(720, -10, -1, 40));

        jPanel3.setBackground(new java.awt.Color(153, 153, 153));

        fName3.setBackground(new java.awt.Color(59, 63, 66));
        fName3.setFont(fName3.getFont().deriveFont(fName3.getFont().getStyle() | java.awt.Font.BOLD, fName3.getFont().getSize()+2));
        fName3.setForeground(new java.awt.Color(59, 63, 66));
        fName3.setText("Task");

        jCheckBox1.setBackground(new java.awt.Color(153, 153, 153));
        jCheckBox1.setForeground(new java.awt.Color(59, 63, 66));
        jCheckBox1.setText("Select All");

        javax.swing.GroupLayout jPanel3Layout = new javax.swing.GroupLayout(jPanel3);
        jPanel3.setLayout(jPanel3Layout);
        jPanel3Layout.setHorizontalGroup(
            jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel3Layout.createSequentialGroup()
                .addGap(12, 12, 12)
                .addGroup(jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jCheckBox1)
                    .addComponent(fName3, javax.swing.GroupLayout.PREFERRED_SIZE, 140, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 261, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addContainerGap(17, Short.MAX_VALUE))
        );
        jPanel3Layout.setVerticalGroup(
            jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel3Layout.createSequentialGroup()
                .addGap(18, 18, 18)
                .addComponent(fName3)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 334, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jCheckBox1)
                .addContainerGap(27, Short.MAX_VALUE))
        );

        jPanel4.setBackground(new java.awt.Color(153, 153, 153));

        fName2.setBackground(new java.awt.Color(59, 63, 66));
        fName2.setFont(fName2.getFont().deriveFont(fName2.getFont().getStyle() | java.awt.Font.BOLD, fName2.getFont().getSize()+2));
        fName2.setForeground(new java.awt.Color(59, 63, 66));
        fName2.setText("Subtotal");

        fName4.setBackground(new java.awt.Color(59, 63, 66));
        fName4.setFont(fName4.getFont().deriveFont(fName4.getFont().getStyle() | java.awt.Font.BOLD, fName4.getFont().getSize()+2));
        fName4.setForeground(new java.awt.Color(59, 63, 66));
        fName4.setText("£");

        fName5.setBackground(new java.awt.Color(59, 63, 66));
        fName5.setFont(fName5.getFont().deriveFont(fName5.getFont().getStyle() | java.awt.Font.BOLD, fName5.getFont().getSize()+2));
        fName5.setForeground(new java.awt.Color(59, 63, 66));
        fName5.setText("Subtotal");

        fName6.setBackground(new java.awt.Color(59, 63, 66));
        fName6.setFont(fName6.getFont().deriveFont(fName6.getFont().getStyle() | java.awt.Font.BOLD, fName6.getFont().getSize()+2));
        fName6.setForeground(new java.awt.Color(59, 63, 66));
        fName6.setText("VAT");

        fName7.setBackground(new java.awt.Color(59, 63, 66));
        fName7.setFont(fName7.getFont().deriveFont(fName7.getFont().getStyle() | java.awt.Font.BOLD, fName7.getFont().getSize()+2));
        fName7.setForeground(new java.awt.Color(59, 63, 66));
        fName7.setText("£");

        fName8.setBackground(new java.awt.Color(59, 63, 66));
        fName8.setFont(fName8.getFont().deriveFont(fName8.getFont().getStyle() | java.awt.Font.BOLD, fName8.getFont().getSize()+2));
        fName8.setForeground(new java.awt.Color(59, 63, 66));
        fName8.setText("VAT");

        fName9.setBackground(new java.awt.Color(59, 63, 66));
        fName9.setFont(fName9.getFont().deriveFont(fName9.getFont().getStyle() | java.awt.Font.BOLD, fName9.getFont().getSize()+2));
        fName9.setForeground(new java.awt.Color(59, 63, 66));
        fName9.setText("Total");

        fName10.setBackground(new java.awt.Color(59, 63, 66));
        fName10.setFont(fName10.getFont().deriveFont(fName10.getFont().getStyle() | java.awt.Font.BOLD, fName10.getFont().getSize()+2));
        fName10.setForeground(new java.awt.Color(59, 63, 66));
        fName10.setText("£");

        fName11.setBackground(new java.awt.Color(59, 63, 66));
        fName11.setFont(fName11.getFont().deriveFont(fName11.getFont().getStyle() | java.awt.Font.BOLD, fName11.getFont().getSize()+2));
        fName11.setForeground(new java.awt.Color(59, 63, 66));
        fName11.setText("Total");

        fName12.setBackground(new java.awt.Color(59, 63, 66));
        fName12.setFont(fName12.getFont().deriveFont(fName12.getFont().getStyle() | java.awt.Font.BOLD, fName12.getFont().getSize()+2));
        fName12.setForeground(new java.awt.Color(59, 63, 66));
        fName12.setText("Payment Type");

        jRadioButton1.setBackground(new java.awt.Color(153, 153, 153));
        jRadioButton1.setFont(jRadioButton1.getFont().deriveFont(jRadioButton1.getFont().getStyle() | java.awt.Font.BOLD));
        jRadioButton1.setForeground(new java.awt.Color(59, 63, 66));
        jRadioButton1.setText("Cash");
        jRadioButton1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jRadioButton1ActionPerformed(evt);
            }
        });

        addTask.setBackground(new java.awt.Color(171, 172, 173));
        addTask.setFont(addTask.getFont().deriveFont(addTask.getFont().getStyle() | java.awt.Font.BOLD));
        addTask.setForeground(new java.awt.Color(171, 172, 173));
        addTask.setText("+ Add Task");
        addTask.setBorderPainted(false);
        addTask.setContentAreaFilled(false);
        addTask.setCursor(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));
        addTask.setHorizontalAlignment(javax.swing.SwingConstants.LEFT);
        addTask.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                addTaskActionPerformed(evt);
            }
        });

        jFormattedTextField1.setText("jFormattedTextField1");
        jFormattedTextField1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jFormattedTextField1ActionPerformed(evt);
            }
        });

        jRadioButton2.setBackground(new java.awt.Color(153, 153, 153));
        jRadioButton2.setFont(jRadioButton2.getFont().deriveFont(jRadioButton2.getFont().getStyle() | java.awt.Font.BOLD));
        jRadioButton2.setForeground(new java.awt.Color(59, 63, 66));
        jRadioButton2.setText("Credit/Debit");
        jRadioButton2.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jRadioButton2ActionPerformed(evt);
            }
        });

        jPanel2.setLayout(new org.netbeans.lib.awtextra.AbsoluteLayout());

        jLabel22.setBackground(new java.awt.Color(171, 172, 173));
        jLabel22.setFont(jLabel22.getFont().deriveFont(jLabel22.getFont().getStyle() | java.awt.Font.BOLD, jLabel22.getFont().getSize()+2));
        jLabel22.setForeground(new java.awt.Color(171, 172, 173));
        jLabel22.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        jLabel22.setText("Email");
        jLabel22.setCursor(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));
        jLabel22.setHorizontalTextPosition(javax.swing.SwingConstants.CENTER);
        jPanel2.add(jLabel22, new org.netbeans.lib.awtextra.AbsoluteConstraints(0, 0, 230, 30));

        jButton1.setText("Complete Payment");
        jButton1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButton1ActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout jPanel4Layout = new javax.swing.GroupLayout(jPanel4);
        jPanel4.setLayout(jPanel4Layout);
        jPanel4Layout.setHorizontalGroup(
            jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel4Layout.createSequentialGroup()
                .addGap(26, 26, 26)
                .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel4Layout.createSequentialGroup()
                        .addComponent(jRadioButton2)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(addTask))
                    .addComponent(jSeparator1)
                    .addComponent(jSeparator2)
                    .addComponent(jRadioButton1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(jButton1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addGroup(jPanel4Layout.createSequentialGroup()
                        .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addGroup(jPanel4Layout.createSequentialGroup()
                                .addComponent(fName9, javax.swing.GroupLayout.PREFERRED_SIZE, 74, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addGap(84, 84, 84)
                                .addComponent(fName10)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                                .addComponent(fName11, javax.swing.GroupLayout.PREFERRED_SIZE, 74, javax.swing.GroupLayout.PREFERRED_SIZE))
                            .addGroup(jPanel4Layout.createSequentialGroup()
                                .addComponent(fName6, javax.swing.GroupLayout.PREFERRED_SIZE, 74, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addGap(84, 84, 84)
                                .addComponent(fName7)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                                .addComponent(fName8, javax.swing.GroupLayout.PREFERRED_SIZE, 74, javax.swing.GroupLayout.PREFERRED_SIZE))
                            .addGroup(jPanel4Layout.createSequentialGroup()
                                .addComponent(fName2, javax.swing.GroupLayout.PREFERRED_SIZE, 74, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addGap(84, 84, 84)
                                .addComponent(fName4)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                                .addComponent(fName5, javax.swing.GroupLayout.PREFERRED_SIZE, 74, javax.swing.GroupLayout.PREFERRED_SIZE))
                            .addComponent(fName12))
                        .addGap(0, 3, Short.MAX_VALUE))
                    .addGroup(jPanel4Layout.createSequentialGroup()
                        .addGap(21, 21, 21)
                        .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(jPanel2, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                            .addComponent(jFormattedTextField1))))
                .addGap(23, 23, 23))
        );
        jPanel4Layout.setVerticalGroup(
            jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel4Layout.createSequentialGroup()
                .addGap(19, 19, 19)
                .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(fName2)
                    .addComponent(fName4)
                    .addComponent(fName5))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(fName6)
                    .addComponent(fName7)
                    .addComponent(fName8))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(jSeparator1, javax.swing.GroupLayout.PREFERRED_SIZE, 10, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(fName9)
                    .addComponent(fName10)
                    .addComponent(fName11))
                .addGap(18, 18, 18)
                .addComponent(jSeparator2, javax.swing.GroupLayout.PREFERRED_SIZE, 10, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(18, 18, 18)
                .addComponent(fName12)
                .addGap(18, 18, 18)
                .addComponent(jRadioButton1)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jFormattedTextField1, javax.swing.GroupLayout.PREFERRED_SIZE, 30, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(18, 18, 18)
                .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jRadioButton2)
                    .addComponent(addTask, javax.swing.GroupLayout.PREFERRED_SIZE, 30, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jPanel2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(27, 27, 27)
                .addComponent(jButton1)
                .addContainerGap(38, Short.MAX_VALUE))
        );

        javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);
        jPanel1.setLayout(jPanel1Layout);
        jPanel1Layout.setHorizontalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addGap(8, 8, 8)
                .addComponent(jPanel9, javax.swing.GroupLayout.PREFERRED_SIZE, 750, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(0, 0, Short.MAX_VALUE))
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addGap(28, 28, 28)
                .addComponent(jLabel1)
                .addGap(18, 18, 18)
                .addComponent(jPanel3, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addComponent(jPanel4, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(44, 44, 44))
        );
        jPanel1Layout.setVerticalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addGap(6, 6, 6)
                .addComponent(jPanel9, javax.swing.GroupLayout.PREFERRED_SIZE, 64, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(38, 38, 38)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addGap(42, 42, 42)
                        .addComponent(jLabel1))
                    .addComponent(jPanel3, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jPanel4, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)))
        );

        getContentPane().add(jPanel1, new org.netbeans.lib.awtextra.AbsoluteConstraints(-10, -10, 760, 580));

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void exit1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_exit1ActionPerformed
        // TODO add your handling code here:
        this.dispose();
    }//GEN-LAST:event_exit1ActionPerformed

    private void jPanel9MousePressed(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_jPanel9MousePressed
        mouseX=evt.getX();
        mouseY=evt.getY();
    }//GEN-LAST:event_jPanel9MousePressed

    private void jPanel9MouseDragged(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_jPanel9MouseDragged
        this.setLocation(evt.getXOnScreen()-mouseX, evt.getYOnScreen()-mouseY);
    }//GEN-LAST:event_jPanel9MouseDragged

    private void jRadioButton1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jRadioButton1ActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_jRadioButton1ActionPerformed

    private void jFormattedTextField1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jFormattedTextField1ActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_jFormattedTextField1ActionPerformed

    private void jRadioButton2ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jRadioButton2ActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_jRadioButton2ActionPerformed

    private void addTaskActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_addTaskActionPerformed
        // TODO add your handling code here:
        new CreateTask(conn,id.getText()).show();
    }//GEN-LAST:event_addTaskActionPerformed

    private void jButton1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton1ActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_jButton1ActionPerformed
    
    public void initiateData(String s){
        
        try{
            query = "select * from customer_account where email=\""+s+"\"";
            pst = conn.prepareStatement(query);
            rs = pst.executeQuery();
        
            while(rs.next()){
                id.setText(String.valueOf(rs.getInt("customer_id")));
                role.setText(rs.getString("type"));
                fName.setText(rs.getString("first_name"));
                lName.setText(rs.getString("last_name"));
                String add2 =  rs.getString("address_2");
                String county =  rs.getString("county"); 
                if(add2 == null || add2.isEmpty()){
                    add2 = "";
                } else {
                    add2 = add2 + ", ";
                }
                if(county == null|| county.isEmpty()){
                    county = "";
                } else {
                    county = county + ", ";
                }
                address.setText(rs.getString("address_1")+", "+add2+rs.getString("town_city")+", "+county+rs.getString("postcode")+", "+rs.getString("country"));
                email.setText(rs.getString("email"));
                cno.setText(String.valueOf(rs.getLong("contact_no")));
                if(!rs.getBoolean("suspended")){
                    accsus.setBackground(Color.GREEN);
                    suspend.setText("Active");
                } else {
                    accsus.setBackground(Color.red);
                    suspend.setText("Suspended");
                    addTask.setVisible(false);
                    addTaskPanel.setVisible(false);
                }
                System.out.println("Opened customer account : " + String.valueOf(rs.getInt("customer_id")) );
            }
        } catch(SQLException e){
            System.out.println("Exception in opening customer profile : " + e);
        }
    }
    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(Payment.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(Payment.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(Payment.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(Payment.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>
        //</editor-fold>
        //</editor-fold>
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new Payment(conn,s).setVisible(true);
            }
        });
        
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton addTask;
    private javax.swing.border.BevelBorder bevelBorder1;
    private javax.swing.JButton exit1;
    private javax.swing.JLabel fName10;
    private javax.swing.JLabel fName11;
    private javax.swing.JLabel fName12;
    private javax.swing.JLabel fName2;
    private javax.swing.JLabel fName3;
    private javax.swing.JLabel fName4;
    private javax.swing.JLabel fName5;
    private javax.swing.JLabel fName6;
    private javax.swing.JLabel fName7;
    private javax.swing.JLabel fName8;
    private javax.swing.JLabel fName9;
    private javax.swing.JButton jButton1;
    private javax.swing.JCheckBox jCheckBox1;
    private javax.swing.JFormattedTextField jFormattedTextField1;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel22;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JPanel jPanel3;
    private javax.swing.JPanel jPanel4;
    private javax.swing.JPanel jPanel9;
    private javax.swing.JRadioButton jRadioButton1;
    private javax.swing.JRadioButton jRadioButton2;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JSeparator jSeparator1;
    private javax.swing.JSeparator jSeparator2;
    // End of variables declaration//GEN-END:variables
}
