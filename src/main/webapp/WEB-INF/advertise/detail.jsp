<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" type="text/css" href="/css/product_style.css">
<div class="inner">
<div class="infoAll">
	<div class="img group">
		<div class="bigImgDiv">
			<c:if test="${dto.photo=='no'}">
				<img class="bigImg" alt="thumbnail" src="/image/list-noimg.gif">
			</c:if>
			<c:if test="${dto.photo!='no'}">
				<img class="bigImg" alt="thumbnail" src="../photo/${dbimg[0]}">
			</c:if>
		</div>
		<div class="smImgDiv">
			<c:forEach items="${dbimg}" var="dbimg">			
				<div class="smImg child">
					<c:if test="${dto.photo=='no'}">
						<img alt="smallImage" src="/image/list-noimg.gif" class="smImg">
					</c:if>
					<c:if test="${dto.photo!='no'}">
						<img alt="smallImage" src="../photo/${dbimg}" class="smImg">
					</c:if>
				</div>
			</c:forEach>
		</div>
	</div>
	
	<table class="info table table-default">
		<tr>
			<td rowspan="2" class="profile">
				<img alt="profile" src="/image/profile-icon.png" class="profileImg">	
			</td>
			<td class="nick tit">
				닉네임
			</td>
			<td rowspan="2" class="detailBtn">
				<button class="btn-list btn-sm" id="follow">팔로우</button>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				${dto.title}
			</td>
		</tr>
		<tr>
			<td colspan="3">
				찜 <p>조회수${dto.readcount}</p>
			</td>
		</tr>
		<tr>
			<td>
			찜
			</td>
			<!-- 작성자면 -->
			<c:if test="true">
				<td colspan="2" class="detailBtn">
					<button class="btn-update">수정</button>
					<button class="btn-delete"
						onclick="location.href='delete?idx=${dto.idx}&currentPage=${currentPage}'">삭제</button>
				</td>
			</c:if>
		</tr>
	</table>
</div>
	<div class="detailContentDiv">
		<textarea class="detailContent">${dto.content}</textarea>
	</div>
</div>