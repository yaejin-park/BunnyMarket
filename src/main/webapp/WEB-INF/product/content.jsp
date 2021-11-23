<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" type="text/css" href="/css/product_style.css">
<div class="inner">
<div class="infoAll">
	<div class="img group">
		<div class="bigImgDiv">
			<img class="bigImg" alt="thumbnail" src="../photo/${photo[0]}">
		</div>
		<div class="smImgDiv">
			<c:forEach items="${photo}" var="photo">
				<div class="smImg child">
					<img alt="smallImage" src="../photo/${photo}" class="smImg">
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
			<td>
				후기
			</td>
		</tr>
		<tr>
			<td colspan="3">카테고리 | 시간</td>
		<tr>
		<tr>
			<!-- 작성자가 아닐 경우-->
			<c:if test="false">
				<td>
					예약중
				</td>
			</c:if>
			<c:if test="true">
				<td>
					<select>
						<option>판매중</option>
						<option>예약중</option>
						<option>거래완료</option>
					</select>
				</td>
			</c:if>
			<td colspan="2">
				${dto.title}
			</td>
		</tr>
		<tr>
			<td colspan="3">
				${dto.price}
			</td>
		</tr>
		<tr>
			<td colspan="3">
			대화 찜 조회수
			</td>
		</tr>
		<tr>
			<td>
			찜
			</td>
			<!-- 작성자가 아니면 -->
			<c:if test="false">
				<td colspan="2">
					<button class="btn-add">채팅하기</button>
				</td>
			</c:if>
			<!-- 작성자면 -->
			<c:if test="true">
				<td colspan="2" class="detailBtn">
					<button class="btn-update">수정</button>
					<button class="btn-delete">삭제</button>
				</td>
			</c:if>
		</tr>
	</table>
</div>
	<div class="detailContentDiv">
		<textarea class="detailContent">${dto.content }</textarea>
	</div>
	<br><br>
	<hr>
	
	<div class="relative">
		<div class="tit child">연관상품</div>
		<div class="child">더보기></div>
	</div>
</div>