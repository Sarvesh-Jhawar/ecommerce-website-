<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>About Me</title>
<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	background-color: #f8f9fa;
}

.about-section {
	background-color: #fff;
	max-width: 800px;
	margin: 50px auto;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
	text-align: center;
}

.about-section h1 {
	font-size: 2.5rem;
	margin-bottom: 20px;
	color: #007bff;
}

.about-section p {
	font-size: 1.2rem;
	margin-bottom: 10px;
	line-height: 1.6;
}

.about-section a {
	color: #007bff;
	text-decoration: none;
}

.about-section a:hover {
	text-decoration: underline;
}

.back-button {
	display: inline-block;
	margin-bottom: 20px;
	text-decoration: none;
	color: #000;
	background-color: white;
	padding: 10px 20px;
	border-radius: 5px;
	transition: background-color 0.3s, color 0.3s;
}

.back-button:hover {
	background-color: #0056b3; /* Blue background on hover */
	color: #fff; /* Change text color to white on hover */
}

.footer {
	text-align: center;
	padding: 10px;
	background-color: #343a40;
	color: white;
	position: fixed;
	bottom: 0;
	width: 100%;
}
</style>
</head>
<body>
	<div class="about-section">
		<h1>About Me</h1>
		<p>
			Hi, my name is <strong>Sarvesh Jhawar</strong>. I am currently
			pursuing my <strong>B.Tech in Information Technology</strong> at <strong>Chaitanya
				Bharathi Institute of Technology</strong>, Hyderabad.
		</p>
		<p>I am in my 2nd year of studies and am passionate about learning
			new technologies and building projects that help me grow as a
			developer.</p>
		<p>
			This project was created in <strong>December 2024</strong> as part of
			my learning journey to explore web development using <strong>Java,
				JSP, and Servlets</strong>.
		</p>
		<p>
			If you'd like to reach out, feel free to email me at <a
				href="mailto:sarveshjhawar08@gmail.com">sarveshjhawar08@gmail.com</a>.
		</p>
		<p>Thank you for visiting my website!</p>
		<a href="index.jsp" class="back-button">← Back to Home</a>
	</div>
	<div class="footer">© Sarvesh Jhawar - December 2024</div>
</body>
</html>
