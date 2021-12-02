<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<link rel="stylesheet" type="text/css" href="/css/faq_style.css">
<div class="faq-div">
	<div class="inner">
		<select id="faq-category">
			<option value="all">전체</option>
			<option value="order">주문관련</option> 
			<option value="cancle">교환/반품</option>
			<option value="delivery">배송관련</option>
		</select>
		<table class="table">
			<thead>
				<tr>
					<th class="num">no</th>
					<th class="category">카테고리</th>
					<th class="question">질문</th>
					<th class="bin"></th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${totalCount>0}">
					<c:forEach var="a" items="${list}">
						<tr>
							<td>${a.idx}</td>
							<td>${a.category}</td>
							<td>${a.question}</td>
							<td>
								<button type="button" class="btn-update btn-sm" onclick="location.href='updateform'">수정하기</button> 
								<button type="button" class="btn-delete btn-sm">삭제하기</button>
								<button type="button" class="arrow1" data-idx="${a.idx}"></button>
							</td>
						</tr>
						<tr class="answer" id="answer-${a.idx}">
							<td  colspan="3">${a.answer}</td>
						</tr>
					</c:forEach>
				</c:if>
			</tbody>
		</table>
	</div>
</div>
<script type="text/javascript" src="/js/faq_script.js"></script>

