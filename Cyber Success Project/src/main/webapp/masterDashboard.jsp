<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.cyber.DAO.UserDAO"%>
<%@page import="com.cyber.model.TimetableEntry"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Master Dashboard - Cyber Success</title>
<link rel="stylesheet" href="Admin_css/master.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
	<div class="dashboard">
		<div class="sidebar">
			<div class="sidebar-header">
				<h2>
					<span class="blue">CYBER</span> <span class="green">SUCCESS</span>
				</h2>
				<i class="fas fa-arrow-left collapse-btn" id="collapse-btn"></i>
			</div>
			<nav class="sidebar-nav">
				<ul>
					<li><a href="#" class="active"><i
							class="fas fa-calendar-day icon-timetable"></i> <span>Today's
								TimeTable</span> </a></li>
					<li><a href="#"><i class="fas fa-users-cog icon-managers" style="font-size: 13px;"></i>
							<span>Manage Managers</span> </a></li>
					<li><a href="#"><i class="fas fa-layer-group icon-batches" style="font-size: 13px;"></i>
							<span>Manage Batches</span> </a></li>
					<li><a href="#"><i
							class="fas fa-user-check icon-attendance"></i> <span>See
								Attendance Batchwise</span> </a></li>
					<li><a href="#"><i
							class="fas fa-calendar-alt icon-timetables"></i> <span>
								Time Tables</span> </a></li>
					<li><a href="#"><i class="fas fa-user-tie icon-trainers"></i>
							<span>Manage Trainers</span> </a></li>
					<li><a href="#"><i
							class="fas fa-unlock-alt icon-forgot-manager-password"></i> <span>Forgot
								Manager Password</span> </a></li>
					<li><a href="#"><i
							class="fas fa-unlock-alt icon-forgot-trainer-password"></i> <span>Forgot
								Trainer Password</span> </a></li>
				</ul>
				<h4>Settings</h4>
				<ul>
					<li><a href="#"><i class="fas fa-user icon-profile"></i> <span>Profile</span>
					</a></li>
					<li><a href="#"><i class="fas fa-cogs icon-settings" style="font-size: 13px;"></i>
							<span>Settings</span> </a></li>
					<li><a href="#"><i class="fas fa-sign-out-alt icon-logout"></i>
							<span>Logout</span> </a></li>
				</ul>
			</nav>


		</div>
		<div class="main-content">
			<div class="header">
				<div class="search-bar">
					<input type="text"
						placeholder="Search batch code, Trainer name, Date-Day, Or anything..">
					<button class="search-btn">Search</button>
				</div>
			</div>
			
			<%
			List<TimetableEntry> entries2 = UserDAO.getTimetableEntriesByDate("2024-07-17");
			Map<String, List<TimetableEntry>> classroomMap = new HashMap<>();
			for (TimetableEntry entry : entries2) {
				String classroom = entry.getClassroom();
				if (!classroomMap.containsKey(classroom)) {
					classroomMap.put(classroom, new ArrayList<>());
				}
				classroomMap.get(classroom).add(entry);
			}
			%>

			<div class="date-day"
				style="width: 100%; display: flex; align-items: center; justify-content: center;">
				<%
				if (!entries2.isEmpty()) {
				%>
				<span class="actual" style="margin: 10px 10px;"><%=entries2.get(0).getDate()%></span>
				<span class="actual" style="font-weight: 600;"><%=entries2.get(0).getDay()%></span>
				<%
				}
				%>
			</div>
			
			<div class="timetable-showing"
				style="height: auto; width: 100%; background: white; box-shadow: rgba(0, 0, 0, 0.24) 0px 3px 8px; display: flex; justify-content: space-between;">
				<div class="s1" style="width: 16%; height: 100vh; border: 1px solid;">
					<div class="heading"
						style="height: 10vh; width: 100%; background: black; color:white; display: flex; justify-content: center; align-items: center;">Success
						1</div>
					<%
					List<TimetableEntry> success1Entries = classroomMap.get("Success 1");
					%>
					<%
					if (success1Entries != null) {
					%>
					<%
					for (TimetableEntry entry : success1Entries) {
					%>
					<%if(entry.getTeacher().equalsIgnoreCase("Harshad sir")){
					%>
					<div class="box"
						style="border: 1px solid; background: brown; color: white; padding: 10px; display: flex; flex-direction: column; align-items: center; justify-content: center;">
						<span><%=entry.getBatchCode()%></span> 
						<span><%=entry.getSubject()%></span>
						<span><%=entry.getTeacher()%></span> 
						<span><%=entry.getTimeFrom()%> TO <span><%=entry.getTimeTo()%></span></span>
						
					</div>
					<%} %>
					<%if(entry.getTeacher().equalsIgnoreCase("Rushi")){
					%>
					<div class="box"
						style="border: 1px solid; background: #f20ae3; color: black; padding: 10px; display: flex; flex-direction: column; align-items: center; justify-content: center;">
						<span><%=entry.getBatchCode()%></span> 
						<span><%=entry.getSubject()%></span>
						<span><%=entry.getTeacher()%></span> 
						<span><%=entry.getTimeFrom()%> TO <span><%=entry.getTimeTo()%></span></span>
						
					</div>
					<%} %>
					<%if(entry.getTeacher().equalsIgnoreCase("Nilesh Sir")){
					%>
					<div class="box"
						style="border: 1px solid; background: #cf0af2; color: black; padding: 10px; display: flex; flex-direction: column; align-items: center; justify-content: center;">
						<span><%=entry.getBatchCode()%></span> 
						<span><%=entry.getSubject()%></span>
						<span><%=entry.getTeacher()%></span> 
						<span><%=entry.getTimeFrom()%> TO <span><%=entry.getTimeTo()%></span></span>
						
					</div>
					<%} %>
					<%if(entry.getTeacher().equalsIgnoreCase("Zulfikar Sir")){
					%>
					<div class="box"
						style="border: 1px solid; background: gray; color: white; padding: 10px; display: flex; flex-direction: column; align-items: center; justify-content: center;">
						<span><%=entry.getBatchCode()%></span> 
						<span><%=entry.getSubject()%></span>
						<span><%=entry.getTeacher()%></span> 
						<span><%=entry.getTimeFrom()%> TO <span><%=entry.getTimeTo()%></span></span>
						
					</div>
					<%} %>
					<%if(entry.getTeacher().equalsIgnoreCase("Siddhart Sir")){
					%>
					<div class="box"
						style="border: 1px solid; background: orange; color: white; padding: 10px; display: flex; flex-direction: column; align-items: center; justify-content: center;">
						<span><%=entry.getBatchCode()%></span> 
						<span><%=entry.getSubject()%></span>
						<span><%=entry.getTeacher()%></span> 
						<span><%=entry.getTimeFrom()%> TO <span><%=entry.getTimeTo()%></span></span>
						
					</div>
					<%} %>
					<%if(entry.getTeacher().equalsIgnoreCase("Gaurav Sir")){
					%>
					<div class="box"
						style="border: 1px solid; background: blue; color: white; padding: 10px; display: flex; flex-direction: column; align-items: center; justify-content: center;">
						<span><%=entry.getBatchCode()%></span> 
						<span><%=entry.getSubject()%></span>
						<span><%=entry.getTeacher()%></span> 
						<span><%=entry.getTimeFrom()%> TO <span><%=entry.getTimeTo()%></span></span>
						
					</div>
					<%} %>
					<%if(entry.getTeacher().equalsIgnoreCase("Master")){
					%>
					<div class="box"
						style="border: 1px solid; background: #0af211; color: black; padding: 10px; display: flex; flex-direction: column; align-items: center; justify-content: center;">
						<span><%=entry.getBatchCode()%></span> 
						<span><%=entry.getSubject()%></span>
						<span><%=entry.getTeacher()%></span> 
						<span><%=entry.getTimeFrom()%> TO <span><%=entry.getTimeTo()%></span></span>
						
					</div>
					<%} %>
					<%
					}
					%>
					<%
					}
					%>
				</div>
				<div class="s2" style="width: 16%; height: 100vh; border: 1px solid;">
					<div class="heading"
						style="height: 10vh; width: 100%; background: black; color:white; display: flex; justify-content: center; align-items: center;">Success
						2</div>
					<%
					List<TimetableEntry> success2Entries = classroomMap.get("Success 2");
					%>
					<%
					if (success2Entries != null) {
					%>
					<%
					for (TimetableEntry entry : success2Entries) {
					%>
					<%if(entry.getTeacher().equalsIgnoreCase("Harshad sir")){
					%>
					<div class="box"
						style="border: 1px solid; background: brown; color: white; padding: 10px; display: flex; flex-direction: column; align-items: center; justify-content: center;">
						<span><%=entry.getBatchCode()%></span> 
						<span><%=entry.getSubject()%></span>
						<span><%=entry.getTeacher()%></span> 
						<span><%=entry.getTimeFrom()%> TO <span><%=entry.getTimeTo()%></span></span>
						
					</div>
					<%} %>
					<%if(entry.getTeacher().equalsIgnoreCase("Rushi")){
					%>
					<div class="box"
						style="border: 1px solid; background: #f20ae3; color: black; padding: 10px; display: flex; flex-direction: column; align-items: center; justify-content: center;">
						<span><%=entry.getBatchCode()%></span> 
						<span><%=entry.getSubject()%></span>
						<span><%=entry.getTeacher()%></span> 
						<span><%=entry.getTimeFrom()%> TO <span><%=entry.getTimeTo()%></span></span>
						
					</div>
					<%} %>
					<%if(entry.getTeacher().equalsIgnoreCase("Nilesh Sir")){
					%>
					<div class="box"
						style="border: 1px solid; background: #cf0af2; color: black; padding: 10px; display: flex; flex-direction: column; align-items: center; justify-content: center;">
						<span><%=entry.getBatchCode()%></span> 
						<span><%=entry.getSubject()%></span>
						<span><%=entry.getTeacher()%></span> 
						<span><%=entry.getTimeFrom()%> TO <span><%=entry.getTimeTo()%></span></span>
						
					</div>
					<%} %>
					<%if(entry.getTeacher().equalsIgnoreCase("Zulfikar Sir")){
					%>
					<div class="box"
						style="border: 1px solid; background: gray; color: white; padding: 10px; display: flex; flex-direction: column; align-items: center; justify-content: center;">
						<span><%=entry.getBatchCode()%></span> 
						<span><%=entry.getSubject()%></span>
						<span><%=entry.getTeacher()%></span> 
						<span><%=entry.getTimeFrom()%> TO <span><%=entry.getTimeTo()%></span></span>
						
					</div>
					<%} %>
					<%if(entry.getTeacher().equalsIgnoreCase("Siddhart Sir")){
					%>
					<div class="box"
						style="border: 1px solid; background: orange; color: white; padding: 10px; display: flex; flex-direction: column; align-items: center; justify-content: center;">
						<span><%=entry.getBatchCode()%></span> 
						<span><%=entry.getSubject()%></span>
						<span><%=entry.getTeacher()%></span> 
						<span><%=entry.getTimeFrom()%> TO <span><%=entry.getTimeTo()%></span></span>
						
					</div>
					<%} %>
					<%if(entry.getTeacher().equalsIgnoreCase("Gaurav Sir")){
					%>
					<div class="box"
						style="border: 1px solid; background: blue; color: white; padding: 10px; display: flex; flex-direction: column; align-items: center; justify-content: center;">
						<span><%=entry.getBatchCode()%></span> 
						<span><%=entry.getSubject()%></span>
						<span><%=entry.getTeacher()%></span> 
						<span><%=entry.getTimeFrom()%> TO <span><%=entry.getTimeTo()%></span></span>
						
					</div>
					<%} %>
					<%if(entry.getTeacher().equalsIgnoreCase("Master")){
					%>
					<div class="box"
						style="border: 1px solid; background: #0af211; color: black; padding: 10px; display: flex; flex-direction: column; align-items: center; justify-content: center;">
						<span><%=entry.getBatchCode()%></span> 
						<span><%=entry.getSubject()%></span>
						<span><%=entry.getTeacher()%></span> 
						<span><%=entry.getTimeFrom()%> TO <span><%=entry.getTimeTo()%></span></span>
						
					</div>
					<%} %>
					<%
					}
					%>
					<%
					}
					%>
				</div>
				
				<div class="s3" style="width: 16%; height: 100vh; border: 1px solid;">
					<div class="heading"
						style="height: 10vh; width: 100%; background: black; color:white; display: flex; justify-content: center; align-items: center;">Success
						3</div>
					<%
					List<TimetableEntry> success3Entries = classroomMap.get("Success 3");
					%>
					<%
					if (success3Entries != null) {
					%>
					<%
					for (TimetableEntry entry : success3Entries) {
					%>
					<%if(entry.getTeacher().equalsIgnoreCase("Harshad sir")){
					%>
					<div class="box"
						style="border: 1px solid; background: brown; color: white; padding: 10px; display: flex; flex-direction: column; align-items: center; justify-content: center;">
						<span><%=entry.getBatchCode()%></span> 
						<span><%=entry.getSubject()%></span>
						<span><%=entry.getTeacher()%></span> 
						<span><%=entry.getTimeFrom()%> TO <span><%=entry.getTimeTo()%></span></span>
						
					</div>
					<%} %>
					<%if(entry.getTeacher().equalsIgnoreCase("Rushi")){
					%>
					<div class="box"
						style="border: 1px solid; background: #f20ae3; color: black; padding: 10px; display: flex; flex-direction: column; align-items: center; justify-content: center;">
						<span><%=entry.getBatchCode()%></span> 
						<span><%=entry.getSubject()%></span>
						<span><%=entry.getTeacher()%></span> 
						<span><%=entry.getTimeFrom()%> TO <span><%=entry.getTimeTo()%></span></span>
						
					</div>
					<%} %>
					<%if(entry.getTeacher().equalsIgnoreCase("Nilesh Sir")){
					%>
					<div class="box"
						style="border: 1px solid; background: #cf0af2; color: black; padding: 10px; display: flex; flex-direction: column; align-items: center; justify-content: center;">
						<span><%=entry.getBatchCode()%></span> 
						<span><%=entry.getSubject()%></span>
						<span><%=entry.getTeacher()%></span> 
						<span><%=entry.getTimeFrom()%> TO <span><%=entry.getTimeTo()%></span></span>
						
					</div>
					<%} %>
					<%if(entry.getTeacher().equalsIgnoreCase("Zulfikar Sir")){
					%>
					<div class="box"
						style="border: 1px solid; background: gray; color: white; padding: 10px; display: flex; flex-direction: column; align-items: center; justify-content: center;">
						<span><%=entry.getBatchCode()%></span> 
						<span><%=entry.getSubject()%></span>
						<span><%=entry.getTeacher()%></span> 
						<span><%=entry.getTimeFrom()%> TO <span><%=entry.getTimeTo()%></span></span>
						
					</div>
					<%} %>
					<%if(entry.getTeacher().equalsIgnoreCase("Siddhart Sir")){
					%>
					<div class="box"
						style="border: 1px solid; background: orange; color: white; padding: 10px; display: flex; flex-direction: column; align-items: center; justify-content: center;">
						<span><%=entry.getBatchCode()%></span> 
						<span><%=entry.getSubject()%></span>
						<span><%=entry.getTeacher()%></span> 
						<span><%=entry.getTimeFrom()%> TO <span><%=entry.getTimeTo()%></span></span>
						
					</div>
					<%} %>
					<%if(entry.getTeacher().equalsIgnoreCase("Gaurav Sir")){
					%>
					<div class="box"
						style="border: 1px solid; background: blue; color: white; padding: 10px; display: flex; flex-direction: column; align-items: center; justify-content: center;">
						<span><%=entry.getBatchCode()%></span> 
						<span><%=entry.getSubject()%></span>
						<span><%=entry.getTeacher()%></span> 
						<span><%=entry.getTimeFrom()%> TO <span><%=entry.getTimeTo()%></span></span>
						
					</div>
					<%} %>
					<%if(entry.getTeacher().equalsIgnoreCase("Master")){
					%>
					<div class="box"
						style="border: 1px solid; background: #0af211; color: black; padding: 10px; display: flex; flex-direction: column; align-items: center; justify-content: center;">
						<span><%=entry.getBatchCode()%></span> 
						<span><%=entry.getSubject()%></span>
						<span><%=entry.getTeacher()%></span> 
						<span><%=entry.getTimeFrom()%> TO <span><%=entry.getTimeTo()%></span></span>
						
					</div>
					<%} %>
					<%
					}
					%>
					<%
					}
					%>
				</div>
				<div class="s4" style="width: 16%; height: 100vh; border: 1px solid;">
					<div class="heading"
						style="height: 10vh; width: 100%; background: black; color:white; display: flex; justify-content: center; align-items: center;">Success
						4</div>
					<%
					List<TimetableEntry> success4Entries = classroomMap.get("Success 4");
					%>
					<%
					if (success4Entries != null) {
					%>
					<%
					for (TimetableEntry entry : success4Entries) {
					%>
					<%if(entry.getTeacher().equalsIgnoreCase("Harshad sir")){
					%>
					<div class="box"
						style="border: 1px solid; background: brown; color: white; padding: 10px; display: flex; flex-direction: column; align-items: center; justify-content: center;">
						<span><%=entry.getBatchCode()%></span> 
						<span><%=entry.getSubject()%></span>
						<span><%=entry.getTeacher()%></span> 
						<span><%=entry.getTimeFrom()%> TO <span><%=entry.getTimeTo()%></span></span>
						
					</div>
					<%} %>
					<%if(entry.getTeacher().equalsIgnoreCase("Rushi")){
					%>
					<div class="box"
						style="border: 1px solid; background: #f20ae3; color: black; padding: 10px; display: flex; flex-direction: column; align-items: center; justify-content: center;">
						<span><%=entry.getBatchCode()%></span> 
						<span><%=entry.getSubject()%></span>
						<span><%=entry.getTeacher()%></span> 
						<span><%=entry.getTimeFrom()%> TO <span><%=entry.getTimeTo()%></span></span>
						
					</div>
					<%} %>
					<%if(entry.getTeacher().equalsIgnoreCase("Nilesh Sir")){
					%>
					<div class="box"
						style="border: 1px solid; background: #cf0af2; color: black; padding: 10px; display: flex; flex-direction: column; align-items: center; justify-content: center;">
						<span><%=entry.getBatchCode()%></span> 
						<span><%=entry.getSubject()%></span>
						<span><%=entry.getTeacher()%></span> 
						<span><%=entry.getTimeFrom()%> TO <span><%=entry.getTimeTo()%></span></span>
						
					</div>
					<%} %>
					<%if(entry.getTeacher().equalsIgnoreCase("Zulfikar Sir")){
					%>
					<div class="box"
						style="border: 1px solid; background: gray; color: white; padding: 10px; display: flex; flex-direction: column; align-items: center; justify-content: center;">
						<span><%=entry.getBatchCode()%></span> 
						<span><%=entry.getSubject()%></span>
						<span><%=entry.getTeacher()%></span> 
						<span><%=entry.getTimeFrom()%> TO <span><%=entry.getTimeTo()%></span></span>
						
					</div>
					<%} %>
					<%if(entry.getTeacher().equalsIgnoreCase("Siddhart Sir")){
					%>
					<div class="box"
						style="border: 1px solid; background: orange; color: white; padding: 10px; display: flex; flex-direction: column; align-items: center; justify-content: center;">
						<span><%=entry.getBatchCode()%></span> 
						<span><%=entry.getSubject()%></span>
						<span><%=entry.getTeacher()%></span> 
						<span><%=entry.getTimeFrom()%> TO <span><%=entry.getTimeTo()%></span></span>
						
					</div>
					<%} %>
					<%if(entry.getTeacher().equalsIgnoreCase("Gaurav Sir")){
					%>
					<div class="box"
						style="border: 1px solid; background: blue; color: white; padding: 10px; display: flex; flex-direction: column; align-items: center; justify-content: center;">
						<span><%=entry.getBatchCode()%></span> 
						<span><%=entry.getSubject()%></span>
						<span><%=entry.getTeacher()%></span> 
						<span><%=entry.getTimeFrom()%> TO <span><%=entry.getTimeTo()%></span></span>
						
					</div>
					<%} %>
					<%if(entry.getTeacher().equalsIgnoreCase("Master")){
					%>
					<div class="box"
						style="border: 1px solid; background: #0af211; color: black; padding: 10px; display: flex; flex-direction: column; align-items: center; justify-content: center;">
						<span><%=entry.getBatchCode()%></span> 
						<span><%=entry.getSubject()%></span>
						<span><%=entry.getTeacher()%></span> 
						<span><%=entry.getTimeFrom()%> TO <span><%=entry.getTimeTo()%></span></span>
						
					</div>
					<%} %>
					<%
					}
					%>
					<%
					}
					%>
				</div>
				<div class="s5" style="width: 16%; height: 100vh; border: 1px solid;">
					<div class="heading"
						style="height: 10vh; width: 100%; background: black; color:white; display: flex; justify-content: center; align-items: center;">Success
						5</div>
					<%
					List<TimetableEntry> success5Entries = classroomMap.get("Success 5");
					%>
					<%
					if (success5Entries != null) {
					%>
					<%
					for (TimetableEntry entry : success5Entries) {
					%>
					<%if(entry.getTeacher().equalsIgnoreCase("Harshad sir")){
					%>
					<div class="box"
						style="border: 1px solid; background: brown; color: white; padding: 10px; display: flex; flex-direction: column; align-items: center; justify-content: center;">
						<span><%=entry.getBatchCode()%></span> 
						<span><%=entry.getSubject()%></span>
						<span><%=entry.getTeacher()%></span> 
						<span><%=entry.getTimeFrom()%> TO <span><%=entry.getTimeTo()%></span></span>
						
					</div>
					<%} %>
					<%if(entry.getTeacher().equalsIgnoreCase("Rushi")){
					%>
					<div class="box"
						style="border: 1px solid; background: #f20ae3; color: black; padding: 10px; display: flex; flex-direction: column; align-items: center; justify-content: center;">
						<span><%=entry.getBatchCode()%></span> 
						<span><%=entry.getSubject()%></span>
						<span><%=entry.getTeacher()%></span> 
						<span><%=entry.getTimeFrom()%> TO <span><%=entry.getTimeTo()%></span></span>
						
					</div>
					<%} %>
					<%if(entry.getTeacher().equalsIgnoreCase("Nilesh Sir")){
					%>
					<div class="box"
						style="border: 1px solid; background: #cf0af2; color: black; padding: 10px; display: flex; flex-direction: column; align-items: center; justify-content: center;">
						<span><%=entry.getBatchCode()%></span> 
						<span><%=entry.getSubject()%></span>
						<span><%=entry.getTeacher()%></span> 
						<span><%=entry.getTimeFrom()%> TO <span><%=entry.getTimeTo()%></span></span>
						
					</div>
					<%} %>
					<%if(entry.getTeacher().equalsIgnoreCase("Zulfikar Sir")){
					%>
					<div class="box"
						style="border: 1px solid; background: gray; color: white; padding: 10px; display: flex; flex-direction: column; align-items: center; justify-content: center;">
						<span><%=entry.getBatchCode()%></span> 
						<span><%=entry.getSubject()%></span>
						<span><%=entry.getTeacher()%></span> 
						<span><%=entry.getTimeFrom()%> TO <span><%=entry.getTimeTo()%></span></span>
						
					</div>
					<%} %>
					<%if(entry.getTeacher().equalsIgnoreCase("Siddhart Sir")){
					%>
					<div class="box"
						style="border: 1px solid; background: orange; color: white; padding: 10px; display: flex; flex-direction: column; align-items: center; justify-content: center;">
						<span><%=entry.getBatchCode()%></span> 
						<span><%=entry.getSubject()%></span>
						<span><%=entry.getTeacher()%></span> 
						<span><%=entry.getTimeFrom()%> TO <span><%=entry.getTimeTo()%></span></span>
						
					</div>
					<%} %>
					<%if(entry.getTeacher().equalsIgnoreCase("Gaurav Sir")){
					%>
					<div class="box"
						style="border: 1px solid; background: blue; color: white; padding: 10px; display: flex; flex-direction: column; align-items: center; justify-content: center;">
						<span><%=entry.getBatchCode()%></span> 
						<span><%=entry.getSubject()%></span>
						<span><%=entry.getTeacher()%></span> 
						<span><%=entry.getTimeFrom()%> TO <span><%=entry.getTimeTo()%></span></span>
						
					</div>
					<%} %>
					<%if(entry.getTeacher().equalsIgnoreCase("Master")){
					%>
					<div class="box"
						style="border: 1px solid; background: #0af211; color: black; padding: 10px; display: flex; flex-direction: column; align-items: center; justify-content: center;">
						<span><%=entry.getBatchCode()%></span> 
						<span><%=entry.getSubject()%></span>
						<span><%=entry.getTeacher()%></span> 
						<span><%=entry.getTimeFrom()%> TO <span><%=entry.getTimeTo()%></span></span>
						
					</div>
					<%} %>
					<%
					}
					%>
					<%
					}
					%>
				</div>
				<div class="s6" style="width: 16%; height: 100vh; border: 1px solid;">
					<div class="heading"
						style="height: 10vh; width: 100%; background: black; color:white; display: flex; justify-content: center; align-items: center;">Success
						6</div>
					<%
					List<TimetableEntry> success6Entries = classroomMap.get("Success 6");
					%>
					<%
					if (success6Entries != null) {
					%>
					<%
					for (TimetableEntry entry : success6Entries) {
					%>
					<%if(entry.getTeacher().equalsIgnoreCase("Harshad sir")){
					%>
					<div class="box"
						style="border: 1px solid; background: brown; color: white; padding: 10px; display: flex; flex-direction: column; align-items: center; justify-content: center;">
						<span><%=entry.getBatchCode()%></span> 
						<span><%=entry.getSubject()%></span>
						<span><%=entry.getTeacher()%></span> 
						<span><%=entry.getTimeFrom()%> TO <span><%=entry.getTimeTo()%></span></span>
						
					</div>
					<%} %>
					<%if(entry.getTeacher().equalsIgnoreCase("Rushi")){
					%>
					<div class="box"
						style="border: 1px solid; background: #f20ae3; color: black; padding: 10px; display: flex; flex-direction: column; align-items: center; justify-content: center;">
						<span><%=entry.getBatchCode()%></span> 
						<span><%=entry.getSubject()%></span>
						<span><%=entry.getTeacher()%></span> 
						<span><%=entry.getTimeFrom()%> TO <span><%=entry.getTimeTo()%></span></span>
						
					</div>
					<%} %>
					<%if(entry.getTeacher().equalsIgnoreCase("Nilesh Sir")){
					%>
					<div class="box"
						style="border: 1px solid; background: #cf0af2; color: black; padding: 10px; display: flex; flex-direction: column; align-items: center; justify-content: center;">
						<span><%=entry.getBatchCode()%></span> 
						<span><%=entry.getSubject()%></span>
						<span><%=entry.getTeacher()%></span> 
						<span><%=entry.getTimeFrom()%> TO <span><%=entry.getTimeTo()%></span></span>
						
					</div>
					<%} %>
					<%if(entry.getTeacher().equalsIgnoreCase("Zulfikar Sir")){
					%>
					<div class="box"
						style="border: 1px solid; background: gray; color: white; padding: 10px; display: flex; flex-direction: column; align-items: center; justify-content: center;">
						<span><%=entry.getBatchCode()%></span> 
						<span><%=entry.getSubject()%></span>
						<span><%=entry.getTeacher()%></span> 
						<span><%=entry.getTimeFrom()%> TO <span><%=entry.getTimeTo()%></span></span>
						
					</div>
					<%} %>
					<%if(entry.getTeacher().equalsIgnoreCase("Siddhart Sir")){
					%>
					<div class="box"
						style="border: 1px solid; background: orange; color: white; padding: 10px; display: flex; flex-direction: column; align-items: center; justify-content: center;">
						<span><%=entry.getBatchCode()%></span> 
						<span><%=entry.getSubject()%></span>
						<span><%=entry.getTeacher()%></span> 
						<span><%=entry.getTimeFrom()%> TO <span><%=entry.getTimeTo()%></span></span>
						
					</div>
					<%} %>
					<%if(entry.getTeacher().equalsIgnoreCase("Gaurav Sir")){
					%>
					<div class="box"
						style="border: 1px solid; background: blue; color: white; padding: 10px; display: flex; flex-direction: column; align-items: center; justify-content: center;">
						<span><%=entry.getBatchCode()%></span> 
						<span><%=entry.getSubject()%></span>
						<span><%=entry.getTeacher()%></span> 
						<span><%=entry.getTimeFrom()%> TO <span><%=entry.getTimeTo()%></span></span>
						
					</div>
					<%} %>
					<%if(entry.getTeacher().equalsIgnoreCase("Master")){
					%>
					<div class="box"
						style="border: 1px solid; background: #0af211; color: black; padding: 10px; display: flex; flex-direction: column; align-items: center; justify-content: center;">
						<span><%=entry.getBatchCode()%></span> 
						<span><%=entry.getSubject()%></span>
						<span><%=entry.getTeacher()%></span> 
						<span><%=entry.getTimeFrom()%> TO <span><%=entry.getTimeTo()%></span></span>
						
					</div>
					<%} %>
					<%
					}
					%>
					<%
					}
					%>
				</div>
			</div>
			
			
			
		</div>
	</div>
	<script type="text/javascript">
		document.addEventListener('DOMContentLoaded', function() {
			const collapseBtn = document.getElementById('collapse-btn');
			const sidebar = document.querySelector('.sidebar');
			collapseBtn.addEventListener('click', function() {
				sidebar.classList.toggle('collapsed');
				if (sidebar.classList.contains('collapsed')) {
					collapseBtn.classList.replace('fa-arrow-left',
							'fa-arrow-right');
				} else {
					collapseBtn.classList.replace('fa-arrow-right',
							'fa-arrow-left');
				}
			});
		});
	</script>
</body>
</html>