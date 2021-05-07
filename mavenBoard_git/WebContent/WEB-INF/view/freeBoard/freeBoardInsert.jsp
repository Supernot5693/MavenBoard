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
				alert('�̸��� �����Ͻʽÿ�');
				$('input[name=name]').focus();
				return false; //preventDefault();
			}
			if(title==''){
				alert('������ �����Ͻʽÿ�');
				$('input[name=title]').focus();
				return false; //preventDefault();
			}
			if(content==''){
				alert('������ �����Ͻʽÿ�');
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
						alert("�۾��� ����");
						/* result.result = true/false */
						/* result.num = num���� ����մ�. */
						console.log(result.num);
						console.log(result);
						
						goToMain = confirm("�������� ���ư��ðڽ��ϱ�?");
						
						if(goToMain){
							location.href = './main.ino';
							/* location.replace('./main.ino'); */
						} else{
							location.href = './freeBoardDetail.ino?num=' + result.num;
						}
					}else{
						alert("�۾��� ����");
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
		<h1>�����Խ���</h1>
	</div>
	<div style="width:650px;" align="right">
		<a href="./main.ino">����Ʈ��</a>
	</div>
	<hr style="width: 600px">

	<form id="resultDIV" name="resultDIV" onsubmit="return false;"><!-- action="./freeBoardInsertPro.ino" -->

		<table border="1">
			<tbody>
				<tr>
					<td style="width: 150px;" align="center">Ÿ�� :</td>
					<td style="width: 400px;">
						<select name="codeType">
							<c:forEach var="codeOne" items="${cType }">
								<option value="${codeOne.CODE }">${codeOne.CODE_NAME }</option>
							</c:forEach> 
						</select>
					</td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">�̸� :</td>
					<td style="width: 400px;"><input type="text" name="name"/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">���� :</td>
					<td style="width: 400px;"><input type="text" name="title"/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">���� :</td>
					<td style="width: 400px;"><textarea name="content" rows="25" cols="65" ></textarea></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td></td>
					<td align="right">
					<input type="button" id="btn" value="�۾���"> <!-- submit - ajax�� ��� -->
					<input type="button" value="�ٽþ���" onclick="reset()">
					<input type="button" value="���" onclick="">
					&nbsp;&nbsp;&nbsp;
					</td>
				</tr>
			</tfoot>
		</table>
	</form>


</body>
</html>