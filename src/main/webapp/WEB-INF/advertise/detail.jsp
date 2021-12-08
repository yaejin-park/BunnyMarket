<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"  %>
<link rel="stylesheet" type="text/css" href="/css/swiper.min.css">
<link rel="stylesheet" type="text/css" href="/css/product_style.css">
<link rel="stylesheet" type="text/css" href="/css/ad_style.css">
<div class="ad-div inner">
<div class="infoAll">
	<input type="hidden" name="current-page" value="${currentPage}">
		<div class="img group">
			<div class="detail-swiper">
				<div class="bigImgDiv swiper-wrapper">
					<c:forEach items="${dto.photo}" var="dbimg">				
						<div class="swiper-slide bigImg fix">
							<c:if test="${dto.photo=='no'}">
								<img class="bigImg" alt="thumbnail" src="/image/list-noimg.gif">
							</c:if>
							<c:if test="${dto.photo!='no'}">
								<img class="bigImg" alt="thumbnail" src="../photo/${dbimg}">
							</c:if>
						</div>
					</c:forEach>
				</div>
				<div class="swiper-button-next"></div>
	   			<div class="swiper-button-prev"></div>
				<div class="swiper-pagination"></div>
			</div>
			<div class="smImgDiv">
				<c:forEach items="${dbimg}" var="dbimg">			
					<div class="smImg child">
						<c:if test="${dto.photo=='no'}">
							<img alt="smallImage" src="/image/list-noimg.gif" class="smImg">
						</c:if>
						<c:if test="${dto.photo!='no'}">
							<img alt="smallImage" src="../photo/${dbimg}" class="smImg">
						</c:if>
					</div>
				</c:forEach>
			</div>
		</div>
		
		<div class="info">
			<table class="table table-default">
				<tr>				
					<td class="ad-tit" colspan="3">
						${dto.title}
					</td>
				</tr>
				<tr>
					<td rowspan="2" class="profile">
						<img alt="profile" src="/image/profile-icon.png" class="profileImg">	
					</td>
					<td class="nick tit verticalBottom">
						${nick}
					</td>
				</tr>
				<tr>
					<td colspan="2" class="tit-sm">
						작성일 <fmt:formatDate value="${dto.writeday}" pattern="yy.MM.dd HH:mm"/>
					</td>
					<td colspan="3" class="tit-sm">
				<div class="info-sm">   
					<div class="info-sm-div">
						<a href="detail?idx=${dto.idx}&currentPage=${currentPage}&key=list#reply">
							<div class="comment icon-sm">${recount}</div>
						</a>
					</div>
					<div class="info-sm-div">
						<div class="dibs icon-sm">${dto.goodcount}</div>
					</div>
					<div class="info-sm-div">
						<div class="read icon-sm">${dto.readcount}</div>
					</div>
				</div>
			</td>
				</tr>
			</table>
		</div>
	</div>

	<!-- 로그인/비로그인시 나타나는 버튼들 -->
	<div class="detailbtn">
		<!-- 로그인 안했을경우 -->
		<c:if test="${userId != dto.id}">
			<button type="button" class="btn-list delist" onclick="location.href='list'">목록</button>
		</c:if>
		
		<!-- 로그인 했을경우 -->
		<c:if test="${userId == dto.id}">
			<button type="button" class="btn-list delist" onclick="location.href='list'">목록</button>
			<button type="button" class="btn-update" onclick="location.href='./auth/updateform?idx=${dto.idx}&currentPage=${currentPage}'">수정</button>
			<button type="button" id="deleteBtn" class="btn-delete" value="${dto.idx}">삭제</button>
		</c:if>
	</div>
	<div class="img-detail-div">
		<a href="javascript:" class="img-detail-view">상세사진보기(접기)</a>
		<div class="content-img">
		<c:forEach var="photo" items="${dto.photo}">
			<img src="/photo/${photo}" alt="">
		</c:forEach>
		</div>
	</div>
	<div class="content-detail-div">
		<pre class="detailContent">${dto.content}</pre>
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
		    	<c:forEach var="ardto" items="${relist}">
		    		<li class="${ardto.restep!=0?'bg':''}">
	    				<input type="hidden" name="regroup" value="${ardto.regroup}">
	    				<input type="hidden" name="restep" value="${ardto.restep}">
	    				<input type="hidden" name="relevel" value="${ardto.relevel}">
	    				<p class="re-info writer">
	    					<span class="profile">
	    						<img alt="" src="/image/profile-icon.png">
	    					</span>
	    					<span>${ardto.nickname}</span>
	    				</p>
		    			<div class="re-content">
		                	<p class="txt">${ardto.content}</p>		                	
		                	<span class="re-day">
				                <fmt:formatDate value="${ardto.writeday}" pattern="yy.MM.dd"/>
				                <fmt:formatDate value="${ardto.writeday}" pattern="HH:mm"/>
				            </span>
					        <div class="btn-wrap">
					        	<a href="javascript:" class="reply-btn">답글쓰기</a>
					        	<c:if test="${userId==ardto.id}">
					        		<a href="javascript:" class="btn-delete btn-sm" idx="${ardto.idx}">삭제</a>
					        	</c:if>
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

<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<script type="text/javascript" src="/js/advertise_script.js"></script>