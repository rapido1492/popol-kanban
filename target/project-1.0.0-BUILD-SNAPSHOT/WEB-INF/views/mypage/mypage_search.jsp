<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  	
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 

<script>
function clean(m_idx){
	$('#'+m_idx).empty();
	$('#'+m_idx).remove();
}  
</script>

<div id="${search_vo.m_idx}">
<div  id="g_invite4">
	<input type="hidden" name='invite_idx' value="${search_vo.m_idx}" >
	<div>${search_vo.m_nick} (${search_vo.m_email}) <div id="x_box" onclick="clean('${search_vo.m_idx}');"><i class="far fa-times-circle"></i></div> </div>
</div>
</div>
