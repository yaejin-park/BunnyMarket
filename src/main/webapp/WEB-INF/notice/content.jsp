<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

	<div class="inner">
		<button type="button">목록</button>
		<table>
			<tr>
				<th>${dto.title}</th>
				<th><fmt:formatDate value="${dto.write_day}" pattern="yy.MM.dd"/></th>
				<th>${dto.readcount}</th>
			</tr>
			<tr>
				<td>${dto.content}</td>
			</tr>
		
		
		</table>
	</div>
