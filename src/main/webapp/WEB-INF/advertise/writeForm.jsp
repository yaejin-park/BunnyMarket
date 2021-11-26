<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="/css/ad_style.css">
<!-- 첨부파일 -->
<div class = "row">
	<div class = "col-lg-12">
		<div class = "panel panel-default">
			<div class = "panel-heading">File Attach</div>
			<!-- /.panel-heading -->
			<div class = "panel-body">
				<div class = "panel-body">
					<div class = "form-group uploadDiv">
						<input type = "file" name = 'uploadFile' multiple>
					</div>
					
					<div class = 'uploadResult'>
						<ul>
						
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	$(document).ready(function() {
		var formObj=$("form[role='form']");
		$("button[type='submit']").on("click",function(e){
			e.preventDefault();
			console.log("submit clicked");
		});
		
		var regex=new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		//var maxSize=5242880; //5MB
		
		function checkExtension(fileName,fileSize) {
			if(fileSize>=maxSize){
				alert("파일 사이즈 초과");
				return false;
			}
			
			if(regex.test(fileName)){
				alert("해당 종류의 파일은 업로드할 수 없습니다.");
				return false;
			}
			return true;
		}
		
		$("input[type='file']").change(function(e) {
			var formData=new FormData();
			var inputFile=$("input[name='photoupload']");
			var files=inputFile[0].files;
			
			for(var i=0;i<files.length;i++){
				if(!checkExtension(files[i]).name,files[i].size)){
					return false;
				}
				formData.append("photoupload",files[i]);
			}
			
			$.ajax({
				url:'uploadAjaxAction',
				processData:false,
				contentType:false,
				datas:formData,
				type:'POST',
				dataType:'json',
				success:function(result){
					console.log(result);
					showUploadResult(result);
				}
			});
		});
	});
	
	function showUploadResult(uploadResultArr) {
		if(!uploadResultArr || uploadResultArr.length==0){
			return;
		}
		
		var uploadUL=$(".previewarea ul");
		var str="";
		
		$(uploadResultArr).each(function(i,obj) {
			if(!obj.image){
				var fileCallPath=encodeURIComponent(obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
				var fileLink=fileCallPath.replace(new RegExp(/\\/g), "/");
				
				str+="<li><a href='/download?fileName="+fileCallPath+"'><img src='/resources/img/attach.png'>"
	    		   +obj.fileName+"</a>" + "<span data-file=\ '"+ fileCallPath+"\' data-type='file'> x </span>"
	    		   + "<div></li>";
				str += "<li><div>";
		          str += "<span> "+ obj.fileName+"</span>";
		          str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
		          str += "<img src='/display?fileName="+fileCallPath+"'>";
		          str += "</div>";
		          str +"</li>";
			}else{
				var fileCallPath=encodeURIComponent( obj.uploadPath+ "/s_"+obj.uuid +"_"+obj.fileName);
				var originPath=originPath.replace(new RegExp(/\\/g), "/");
				
				str+="<li><a href=\"javascript:showImage(\'"
		    		   +originPath+"\')\"><img src='/display?fileName="+fileCallPath+"'></a>"
    				   + "<span data-file=\'" + fileCallPath + "\' data-type='image'> x </span><li>";
				str += "<li><div>";
		          str += "<span> "+ obj.fileName+"</span>";
		          str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
		          str += "<img src='/resources/img/attach.png'></a>";
		          str += "</div>";
		          str +"</li>";
			}
		});
		uploadResult.append(str);
		uploadUL.append(str);
	}
</script>