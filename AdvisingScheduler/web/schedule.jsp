<%-- 
    Document   : Appointment
    Created on : Sep 19, 2014, 12:43:15 PM
    Author     : Han
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<%@page import="uta.cse4361.businessobjects.FlyweightDatabaseManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <script src="//code.jquery.com/jquery-1.10.2.js"></script>
        <script src="//code.jquery.com/ui/1.11.1/jquery-ui.js"></script>

        <jsp:include page="header.jsp" />
        <%
            FlyweightDatabaseManager fdm = new FlyweightDatabaseManager();
            ArrayList<Date> availableDates = fdm.getDatesForAvailability();
            ArrayList<String> availables = new ArrayList<String>();
            for (Date d : availableDates) {
                int dd = d.getDate();
                int mm = d.getMonth()+1;
                int yy = d.getYear() + 1900;
                String newRecord = "" + dd + "-" + mm + "-" + yy;
                availables.add(newRecord);
            }
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < availables.size(); i++) {
                sb.append(availables.get(i) + ",");
            }
        %>
        
        <script type="text/javascript">
            temp = "<%=sb.toString()%>";
            var availableDates = new Array();
            availableDates = temp.split(',', '<%=availables.size()%>');

            //alert("array: " + availableDates);
            function available(date) {
                dmy = date.getDate() + "-" + (date.getMonth() + 1) + "-" + date.getFullYear();
                if ($.inArray(dmy, availableDates) !== -1) {
                    return [true, "", "Available"];
                } else {
                    return [false, "", "unAvailable"];
                }
            }
            $(function () {
                $('#date').datepicker({beforeShowDay: available});
            })
        </script>


        <script type="text/javascript">
            function validate() {
                var sID = document.forms["schedule"]["sID"].value;
                var sName = document.forms["schedule"]["sName"].value;
                var dp = document.forms["schedule"]["description"].value;
                if (sID === null || sID === "") {
                    alert("Please fill out student ID");
                    document.forms["schedule"]["sID"].focus();
                    return false;
                }
                if (isNaN(sID)) {
                    alert("Student ID must be number");
                    document.forms["schedule"]["sID"].focus();
                    return false;
                }
                if (sID.length !== 10) {
                    alert("Student ID must be a 10-digit number");
                    document.forms["schedule"]["sID"].focus();
                    return false;
                }
                if (sID.indexOf("1000") === -1 && sID.indexOf("6000") === -1) {
                    alert("Student ID should start with 1000 or 6000");
                    document.forms["schedule"]["sID"].focus();
                    return false;
                }
                if (sName === null || sName === "") {
                    alert("Please fill out student name");
                    document.forms["schedule"]["sName"].focus();
                    return false;
                }
                if (dp === null || dp === "") {
                    alert("Please fill out advising description");
                    document.forms["schedule"]["description"].focus();
                    return false;
                }
            }
        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Schedule Appointment</title>
    </head>
    <p id="demo"></p>
    <body>
        <div id="accordion">
            <h3>Schedule Appointment</h3>
            <div>

                <form name="schedule" action="StudentCalendar.jsp" onSubmit="return validate();">
                    <table>
                        <tr>
                            <td>
                                Student ID:
                            </td>
                            <td>
                                <input type="text" onkeypress="return event.charCode >= 48 && event.charCode <= 57" name="sID" id="sID" value=""><br>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Student Name:
                            </td>
                            <td>
                                <input type="text" name="sName" id="sName" value=""><br>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Advisor:
                            </td>
                            <td>
                                <select name="aName" id="aName">
                                    <option value="Linda Barasch">Linda Barasch</option>
                                    <option value="Bob Weems">Bob Weems</option>
                                </select><br>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Date:
                            </td>
                            <td>
                                <input type="text" name="date" id="date" readonly="true"><br>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Description: 
                            </td>
                            <td>
                                <textarea name="description" id="description" rows="6" cols="50" value=""></textarea><br>
                            </td>
                        <tr>
                    </table>
                    <input type="submit" value="Submit" id="submitBtn">
                    <input type="reset" value="Reset" id="resetBtn">
                </form>
            </div>
        </div>
        <br>
    </body>
    <jsp:include page="footer.jsp" />
    <script type="text/javascript" src="js/schedule.js"></script>    
</html>
