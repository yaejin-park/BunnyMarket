<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<link rel="stylesheet" type="text/css" href="/css/swiper.min.css">
<link rel="stylesheet" type="text/css" href="/css/common.css">
<link rel="stylesheet" type="text/css" href="/css/community_style.css">

<div class="community-div inner">
	<div class="community-detail-div">
	<input type="hidden" name="current-page" value="${currentPage}">
	<input type="hidden" id="isLogin" value="${isLogin}">
	<input type="hidden" name="cIdx" value="${dto.idx}">
	
	<div class="infoAll">
		<div class="img group">
			<div class="detail-swiper">
				<div class="bigImgDiv swiper-wrapper">
					<c:forEach items="${photo}" var="photo">
						<div class="swiper-slide bigImg fix">
							<!-- 이미지 없는경우 -->
							<c:if test="${photo=='no'}">
								<img alt="thumbnail" src="../image/co-noimg.jpg">
							</c:if>
							<!-- 이미지 있는경우 -->
							<c:if test="${photo!='no'}">
								<img alt="thumbnail" src="../photo/${photo}">
							</c:if>
						</div>
					</c:forEach>
				</div>
				<div class="swiper-butten-next"></div>
				<div class="swiper-butten-prev"></div>
				<div class="swiper-pagination"></div>
			</div>
			<div class="smImgDiv">
				<c:forEach items="${photo}" var="photo">
					<div class="smImg child">
						<c:if test="${photo=='no'}">
						<!-- 이미지 없는경우 -->
							<img alt="smallImage" src="../image/co-noimg.jpg">
						</c:if>
						<c:if test="${photo!='no'}">
						<!-- 이미지 있을경우 -->
							<img alt="smallImage" src="../photo/${photo}">
						</c:if>
					</div>
				</c:forEach>
			</div>
		</div>
	
		<div class="info">
			<table class="table">
				<tr>
					<td>
						<fmt:formatDate value="${dto.writeday}" pattern="yyyy.MM.dd"/>
					</td>
					<td align="right">
						<a class="txt readcount">조회수 : ${dto.readcount}</a>
					</td>
				</tr>
				<tr>
					<td colspan="2" class="detailtit">
						${dto.title}
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<p class="pro-img">
							<c:if test="${profile == 'no'}">
								<img alt="profile" src="/image/profile-icon.png" class="profileImg" />
							</c:if>
							<c:if test="${profile != 'no'}">
								<img alt="profile" src="/photo/${profile}" class="profileImg" />
							</c:if>
						</p>
						<span class="nick txt">${nick}</span>
					</td>
				</tr>
				<tr>
					<td colspan="2" class="tit-sm other" >
						<div class="reply-heart">
							<!-- 공감수표시 -->
								<div class="gdcount-icon">
									<img src="../image/heart-icon.png">
									<span class="txt gdcount">${dto.goodcount}</span>
								</div>
							<!-- 댓글수표시 -->
								<div class="reply-icon">
									<img src="../image/comment-icon.png">
									<span class="txt recount">${recount}</span>
								</div>
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<div class="btn-wrap">
							<!-- 로그인 했을경우 공감 / 로그인&내가쓴글에만 수정,삭제버튼 보이기 -->
								<button type="button" id="dibs" class="goodbtn" onclick="dibsClicked()">
									<img src="/image/stopheart-icon.gif" alt="dibsButton" id="dibsBtnImg">
								</button>
									
								<sec:authorize access="isAuthenticated()">
									<c:if test="${userId == dto.id}">
										<button type="button" class="btn-update deupdate"
										onclick="location.href='/community/auth/updateform?idx=${dto.idx}&currentPage=${currentPage}'">수정</button>
										<button type="button" class="btn-delete dedelete" idx="${dto.idx}">삭제</button>
									</c:if>
								</sec:authorize>
						</div>
					</td>
				</tr>
			</table>
		</div>
	</div>
	
	<div class="img-detail-div">
		<a href="javascript:" class="img-detail-view">상세사진보기(접기)</a>
		<div class="content-img">
		<c:forEach var="photo" items="${dto.photo}">
			<img src="/photo/${photo}" alt="">
		</c:forEach>
		</div>
	</div>

	<div class="detailContentDiv">
		<pre class="detailContent">${dto.content}</pre>
	</div>
	
	<div class="detailbtn">
			<button type="button" class="btn-list delist"
			onclick="location.href='list'">목록</button>
	</div>
	
	<!-- 댓글 -->
	<div class="reply">
		<input type="hidden" value="${dto.idx}" name="num">
		<input type="hidden" value="${maxReply==null?0:maxReply}" name="regroup">
		<div class="tit">
			댓글 ${recount}
		</div>
		<div class="re-div">
			<p class="re-info writer">
				<span class="profile">
					<c:if test="${userProfile =='no'}">
						<img alt="" src="/image/profile-icon.png">
					</c:if>
					<c:if test="${userProfile !='no'}">
						<img alt="" src="/photo/${userProfile}">
					</c:if>
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
	
	<!-- 댓글목록 -->
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
	    						<c:if test="${replyDto.profile == 'no'}">
	    							<img alt="" src="/image/profile-icon.png">
	    						</c:if>
	    						<c:if test="${replyDto.profile != 'no'}">
	    							<img alt="" src="/photo/${replyDto.profile}">
	    						</c:if>
	    					</span>
	    					<span>${replyDto.nickname}</span>
	    				</p>
		    			<div class="re-content">
		                	<p class="txt">${replyDto.content}</p>
					        <div class="btn-wrap">
					        	<a href="javascript:" class="reply-btn">답글쓰기</a>
					        	<c:if test="${userId==replyDto.id}">
			                	<a href="javascript:" class="btn-delete btn-sm" idx="${replyDto.idx}">삭제</a>
					        	</c:if>
					        </div>
		    			</div>
		    			<div class="re-div">
							<input type="hidden" value="${dto.idx}" name="num">
							<input type="hidden" value="${maxReply}" name="regroup">
							<p class="re-info writer">
								<span class="profile">
									<c:if test="${userProfile =='no'}">
										<img alt="" src="/image/profile-icon.png">
									</c:if>
									<c:if test="${userProfile !='no'}">
										<img alt="" src="/photo/${userProfile}">
									</c:if>
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
										<button type="submit" class="btn-add btn-sm">등록</button>
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
</div>

<script type="text/javascript" src="/js/swiper.min.js"></script>
<script type="text/javascript" src="/js/community_script.js"></script>
