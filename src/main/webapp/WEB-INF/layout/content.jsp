<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	.guide {
		padding-bottom:150px;
	}
	.guide .inner {
		margin-top:120px;
	}
	.guide .inner .title {
		margin-bottom:20px;
		font-size:25px;
		font-weight:bold;
		color:#333;
	}
	.btn-div {
		margin-bottom:60px;
	}
	.btn-div:last-child {
		margin-bottom:0;
	}
	.color {
		display:inline-block;
		width:100px;
		height:100px;
		margin-right:30px;
		border-radius:50%;
	}
	.color.point {
		background:#ff7ab0;
	}
	.color.sub {
		background:#f8a673;
	}
	.color.default {
		background:#e5e5e5;
	}
</style>
<div class="guide">
	<div class="inner">
		<p class="title">기본 포인트 컬러</p>
		<div class="color point"></div>
		<div class="color sub"></div>
		<div class="color default"></div>
	</div> 
	<div class="inner">
		<p class="title">버튼 가이드</p>
		<div class="btn-div">
			<p class="title">기본 버튼</p>
			<button type="button" class="btn-default">버튼</button>
			<button type="button" class="btn-list">목록</button>
			<button type="button" class="btn-add">글쓰기</button>
			<button type="button" class="btn-update">수정</button>
			<button type="button" class="btn-delete">삭제</button>
		</div>
		<div class="btn-div">
			<p class="title">작은 버튼</p>
			<button type="button" class="btn-default btn-sm">버튼</button>
			<button type="button" class="btn-list btn-sm">목록</button>
			<button type="button" class="btn-add btn-sm">글쓰기</button>
			<button type="button" class="btn-update btn-sm">수정</button>
			<button type="button" class="btn-delete btn-sm">삭제</button>
		</div>
	</div>       
	<div class="inner">
		<p class="title">Table 가이드</p>
		<table class="table">
			<thead>
				<tr>
					<th class="num">번호</th>
					<th class="title">타이틀</th>
					<th class="writer">작성자</th>
					<th class="writeday">작성일</th>
					<th class="readcount">조회수</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>2</td>
					<td>안녕하세요</td>
					<td>한희규</td>
					<td>2021.12.29</td>
					<td>12</td>
				</tr>
				<tr>
					<td>1</td>
					<td>안녕하세요 반가워요!</td>
					<td>박예진</td>
					<td>2021.11.19</td>
					<td>7</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>
