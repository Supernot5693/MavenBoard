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
		$('#btn').click(function(){
			var name = $('input[name=name]').val();
			var title = $('input[name=title]').val();
			var content = $('input[name=content]').val();
			
			if(name==''){
				alert('이름을 기입하십시오');
				$('input[name=name]').focus();
				return false; //preventDefault();
			}
			if(title==''){
				alert('제목을 기입하십시오');
				$('input[name=title]').focus();
				return false; //preventDefault();
			}
			if(content==''){
				alert('내용을 기입하십시오');
				$('input[name=content]').focus();
				return false; //preventDefault();
			} 
			
			var params = $("#resultDIV").serialize();
			
			$.ajax({
				url: './freeBoardInsertPro.ino',
				type: 'POST',
				data: params,
				success: function (result){
					
					var goToMain;
					console.log(result.result);
					
					
					if(result.result=='true'){
						alert("글쓰기 성공");
						/* result.result = true/false */
						/* result.num = num값이 들어잇다. */
						console.log(result.num);
						console.log(result);
						
						goToMain = confirm("메인으로 돌아가시겠습니까?");
						
						if(goToMain){
							location.href = './main.ino';
							/* location.replace('./main.ino'); */
						} else{
							location.href = './freeBoardDetail.ino?num=' + result.num;
						}
					}else{
						alert("글쓰기 실패");
						location.href = './freeBoardInsert.ino';
					}
				}
			});
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

	<form id="resultDIV" name="resultDIV" onsubmit="return false;"><!-- action="./freeBoardInsertPro.ino" -->

		<table border="1">
			<tbody>
				<tr>
					<td style="width: 150px;" align="center">타입 :</td>
					<td style="width: 400px;">
						<select name="codeType">
							<c:forEach var="codeOne" items="${cType }">
								<option value="${codeOne.CODE }">${codeOne.CODE_NAME }</option>
							</c:forEach> 
						</select>
					</td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">이름 :</td>
					<td style="width: 400px;"><input type="text" name="name"/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">제목 :</td>
					<td style="width: 400px;"><input type="text" name="title"/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">내용 :</td>
					<td style="width: 400px;"><textarea name="content" rows="25" cols="65" ></textarea></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td></td>
					<td align="right">
					<input type="button" id="btn" value="글쓰기"> <!-- submit - ajax로 통신 -->
					<input type="button" value="다시쓰기" onclick="reset()">
					<input type="button" value="취소" onclick="">
					&nbsp;&nbsp;&nbsp;
					</td>
				</tr>
			</tfoot>
		</table>
	</form>


</body>
</html>