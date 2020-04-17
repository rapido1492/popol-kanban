<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/signup/signup.css">
<meta charset="UTF-8">
<title>Insert title here</title>

	<script type="text/javascript">
    var rangeLabel = document.getElementById("range-label");
    var experience = document.getElementById("experience");

    function change() {
    rangeLabel.innerText = experience.value + "K";
    }

    function send(f){
    	
    	var m_idx = f.m_idx.value;
    	var m_nick = f.m_nick.value;
    	var m_name = f.m_name.value;
    	var m_email = f.m_email.value;
    	var m_pwd = f.m_pwd.value;
    	var m_phone = f.m_phone.value;
    	var photo = f.photo.value;
    	
    	var m_nick = f.m_nick.value;
    	var m_name = f.m_name.value;
    	var m_email = f.m_email.value;
    	var m_pwd = f.m_pwd.value;
    	var m_phone = f.m_phone.value;
    	var photo = f.photo.value;
    	
    	var test_name =	/^[ㄱ-ㅎ|가-힣|a-z|A-Z|\*]+$/
    	var test_email = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		var test_pwd = /^(?=.*[a-zA-Z])(?=.*[0-9]).{6,12}/;
		var test_phone = /^[0-9]+$/;
    	
		if(m_nick ==""){
			alert("닉네임을 입력해주세요.");
			return;
		}
		if(m_name ==""){
			alert("이름을 입력해주세요.");
			return;
		}
		if(test_name.test(m_name) == false){
			alert("이름은 영문이나 한글로 입력해주세요.")
			return;
		}
		
		if (m_email == ""){
			alert("E-mail이 입력되지 않았습니다. 입력 부탁드립니다.");
			return;
		}
		
		if(test_email.test(m_email) == false ){
			alert("E-mail이 비 정상적으로 입력 되었습니다.");
			return;
		}
		
		if (m_pwd == ""){
			alert("pwd가 입력되지 않았습니다. 입력 부탁드립니다.");
			return;
		}
		
		if(test_pwd.test(m_pwd) == false ){
			alert("pwd는 6 ~ 12자리의 영문, 숫자를 반드시 포함하여 만들어주세요.");
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
		if(test_phone.test(m_phone) == false){
			alert("전화번호는 숫자만 입력 부탁드립니다.");
			return;
		}
    	
    	alert(m_idx +m_nick + m_name + m_email + m_pwd + m_phone + photo);
    	
    	f.action = "signchange.do";
    	f.submit();
    	
    }
    
	function emailcheck(){
		
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
		
		alert(m_email);
		
		sendRequest(url, param, resultFn, "get");
		
	}//emailcheck
	
	function resultFn(){

		if( xhr.readyState == 4 && xhr.status == 200 ){
			
			var data = xhr.responseText;
			
			alert(data);
			
			if( data == "yes"){
				
				alert("해당 e-mail이 있습니다. 다른 e-mail을 사용 부탁드립니다.");
				
				return;
				
			}
				
			alert("해당 email은 사용 가능 합니다.");
			
			document.getElementById("create").setAttribute("onClick", "send(form);")
			
		}
		
	}//resultFn()
	
	function idcheck() {
		
		alert("이메일 중복 체크를 해주세요");
		
		return;
		
	}
	</script>

</head>
<body>

    <form class="signup-form" method="POST" enctype="multipart/form-data">

	<input type="hidden" name="m_idx" value="${ vo.m_idx }" >
      <!-- form header -->
      <div class="form-header">
        <h1>Account Change</h1>
      </div>

      <!-- form body -->
      <div class="form-body">

        <!-- nickname and fullname -->
        <div class="horizontal-group">
          <div class="form-group left">
            <label for="firstname" class="label-title">Nick name *</label>
            <input type="text" name="m_nick" class="form-input" placeholder="enter your Nick name" required="required" value="${vo.m_nick }" />
          </div>
          <div class="form-group right">
            <label for="lastname" class="label-title">Full name</label>
            <input type="text" name="m_name" class="form-input" placeholder="enter your full name" value="${vo.m_name }"/>
          </div>
        </div>

        <!-- Email -->
        <div class="form-group">
          <label for="email" class="label-title">Email*</label>
          <input type="email" name="m_email" class="form-input" placeholder="enter your email" required="required" value="${vo.m_email }">
          <input type="button" value="Email 중복 확인" onclick="emailcheck();">
        </div>

        <!-- Password and confirm password-->
        <div class="horizontal-group">
          <div class="form-group left">
            <label for="password" class="label-title">Password *</label>
            <input type="password" name="m_pwd" class="form-input" placeholder="enter your password" required="required" value="${vo.m_pwd }">
          </div>
          <div class="form-group right">
            <label for="confirm-password" class="label-title">Confirm Password *</label>
            <input type="password" class="form-input" id="confirm-password" placeholder="enter your password again" required="required" value="${vo.m_pwd }">
          </div>
        </div>
        
        <!-- phone number-->
        <div class="horizontal-group">
          <div class="form-group left">
            <label for="phone" class="label-title">Phone</label>
            <input type="text" name="m_phone" class="form-input" placeholder="enter your Phone number" required="required" value="${vo.m_phone }">
          </div>
           <div class="form-group left" >
            <label for="choose-file" class="label-title">Upload Profile Picture</label>
            <input type="file" name="photo" id="choose-file" size="80">
          </div>
          
        </div>
      <!-- form-footer -->
      <div class="form-footer">
        <span>* required</span>
        <button type="submit" class="btn" onclick="idcheck();">Create</button>
      </div>
      </div>
    </form>

</body>
</html>