<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="/css/mypage_style.css">
<div class="sell-list">
	<div class="inner">
		<div class="sell-condition">
			<input type="button" id="button" name="button"
			value="판매중" class="btn-list selling">
			<input type="button" id="button" name="button"
			value="예약중" class="btn-list reserving">
			<input type="button" id="button" name="button"
			value="판매완료" class="btn-list soldout">
		</div>
		<div class="myselling">
			<table class="table">
				<thead>
					<tr>
						<th></th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
</div>