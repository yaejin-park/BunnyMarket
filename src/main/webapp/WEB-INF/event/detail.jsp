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
	
	<div class="reform tit">
		댓글 ${recount}
	</div>
	<form action="reinsert" method="post">
		<input type="hidden" value="${currentPage}" name="currentPage">
		<input type="hidden" value="${dto.idx}" name="num">
		<div class="reply">
			<div class="re-addcontent">
				<textarea name="content" class="re-textinput" placeholder="댓글을 입력해주세요."
							required="required"></textarea>
			</div>
			<div class="re-items">
				<div class="re-addbtn">
					<button type="submit" class="btn-add btn-sm" id="re-addbtn">등록</button>
				</div>
				<div class="text-count">
					<span class="text-plus">0</span><span>/100</span>
				</div>
			</div>
		</div>	
	</form>
	
	<div class="re-list">
		<c:if test="${recount==0}">
			<div class="nodata">
				<p class="icon">
					<img alt="" src="/image/nodata-icon.png">
				</p>
				<p>등록된 댓글이 없습니다.</p>
			</div>
		</c:if>
		<c:if test="${recount>0}">
		    <c:forEach var="ardto" items="${relist}">
		    	<div class="re-info">
		    		<img alt="" src="../image/profile-icon.png" class="re-profileimg">
		    	</div>
	            <div class="re-info">
		            <span class="re-writer">${ardto.id}</span>
		            <span class="re-day">
		                <fmt:formatDate value="${ardto.writeday}" pattern="yy.MM.dd"/>
		            </span>
		        </div>
	            <div class="re-detail">		    
	                <!-- relevel 만큼 공백 -->
	                <c:forEach var="sp" begin="1" end="${ardto.relevel}">
	                    <div class="re-blank"></div>
	                </c:forEach>
	                <!-- 답글인 경우에만 re 이미지 출력 -->
	                <c:if test="${ardto.relevel>0}">
	                    <!-- <img src="../photo/re.png"> -->
	                    <div>👉</div>
	                </c:if>
	                <!-- 댓글내용 -->
	                <div class="re-content">
	                	<pre>${ardto.content}</pre>
				        <div class="re-rebtn">
				        	<a href="#" role="button" class="re-reply">답글쓰기</a>
				        </div>
	                </div>
	                <div class="re-modbtn">
	                	<a href="#">수정</a>
	                </div>
	                <div class="re-delbtn">
	                	<a href="#" class="redel" idx="${ardto.idx}">삭제</a>
	                </div>
	            </div>
		    </c:forEach>
		</c:if>
	</div>
</div>
<script type="text/javascript">
	$(function(){
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
			$(".re-textinput").keyup(function() {
				var inputlength=$(this).val().length;
				var remain=+inputlength;
				$(".text-plus").html(remain);
				if(remain>=90){
					$(".text-plus").css('color','red');
				}else{
					$(".text-plus").css('color','black');
				}
			});
			
			$(".re-textinput").keyup(function() {
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