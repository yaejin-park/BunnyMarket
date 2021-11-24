<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="inner">
	<div class="group">
		<c:forEach items="${list}" var="one">
		<c:set var="thumbName" value="${fn:split(one.uploadfile,',')[0]}"/>
		<div class="child">
			<div>
				<img class="thumbnail" alt="thubnail" src="../photo/${thumbName}">
			</div>
			<div>${one.title}</div>
			<div>${one.price}</div>
		</div>
		</c:forEach>
	</div>
	
<!-- 페이징 -->
<div>


</div>

	
</div>