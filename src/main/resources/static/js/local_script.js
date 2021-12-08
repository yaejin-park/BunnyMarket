$(function(){
	var currentBtn = "<p class='map-util'><span class='current-btn'>현재위치로 이동</span></p>";
	var currentLoca = "";
	var sCityHallLoca = new naver.maps.LatLng(37.5666805, 126.9784147);
	
	var map = new naver.maps.Map('map',{
		center: sCityHallLoca,
		scaleControl: false,
		mapDataControl: false,
		zoom: 17
	});
	
	new naver.maps.Marker({
		position: sCityHallLoca,
		map: map
	});

	naver.maps.Event.once(map, "init_stylemap", function(){
		var cstmCtrl = new naver.maps.CustomControl(currentBtn,{
			position:naver.maps.Position.RIGHT_TOP
		});
		
		cstmCtrl.setMap(map);
		
		naver.maps.Event.addDOMListener(cstmCtrl.getElement(), "click", function(){
			if(currentLoca){
				map.setCenter(currentLoca);
				map.setZoom(17);
			}else{
				alert("위치 액세스가 거부되었습니다.\n사용하시려면 위치 액세스를 허용해주세요.");
			}
		});
	});
	
	var currentLocaLat ="";
	var currentLocaLng ="";
	
	var onSuccessGeolocation = function(position){
		currentLocaLat = position.coords.latitude;
		currentLocaLng = position.coords.longitude;
		
		currentLoca = new naver.maps.LatLng(currentLocaLat, currentLocaLng);
		map.setCenter(currentLoca);
		map.setZoom(17);
		
		new naver.maps.Marker({
			position: currentLoca,
			map: map,
			icon: {url:"/image/map-marker2.png"}
		});
		
		getCurrentAddress();
	}
	
	var onErrorGeolocation = function(){
		var agent = navigator.userAgent.toLowerCase(), name = navigator.appName;
		
		if(name == "Microsoft Internet Explorer" || agent.indexOf("trident") > -1 || agent.indexOf("edge/") > -1){
			alert("지원하지 않는 브라우저입니다.");
		}else{
			console.log("현재 위치를 가져오는데 에러가 발생하였습니다.");
		}
	}
	
	if(navigator.geolocation){
		navigator.geolocation.getCurrentPosition(onSuccessGeolocation, onErrorGeolocation);
	}else{
		console.log("지리적 위치가 지원되지 않습니다.");
	}
	
	var getCurrentAddress = function(){
		naver.maps.Service.reverseGeocode({
	        location: new naver.maps.LatLng(currentLocaLat, currentLocaLng),
	    }, function(status, response) {
	        if (status !== naver.maps.Service.Status.OK) {
	            return alert('Something wrong!');
	        }
	
	        var result = response.result,
            getCurrentItems = result.items;
			for(var i=0; i<getCurrentItems.length;i++){
				if(getCurrentItems[i].isAdmAddress){
					$(".local-map-div input[name='current-local']").val(getCurrentItems[i].addrdetail.dongmyun);
				}
			}
	    });
	}	
	
	var current;
	$(document).on("click", ".local-map-div .user-local-list .plus-btn", function(){
		popOpen("#setCurrentPop");
		current = $(".local-map-div input[name='current-local']").val();
		$("#setCurrentPop .txt").text("현재 위치 " + current + "으로 추가하시겠습니까?");
		$(".local-map-div .search-area").show();
	});
	
	$("#setCurrentPop .yes-btn").click(function(){
		$(".local-map-div .user-local-list").append("<li><span>"+ current +"</span><a href='javascript:' class='delete-btn'></a></li>");
		$(".local-map-div .user-local-list li.plus-type").remove();
		popClose("#setCurrentPop");
	});
	
	$(".local-map-div .search-div .local-search-btn").click(function(){
		var search = $(this).prev("input[name='local-search']").val();
		console.log(search)
		
		naver.maps.Service.geocode({
	        address: search
	    }, function(status, response) {
	        if (status !== naver.maps.Service.Status.OK) {
	            return alert('Something wrong!');
	        }
	
	        var result = response.result; // 검색 결과의 컨테이너
            var	searchItems = result.items; // 검색 결과의 배열
			//console.log(searchItems);
			var resultHtml = "";
			if(searchItems.length==0){
				resultHtml += "<div class='nodata'>";
				resultHtml += "<p class='icon'><img alt='' src='/image/nodata-icon.png'></p>";
				resultHtml += "<p>검색된 지역이 없습니다.</p>";
				resultHtml += "</div>";
			}else{
				resultHtml += "<ul class='search-list'>";
				for(var i=0; i<searchItems.length; i++){
					if(searchItems[i].isRoadAddress){
						resultHtml += "<li>";
						resultHtml += "<input type='hidden' name='addr' value='" + searchItems[i].addrdetail.dongmyun + "'/>";
						resultHtml += "<a href='javascript:' class='choose-list'>" + searchItems[i].address + "</a>";
						resultHtml += "</li>";
					}
				}
				resultHtml += "</ul>";
			}
			
			$(".local-map-div .result-div").html(resultHtml);
	    });
	});
	
	var chooseIndex;
	var chooseAddr; 
	$(document).on("click", ".choose-list", function(e){
		chooseIndex = $(this).parent("li").index()
		popOpen("#setLocalPop");
		var choose = $(this).text();
		chooseAddr = $(this).parent("li").find("input[name='addr']").val();
		$("#setLocalPop").find(".txt").text(choose + "\n선택하시겠습니까?");
	});
	
	$("#setLocalPop").find(".yes-btn").click(function(){
		$(".local-map-div .search-list li").eq(chooseIndex).addClass("active");
		if($(".local-map-div .user-local-list li:not(.plus-type)").length < 2){
			$(".local-map-div .user-local-list").append("<li><span>"+ chooseAddr +"</span><a href='javascript:' class='delete-btn'></a></li>");
			$(".local-map-div .user-local-list li.plus-type").remove();
		}else{
			alert("동네는 최대 2개까지 설정 가능합니다.");
		}
		popClose("#setLocalPop");
	});
	
	$(".local-map-div .local-set-btn").click(function(){
		var local = "";
		$(".local-map-div .user-local-list li:not(.plus-type)").each(function(){
			local += $(this).find("span").text() + ",";
		});
		local = local.substring(0, local.length-1);
		
		$.ajax({
			type:"post",
			url:"update",
			data:{"local": local},
			success:function(){
				console.log("성공");
			}
		});
	});
	
	$(document).on("click", ".local-map-div .user-local-list li .delete-btn", function(e){
		var text = $(this).prev("span").text();
		$.ajax({
			type:"get",
			url:"./getlocal",
			data:{"local":text},
			dataType:"json",
			success:function(data){
				if(data.cnt>0){
					alert("기본 주소는 삭제할 수 없습니다.");
				}else{		
					if($(".local-map-div .user-local-list li:not(.plus-type)").length > 1){
						$(e.target).parent("li").remove();
						$(".local-map-div .search-div input").val("").focus();
						$(".local-map-div .search-list li").removeClass("active");
						if($(".local-map-div .user-local-list li:not(.plus-type)").length < 2){
							$(".local-map-div .user-local-list").append("<li class='plus-type'><a href='javascript:' class='plus-btn'></a></li>");
						}
					}else{
						alert("동네가 1개만 선택된 상태에서는 삭제를 할 수 없어요.");
					}
				}
			}
		});	
	});
	
	$(document).on("click", "header .local-option li:not(.set-btn)", function(){
		console.log($(this).find("span").text());
		$("header .local-div .local-btn").text($(this).find("span").text());
	});
});