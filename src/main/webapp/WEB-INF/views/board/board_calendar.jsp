<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
	<title>Calendar</title>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.4.1.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/httpRequest.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/calendar.js"></script>
		<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
				<!-- Bootstrap core CSS -->
		<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
		<!-- 합쳐지고 최소화된 최신 CSS -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
		<!-- 부가적인 테마 -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
		<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/bbspage/calendar.css">
</head>
<body>

		<div class="calendar">

			<div class="col leftCol">
				<div class="content">
					<h1 class="date">Friday<span>September 12th</span></h1>
					<div class="notes">
						<p>
							<input type="text" value="" placeholder="new note"/>
							<a href="#" title="Add note" class="addNote animate">+</a>
						</p>
	
					</div>
				</div>
			</div>

			<div class="col rightCol">
				<div class="content">
					<h2 class="year">2020</h2>
					<ul class="months">
						<li><a href="#" title="Jan" data-value="1" class="selected">Jan</a></li>
						<li><a href="#" title="Feb" data-value="2">Feb</a></li>
						<li><a href="#" title="Mar" data-value="3">Mar</a></li>
						<li><a href="#" title="Apr" data-value="4">Apr</a></li>
						<li><a href="#" title="May" data-value="5">May</a></li>
						<li><a href="#" title="Jun" data-value="6">Jun</a></li>
						<li><a href="#" title="Jul" data-value="7">Jul</a></li>
						<li><a href="#" title="Aug" data-value="8">Aug</a></li>
						<li><a href="#" title="Sep" data-value="9">Sep</a></li>
						<li><a href="#" title="Oct" data-value="10">Oct</a></li>
						<li><a href="#" title="Nov" data-value="11">Nov</a></li>
						<li><a href="#" title="Dec" data-value="12">Dec</a></li>
					</ul>
					<div class="clearfix"></div>
					<ul class="weekday">
						<li><a href="#" title="Mon" data-value="6">Mon</a></li>
						<li><a href="#" title="Tue" data-value="7">Tue</a></li>
						<li><a href="#" title="Wed" data-value="1">Wed</a></li>
						<li><a href="#" title="Thu" data-value="2">Thu</a></li>
						<li><a href="#" title="Fri" data-value="3">Fri</a></li>
						<li><a href="#" title="Say" data-value="4">Sat</a></li>
						<li><a href="#" title="Sun" data-value="5">Sun</a></li>
					</ul>
					<div class="clearfix"></div>
					<ul class="days">
						<script>
							for( var _i = 1; _i <= 31; _i += 1 ){
								var _addClass = '';
								if( _i === 2 ){ _addClass = ' class="selected"'; }

								document.write( '<li><a href="#" title="'+_i+'" data-value="'+_i+'"'+_addClass+'>'+_i+'</a></li>' );
							}
						</script>
					</ul>
					<div class="clearfix"></div>
				</div>
			</div>

			<div class="clearfix"></div>

		</div> 
	</body>
</html>