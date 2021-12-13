<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<link rel="stylesheet" type="text/css" href="/css/faq_style.css">
<div class="faq-div">
	<div class="inner">
		<form class="faq-form-div">
		<select id="faq-category">
				<option value="all">전체</option>
				<option value="sale">구매/판매</option> 
				<option value="manner">거래매너</option>
				<option value="other">기타</option>
			</select>
			<c:if test="${admin == 'admin'}">
				<div class="btn-wrap">
					<button type="button" class="btn-add" onclick="location.href='insertform'" >글쓰기</button>
				</div>
			</c:if>
			<table class="table">
				<thead>
					<tr>
						<th class="category">카테고리</th>
						<th class="question">질문</th>
						<th class="bin"></th>
					</tr>
				</thead>
				<tbody id="faq-list-tbody">
				</tbody>
			</table>
			<div class="paging">
			</div>
		</form>
	</div>
</div>
<script type="text/javascript" src="/js/faq_script.js"></script>

