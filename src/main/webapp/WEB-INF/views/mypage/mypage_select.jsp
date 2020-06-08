<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  	
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
				<c:if test="${empty p_list}">
					<div class='newsfeed_articlecontainer__article' id="no_pj">
						<div class='article_title' onclick="location.href='board.do?pj_idx=${pj_vo.pj_idx}'">
					 		<h1> 참여한 프로젝트가 없습니다.</h1>
							<h1> 밑에 버튼을 눌러 프로젝트를 생성해주세요.</h1>
						</div>
					</div>
				</c:if>


				<c:forEach var="pj_vo" items="${p_list}">
					<c:set var="now" value="now"/>
					<c:set var="past" value="past"/>
					<div class='newsfeed_articlecontainer__article' >
					
						<!-- 프로젝트 수정/삭제/탈퇴 -->
						<div class="btn-group" id="pj_option">
							<div id="pj_option" data-toggle="dropdown">
								<i class="fas fa-ellipsis-v i-r b"></i>
							</div>
							<ul class="dropdown-menu" id="pj_option_menu">
								<li onclick="pj_group_invite('${pj_vo.pj_leader }','${pj_vo.pj_idx }');"data-toggle="modal" data-target="#myModal4">그룹초대</li>							
								<li onclick="pj_group_update('${pj_vo.pj_leader }','${pj_vo.pj_idx }');" data-toggle="modal" data-target="#myModal3">그룹수정</li>
								<li onclick="pj_update_form('${pj_vo.pj_leader }','${pj_vo.pj_idx }','${pj_vo.pj_name}','${pj_vo.pj_sdate}','${pj_vo.pj_ddate}','${pj_vo.pj_contents}');" data-toggle="modal" data-target="#myModal2">수정</li>
								<li onclick="pj_delete('${pj_vo.pj_idx}', '${pj_vo.pj_leader}');">삭제</li>
								<li onclick="pj_out('${pj_vo.pj_idx}', '${pj_vo.pj_leader}', '${m_inf.m_idx}');">탈퇴</li>
							</ul>
						</div>
							
						<c:choose>
							<c:when test="${pj_vo.pj_progress eq now}">
								<div class='d_date'>
									<p>D-${pj_vo.pj_dday}</p>
								</div>
							</c:when>
							<c:otherwise>
								<div class='d_date'>
									<p>Past Project</p>
								</div>
							</c:otherwise> 
						</c:choose>
						<div class='article_title' onclick="location.href='board.do?pj_idx=${pj_vo.pj_idx}'">
							<h1>${pj_vo.pj_name} / <span>${pj_vo.pj_leader}</span>
							</h1>
						</div>


						<div class='start_date'>
							<p>Start Date : ${pj_vo.pj_sdate}</p>
						</div>
						<div class='due_date'>
							<p>
								Due<span>l</span> Date : ${pj_vo.pj_ddate}
							</p>
						</div>

						<div class='article_content'>
							<p>${pj_vo.pj_contents }</p>
						</div>

					</div>


				</c:forEach>				
				<div class='newsfeed_articlecontainer__article' id="plus_project">
					<button class="color-d circule" id="plus" data-toggle="modal"
						data-target="#myModal">
						<i class="fas fa-plus "></i>
					</button>
				</div>
				
				
			
				
</body>
</html>