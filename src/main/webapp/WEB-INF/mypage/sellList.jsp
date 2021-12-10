<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<link rel="stylesheet" type="text/css" href="/css/mypage_style.css">

<div class="sell-list">
	<div class="inner">
		<div class="sell-list-condition">
			<select id="sell-condi">
				<option value="전체">전체</option>
				<option value="판매중">판매중</option>
				<option value="예약중">예약중</option>
				<option value="판매완료">판매완료</option>
			</select>
		</div>
		
		<div class="myselling-list">
			<table class="table">
				<thead>
					<tr>
						<th>상품이미지</th>
						<th>상품정보</th>
					</tr>
				</thead>
				<tbody class="sell-list-tbody" id="sell-list-tbody">
				</tbody>
			</table>
		
		</div>
		
		<!-- 페이징 넣기 -->
		<c:if test="${totalCount>0}">
			<div class="paging">
				<!-- 이전 -->
				 <c:if test="${startPage>1}">
					<a href="list?currentPage=${startPage-1}" class="prev"><span>이전</span></a>		 
				 </c:if>
				
				<c:forEach var="pp" begin="${startPage}" end="${endPage}">
					<c:if test="${currentPage==pp}">
						<a href="list?currentPage=${pp}" class="active">${pp}</a>
					</c:if>
					<c:if test="${currentPage!=pp}">
						<a href="list?currentPage=${pp}">${pp}</a>
					</c:if>
				</c:forEach>
				
				<!-- 다음 -->
				<c:if test="${endPage<totalPage}">
					<a href="list?currentPage=${endPage+1}" class="next"><span>다음</span></a>
				</c:if>
			</div>
		</c:if>
	</div>
</div>

<script type="text/javascript" src="/js/mypage_script.js">
</script>

<script type="text/javascript">
$(function () {
	 	var getstatus = function(value) {
		var status = '';
		switch (value) {
		case '판매중' : 
			status = '판매중';
			break;
		case '예약중' : 
			status = '예약중';
			break;
		case 'soldout' : 
			status = '판매완료';
			break;
		default:
			name = '전체';  
		break;
		}
		return status;
	} 
	 
	 
	 //출력하는 사용자 함수
		var sellList = function() { 
		  var statusval = $("#sell-condi").val(); 
		  console.log(statusval);
		 $.ajax({
				type: "get",
				dataType: "json",
				url: "getListByStatus",
				data: {"statusval":statusval},
				success:function(data){
						var totalCount = data.totalCount;
						var startPage = data.startPage;
						var endPage = data.endPage;
						var list = data.list;
						var category = data.category;
						var currentPage = data.currentPage;
						
						//alert("hi"+statusval);
						$("#sell-list-tbody").empty();
						
						
						if(list !== null && list.length > 0){
							for (var i = 0; i < list.length; i++){
								var a = list[i];
								var s="";
								s += "<c:forEach var='slist' items='${list}'>";
								s += "<tr>";
								s += "<td>";
								s += "<div class='simage'>";
								s += "<img alt='thumnail' src='../photo/${fn:split(slist.uploadfile,"+"','"+")[0]}'>";
								s += "</div>";
								s += "</td>";
								s += "<td><div class='scategory'>"+a.category+"</div></td>";
								s += "<td><div class='stitle'>"+a.title+"</div></td>";
								s += "<td><div class='sprice'>"+a.price+"</div></td>";
								s += "</tr>";
								s += "</c:forEach>";
								$("#sell-list-tbody").append(s);
							}
						}
					}, error: function (e) {
						console.log("에러",e);
					}
				});
			 }
	 
	 
	 $("#sell-condi").on("click",function(){
		 sellList();
	  });
	 
	 sellList();
});
</script>


















