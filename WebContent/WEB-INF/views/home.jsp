<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<script type="text/javascript" src="<%=application.getContextPath()%>/resources/js/jquery-3.4.1.min.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=application.getContextPath()%>/resources/bootstrap-4.3.1-dist/css/bootstrap.min.css">
	<script type="text/javascript" src="<%=application.getContextPath()%>/resources/bootstrap-4.3.1-dist/js/bootstrap.bundle.min.js"></script>
	<style>
	.content {
			padding : 20px 100px;
		}
	</style>
	<script type="text/javascript">
		// [추가] 버튼을 눌렀을 때 자동으로 입력 폼을 확인하는 function입니다.	
		// 해당 function의 return 값이 true이면, 데이터베이스에 해당 항목을 추가합니다.
		function checkForm() {
			var result = true;
			
			// 모든 에러 span의 내용을 초기화합니다.
			$(".error"). text("");
			
			// 모든 form에 내용을 입력했는지 검사합니다.
			if($("#priority").val() == "") {
				$("#priorityError").text("* 중요도를 입력하세요.");
				result = false;
			}
			if($("#content").val() == "") {
				$("#contentError").text("* 추가할 항목의 내용을 입력하세요.");
				result = false;
			}
			if($("#requested_date").val() == "") {
				$("#dateError").text("* 마감 날짜를 입력하세요.");
				result = false;
			}	
			// 채우지 않은 입력 form이 있다면, submit을 처리하지 않습니다.
			return result;	
		}	
		
		// [삭제] 버튼을 눌렀을 때 실행하는 function입니다. 
		// 해당 항목을 데이터베이스에서 삭제합니다.
		function deleteItem(no) {
			$.ajax({
				url: 'deleteItem',
				data: {"no": no},
				success: function(data) {
					if(data.result == true) {
						alert("항목을 삭제합니다.");   
						location.href = "http://" + location.host + "/TodoList";
					}
				},
				error: function() {
					alert("오류가 발생했습니다.");
				}
			});	
		}
		
		// [완료] 혹은 [미완료] 버튼을 눌렀을 때 실행하는 function입니다.	
		// 매개 변수에 따라 할 일 항목의 status를 'Y' 혹은 'N'으로 변경하여 데이터베이스에 저장합니다.
		function changeStatus(no, status) {
			$.ajax({
				url: 'changeStatus',
				data: {"no": no, "status": status},
				success: function(data) {
					if(data.result == true) {
						alert("할 일의 상태를 변경합니다.");   
						location.href = "http://" + location.host + "/TodoList";
					}
				},
				error: function() {
					alert("오류가 발생했습니다.");
				}
			});	
		}
	
	</script>
	<title>나의 Todo List</title>
</head>
<body>
	<div class="content"> 
	<h1>나의 Todo List</h1>	
	<hr style="width: 100%">
	
	<div id="add">
		<h4> 할 일 추가하기</h4>
		<form method="post" action="addItem" onsubmit="return checkForm()">
			<div class="form-group row">
			  <label for="priorityInput" class="col-sm-2 col-form-label" >중요도</label>
			  <div class="col-sm-10">
			    <input type="number" class="form-control" id="priority" name="priority">
			     <span id="priorityError" class="error" style="color:red"></span>
			  </div>
			 </div>
			<div class="form-group row">
			  <label for="contentInput" class="col-sm-2 col-form-label" >내용</label>
			  <div class="col-sm-10">
			    <input type="text" class="form-control" id="content" name="content">
			     <span id="contentError" class="error" style="color:red"></span>
			  </div>
			</div>
			<div class="form-group row">
			  <label for="dateInput" class="col-sm-2 col-form-label">마감 날짜</label>
			  <div class="col-sm-10">
			    <input type="date" class="form-control" id="requested_date" name="requested_date">
			    <span id="dateError" class="error" style="color:red"></span>
			  </div>
			</div>
			<div class="form-group" style="float: right">
			  	<input id="addBtn" type="submit" class="btn btn-outline-success" value="추가"/>
			</div>
		</form>	
	</div>
	
	<br>
	<hr style="width: 100%; margin-top: 50px; margin-bottom: 20px;">
	
	<div id="todoList">
		<h4> 할 일 목록</h4>
		<table style="margin: auto; text-align:center;" class="table table-sm">
		  <thead>
		    <tr style="background-color: #dcdcdc">
		      <th scope="col">번호</th>
		      <th scope="col">중요도</th>
		      <th scope="col">내용</th>
		      <th scope="col">마감 날짜</th>
		      <th scope="col">수정</th>
		      <th scope="col">삭제</th>
		    </tr>
		  </thead>
		  <tbody>
		  	<c:forEach items="${todoList}" var="item">
				<tr>
			      <td style="vertical-align:middle; width: auto;">${item.no}</td>		
			      <td style="vertical-align:middle; width: auto;">${item.priority}</td>	
			      <td style="vertical-align:middle; width: auto;">${item.content}</td>	
			      <td style="vertical-align:middle; width: auto;">${item.requested_date}</td>	
			      <td><button id="delete" onclick="changeStatus(${item.no}, 'Y')" type="button" class="btn btn-outline-info">완료</button></td>
			   	  <td><button id="delete" onclick="deleteItem(${item.no})" type="button" class="btn btn-outline-danger">삭제</button></td>
			   </tr>
			</c:forEach>
		  </tbody>
		</table>
	</div>
	
	<br>
	<hr style="width: 100%; margin-top: 50px; margin-bottom: 20px;">
	
	<div id="doneList">
		<h4> 완료한 일 목록</h4>
		<table style="margin: auto; text-align:center;" class="table table-sm">
		  <thead>
		    <tr style="background-color: #dcdcdc">
		      <th scope="col">번호</th>
		      <th scope="col">중요도</th>
		      <th scope="col">내용</th>
		      <th scope="col">마감 날짜</th>
		      <th scope="col">수정</th>
		      <th scope="col">삭제</th>
		    </tr>
		  </thead>
		  <tbody>
		  	<c:forEach items="${doneList}" var="item">
				<tr>
			      <td style="vertical-align:middle; width: auto;">${item.no}</td>		
			      <td style="vertical-align:middle; width: auto;">${item.priority}</td>	
			      <td style="vertical-align:middle; width: auto;">${item.content}</td>	
			      <td style="vertical-align:middle; width: auto;">${item.requested_date}</td>
			      <td><button id="delete" onclick="changeStatus(${item.no}, 'N')" type="button" class="btn btn-outline-info">미완료</button></td>	
			   	  <td><button id="delete" onclick="deleteItem(${item.no})" type="button" class="btn btn-outline-danger">삭제</button></td>
			   </tr>
			</c:forEach>
		  </tbody>
		</table>
	</div>
	</div>
</body>
</html>