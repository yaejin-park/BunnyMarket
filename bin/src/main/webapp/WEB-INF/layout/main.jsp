<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="/css/swiper.min.css">
<link rel="stylesheet" href="/css/main.css">
<c:set var="root" value="<%=request.getContextPath() %>"></c:set>
<section class="main-vis">
	<div class="swiper-wrapper">
		<div class="swiper-slide">
			<img alt="" src="/image/main-vis1.png">
		</div>
		<div class="swiper-slide">
			<img alt="" src="/image/main-vis2.png">
		</div>
	</div>
	<div class="swiper-pagination"></div>
</section>

<script type="text/javascript" src="/js/swiper.min.js"></script>
<script type="text/javascript">
	var swiper = new Swiper(".main-vis", {
		pagination: {
			el: ".main-vis .swiper-pagination",
		},
	});
</script>
