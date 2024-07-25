<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cyber Success - Login</title>
<link rel="stylesheet" type="text/css" href="css/login.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<div class="form-body">
		<div class="form-container">
			<h2>
				<span class="blue">CYBER</span> <span class="green">SUCCESS</span>
				LOGIN
			</h2>
			<form action="login" method="post">
				<div class="form-group">
					<div class="custom-select-wrapper">
						<div class="custom-select">
							<div class="custom-select__trigger">
								<span>Select Role</span>
								<div class="arrow"></div>
							</div>
							<div class="custom-options">
								<span class="custom-option" data-value="Master">Master</span> 
								<span class="custom-option" data-value="Manager">Manager</span>
								<span class="custom-option" data-value="Trainer">Trainer</span>
							</div>
						</div>
					</div>
					<select name="role" id="role" hidden>
						<option value="Master">Master</option>
						<option value="Manager">Manager</option>
						<option value="Trainer">Trainer</option>
					</select>
				</div>
				<div class="form-group">
					<input type="text" id="username" name="username" required
						autocomplete="username" placeholder="User Name">
				</div>
				<div class="form-group">
					<input type="password" id="password" name="password" required
						autocomplete="current-password" placeholder="Password"> <span
						class="toggle-password eye-closed" onclick="togglePassword()"></span>
				</div>
				<div class="form-group">
					<span id="error-message" style="color: red;"><%=request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : ""%></span>
				</div>
				<div class="form-group"
					style="display: flex; width: 100%; align-items: center; justify-content: space-around;">
					<button type="submit" style="width: 100%;">Login To Access</button>
				</div>
			</form>
			<button id="theme-toggle" class="theme-toggle">Toggle Dark Mode</button>
			<div class="cs-logo">
				<img alt="cs-logo" src="img/cyber-success-final-logo.jpg">
			</div>
		</div>
	</div>
	<script src="JavaScript/script.js"></script>
	<script>
		document.getElementById('theme-toggle').addEventListener('click', function() {
			document.body.classList.toggle('dark-mode');
		});
	</script>
</body>
</html>
