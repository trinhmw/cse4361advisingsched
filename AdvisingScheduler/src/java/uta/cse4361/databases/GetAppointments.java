/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uta.cse4361.databases;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import uta.cse4361.businessobjects.Appointment;

/**
 *
 * @author Han
 */
public class GetAppointments extends RDBImplCommand {

    private int id;
    private String sqlQuery = "SELECT * FROM APPOINTMENT";

    public GetAppointments() {
        super();
    }

    @Override
    public void queryDB() throws SQLException {
        try {
            statement = conn.prepareStatement(sqlQuery);
            resultSet = statement.executeQuery();
        } catch (SQLException e) {
            System.out.println("failed");
            conn.close();
        } finally {
            if (statement != null) {
                statement.close();
            }
        }
    }

    @Override
    public void processResult() {
        result = new ArrayList<Appointment>();
        try {
            while (resultSet.next()) {
                Appointment appt = new Appointment();
                int id = resultSet.getInt("ApptID");
                Date date = resultSet.getDate("ApptDate");
                int sHour = resultSet.getInt("ApptStartHour");
                int sMinute = resultSet.getInt("ApptStartMin");
                int eHour = resultSet.getInt("ApptEndHour");
                int eMinute = resultSet.getInt("ApptEndMin");
                String type = resultSet.getString("ApptType");
                String description = resultSet.getString("Description");
                String sID = resultSet.getString("StudentID");
                String sName = resultSet.getString("StudentName");
                String aName = resultSet.getString("AdvisorName");
                appt.setApptID(id);
                if (appt.initialize(sName, sID, aName, type, description, date, sHour, eHour, sMinute, eMinute));
                    ((ArrayList<Appointment>) result).add(appt);
            }
        } catch (SQLException e) {
            System.out.println("failed");
        }
    }

}
