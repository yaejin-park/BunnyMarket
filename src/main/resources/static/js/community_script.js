

//list에 대표이미지 사이즈 맞추기
$(function(){
	$(window).on("load", function(){
		$(".cummu-list .image").each(function(){
			$(this).height($(this).width());
			if($(this).width() > $(this).find("img").height()){
				$(this).find("img").width("auto");
				$(this).find("img").height("100%");
			}else{
				$(this).find("img").width("100%");
				$(this).find("img").height("auto");
			}
		});
		
	});
})


//detail에 미리보기 이미지처리
var fileArr;
var fileInfoArr=[];

//썸네일 클릭시 삭제
function fileremove(idx){
	console.log("idx:"+idx);
	fileInfoArr.splice(index,1);
	
	 var imgId="#img_id_"+index;
    $(imgId).remove();
    console.log(fileInfoArr);
}

//썸네일 미리보기
function previewImage(targetObj, previewarea){
	var files=targetObj.files;
	fileArr=Array.prototype.slice.call(files);
	
	var preview = document.getElementById(previewarea);
	var ua = window.navigator.userAgent;
	
	for(var i = 0; i<files.length; i++){
	var file = file[i];
	fileInfoArr.push(file);
	}
	
	var imageType = /image.*/;
	if(!file.type.match(imageType))
	continue;
	
	var span = document.createElement('span');
	span.id="img_id_" + i;
	span.style.width = '180px';
	span.style.height = '180px';
	preview.appendChild(span);
	
	var img = document.createElement("img");
            img.className="addImg";
            img.classList.add("obj");
            img.file = file;
            img.style.width='inherit';
            img.style.height='inherit';
            img.style.cursor='pointer';
            const idx=i;

            img.onclick=()=>fileRemove(idx);
            span.appendChild(img);


	if (window.FileReader) { 
                var reader = new FileReader();
                reader.onloadend = (function(aImg) {
                    return function(e) {
                        aImg.src = e.target.result;
                    };
                })(img);
                reader.readAsDataURL(file);
            } else { // safari is not supported FileReader
                //alert('not supported FileReader');
                if (!document.getElementById("sfr_preview_error_"
                    + previewarea)) {
                    var info = document.createElement("p");
                    info.id = "sfr_preview_error_" + previewarea;
                    info.innerHTML = "not supported FileReader";
                    preview.insertBefore(info, null);
                }
            }
        }
    

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	















