<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="/css/review_style.css">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<input type="hidden">
<c:forEach var="r" items="${list}">
	<table class="review">
		<tr>
			<td class="img"></td>
			<td class="name">${r.nickname}<small class="small">${r.last_time}</small>
			</td>
			<td class="go"><i class="arrow" onclick="location.href='insertForm?idx=${idx}?nickname=${r.nickname}'"></i></td>
			
		</tr>

	</table>
	
</c:forEach>



