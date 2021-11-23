<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" type="text/css" href="/css/community_style.css">
<div class="inner">
	<div class="commu-list">
		<ul>
		<c:forEach var="a" items="${commulist}">
			<li>
				<a href="">
					<div class="image">
						<img src="../photo/${a.photo}">
					</div>
					<div class="text-div">
						<p class="tit">${a.title}</p>
						<p class="txt">${a.content}</p>
						<p class="date">
							21.11.19
						<fmt:formatDate value="${dto.writeday}" pattern="yy.MM.dd"/>
						</p>
					</div>
				</a>
			</li>
		</c:forEach>
		</ul>
	</div>
	<div class="paging">
		12345 > <!-- 페이지 별로 넘길수있는 링크태그(a태그) -->
	</div>
</div>
	
