<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="quick-div">
	<a href="/chat/auth/list" class="quick-talk">톡톡채팅</a>
	<a href="/product/auth/insertForm" class="quick-add">상품추가</a>
	<a href="javascript:" class="top-btn">위로가기</a>
</div>

<script>
$( '.top-btn' ).click( function() {
	$( 'html, body' ).animate( { scrollTop : 0 }, 400 );
	return false;
} );
</script>