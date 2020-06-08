<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/signup/signup.css">

<script type="text/javascript"
		  src="${pageContext.request.contextPath}/resources/js/httpRequest.js"></script>


<meta charset="UTF-8">
<title>Insert title here</title>

	<script type="text/javascript">
    var rangeLabel = document.getElementById("range-label");
    var experience = document.getElementById("experience");

    function change() {
    rangeLabel.innerText = experience.value + "K";
    }

    function search(){
    	
    	var m_email = document.getElementById("m_email").value;
    	
    	var test_email = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
    	
		if (m_email == ""){
			
			alert("E-mail이 입력되지 않았습니다. 입력 부탁드립니다.");
			
			return;
		}
    	
		if(test_email.test(m_email) == false ){
			
			alert("E-mail이 비 정상적으로 입력 되었습니다.");
			
			return;
			
		}
		
    	var url = "email_search.do";
		var param = "m_email=" + m_email;
		
		sendRequest(url, param, resultFn, "get");
    	
    }
    
	function resultFn(){

		if( xhr.readyState == 4 && xhr.status == 200 ){
			
			var data = xhr.responseText;
			
			alert(data);
			
			if( data == 'no'){
				
				alert("해당 ID가 없습니다. 다시 확인 부탁드립니다.");
				
				return;
				
			}
				
			document.getElementById("create").setAttribute("onClick", "send(form);")
			
			alert("해당 ID가 있습니다. 변경할 pwd를 입력 부탁드립니다.");
		}
		
	}//resultFn()
	
	function send(f) {
		
		var m_email = f.m_email.value;
		var m_pwd = f.m_pwd.value;
		
		var test_email = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		var test_pwd = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{6,12}/;
		
		if (m_email == ""){
			
			alert("E-mail이 입력되지 않았습니다. 입력 부탁드립니다.");
			
			return;
		}
		
		if(test_email.test(m_email) == false ){
			
			alert("E-mail이 비 정상적으로 입력 되었습니다.");
			
			return;
			
		}
		
		if (m_pwd == ""){
			
			alert("변경할 pwd가 입력되지 않았습니다. 입력 부탁드립니다.");
			
			return;
		}
		
		if(test_pwd.test(m_pwd) == false ){
			
			alert("pwd는 6 ~ 12자리의 영문, 숫자, 특문을 포함하여 만들어주세요.");
			
			return;
		}
		
		if(document.getElementById("confirm-password").value == "" ){
			
			alert("confirm-password가 입력되지 않았습니다.");
			
			return;
			
		}
		
		if (m_pwd != document.getElementById("confirm-password").value){
			
			alert("password와 confirm-password가 다릅니다.");
			
			return;
			
		}
		
		f.action = "pwd_change.do";
		f.submit();
			
	}
	function idcheck() {
		
		alert("id 중복 체크를 해주세요.");
		
		return;
	}
    
	</script>

</head>
<body>

    <form class="signup-form" method="POST" enctype="multipart/form-data">

      <!-- form header -->
      <div class="form-header">
        <h1>Password Search</h1>
      </div>

      <!-- form body -->
      <div class="form-body">

        <!-- Email -->
        <div class="form-group">
          <label for="email" class="label-title">Email*</label>
          <input type="email" id="m_email" name="m_email" class="form-input" placeholder="enter your email" required="required">
          <br><input type="button" value="Email search" onclick="search();" class="btn">
        </div>

        <!-- Password and confirm password-->
        <div class="horizontal-group">
          <div class="form-group left">
            <label for="password" class="label-title">Password *</label>
            <input type="password" name="m_pwd" class="form-input" placeholder="enter your password" required="required">
          </div>
          <div class="form-group right">
            <label for="confirm-password" class="label-title">Confirm Password *</label>
            <input type="password" class="form-input" id="confirm-password" placeholder="enter your password again" required="required">
          </div>
        </div>
        </div>
        
      <!-- form-footer -->
      <div class="form-footer">
      	<button onclick="location.href='login_form.do'" class="btn"> log-in page </button>
        <button type="submit" class="btn" onclick="idcheck();" id="create">Create</button>
      </div>
      
    </form>

</body>
</html>