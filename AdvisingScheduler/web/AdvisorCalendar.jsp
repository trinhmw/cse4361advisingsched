<%-- 
    Document   : Calendar
    Created on : Sep 12, 2014, 9:59:13 PM
    Author     : Melissa
--%>

<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <title>Advisor Calendar</title>
        <link rel='stylesheet' href='css/fullcalendar.css' />
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
   </head>
        <jsp:include page="header.jsp" />
        <jsp:useBean id="fdm" class="uta.cse4361.databases.SlotDatabaseManager" scope="session"/>
        <%
            
            int fwsize = 0;
            fdm = new uta.cse4361.databases.SlotDatabaseManager(); 
            Date currDate = new Date();
            java.util.ArrayList<uta.cse4361.businessobjects.Slot> fw = fdm.getYearFlyweights(currDate);  
            
            StringBuilder sbDay = new StringBuilder();
                                StringBuilder sbHour = new StringBuilder();
                                StringBuilder sbMin = new StringBuilder();
                                StringBuilder sbMonth = new StringBuilder(); 
                                StringBuilder sbYear = new StringBuilder();    
                                StringBuilder sbAppt = new StringBuilder();
                                    if(fw.isEmpty())
                                    {
                                        fwsize = 0;
                                    }
                                    else
                                    {
                                        fwsize = fw.size();                                
                                    
                                        for(int i=0;i<fwsize;i++) 
                                            sbAppt.append(fw.get(i).isAppointment()+",");   
                                        
                                        for(int i=0;i<fwsize;i++) 
                                            sbDay.append(fw.get(i).getDate().getDate()+",");

                                        for(int i=0;i<fwsize;i++) 
                                            sbHour.append(fw.get(i).getTime()/60+",");

                                        for(int i=0;i<fwsize;i++) 
                                            sbMin.append(fw.get(i).getTime()%60+",");

                                        for(int i=0;i<fwsize;i++) 
                                            sbMonth.append(fw.get(i).getDate().getMonth()+",");

                                        for(int i=0;i<fwsize;i++) 
                                            sbYear.append((fw.get(i).getDate().getYear()+1900)+",");     
                                        }
            %>
            <script type="text/javascript">
                var size = '<%=fwsize%>';
//                alert("p1: " + size);
            </script>
            
            <script type="text/javascript">  
                                    //Parse String Slots to array
                                    var size = '<%=fwsize%>';
                                    if(size==0)
                                    {
                                        
                                    }
                                    else
                                    {
                                        
                                    var temp="<%=sbAppt.toString()%>";                               
                                    var isAppt = new Array(); 
                                    window.isAppt = temp.split(',',size);    
                                        
                                    var temp="<%=sbDay.toString()%>";                               
                                    var day = new Array(); 
                                    window.day = temp.split(',',size);

                                    var temp="<%=sbHour.toString()%>";
                                    var hour = new Array();
                                    window.hour = temp.split(',',size);

                                    var temp="<%=sbMin.toString()%>";
                                    var min = new Array();
                                    window.min = temp.split(',',size);

                                    var temp="<%=sbMonth.toString()%>";
                                    var month = new Array();
                                    window.month = temp.split(',',size);

                                    var temp="<%=sbYear.toString()%>";
                                    var year = new Array();
                                    window.year = temp.split(',',size);
//                                    alert("p2:" + size);
                                }
                                   
				</script>
            
            
    <body>           
        <table id="table">
            <tr>
                <%--<jsp:include page="sidebar.jsp" />--%>
                <td style="vertical-align: top">
                    <div style="width:325px" id="navigationAccordion">
                        <h3>Navigation</h3>
                        <div>
                            <a href="schedule.jsp">Schedule Appointment</a><br>
                            <a href="AdvisorCalendar.jsp">Advisor Calendar</a><br>                    
                        </div>   
                    </div>
                     <div style="width:325px" id="allocateAccordion">
                        <!--Andrews code-->
                         <%!
                            public int getHour(String time){
                                int hour = Integer.parseInt(time.substring(0,2));
                                if("PM".equalsIgnoreCase(time.substring(time.length() - 2))){
                                    if(hour!=12){hour += 12;};
                                };
                                return hour;
                            }
                            public int getMin(String time){
                                return Integer.parseInt(time.substring(3,5));
                            }
                            %>
                            <% boolean dateSubmitted = !(request.getParameter("date")==null || request.getParameter("date")=="");
                                boolean startSubmitted =  !(request.getParameter("startTime")==null || request.getParameter("startTime")=="");
                                boolean endSubmitted = !(request.getParameter("endTime")==null || request.getParameter("endTime")=="");
                                boolean formSubmitted = dateSubmitted || startSubmitted || endSubmitted;
                                boolean validFormSubmitted = dateSubmitted && startSubmitted && endSubmitted;%>
                        
                        <h3>Allocate Time</h3>
                        <div>
                            <form action="AdvisorCalendar.jsp" method="post">
                                <table>
                                    <tr>
                                        <td>Date:</td>
                                        <td>
                                            <input type="text" id="datepicker" name="date"<% if (dateSubmitted){out.println(" value=\""+request.getParameter("date")+"\"");}%> readonly></p>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Start Time:</td>
                                        <td>
                                            <input type="datetime" id = "starttimepicker" name="startTime"<% if (startSubmitted){out.println(" value=\""+request.getParameter("startTime")+"\"");}%>></p>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>End Time:</td>
                                        <td>
                                            <input type="datetime" id ="endtimepicker" name="endTime"<% if (endSubmitted){out.println(" value=\""+request.getParameter("endTime")+"\"");}%>></p>
                                        </td>
                                    </tr>
                                </table>
                            <input id="button" type="submit" value="Submit">
                            </form>
                            <% if (validFormSubmitted){
                                   java.text.DateFormat format = new java.text.SimpleDateFormat("MM/dd/yyyy");
                                   format.setLenient(false);
                                   java.util.Date newDate = format.parse(request.getParameter("date"));
                                %>
                                 <jsp:useBean id="allocateTimeBean" class="uta.cse4361.beans.TimeAllocationBean" scope="session"/>
                                 <jsp:setProperty name="allocateTimeBean" property="date" value= '<%= newDate %>'/>
                                 <jsp:setProperty name="allocateTimeBean" property="startHour" value= '<%= getHour(request.getParameter("startTime")) %>'/>
                                 <jsp:setProperty name="allocateTimeBean" property="startMinute" value= '<%= getMin(request.getParameter("startTime")) %>'/>
                                 <jsp:setProperty name="allocateTimeBean" property="endHour" value= '<%= getHour(request.getParameter("endTime")) %>'/>
                                 <jsp:setProperty name="allocateTimeBean" property="endMinute" value= '<%= getMin(request.getParameter("endTime")) %>'/>
                                <%
                                //allocateTimeBean.allocateTime();
                                allocateTimeBean.allocateTimeRepeat();
                                
                                //new fdm to get a fresh copy of the flyweights
                                fdm = new uta.cse4361.databases.SlotDatabaseManager(); 
                                fw = fdm.getYearFlyweights(currDate);  

                                 sbDay = new StringBuilder();
                                 sbHour = new StringBuilder();
                                 sbMin = new StringBuilder();
                                 sbMonth = new StringBuilder(); 
                                 sbYear = new StringBuilder(); 
                                 sbAppt = new StringBuilder();
                                 
                                    if(fw.isEmpty())
                                    {
                                        fwsize = 0;
                                    }
                                    else
                                    {
                                        fwsize = fw.size();                                
                                    
                                        for(int i=0;i<fwsize;i++) 
                                            sbAppt.append(fw.get(i).isAppointment()+",");  
                                            
                                        for(int i=0;i<fwsize;i++) 
                                            sbDay.append(fw.get(i).getDate().getDate()+",");

                                        for(int i=0;i<fwsize;i++) 
                                            sbHour.append(fw.get(i).getTime()/60+",");

                                        for(int i=0;i<fwsize;i++) 
                                            sbMin.append(fw.get(i).getTime()%60+",");

                                        for(int i=0;i<fwsize;i++) 
                                            sbMonth.append(fw.get(i).getDate().getMonth()+",");

                                        for(int i=0;i<fwsize;i++) 
                                            sbYear.append((fw.get(i).getDate().getYear()+1900)+",");     
                                        }
                                
                                %>
                                
                                    <script type="text/javascript">
                                    var size = '<%=fwsize%>';
                   
                                    if(size==0){}
                                    else
                                    {
                                    var temp="<%=sbAppt.toString()%>";                               
                                    var isAppt = new Array(); 
                                    window.isAppt = temp.split(',',size);    
                                        
                                    var temp="<%=sbDay.toString()%>";                               
                                    var day = new Array(); 
                                    window.day = temp.split(',',size);

                                    var temp="<%=sbHour.toString()%>";
                                    var hour = new Array();
                                    window.hour = temp.split(',',size);

                                    var temp="<%=sbMin.toString()%>";
                                    var min = new Array();
                                    window.min = temp.split(',',size);

                                    var temp="<%=sbMonth.toString()%>";
                                    var month = new Array();
                                    window.month = temp.split(',',size);

                                    var temp="<%=sbYear.toString()%>";
                                    var year = new Array();
                                    window.year = temp.split(',',size);
                                }
                                            </script>
                                  
                                <%    
                                }                           
                                else if(formSubmitted){
                                    if(!dateSubmitted){
                                        out.println("Please select a date.\n");
                                    }
                                    if (!startSubmitted){
                                        out.println("Please select a start time.\n");
                                    }
                                    if (!endSubmitted){
                                        out.println("Please select an end time.\n");
                                    }
                                }%>
       
                        
                    </div> 
                     </div>
                </td>
                
                <td style="vertical-align: top; float: right;">
                    <div style="width:765px" id="timeaccordion">
                        <h3>Calendar</h3>
                        <div id="calendar"></div>                        
                    </div> <!--timeaccordion end-->
                </td>       
            </tr>           
        </table>

    </body>

     
        <script type="text/javascript">
            document.getElementById('starttimepicker').onkeydown = function(e){
                e.preventDefault();
            }
             document.getElementById('endtimepicker').onkeydown = function(e){
                e.preventDefault();
            }
        </script>
        <jsp:include page="footer.jsp" />
        <script type="text/javascript" src="js/fullcalendar/moment.min.js"></script>
        <script type="text/javascript" src="js/fullcalendar/fullcalendar.js"></script>
        <script type="text/javascript" src="js/AdvisorCalendar.js"></script>
</html>
