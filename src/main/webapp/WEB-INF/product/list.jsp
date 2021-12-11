<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet" type="text/css" href="/css/product_style.css">
<c:set var="catAll">디지털기기,의류,뷰티,인테리어,스포츠,문화생활,기타</c:set>

<div class="inner">
	<div class="all">
		<div class="group category-div">
			<a class="category ${category == '전체'? 'active' : ''}" href="list?currentPage=${currentPage}&category=전체">전체 ></a>
			<c:forTokens items="${catAll}" delims="," var="cat">
				<a class="category ${cat == category? 'active' : ''}" href="list?currentPage=${currentPage}&category=${cat}">${cat}</a>
			</c:forTokens>
		</div>
	<div class="btn-wrap write-btn-div">
		<button type="button" class="btn-add" onclick="location.href='/product/auth/insertForm'">글쓰기</button>
	</div>
	<c:if test="${list.size()==0}">
		<div class="nodata">
			<p class="icon">
				<img alt="" src="/image/nodata-icon.png">
			</p>
			<p>등록된 데이터가 존재하지 않습니다.</p>
		</div>
	</c:if>
	<c:if test="${list.size()!=0}">
		<div class="group">
			<c:forEach items="${list}" var="one">
				<c:set var="thumbName" value="${fn:split(one.uploadfile,',')[0]}" />
				<div class="oneList child" onclick="location.href='detail?idx=${one.idx}&currentPage=${currentPage}&key=list'">
					<div class="thumbnailDiv">
						<img alt="thumbnail" src="../photo/${thumbName}"class="thumbnail">
					</div>
					<div class="info-div">
						<div class="shortTit">${one.title}</div>
						<div>
							<div class="tit">
								<fmt:formatNumber type="number" value="${one.price}"/>원
							</div>
							<div class="list-info-sm">   
								<div class="list-info-sm-div">
									<div class="chat list-icon-sm">${one.chatcount}</div>
								</div>
								<div class="list-info-sm-div">
									<div class="dibs icon-sm">${one.likecount}</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</c:if>
	
	<!-- 페이징 -->
	<div>
		<div class="paging">
			<c:if test="${startPage>1}">
				<a href="list?currentPage=${startPage-1}" class="prev"><span>이전</span></a>
			</c:if>
			<c:forEach var="i" begin="${startPage}" end="${endPage}" >
				<a href="list?currentPage=${i}"  ${currentPage == i ? 'class="active"' : ''} >${i}</a>
			</c:forEach>
			
			<c:if test="${endPage<totalPage}">
				<a href="list?currentPage=${endPage+1}" class="next"><span>다음</span></a>
			</c:if>
		</div>
		</div>
	</div>
</div>
<input type="hidden" id="categoryActive" value="${category}">
<input type="hidden" name="local" id="local" value="">
<script>
//지역설정
$("#local").val($(".local-btn").text());
$(document).ready(function () {

//검색창
$("input[name='search']").change(function() {
	var keyword = $(this).val();
	var category = $("#categoryActive").val();
	var location = $("#local").val();
	
	/* $.ajax({
		type: "get",
		url: "list",
		data: {"keyword" : keyword, "category" : category, "location" : location},
		success: function(){
			console.log(keyword, category, location);
		}, error: function(e){
			console.log(e, "e");
		}
	}); */
	
	window.location.href = "/product/list?keyword="+keyword+"&category="+category+"&location="+location;
});


});
</script>
