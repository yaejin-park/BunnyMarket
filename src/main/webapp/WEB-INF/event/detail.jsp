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
		<input type="hidden" value="${maxReply}" name="regroup">
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
		    		<li class="${replyDto.restep!=0?'bg':''}">
	    				<input type="hidden" name="regroup" value="${replyDto.regroup}">
	    				<input type="hidden" name="restep" value="${replyDto.restep}">
	    				<input type="hidden" name="relevel" value="${replyDto.relevel}">
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
		    			<div class="re-div">
							<input type="hidden" value="${dto.idx}" name="num">
							<input type="hidden" value="${maxReply}" name="regroup">
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
			var regroup = $(this).parents(".reply").find("input[name='regroup']").val();
			
			$.ajax({
				type:"post",
				url:"auth/reply/insert",
				data:{
					"num":num,
					"content":content,
					"regroup":regroup
				},
				success:function(){
					$(this).parents(".re-div").find("textarea[name='re-content']").val("");
					location.reload();
				}
			});
		});
		
		$(".re-list .reply-btn").click(function(){
			if(!$(this).hasClass("active")){
				$(".re-list .reply-btn").removeClass("active");
				$(".re-list .re-div").hide();
				$(this).addClass("active");
				$(this).parents("li").find(".re-div").show();
			}else{
				$(this).removeClass("active");
				$(this).parents("li").find(".re-div").hide();
			}
		});
		
		$(".event-div .re-list li.bg").each(function(){
			var level = $(this).find("input[name='relevel']").val();
			$(this).css("padding-left",(level*50) + "px");
		})
		
		$(".re-list .re-div").find(".btn-add").click(function(){
			var regroup = $(this).parents("li").find("input[name='regroup']").val();
			var restep = $(this).parents("li").find("input[name='restep']").val();
			var relevel = $(this).parents("li").find("input[name='relevel']").val();
			var num = $(".event-div").find(".reply input[name='num']").val();
			var content = $(this).parents("li").find(".re-div textarea[name='re-content']").val();
			var checkStep = "yes"; 
			console.log(num);
			$.ajax({
				type:"post",
				url:"auth/reply/insert",
				data:{
					"num":num,
					"content":content,
					"regroup":regroup,
					"restep":restep,
					"relevel":relevel,
					"checkStep":checkStep
				},
				success:function(){
					$(this).parents(".re-div").find("textarea[name='re-content']").val("");
					location.reload();
				}
			});
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
			$(".re-content textarea").keyup(function() {
				var inputlength=$(this).val().length;
				var remain=+inputlength;
				$(".text-plus").html(remain);
				if(remain>=90){
					$(".text-plus").css('color','red');
				}else{
					$(".text-plus").css('color','black');
				}
			});
			
			$(".re-content textarea").keyup(function() {
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