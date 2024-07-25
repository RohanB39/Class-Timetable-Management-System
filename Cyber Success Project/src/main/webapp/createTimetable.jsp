<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.sql.Time"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.cyber.DAO.UserDAO"%>
<%@page import="com.cyber.model.TimetableEntry"%>
<%@page import="java.util.List"%>
<%@ page import="java.util.*, java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Manager Dashboard - Cyber Success</title>
<link rel="stylesheet" href="css/createTT.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<style>
/* Form styling */
.form-container {
	background: #fff;
	padding: 20px;
	margin-top: 20px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	border-radius: 8px;
}

.form-container h3 {
	font-size: 24px;
	margin-bottom: 20px;
	color: #333;
}

.date-day {
	display: flex;
	width: 100%;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 10px;
}

.form-groupD {
	width: 25%;
}

.form-groupD label {
	display: block;
	font-weight: 500;
	margin-bottom: 8px;
	color: #333;
}

.form-groupD input, .form-groupD select {
	width: 80%;
	padding: 10px;
	font-size: 16px;
	border: 1px solid #ccc;
	border-radius: 5px;
	transition: border-color 0.3s;
}

.form-groupD input:focus, .form-groupD select:focus {
	border-color: #04c4de;
	outline: none;
}

.batch-class {
	display: flex;
}

.form-groupB {
	width: 100%;
	margin-bottom: 10px;
}

.form-groupB label {
	display: block;
	font-weight: 500;
	margin-bottom: 8px;
	color: #333;
}

.form-groupB input {
	width: 90%;
	padding: 10px;
	font-size: 16px;
	border: 1px solid #ccc;
	border-radius: 5px;
	transition: border-color 0.3s;
}

.form-groupB select {
	width: 95%;
	padding: 10px;
	font-size: 16px;
	border: 1px solid #ccc;
	border-radius: 5px;
	transition: border-color 0.3s;
}

.form-groupB input:focus, .form-groupB select:focus {
	border-color: #04c4de;
	outline: none;
}

.teacher-entry {
	display: flex;
	width: 100%;
}

.form-group {
	width: 100%;
}

.form-group select {
	width: 90%;
	padding: 10px;
	font-size: 16px;
	border: 1px solid #ccc;
	border-radius: 5px;
	transition: border-color 0.3s;
}

.form-group select:focus {
	border-color: #04c4de;
	outline: none;
}

.form-group button {
	background-color: #04c4de;
	color: #fff;
	padding: 10px 20px;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	font-size: 16px;
	transition: background-color 0.3s;
	width: 60%;
}

.form-group button:hover {
	background-color: #0398a0;
}

.form-container2 {
	display: none;
	position: fixed;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	background: white;
	border: 1px solid #ccc;
	padding: 20px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	z-index: 1000;
}

.form-overlay2 {
	display: none;
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.5);
	z-index: 999;
}

.form-container2 input {
	margin-bottom: 10px;
	width: 100%;
	padding: 8px;
	border: 1px solid #ccc;
}

.form-container2 button {
	padding: 10px 20px;
	background: #007bff;
	border: none;
	color: white;
	cursor: pointer;
}

.form-container2 button.close-btn {
	background: red;
}

/* Overlay */
.overlay {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.5);
	display: none;
	z-index: 999;
	transition: opacity 0.3s ease;
	backdrop-filter: blur(5px); /* Apply blur effect */
	-webkit-backdrop-filter: blur(5px); /* For Safari */
}

/* Popup Form */
.popup-form {
	position: fixed;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	width: 450px; /* Fixed width */
	height: 260px; /* Fixed height to make it square */
	background: white;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
	display: none;
	z-index: 1000;
	transition: opacity 0.3s ease, transform 0.3s ease;
	overflow: auto; /* Add scroll if content overflows */
}

/* Show Popup */
.popup-form.show {
	display: block;
	opacity: 1;
	transform: translate(-50%, -50%) scale(1);
}

/* Hide Popup */
.popup-form.hide {
	opacity: 0;
	transform: translate(-50%, -50%) scale(0.9);
}

/* Form Elements */
form {
	display: flex;
	flex-direction: column;
	height: 100%;
}

label {
	margin: 10px 0 5px;
	font-weight: bold;
}

input[type="text"], input[type="time"], select {
	padding: 10px;
	border: 1px solid #ddd;
	border-radius: 5px;
	margin-bottom: 10px;
	font-size: 16px;
	box-sizing: border-box;
	/* Ensure padding and border are included in the element's total width and height */
}

input[type="text"]:focus, input[type="time"]:focus, select:focus {
	border-color: #007bff;
	outline: none;
}

/* Buttons */
button {
	background-color: #007bff;
	color: white;
	border: none;
	padding: 10px 20px;
	border-radius: 5px;
	cursor: pointer;
	font-size: 16px;
	transition: background-color 0.3s ease;
	margin-top: 10px;
}

button:hover {
	background-color: #0056b3;
}

button[type="button"] {
	background-color: #6c757d;
	margin-left: 10px;
}

button[type="button"]:hover {
	background-color: #5a6268;
}

/* Responsive Design */
@media ( max-width : 768px) {
	.popup-form {
		width: 90%;
		height: auto; /* Allow height to adjust for smaller screens */
	}
}
</style>

<script>
	function showForm(batchCode, subject, teacher, timeFrom, timeTo) {
		console.log("showForm called with parameters:", id, batchCode, subject,
				teacher, timeFrom, timeTo);

		document.getElementById('batchCode').value = batchCode;
		document.getElementById('subject').value = subject;
		document.getElementById('teacher').value = teacher;
		document.getElementById('timeFrom').value = timeFrom;
		document.getElementById('timeTo').value = timeTo;

		document.getElementById('formOverlay').style.display = 'block';
		document.getElementById('formContainer2').style.display = 'block';
	}

	function closeForm() {
		document.getElementById('formOverlay').style.display = 'none';
		document.getElementById('formContainer2').style.display = 'none';
	}
</script>

</head>
<body>
	<div class="dashboard">
		<div class="sidebar" style="height: 169vh;">
			<div class="sidebar-header">
				<h2>
					<span class="blue">CYBER</span> <span class="green">SUCCESS</span>
				</h2>
				<i class="fas fa-arrow-left collapse-btn" id="collapse-btn"></i>
			</div>
			<nav class="sidebar-nav">
				<ul>
					<li><a href="managerDashboard.jsp" class="active"><i
							class="fas fa-earth icon-timetable"></i> <span>Dashboard</span> </a></li>
					<li><a href="editTimetable.jsp"><i
							class="fas fa-edit icon-tt"></i> <span>Edit Timetable</span> </a></li>
					<li><a href="managerTrainers.jsp"><i
							class="fas fa-users-cog icon-managers" style="font-size: 13px;"></i>
							<span>Manage Trainers</span> </a></li>
					<li><a href="checkAttendance,jsp"><i
							class="fas fa-user-check icon-attendance"
							style="font-size: 13px;"></i> <span>Check Attendance</span> </a></li>
					<li><a href="timeTables.jsp"><i
							class="fas fa-calendar-alt icon-timetables"></i> <span>Time
								Tables</span> </a></li>
					<li><a href="forgotTrainer.jsp"><i
							class="fas fa-unlock-alt icon-forgot-trainer-password"></i> <span>Forgot
								Trainer Password</span> </a></li>
				</ul>
				<h4>Settings</h4>
				<ul>
					<li><a href="profile.jsp"><i
							class="fas fa-user icon-profile"></i> <span>Profile</span> </a></li>
					<li><a href="settings.jsp"><i
							class="fas fa-cogs icon-settings" style="font-size: 13px;"></i> <span>Settings</span>
					</a></li>
					<li><a href="login.jsp"><i
							class="fas fa-sign-out-alt icon-logout"></i> <span>Logout</span>
					</a></li>
				</ul>

			</nav>
		</div>
		<%
		String selectedDate = request.getParameter("date");
		if (selectedDate == null) {
			selectedDate = new java.sql.Date(System.currentTimeMillis()).toString();
		}
		List<TimetableEntry> entries = UserDAO.getTimetableEntriesByDate(selectedDate);
		%>
		<%
		UserDAO dao = new UserDAO();
		String currentDate = new java.sql.Date(System.currentTimeMillis()).toString();
		List<TimetableEntry> entriess = UserDAO.getTimetableEntriesByDate(currentDate);
		%>
		<div class="main-content">
			<div class="welcome-msg">
				<h3 style="font-weight: 400;">
					Welcome <span style="font-weight: 600; margin-left: 10px;"><%=session.getAttribute("managerName")%></span>
				</h3>
				<i class="fas fa-bell"></i>
			</div>
			<div class="form-container">
				<h3>Create Timetable Entry</h3>
				<form action="createTimetable" method="post">
					<div class="date-day">
						<div class="form-groupD">
							<label for="date">Date:</label> <input type="date"
								value="<%=selectedDate%>" id="date" name="date" required>
						</div>
						<div class="form-groupD">
							<label for="day">Day:</label> <select id="day" name="day"
								required>
								<option value="Sunday">Sunday</option>
								<option value="Monday">Monday</option>
								<option value="Tuesday">Tuesday</option>
								<option value="Wednesday">Wednesday</option>
								<option value="Thursday">Thursday</option>
								<option value="Friday">Friday</option>
								<option value="Saturday">Saturday</option>
							</select>
						</div>
						<div class="form-groupD">
							<label for="time_from">Time-from:</label> <input type="time"
								id="time_from" name="time_from" required>
						</div>
						<div class="form-groupD">
							<label for="time_to">Time-to:</label> <input type="time"
								id="time_to" name="time_to" required>
						</div>
					</div>
					<div class="batch-class">
						<div class="form-groupB">
							<label for="batch_name">Batch</label> <select id="batch_name"
								name="batch_name" required>
								<%
								UserDAO batches = new UserDAO();
								List<String> batchnames = batches.getAllBatchNames();
								for (String code : batchnames) {
								%>
								<option value="<%=code%>"><%=code%></option>
								<%
								}
								%>
							</select>
						</div>
						<div class="form-groupB">
							<label for="classroom">Classroom</label> <select id="classroom"
								name="classroom" required>
								<option value="Success 1">Success 1</option>
								<option value="Success 2">Success 2</option>
								<option value="Success 3">Success 3</option>
								<option value="Success 4">Success 4</option>
								<option value="Success 5">Success 5</option>
								<option value="Success 6">Success 6</option>
							</select>
						</div>
					</div>
					<div class="teacher-entry">
						<div class="form-group">
							<select id="course-name" name="course-name" required>
								<option value="Manual Testing">Manual Testing</option>
								<option value="Core Java">Core Java</option>
								<option value="Advanced Java">Advanced Java</option>
								<option value="Selenium">Selenium</option>
								<option value="Python">Python</option>
								<option value="Automation">Automation</option>
								<option value="Other">Other</option>
							</select>
						</div>
						<div class="form-group">
							<select id="trainer_name" name="trainer_name" required>
								<option value="">Select Trainer</option>
								<%
								UserDAO tnames = new UserDAO();
								List<String> trainerNames = tnames.getAllTrainerNames();
								for (String trainerName : trainerNames) {
								%>
								<option value="<%=trainerName%>"><%=trainerName%></option>
								<%
								}
								%>
							</select>
						</div>
						<div class="form-group">
							<button type="submit">Create Entry</button>
						</div>
					</div>
				</form>
			</div>

			<div class="buttons" style="display: flex;">
				<form action="addPreviousData" method="post">
					<div class="yesterday-entry"
						style="margin-top: 10px; margin-right: 20px;">
						<button class="add" type="submit"
							style="padding: 10px 30px; border-radius: 5px; background: #04c4de; border: none; color: #fff; cursor: pointer; font-weight: 600;">Add
							Previous Data</button>
					</div>
				</form>

				<form action="deleteData" method="post">
					<div class="yesterday-entry" style="margin-top: 10px;">
						<button class="add" type="submit"
							style="padding: 10px 30px; border-radius: 5px; background: #961a18; border: none; color: #fff; cursor: pointer; font-weight: 600;">Delete
							Data</button>
					</div>
				</form>
			</div>


			<%
			LocalDate today = LocalDate.now();
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			String formattedDate = today.format(formatter);
			List<TimetableEntry> entries2 = UserDAO.getTimetableEntriesByDate(formattedDate);
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

			<div class="overlay" id="overlay"></div>
			<div class="popup-form" id="popupForm">
				<form action="${pageContext.request.contextPath}/UpdateEntry"
					method="post" id="upForm" style="height: 81%;">
					<input type="text" id="id" name="id" hidden="true">
					<div class="box-1" style="width: 100%; display: flex; align-items: center; justify-content: space-between; ">
						<select id="batchCodeInput" name="batchCode" required style="width: 45%;">
							<option value="">Select Batch Code</option>
							<%
							UserDAO batches1 = new UserDAO();
							List<String> batchnames1 = batches1.getAllBatchNames();
							for (String code : batchnames1) {
							%>
							<option value="<%=code%>"><%=code%></option>
							<%
							}
							%>
						</select> 
						<input type="text" id="subjectInput" name="subject" style="width: 45%;">
					</div>

					<div class="box-2" style="width: 100%; display: flex; align-items: center; justify-content: space-between; ">
						<select id="trainer_name" name="trainer_name" required style="width: 45%;">
							<option value="">Select Trainer</option>
							<%
							UserDAO tnames1 = new UserDAO();
							List<String> trainerNames1 = tnames1.getAllTrainerNames();
							for (String trainerName : trainerNames1) {
							%>
							<option value="<%=trainerName%>"><%=trainerName%></option>
							<%
							}
							%>
						</select> 
						<select id="classroom" name="classroom" required style="width: 45%;">
							<option value="Success 1">Success 1</option>
							<option value="Success 2">Success 2</option>
							<option value="Success 3">Success 3</option>
							<option value="Success 4">Success 4</option>
							<option value="Success 5">Success 5</option>
							<option value="Success 6">Success 6</option>
						</select>
					</div>
					
					<div class="box-3" style="display: flex; align-items: center;">
						<div class="tf">
							<label for="timeFromInput">Time From:</label> 
							<input type="time" id="timeFromInput" name="timeFrom" style="width: 50%;">
						</div>
						<div class="tt">
							<label for="timeToInput">Time To:</label> 
							<input type="time" id="timeToInput" name="timeTo">
						</div>
					</div>

					<div class="buttns" style="display: grid; grid-template-columns: 1fr 1fr;">
						<button type="submit">Update</button>
						<button type="button" onclick="hideForm()">Close</button>
					</div>
					<button type="button" onclick="submitDeleteForm()" style="background: #801b1b;">Delete</button>
				</form>
			</div>




			<div class="timetable-showing"
				style="height: auto; width: 100%; background: white; box-shadow: rgba(0, 0, 0, 0.24) 0px 3px 8px; display: flex; justify-content: space-between;">

				<!-- Success 1 -->
				<div class="s1"
					style="width: 16%; height: 100vh; border: 1px solid;">
					<div class="heading"
						style="height: 10vh; width: 100%; background: black; color: white; display: flex; justify-content: center; align-items: center;">
						Success 1</div>
					<%
					List<TimetableEntry> success1Entries = classroomMap.get("Success 1");
					if (success1Entries != null) {
						for (TimetableEntry entry : success1Entries) {
							String teacher = entry.getTeacher().toLowerCase();
							String backgroundColor = "";
							String color = "white";
							switch (teacher) {
						case "harshad sir" :
							backgroundColor = "brown";
							break;
						case "rushi" :
							backgroundColor = "#f20ae3";
							color = "black";
							break;
						case "nilesh sir" :
							backgroundColor = "#cf0af2";
							color = "black";
							break;
						case "zulfikar sir" :
							backgroundColor = "gray";
							break;
						case "siddhart sir" :
							backgroundColor = "orange";
							break;
						case "gaurav sir" :
							backgroundColor = "blue";
							break;
						case "master" :
							backgroundColor = "#0af211";
							color = "black";
							break;
							}
					%>
					<div class="box"
						style="border: 1px solid; background: <%=backgroundColor%>; color: <%=color%>; padding: 10px; display: flex; flex-direction: column; align-items: center; justify-content: center;">
						<span><%=entry.getBatchCode()%></span> <span><%=entry.getSubject()%></span>
						<span><%=entry.getTeacher()%></span> <span><%=entry.getTimeFrom()%>
							TO <%=entry.getTimeTo()%></span>
						<div class="updt" style="width: 100%;">
							<button type="button"
								style="background: none; border: none; cursor: pointer;"
								onclick="showForm('<%=entry.getId()%>', '<%=entry.getBatchCode()%>', '<%=entry.getSubject()%>', '<%=entry.getTeacher()%>', '<%=entry.getTimeFrom()%>', '<%=entry.getTimeTo()%>')">
								<i class="fa-solid fa-pen-to-square"></i>
							</button>
						</div>
					</div>

					<div class="form-overlay2" id="formOverlay" onclick="closeForm()"></div>
					<div class="form-container2" id="formContainer2">
						<form id="updateForm" action="updateTimetable" method="post">
							<input type="hidden" name="id" id="entryId"> <label
								for="batchCode">Batch Code</label> <input type="text"
								name="batchCode" id="batchCode"> <label for="subject">Subject</label>
							<input type="text" name="subject" id="subject"> <label
								for="teacher">Teacher</label> <input type="text" name="teacher"
								id="teacher"> <label for="timeFrom">Time From</label> <input
								type="text" name="timeFrom" id="timeFrom"> <label
								for="timeTo">Time To</label> <input type="text" name="timeTo"
								id="timeTo">
							<button type="submit">Update</button>
							<button type="button" class="close-btn" onclick="closeForm()">Close</button>
						</form>
					</div>

					<%
					}
					}
					%>
				</div>

				<!-- Success 2 -->
				<div class="s2"
					style="width: 16%; height: 100vh; border: 1px solid;">
					<div class="heading"
						style="height: 10vh; width: 100%; background: black; color: white; display: flex; justify-content: center; align-items: center;">
						Success 2</div>
					<%
					List<TimetableEntry> success2Entries = classroomMap.get("Success 2");
					if (success2Entries != null) {
						for (TimetableEntry entry : success2Entries) {
							String teacher = entry.getTeacher().toLowerCase();
							String backgroundColor = "";
							String color = "white";
							switch (teacher) {
						case "harshad sir" :
							backgroundColor = "brown";
							break;
						case "rushi" :
							backgroundColor = "#f20ae3";
							color = "black";
							break;
						case "nilesh sir" :
							backgroundColor = "#cf0af2";
							color = "black";
							break;
						case "zulfikar sir" :
							backgroundColor = "gray";
							break;
						case "siddhart sir" :
							backgroundColor = "orange";
							break;
						case "gaurav sir" :
							backgroundColor = "blue";
							break;
						case "master" :
							backgroundColor = "#0af211";
							color = "black";
							break;
							}
					%>
					<div class="box"
						style="border: 1px solid; background: <%=backgroundColor%>; color: <%=color%>; padding: 10px; display: flex; flex-direction: column; align-items: center; justify-content: center;">
						<span><%=entry.getBatchCode()%></span> <span><%=entry.getSubject()%></span>
						<span><%=entry.getTeacher()%></span> <span><%=entry.getTimeFrom()%>
							TO <%=entry.getTimeTo()%></span>
						<div class="updt" style="width: 100%;">
							<button type="button"
								style="background: none; border: none; cursor: pointer;"
								onclick="showForm('<%=entry.getId()%>', '<%=entry.getBatchCode()%>', '<%=entry.getSubject()%>', '<%=entry.getTeacher()%>', '<%=entry.getTimeFrom()%>', '<%=entry.getTimeTo()%>')">
								<i class="fa-solid fa-pen-to-square"></i>
							</button>
						</div>
					</div>
					<%
					}
					}
					%>
				</div>

				<!-- Success 3 -->
				<div class="s3"
					style="width: 16%; height: 100vh; border: 1px solid;">
					<div class="heading"
						style="height: 10vh; width: 100%; background: black; color: white; display: flex; justify-content: center; align-items: center;">
						Success 3</div>
					<%
					List<TimetableEntry> success3Entries = classroomMap.get("Success 3");
					if (success3Entries != null) {
						for (TimetableEntry entry : success3Entries) {
							String teacher = entry.getTeacher().toLowerCase();
							String backgroundColor = "";
							String color = "white";
							switch (teacher) {
						case "harshad sir" :
							backgroundColor = "brown";
							break;
						case "rushi" :
							backgroundColor = "#f20ae3";
							color = "black";
							break;
						case "nilesh sir" :
							backgroundColor = "#cf0af2";
							color = "black";
							break;
						case "zulfikar sir" :
							backgroundColor = "gray";
							break;
						case "siddhart sir" :
							backgroundColor = "orange";
							break;
						case "gaurav sir" :
							backgroundColor = "blue";
							break;
						case "master" :
							backgroundColor = "#0af211";
							color = "black";
							break;
							}
					%>
					<div class="box"
						style="border: 1px solid; background: <%=backgroundColor%>; color: <%=color%>; padding: 10px; display: flex; flex-direction: column; align-items: center; justify-content: center;">
						<span><%=entry.getBatchCode()%></span> <span><%=entry.getSubject()%></span>
						<span><%=entry.getTeacher()%></span> <span><%=entry.getTimeFrom()%>
							TO <%=entry.getTimeTo()%></span>
						<div class="updt" style="width: 100%;">
							<button type="button"
								style="background: none; border: none; cursor: pointer;"
								onclick="showForm('<%=entry.getId()%>', '<%=entry.getBatchCode()%>', '<%=entry.getSubject()%>', '<%=entry.getTeacher()%>', '<%=entry.getTimeFrom()%>', '<%=entry.getTimeTo()%>')">
								<i class="fa-solid fa-pen-to-square"></i>
							</button>
						</div>
					</div>
					<%
					}
					}
					%>
				</div>

				<!-- Success 4 -->
				<div class="s4"
					style="width: 16%; height: 100vh; border: 1px solid;">
					<div class="heading"
						style="height: 10vh; width: 100%; background: black; color: white; display: flex; justify-content: center; align-items: center;">
						Success 4</div>
					<%
					List<TimetableEntry> success4Entries = classroomMap.get("Success 4");
					if (success4Entries != null) {
						for (TimetableEntry entry : success4Entries) {
							String teacher = entry.getTeacher().toLowerCase();
							String backgroundColor = "";
							String color = "white";
							switch (teacher) {
						case "harshad sir" :
							backgroundColor = "brown";
							break;
						case "rushi" :
							backgroundColor = "#f20ae3";
							color = "black";
							break;
						case "nilesh sir" :
							backgroundColor = "#cf0af2";
							color = "black";
							break;
						case "zulfikar sir" :
							backgroundColor = "gray";
							break;
						case "siddhart sir" :
							backgroundColor = "orange";
							break;
						case "gaurav sir" :
							backgroundColor = "blue";
							break;
						case "master" :
							backgroundColor = "#0af211";
							color = "black";
							break;
							}
					%>
					<div class="box"
						style="border: 1px solid; background: <%=backgroundColor%>; color: <%=color%>; padding: 10px; display: flex; flex-direction: column; align-items: center; justify-content: center;">
						<span><%=entry.getBatchCode()%></span> <span><%=entry.getSubject()%></span>
						<span><%=entry.getTeacher()%></span> <span><%=entry.getTimeFrom()%>
							TO <%=entry.getTimeTo()%></span>
						<div class="updt" style="width: 100%;">
							<button type="button"
								style="background: none; border: none; cursor: pointer;"
								onclick="showForm('<%=entry.getId()%>', '<%=entry.getBatchCode()%>', '<%=entry.getSubject()%>', '<%=entry.getTeacher()%>', '<%=entry.getTimeFrom()%>', '<%=entry.getTimeTo()%>')">
								<i class="fa-solid fa-pen-to-square"></i>
							</button>
						</div>
					</div>
					<%
					}
					}
					%>
				</div>

				<!-- Success 5 -->
				<div class="s5"
					style="width: 16%; height: 100vh; border: 1px solid;">
					<div class="heading"
						style="height: 10vh; width: 100%; background: black; color: white; display: flex; justify-content: center; align-items: center;">
						Success 5</div>
					<%
					List<TimetableEntry> success5Entries = classroomMap.get("Success 5");
					if (success5Entries != null) {
						for (TimetableEntry entry : success5Entries) {
							String teacher = entry.getTeacher().toLowerCase();
							String backgroundColor = "";
							String color = "white";
							switch (teacher) {
						case "harshad sir" :
							backgroundColor = "brown";
							break;
						case "rushi" :
							backgroundColor = "#f20ae3";
							color = "black";
							break;
						case "nilesh sir" :
							backgroundColor = "#cf0af2";
							color = "black";
							break;
						case "zulfikar sir" :
							backgroundColor = "gray";
							break;
						case "siddhart sir" :
							backgroundColor = "orange";
							break;
						case "gaurav sir" :
							backgroundColor = "blue";
							break;
						case "master" :
							backgroundColor = "#0af211";
							color = "black";
							break;
							}
					%>
					<div class="box"
						style="border: 1px solid; background: <%=backgroundColor%>; color: <%=color%>; padding: 10px; display: flex; flex-direction: column; align-items: center; justify-content: center;">
						<span><%=entry.getBatchCode()%></span> <span><%=entry.getSubject()%></span>
						<span><%=entry.getTeacher()%></span> <span><%=entry.getTimeFrom()%>
							TO <%=entry.getTimeTo()%></span>
						<div class="updt" style="width: 100%;">
							<button type="button"
								style="background: none; border: none; cursor: pointer;"
								onclick="showForm('<%=entry.getId()%>', '<%=entry.getBatchCode()%>', '<%=entry.getSubject()%>', '<%=entry.getTeacher()%>', '<%=entry.getTimeFrom()%>', '<%=entry.getTimeTo()%>')">
								<i class="fa-solid fa-pen-to-square"></i>
							</button>
						</div>
					</div>
					<%
					}
					}
					%>
				</div>

				<!-- Success 6 -->
				<div class="s6"
					style="width: 16%; height: 100vh; border: 1px solid;">
					<div class="heading"
						style="height: 10vh; width: 100%; background: black; color: white; display: flex; justify-content: center; align-items: center;">
						Success 6</div>
					<%
					List<TimetableEntry> success6Entries = classroomMap.get("Success 6");
					if (success6Entries != null) {
						for (TimetableEntry entry : success6Entries) {
							String teacher = entry.getTeacher().toLowerCase();
							String backgroundColor = "";
							String color = "white";
							switch (teacher) {
						case "harshad sir" :
							backgroundColor = "brown";
							break;
						case "rushi" :
							backgroundColor = "#f20ae3";
							color = "black";
							break;
						case "nilesh sir" :
							backgroundColor = "#cf0af2";
							color = "black";
							break;
						case "zulfikar sir" :
							backgroundColor = "gray";
							break;
						case "siddhart sir" :
							backgroundColor = "orange";
							break;
						case "gaurav sir" :
							backgroundColor = "blue";
							break;
						case "master" :
							backgroundColor = "#0af211";
							color = "black";
							break;
							}
					%>
					<div class="box"
						style="border: 1px solid; background: <%=backgroundColor%>; color: <%=color%>; padding: 10px; display: flex; flex-direction: column; align-items: center; justify-content: center;">
						<span><%=entry.getBatchCode()%></span> <span><%=entry.getSubject()%></span>
						<span><%=entry.getTeacher()%></span> <span><%=entry.getTimeFrom()%>
							TO <%=entry.getTimeTo()%></span>
						<div class="updt" style="width: 100%;">
							<button type="button"
								style="background: none; border: none; cursor: pointer;"
								onclick="showForm('<%=entry.getId()%>', '<%=entry.getBatchCode()%>', '<%=entry.getSubject()%>', '<%=entry.getTeacher()%>', '<%=entry.getTimeFrom()%>', '<%=entry.getTimeTo()%>')">
								<i class="fa-solid fa-pen-to-square"></i>
							</button>
						</div>
					</div>
					<%
					}
					}
					%>
				</div>
			</div>
				<div class="ss">
					<button class="yesterday-entry">Submit & Send</button>
				</div>
		</div>
	</div>
	<script>
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

			// Set current date and day
			const dateInput = document.getElementById('date');
			const dayInput = document.getElementById('day');

			const today = new Date();
			const yyyy = today.getFullYear();
			let mm = today.getMonth() + 1; // Months start at 0!
			let dd = today.getDate();

			if (dd < 10)
				dd = '0' + dd;
			if (mm < 10)
				mm = '0' + mm;

			const formattedDate = yyyy + '-' + mm + '-' + dd;
			dateInput.value = formattedDate;

			const daysOfWeek = [ "Sunday", "Monday", "Tuesday", "Wednesday",
					"Thursday", "Friday", "Saturday" ];
			const dayName = daysOfWeek[today.getDay()];
			dayInput.value = dayName;
		});

		function showForm(id, batchCode, subject, teacher, classroom, timeFrom,
				timeTo) {

			document.getElementById('id').value = id;
			document.getElementById('batchCodeInput').value = batchCode;
			document.getElementById('subjectInput').value = subject;
			document.getElementById('trainer_name').value = teacher;
			document.getElementById('classroom').value = classroom;
			document.getElementById('timeFromInput').value = timeFrom;
			document.getElementById('timeToInput').value = timeTo;

			document.getElementById('popupForm').style.display = 'block';
			document.getElementById('overlay').style.display = 'block';
		}
		function hideForm() {
			document.getElementById('popupForm').style.display = 'none';
			document.getElementById('overlay').style.display = 'none';
		}
		
		function submitDeleteForm() {
	        var form = document.getElementById('upForm');
	        form.action = '${pageContext.request.contextPath}/DeleteEntry';
	        form.submit();
	    }
	</script>

</body>
</html>
