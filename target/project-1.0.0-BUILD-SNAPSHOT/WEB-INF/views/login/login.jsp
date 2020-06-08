<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login/login.css">

	<title>Home</title>
	
	<script type="text/javascript">
	function send(f) {
		
		var m_email = f.m_email.value;
		var m_pwd = f.m_pwd.value;
		
		if (m_email == ""){
			
			alert("E-mail이 입력되지 않았습니다. 입력 부탁드립니다.");
			
			return;
		}
		if (m_pwd == ""){
			
			alert("패스워드가 입력되지 않았습니다. 입력 부탁드립니다.");
			
			return;
		}
		
		
		f.action = "login.do";
		f.method = "post";
		f.submit();
		
	}
	
	</script>
	
</head>
<body>
<div class="container" id="container">
	<div class="form-container sign-in-container">
		<form >
			<h1>Sign in</h1><br>
			
			<c:if test="${ not empty loginerrer }">
				<font color="red"> ${ loginerrer }</font>
			</c:if>
			
			<span>or use your account</span>
			
			<input type="text" name="m_email" placeholder="E-mail" />
			
			<input type="password" name="m_pwd" placeholder="Password" />
			
			<a href="pwdsearch_form.do">Forgot your password?</a>
			
			<button onclick="send(this.form);">Log In</button>
		</form>
	</div>
	<div class="overlay-container">
		<div class="overlay">
			<div class="overlay-panel overlay-right">
				<h1>Hello, Friend!</h1>
				<p>Enter your personal details and start journey with us</p>
				<button class="ghost" id="signUp" onclick="location.href='signup_form.do'">Sign Up</button>
			</div>
		</div>
	</div>
</div>

<footer>

</footer>
</body>
</html>

