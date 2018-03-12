/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package JPanels;

import codex.MySQLQueries;
import com.mysql.jdbc.StringUtils;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.swing.table.DefaultTableModel;

/**
 *
 * @author Sai
 */
public class StaffSearchList extends javax.swing.JFrame {

    private static Connection conn = null;

    private Statement pst = null;

    private ResultSet rs = null;
    
    private MySQLQueries SQuery = null;

    /**
     * Creates new form StaffSearchList
     */
    public StaffSearchList(Connection conn, String s) {
        this.conn = conn;
        this.setUndecorated(true);
        initComponents();
        SQuery = new MySQLQueries(conn);
        id.setText(s);
        cTable.setModel(SQuery.SearchStaff(s));
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jPanel1 = new javax.swing.JPanel();
        jScrollPane2 = new javax.swing.JScrollPane();
        cTable = new javax.swing.JTable();
        jPanel2 = new javax.swing.JPanel();
        exit1 = new javax.swing.JButton();
        jLabel1 = new javax.swing.JLabel();
        Submit = new javax.swing.JButton();
        text = new javax.swing.JLabel();
        id = new javax.swing.JTextField();
        exit = new javax.swing.JButton();
        Submit1 = new javax.swing.JButton();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        getContentPane().setLayout(new org.netbeans.lib.awtextra.AbsoluteLayout());

        jPanel1.setBackground(new java.awt.Color(204, 204, 204));
        jPanel1.setBorder(javax.swing.BorderFactory.createBevelBorder(javax.swing.border.BevelBorder.RAISED));
        jPanel1.setForeground(new java.awt.Color(171, 172, 173));
        jPanel1.setLayout(new org.netbeans.lib.awtextra.AbsoluteLayout());

        cTable.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {
                {null, null, null, null, null},
                {null, null, null, null, null},
                {null, null, null, null, null}
            },
            new String [] {
                "ID", "Role", "First Name", "Second Name", "Email ID"
            }
        ) {
            boolean[] canEdit = new boolean [] {
                false, false, false, false, false
            };

            public boolean isCellEditable(int rowIndex, int columnIndex) {
                return canEdit [columnIndex];
            }
        });
        cTable.setColumnSelectionAllowed(true);
        jScrollPane2.setViewportView(cTable);
        cTable.getColumnModel().getSelectionModel().setSelectionMode(javax.swing.ListSelectionModel.SINGLE_INTERVAL_SELECTION);
        if (cTable.getColumnModel().getColumnCount() > 0) {
            cTable.getColumnModel().getColumn(1).setResizable(false);
        }

        jPanel1.add(jScrollPane2, new org.netbeans.lib.awtextra.AbsoluteConstraints(20, 170, 920, 200));

        jPanel2.setBackground(new java.awt.Color(59, 63, 66));
        jPanel2.setForeground(new java.awt.Color(59, 63, 66));
        jPanel2.setLayout(new org.netbeans.lib.awtextra.AbsoluteLayout());

        exit1.setBackground(new java.awt.Color(255, 0, 0));
        exit1.setForeground(new java.awt.Color(255, 255, 255));
        exit1.setText("X");
        exit1.setHorizontalTextPosition(javax.swing.SwingConstants.LEFT);
        exit1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                exit1ActionPerformed(evt);
            }
        });
        jPanel2.add(exit1, new org.netbeans.lib.awtextra.AbsoluteConstraints(930, -10, -1, 40));

        jLabel1.setBackground(new java.awt.Color(171, 172, 173));
        jLabel1.setFont(new java.awt.Font("Dialog", 1, 18)); // NOI18N
        jLabel1.setForeground(new java.awt.Color(171, 172, 173));
        jLabel1.setText("Staff Search Result");
        jPanel2.add(jLabel1, new org.netbeans.lib.awtextra.AbsoluteConstraints(40, 20, 220, -1));

        jPanel1.add(jPanel2, new org.netbeans.lib.awtextra.AbsoluteConstraints(0, 0, 960, 60));

        Submit.setText("Create");
        Submit.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                SubmitActionPerformed(evt);
            }
        });
        jPanel1.add(Submit, new org.netbeans.lib.awtextra.AbsoluteConstraints(870, 100, -1, 30));

        text.setForeground(new java.awt.Color(204, 0, 0));
        jPanel1.add(text, new org.netbeans.lib.awtextra.AbsoluteConstraints(20, 140, 270, 20));

        id.setText("Enter Keywords");
        id.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                idActionPerformed(evt);
            }
        });
        id.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyPressed(java.awt.event.KeyEvent evt) {
                idKeyPressed(evt);
            }
            public void keyReleased(java.awt.event.KeyEvent evt) {
                idKeyReleased(evt);
            }
            public void keyTyped(java.awt.event.KeyEvent evt) {
                idKeyTyped(evt);
            }
        });
        jPanel1.add(id, new org.netbeans.lib.awtextra.AbsoluteConstraints(20, 100, 760, 30));

        exit.setText("X");
        exit.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                exitActionPerformed(evt);
            }
        });
        jPanel1.add(exit, new org.netbeans.lib.awtextra.AbsoluteConstraints(660, -8, -1, 40));

        Submit1.setText("Search");
        Submit1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                Submit1ActionPerformed(evt);
            }
        });
        jPanel1.add(Submit1, new org.netbeans.lib.awtextra.AbsoluteConstraints(790, 100, -1, 30));

        getContentPane().add(jPanel1, new org.netbeans.lib.awtextra.AbsoluteConstraints(-4, 0, 960, 392));

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void SubmitActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_SubmitActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_SubmitActionPerformed

    private void exitActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_exitActionPerformed
        // TODO add your handling code here:
        this.dispose();
    }//GEN-LAST:event_exitActionPerformed

    private void exit1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_exit1ActionPerformed
        // TODO add your handling code here:
        this.dispose();
    }//GEN-LAST:event_exit1ActionPerformed

    private void Submit1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_Submit1ActionPerformed
        // TODO add your handling code here:
        cTable.setModel(SQuery.SearchStaff(id.getText()));
    }//GEN-LAST:event_Submit1ActionPerformed

    private void idActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_idActionPerformed
        // TODO add your handling code here:
        cTable.setModel(SQuery.SearchStaff(id.getText()));
    }//GEN-LAST:event_idActionPerformed

    private void idKeyPressed(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_idKeyPressed
        // TODO add your handling code here:
        cTable.setModel(SQuery.SearchStaff(id.getText()));

    }//GEN-LAST:event_idKeyPressed

    private void idKeyTyped(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_idKeyTyped
        // TODO add your handling code here:
        cTable.setModel(SQuery.SearchStaff(id.getText()));
    }//GEN-LAST:event_idKeyTyped

    private void idKeyReleased(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_idKeyReleased
        // TODO add your handling code here:
        cTable.setModel(SQuery.SearchStaff(id.getText()));
    }//GEN-LAST:event_idKeyReleased

    

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
            java.util.logging.Logger.getLogger(StaffSearchList.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(StaffSearchList.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(StaffSearchList.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(StaffSearchList.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>
        //</editor-fold>
        //</editor-fold>
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new StaffSearchList(conn, new String()).setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton Submit;
    private javax.swing.JButton Submit1;
    private javax.swing.JTable cTable;
    private javax.swing.JButton exit;
    private javax.swing.JButton exit1;
    private javax.swing.JTextField id;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JScrollPane jScrollPane2;
    private javax.swing.JLabel text;
    // End of variables declaration//GEN-END:variables
}
