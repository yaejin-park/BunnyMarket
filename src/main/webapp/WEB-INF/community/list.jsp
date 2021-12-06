<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<link rel="stylesheet" type="text/css" href="/css/community_style.css">

<div class="commu-wrap">
	<div class="inner">
		<div class="top-div btn-wrap">
		 	<button type="button" class="btn-add" onclick="location.href='insertform'">글쓰기</button>
		</div>
		
		<div class="commu-div">
			<c:if test="${totalCount==0}">
				<div class="nodata">
					<p class="icon">
						<img alt="" src="/image/nodata-icon.png">
					</p>
					<p>등록된 글이 없습니다.</p>
				</div>
			</c:if> 
			
			<c:if test="${totalCount>0}">
				<ul class="cummu-list">
					<c:forEach var="a" items="${commulist}">
					
						<li>
							<a href="detail?idx=${a.idx}&currentPage=${currentPage}&key=list">
								
								<div class="img-div">
								<!-- 이미지 없을경우 -->
									<c:if test="${a.photo=='no'}">
										<img src="../image/co-noimg.jpg">
									</c:if>
									
								<!-- 이미지 있을경우 -->
									<c:if test="${a.photo!='no'}">
										<img src="../photo/${fn:split(a.photo,',')[0]}">
									</c:if>
								</div>
								
								<div class="text-div">
									<p class="tit">${a.title}</p>
									<p class="txt">${a.content}</p>
									<p class="date">
										<fmt:formatDate value="${a.writeday}" pattern="yy.MM.dd"/>
									</p>
								</div>
								
								<div class="reply-heart">
								<!-- 공감수표시 -->
									<div class="gdcount-icon">
										<div class="gd-img">
										<img src="../image/heart-icon.png">
										</div>
										<span class="txt gdcount">${a.goodcount}</span>
									</div>
								<!-- 댓글수표시 -->
									<div class="reply-icon">
										<div class="rec-img">
										<img src="../image/comment-icon.png">
										</div>
										<span class="txt recount">${a.acount}</span>
									</div>
								</div>
							</a>
						</li>
					</c:forEach>
				</ul>
			</c:if>
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

<script type="text/javascript" src="/js/community_script.js">

</script>