<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Manage Trainers - Cyber Success</title>
<link rel="stylesheet" href="css/manageTrainers.css">
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
					<li><a href="managerDashboard.jsp"><i
							class="fas fa-earth icon-timetable"></i> <span>Dashboard</span> </a></li>
					<li><a href="editTimetable.jsp"><i
							class="fas fa-edit icon-tt"></i> <span>Edit Timetable</span> </a></li>
					<li><a href="managerTrainers.jsp" class="active"><i
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
		<div class="main-content"></div>
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


