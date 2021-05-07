<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script>
	$(document).ready(function(){
		$("#modify").click(function(){
			
			var title = $('input[name=title]').val();
			var content = $('input[name=content]').val();
			
			if(title==''){
				alert('제목을 기입하십시오');
				$('input[name=title]').focus();
				return false;
			}else if(content==''){
				alert('내용을 기입하십시오');
				$('input[name=content]').focus();
				
			}else{
				var params = $("#insertForm").serialize();
				
				$.ajax({
					url: './freeBoardModify.ino',
					type: 'POST',
					data: params,
					success: function(result){
						
						if(result.result=='true'){
							alert("수정 성공");
							location.href = './main.ino';
							
							goToMain = confirm("메인으로 돌아가시겠습니까?");
							
							if(goToMain){
								location.href = './main.ino';
							}else{
								location.href = './freeBoardDetail.ino?num=' + result.num;
							}
							
						}else{
							alert("수정 실패");
							location.href = './freeBoardDetail.ino?num=' + result.num;
						}
					}
				});
			}
		});
		
		$("#delete").click(function(){
			
			goToDelete = confirm("정말 삭제하시겠습니까?");
			
			if(goToDelete){
				
				var params = $("#insertForm").serialize();
				
				$.ajax({
					url: './freeBoardDelete.ino',
					type: 'POST',
					data: params,
					success: function(result){
						
						console.log(result.result);
						
						if(result.result=='true'){
							alert("삭제 성공");
							location.href = './main.ino';
						}else{
							alert("삭제 실패");
							location.href = './freeBoardDetail.ino?num=' + result.num;
						}
					}
				});
			}else{
				location.reload();
			}
		});
	});
	
	

</script>
</head>
<body>

	<div>
		<h1>자유게시판</h1>
	</div>
	<div style="width:650px;" align="right">
		<a href="./main.ino">리스트로</a>
	</div>
	<hr style="width: 600px">

	<form name="insertForm" id="insertForm">
		<input type="hidden" name="num" value="${freeBoardDto.num }" />
		<table border="1">
			<tbody>
				<tr>
					<td style="width: 150px;" align="center">타입 :</td>
					<td style="width: 400px;">
						<select id="codeType" name="codeType" >
							<c:forEach var="codeOne" items="${cType }">
								<option value="${codeOne.CODE }"<c:if test="${freeBoardDto.codeType==codeOne.CODE}">selected</c:if>>${codeOne.CODE_NAME}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">이름 :</td>
					<td style="width: 400px;"><input type="text" name="name" value="${freeBoardDto.name }" readonly/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">제목 :</td>
					<td style="width: 400px;"><input type="text" name="title"  value="${freeBoardDto.title }"/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">내용 :</td>
					<td style="width: 400px;"><textarea name="content" rows="25" cols="65"  >${freeBoardDto.content }</textarea></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td></td>
					<td align="right">
					<input type="button" id="modify" value="수정">
					<input type="button" id="delete" value="삭제" >
					<input type="button" value="취소" onclick="location.href='./main.ino'">
					&nbsp;&nbsp;&nbsp;
					</td>
				</tr>
			</tfoot>
		</table>

	</form>


<%-- 	<input type="hidden" name="num" value="${freeBoardDto.num }" />

		<div style="width: 150px; float: left;">이름 :</div>
		<div style="width: 500px; float: left;" align="left"><input type="text" name="name" value="${freeBoardDto.name }" readonly/></div>

		<div style="width: 150px; float: left;">제목 :</div>
		<div style="width: 500px; float: left;" align="left"><input type="text" name="title"  value="${freeBoardDto.title }"/></div>

		<div style="width: 150px; float: left;">작성날자</div>
		<div style="width: 500px; float: left;" align="left"><input type="text" name="regdate"  value="${freeBoardDto.regdate }"/></div>

		<div style="width: 150px; float: left;">내용 :</div>
		<div style="width: 500px; float: left;" align="left"><textarea name="content" rows="25" cols="65"  >${freeBoardDto.content }</textarea></div>
		<div align="right">
		<input type="button" value="수정" onclick="modify()">
		<input type="button" value="삭제" onclick="location.href='./freeBoardDelete.ino?num=${freeBoardDto.num }'">

		<input type="button" value="취소" onclick="location.href='./main.ino'">
		&nbsp;&nbsp;&nbsp;
		</div> --%>

</body>
</html>