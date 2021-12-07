<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" type="text/css" href="/css/event_style.css">
<div class="event-div inner">
	<div class="event-detail-div">
		<div class="title-div">
			<span class="label">${dto.category}</span>
			<p class="tit">${dto.title}</p>
			<p class="date">
				<fmt:formatDate value="${dto.event_start}" pattern="yyyy.MM.dd" />
				~
				<fmt:formatDate value="${dto.event_end}" pattern="yyyy.MM.dd" />
			</p>
		</div>
		<div class="view-div">
			<c:forEach var="photo" items="${photoList}">
				<div class="img-div">
					<img src="/photo/${photo}" alt="">
				</div>
			</c:forEach>
			<div class="txt-div">
				${dto.content}
			</div>
		</div>
		<div class="btn-wrap">
			<a href="javascript:" class="btn-list">목록</a>
			<c:if test="${userType == 'admin'}">
				<a href="javascript:" class="btn-update">수정</a>
				<a href="javascript:" class="btn-delete">삭제</a>
			</c:if>
		</div>
	</div>
	
	<div class="reply">
		<input type="hidden" value="${dto.idx}" name="num">
		<div class="tit">
			댓글 ${recount}
		</div>
		<div class="re-div">
			<p class="re-info writer">
				<span class="profile">
					<img alt="" src="/image/profile-icon.png">
				</span>
				<c:if test="${userNickName=='no'}">
					<a href="/login/main"><span>로그인해주세요.</span></a>
				</c:if>
				<c:if test="${userNickName!='no'}">
					<span>${userNickName}</span>
				</c:if>
			</p>
			<c:if test="${userNickName!='no'}">
				<div class="re-content">
					<textarea name="re-content" placeholder="댓글을 입력해주세요."></textarea>
				</div>
					
				<div class="re-util">
					<div class="btn-wrap">
						<button type="button" class="btn-add btn-sm">등록</button>
					</div>
					<div class="text-count">
						<span class="text-plus">0</span><span>/100</span>
					</div>
				</div>
			</c:if>
		</div>
	</div>
	
	<div class="re-list-div">
		<c:if test="${recount==0}">
			<div class="nodata">
				<p class="icon">
					<img alt="" src="/image/nodata-icon.png">
				</p>
				<p>등록된 댓글이 없습니다.</p>
			</div>
		</c:if>
		<c:if test="${recount>0}">
		    <ul class="re-list">
		    	<c:forEach var="replyDto" items="${relist}">
		    		<li>
	    				<p class="re-info writer">
	    					<span class="profile">
	    						<img alt="" src="/image/profile-icon.png">
	    					</span>
	    					<span>${replyDto.nickname}</span>
	    				</p>
		    			<div class="re-content">
		                	<p class="txt">${replyDto.content}</p>
					        <div class="btn-wrap">
					        	<a href="javascript:" class="reply-btn">답글쓰기</a>
			                	<a href="javascript:" class="btn-update btn-sm re-modbtn" idx="${replyDto.idx}">수정</a>
			                	<a href="javascript:" class="btn-delete btn-sm re-modbtn" idx="${replyDto.idx}">삭제</a>
					        </div>
		    			</div>
		    		</li>
		    	</c:forEach>
		    </ul>
		</c:if>
	</div>
</div>
<script type="text/javascript">
	$(function(){
		$(".reply .re-div .btn-add").click(function(){
			var num = $(this).parents(".reply").find("input[name='num']").val();
			var content = $(this).parents(".re-div").find("textarea[name='re-content']").val();
			
			$.ajax({
				type:"post",
				url:"auth/reply/insert",
				data:{
					"num":num,
					"content":content
				},
				success:function(){
					$(this).parents(".re-div").find("textarea[name='re-content']").val("");
					location.reload();
				}
			})
		});
		//삭제 버튼 alert
		$("#deleteBtn").click(function() {
			var idx =  $(this).val();
			var currentPage= $("input[name='current-page']").val();
			
			var n = confirm("정말 게시물을 삭제하시겠습니까?");
			if(n){
				location.href="delete?idx="+idx+"&currentPage="+currentPage;
			} else{
				return;			
			}
		});
	
		//댓글 글자수 제한
		$(document).ready(function() {
			$(".re-text-input").keyup(function() {
				var inputlength=$(this).val().length;
				var remain=+inputlength;
				$(".text-plus").html(remain);
				if(remain>=90){
					$(".text-plus").css('color','red');
				}else{
					$(".text-plus").css('color','black');
				}
			});
			
			$(".re-text-input").keyup(function() {
				var inputlength=$(this).val().length;
				var remain=+inputlength;
				$(".text-plus").html(remain);
				if(remain>=101){
					alert("100자를 초과했습니다.")
				}else{
					return;
				}
			});
		});
	
		//댓글삭제
		$("a.redel").click(function() {
			var idx=$(this).attr("idx");
			console.log(idx);
			if(confirm("댓글을 삭제하시겠습니까?")){
				$ajax({
					type:"get",
					dataType:"html",
					url:"/redelete",
					data:{"idx":idx},
					success:function(){
						alert("댓글을 삭제했습니다.");
						location.reload();
					}
				});
			}
		});
	});
</script>