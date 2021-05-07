<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script>
	
	$(document).ready(function(){
		
		$("#searchKey").on('change',function(){
			
			$("input").remove("#searchValue");
			$("select").remove("#searchValue");	
			$("input").remove("#searchValue1");
			$("b").remove();		
			
			if($(this).val()=="0"){
				$("#type select").after('<input type="text" id="searchValue" name="searchValue" value="" placeholder="검색어를 입력하세요">')   
			}else if($(this).val()=="1"){
				$("#type select").after("<select id='searchValue' name='searchValue'>" +
						"<option value='01'>자유</option>" +
						"<option value='02'>익명</option>" +
						"<option value='03'>QnA</option>" +
						"</select>")
			}else if($(this).val()=="2"||$(this).val()=="3"||$(this).val()=="4"){
				$("#type select").after('<input type="text" id="searchValue" name="searchValue" value="" placeholder="검색어를 입력하세요">') 
			}else if($(this).val()=="5"){
				$("#type select").after('<input type="text" id="searchValue" name="searchValue" value="" placeholder="숫자만 입력 가능합니다">')
			}else{
				$("#type select").after('<input type="text" id="searchValue" name="searchValue" value="" placeholder="시작 날짜 입력"> <b>~</b> ' + 
										'<input type="text" id="searchValue1" name="searchValue1" value="" placeholder="마지막 날짜 입력">')
			}
		});
		
		$("#checkAll").click(function(){
			if($("input:checkbox[id='checkAll']").prop("checked")){
				$("input[name=check]").prop("checked",true);
			}else{
				$("input[name=check]").prop("checked",false)
			}
		});
		
		$("#checkDel").click(function(){
			var checkArr = [];
			
			$('input[name=check]:checked').each(function(){
				checkArr.push($(this).val());
			});
			console.log(checkArr);
			
			if(checkArr.length == 0){
		        alert("삭제할 게시물을 선택하세요.");
		        return false;
		    }else{
		    	$.ajax({
					url: './freeBoardCheckDelete.ino',
					type: 'POST',
					datatype: 'json',
					data: {checkArr:checkArr},
					success: function(result){
						checkArr= new Array();
						
						console.log(result.result);
						if(result.result=='true'){
							alert("삭제 성공");
							location.href = './main.ino';
						}else{
							alert("삭제 실패");
							location.href = './main.ino';
						}
					}
				});
		    }
		});
	});
	
	function ajaxData(pageNum){
		
		if(type=="5"){
			if(!$.isNumeric($("#searchValue").val())){
				alert("숫자만 입력 가능합니다");
				return false;
			}
		}
		
		if(type=="6"){
			if(!$.isNumeric($("#searchValue").val())&&!$.isNumeric($("#searchValue1").val())){
				alert("숫자만 입력 가능합니다");
				return false;
			}
		}
		
		var data = {};
		data["searchKey"] = $("#searchKey").val();
		data["searchValue"] = $("#searchValue").val();
		data["searchValue1"] = $("#searchValue1").val();
		
		if(pageNum==null){
			pageNum = 1;
		}
		
		data["pageNum"] = pageNum;
		
		$.ajax({
			url: './freeBoardSearch.ino',
			type: 'POST',
			data: data,
			success: function(result){
				console.log(result);
				console.log(result.list);
				$("tbody").remove();
			
				var view = '<tbody id="tb" name="tb">';
				$.each(result.list, function(index, list){
					
					view += '<tr>';
					view += '<td><input type="checkbox" id="check" name="check" value="'+ (list.NUM) +'"></td>'
					view += '<td style="width: 55px; padding-left: 30px;" align="center">'+ (list.CODETYPE || '') +'</td>';
					view += '<td style="width: 50px; padding-left: 10px;" align="center">'+ (list.NUM || '') +'</td>';
					view += '<td style="width: 125px; align="center"><a href="./freeBoardDetail.ino?num='+ (list.NUM || '') +'">'+ (list.TITLE || '') +'</a></td>';
					view += '<td style="width: 48px; padding-left: 50px;" align="center">'+ (list.NAME || '') +'</td>';
					view += '<td style="width: 100px; padding-left: 95px;" align="center">'+ (list.REGDATE || '') +'</td>';
					view += '</tr>'
					
				});
				view += '<tr><td><input type="button" id="checkDel" name="checkDel" value="삭제"></td>';
				view += '<td align="center" colspan="5">';
				
				
				// 이전 다음 a태그 생성 및 함수생성
				
				for(var i=1;i<=result.totalPage;i++){
					if(i == result.currentPage){
						view+="<font color='Fuchsia'>" + i + "</font> ";
					}else{
						view+="<a href='#' id='page' name='page' onclick='ajaxData("+ i +");'>"+ i + "</a> ";
					}
				}
				
				/* view += result.sb + '</td></tr>'; */
				view += '</td></tr>';
				view += '</tbody>';
				$("#tab").append(view);
			}
		});
	}
	
</script>
</head>
<body>
<form id="mainForm"  onsubmit="return false;">
	<div>
		<h1>자유게시판</h1>
		<input type="hidden" id="pageNum" name="pageNum" value=""/>
	</div>
	<div style="margin-left: 180px;" align="left" id="type" >
		<select id="searchKey" name="searchKey">
			<option value="0">전체</option>
			<c:forEach var="codeOne" items="${sType }" >
				<option value="${codeOne.CODE }">${codeOne.CODE_NAME }</option>	<!-- selectBox -->
			</c:forEach>
		</select>
		<input type="text" id="searchValue" name="searchValue" value="" placeholder="검색어를 입력하세요">
		<!-- <input> -<input> -->
		<input id="searchBtn" name="searchBtn" type="button" value="검색" onclick="ajaxData(1);">
	</div>
	<div style="width:650px;" align="right">
		<a href="./freeBoardInsert.ino">글쓰기</a>
	</div>
	<hr style="width: 600px;">
	<div style="padding-bottom: 10px;">
		<table border="1">
			<thead>
				<tr>
					<td><input type="checkbox" id="checkAll" name="checkAll" value=""/></td>
					<td style="width: 55px; padding-left: 30px;" align="center">타입</td>
					<td style="width: 50px; padding-left: 10px;" align="center">글번호</td>
					<td style="width: 125px;" align="center">글제목</td>
					<td style="width: 48px; padding-left: 50px;" align="center">글쓴이</td>
					<td style="width: 100px; padding-left: 95px;" align="center">작성일시</td>
				</tr>
			</thead>
		</table>
	</div>
	<hr style="width: 600px;">

	<div>
		<table border="1" id="tab" >
			<tbody id="" name="tb">
					<c:forEach var="dto" items="${freeBoardList }">
						<tr id="select" name="select">
							<td><input type="checkbox" id="check" name="check" value="${dto.NUM }"></td>
							<td style="width: 55px; padding-left: 30px;" align="center">${dto.CODETYPE }</td>
							<td style="width: 50px; padding-left: 10px;" align="center">${dto.NUM }</td>
							<td style="width: 125px; align="center"><a href="./freeBoardDetail.ino?num=${dto.NUM }">${dto.TITLE }</a></td>
							<td style="width: 48px; padding-left: 50px;" align="center">${dto.NAME }</td>
							<td style="width: 100px; padding-left: 95px;" align="center">${dto.REGDATE }</td>
						<tr>
					</c:forEach>
					<tr>
						<td><input type="button" id="checkDel" name="checkDel" value="삭제"></td>
						<td align="center" colspan="5">
							<font color='Fuchsia'>1</font>&nbsp;
							<c:forEach var="i" begin="2" end="${totalPage }">
								<a href='#' id='page' name='page' onclick='ajaxData(${i});'>${i}</a>&nbsp;
							</c:forEach>
						</td>
					</tr>
			</tbody>
		</table>
	</div>
</form>
</body>
</html>