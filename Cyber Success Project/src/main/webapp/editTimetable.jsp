<%@page import="com.cyber.DAO.UserDAO"%>
<%@page import="com.cyber.model.TimetableEntry"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit Timetable - Cyber Success</title>
<link rel="stylesheet" href="css/createTT.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
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

/* General table styling */
.timetable-entries {
	margin-top: 20px;
}

.timetable-entries table {
	width: 100%;
	border-collapse: collapse;
	margin: 20px 0;
	font-size: 18px;
	text-align: left;
}

.timetable-entries table th, .timetable-entries table td {
	padding: 12px;
	border: 1px solid #ddd;
	transition: background-color 0.3s ease;
}

/* Header styling */
.timetable-entries table th {
	background-color: #04c4de;
	color: #fff;
	font-size: 20px;
	padding: 15px;
}

/* Row styling */
.timetable-entries table tr {
	transition: background-color 0.3s;
}

/* Zebra striping */
.timetable-entries table tr:nth-child(even) {
	background-color: #f2f2f2;
}

/* Hover effect */
.timetable-entries table tr:hover {
	background-color: #e0f7fa;
}

/* Cell styling */
.timetable-entries table td {
	padding: 15px;
	border-bottom: 1px solid #ddd;
}

/* Animated buttons */
.timetable-entries table td button {
	background-color: #04c4de;
	color: #fff;
	border: none;
	padding: 8px 12px;
	border-radius: 4px;
	cursor: pointer;
	transition: background-color 0.3s;
}

.timetable-entries table td button:hover {
	background-color: #0398a0;
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
					<li><a href="managerDashboard.jsp"><i
							class="fas fa-earth icon-timetable"></i> <span>Dashboard</span> </a></li>
					<li><a href="editTimetable.jsp" class="active"><i
							class="fas fa-edit icon-tt"></i> <span>Edit Timetable</span> </a></li>
					<li><a href="managerTrainers.jsp"><i
							class="fas fa-users-cog icon-managers" style="font-size: 13px;"></i>
							<span>Manage Trainers</span> </a></li>
					<li><a href="checkAttendance.jsp"><i
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
		<div class="main-content">
			<h2>Edit Timetable</h2>
			<div class="form-container">
				<h3>Select Date and Day</h3>
				<div class="date-day">
					<div class="form-groupD">
						<label for="date">Date:</label> <input type="date" id="date"
							name="date">
					</div>
					<div class="form-groupD">
						<label for="day">Day:</label> <input type="text" id="day"
							name="day" readonly>
					</div>
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
				
				
				
				<h3>Edit Timetable Entries</h3>
				<div class="timetable-entries"></div>	
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
				collapseBtn.classList
						.replace('fa-arrow-left', 'fa-arrow-right');
			} else {
				collapseBtn.classList
						.replace('fa-arrow-right', 'fa-arrow-left');
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

		// Fetch timetable entries for the current date
		fetchTimetableEntries(formattedDate);

		// Event listener for date change
		dateInput.addEventListener('change', function() {
			const selectedDate = dateInput.value;
			fetchTimetableEntries(selectedDate);
		});
	});

	function fetchTimetableEntries(date) {
        const xhr = new XMLHttpRequest();
        xhr.open('GET', 'fetchTimetableEntries?date=' + date, true);
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {
                const timetableEntriesDiv = document.querySelector('.timetable-entries');
                timetableEntriesDiv.innerHTML = xhr.responseText;
                attachEditButtonListeners();
            }
        };
        xhr.send();
    }
	
	
    // Initial fetch on page load
    fetchTimetableEntries(new Date().toISOString().split('T')[0]);
    
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
</script>


</body>
</html>