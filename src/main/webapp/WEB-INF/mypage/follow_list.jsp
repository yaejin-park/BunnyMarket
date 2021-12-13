<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="/css/swiper.min.css">
<link rel="stylesheet" type="text/css" href="/css/mypage_style.css">
<div class="mydetail-form follow-div">
	<div class="inner">
		<form action="follow-form-div">			
			<div class="myfollow-list">
				<table class="table">					
					<thead>
						<tr>
							<th class="follower">팔로워</th>
							<th class="pimg">상품이미지</th>
							<th class="pinfo">상품정보</th>
						</tr>
					</thead>
					<tbody class="follow-list-tbody" id="follow-list-tbody">
					</tbody>
				</table>
				<div class="paging">
				</div>
			</div>
		</form>	
	</div>
</div>
<script type="text/javascript" src="/js/mypage_script.js"></script>