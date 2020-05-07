<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
 <link rel="stylesheet" href="../css/BmsHomePage.css">
    <script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
    <script src="../js/BmsHomePage.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<!-- 活動用的 UI js -->
<!-- 	<link rel="stylesheet"	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"> -->
	<script src="https://code.jquery.com/ui/1.12.0/jquery-ui.min.js"></script>
	<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
	<script src="https://cdn.ckeditor.com/ckeditor5/19.0.0/classic/ckeditor.js"></script>
	<!-- 活動用的 UI js END -->
<meta charset="utf-8">
<title>Event</title>

<style>

.ck-editor__editable{
  height: 200px;
  width: 700px;
}
</style>
</head>
<body>

			
		<div>
			<button id="insEvent" class="button">新增活動</button>
            <button id="qurEvent" class="productListView button">查詢活動</button>
			<div>
				<h2>新增活動</h2>
				<form action="addEvent" method="post" enctype="multipart/form-data">
					<table>
						<tr>
							<td>活動起始時間 : <input type="date" id="startDate"	name="startDate"></td>
						</tr>
						<tr>
							<td>活動結束時間 : <input type="date" id="endDate" name="endDate"></td>
						</tr>
						<tr>
							<td>活動圖檔 : <input type="file" id="imageUpload"	name="eventImage" multiple="multiple" accept=".png, .jpg, .jpeg" /><img id="preview_Image" src="#" />
							</td>
						</tr>
						<tr>
							<td>產品編號 : <input type="text" name="productId"></td>
						</tr>
						<tr>
							<td>活動標題 : <input type="text" name="eventName"></td>
						</tr>
						<tr>
							<td>活動內文 : <textarea id="editor" name="content"></textarea></td>
						</tr> 
						<tr>
							<td><input type="submit" value="新增" id="add" /><input type="reset" value="清除" id="reset" /></td>							
													
						</tr>
					</table>
				</form>
			</div>


			
			
				<div id="queryEventData" hidden>
					<h2>查詢活動</h2>
					<table>
						<input type="text" id="se1" placeholder="請輸入想搜尋的活動編號">
						<button id="search">查詢</button>
						<button id="searchAllData">查詢全部活動</button>						
					</table>

					<table id="queryAllEvent">
					</table>
				</div>
			</div>

<!-- 				<div class="container"> -->
					
<!-- 					Button to Open the Modal					 -->
<!-- 					The Modal -->
<!-- 					<div class="modal" id="myModal"> -->
<!-- 						<div class="modal-dialog"> -->
<!-- 							<div class="modal-content"  style="width:600px;height:600px;"> -->
<!-- 								Modal Header -->
<!-- 								<div class="modal-header"> -->
<!-- 									<h5 class="modal-title">修改活動資料</h5> -->
<!-- 									<button type="button" class="close" data-dismiss="modal">&times;</button> -->
<!-- 								</div> -->
<!-- 								<form id="updateForm" name="updateForm" action="updateEvent" method="post" enctype="multipart/form-data" > -->
<!-- 								Modal body -->
<!-- 								<div class="modal-body">							 -->
<!-- 									<table id="updateEvent"> -->
<!-- 										<tr> -->
<!-- 											<td name="eventId1" id="eventId1"></td> -->
<!-- 										</tr> -->
<!-- 										<tr> -->
<!-- 											<td>活動起始時間 : <input type="date" id="startDate1" name="startDate1"></td> -->
<!-- 										</tr> -->
<!-- 										<tr> -->
<!-- 											<td>活動結束時間 : <input type="date" id="endDate1" name="endDate1"></td> -->
<!-- 										</tr> -->
<!-- 										<tr> -->
<!-- 											<td>活動圖檔 : <input type="file" id="imageUpdate" name="eventImage1" multiple="multiple" accept=".png, .jpg, .jpeg"/><img  name="eventImage2" alt="" src="" >	</td> -->
<!-- 										</tr> -->
<!-- 										<tr> -->
<!-- 											<td>產品編號 <input type="text" name="productId1"></td> -->
<!-- 										</tr> -->
<!-- 										<tr> -->
<!-- 											<td>活動標題 : <input type="text" name="eventName1"></td> -->
<!-- 										</tr>									 -->
<!-- 									 	<tr> -->
<!-- 											<td>活動內文 : <textarea id="editor2" name="content1"></textarea></td> -->
<!-- 										</tr> 														 -->
<!-- 									</table>																																										 -->
<!-- 								</div> -->
<!-- 								Modal footer -->
<!-- 								<div class="modal-footer"> -->
<!-- 									<button type="submit" id="SaveButton" class="btn btn-success"data-dismiss="modal">Save</button> -->
<!-- 									<button type="button" class="btn btn-danger"data-dismiss="modal">Close</button> -->
<!-- 								</div>															 -->
<!-- 								</form>																								 -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 				</div> -->
				
			</div>		
		</div>
	</div>
	

	<script type="text/javascript">	
		
		//CKEditor5 文字編輯器
		//發布
		var editorcontent;
		var responseEditorcontent;
		ClassicEditor
			.create(document.querySelector('#editor'), {
				toolbar: ['bold', 'italic', 'link',
					'bulletedList',
					'numberedList',
					'|', 'outdent', 'indent'],
				placeholder: '請輸入文章...',
			})
			.then(editor => {
				console.log(editor);
				editorcontent = editor;
			})
			.catch(error => {
				console.error(error);
			});
		
		//修改
		ClassicEditor
		.create(document.querySelector('#editor2'), {
			toolbar: ['bold', 'italic', 'link',
				'bulletedList',
				'numberedList',
				'|', 'outdent', 'indent']
		})
		.then(editor => {
			console.log(editor);
			responseEditorcontent = editor;
		})
		.catch(error => {
			console.error(error);
		});
		
		
		
		//ShowQueryAllEvent
		$(document).ready(function (){
							console.log('QueryAll:run');
							$.ajax({
										url : "queryAllEvent",
										dataType : "json",
										type : "GET",
										success : function(response) {
											console.log('queryResopnse',
													response);
											//console.log('QueryAll:2');
											var txt = "<tr><th>活動編號<th>產品編號<th>活動照片<th>活動名稱<th>活動內文<th>開始日期<th>結束日期<th colspan='2'>設定";
											for (let i = 0; i < response.length; i++) {
												var id = response[i].eventId;
												txt += "<tr><td>"+ response[i].eventId;
												txt += "<td>"+ response[i].productId;
												txt += "<td><img src='data:image/jpeg;base64," + response[i].eventImage + "' >"
												txt += "<td>"+ response[i].eventName;
												txt += "<td><button type='button' class='btn btn-danger' id=''>內文</button>";
												//txt += "<td>"+ response[i].content;
												txt += "<td>"+ response[i].startDate;
												txt += "<td>"+ response[i].endDate;
												txt += '<td><button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal" id="queryUpdateData">修改</button>';
												
												txt += '<td><button type="button" class="btn btn-danger" id="delete">刪除</button>';
												
											}
											$('#queryAllEvent').html(txt);

											console.log('ShowQueryAllEvent:OK');
										}
									});
						})

		//searchAllData				
					$(document).on('click', '#searchAllData', function() {
						$.ajax({
							url : "queryAllEvent",
							dataType : "json",
							type : "GET",
							success : function(response) {
								console.log('queryResopnse',response);								
								var txt = "<tr><th>活動編號<th>產品編號<th>活動照片<th>活動名稱<th>活動內文<th>開始日期<th>結束日期<th colspan='2'>設定";
								for (let i = 0; i < response.length; i++) {
									var id = response[i].eventId;
									txt += "<tr><td>"+ response[i].eventId;
									txt += "<td>"+ response[i].productId;
									txt += "<td><img src='data:image/jpeg;base64," + response[i].eventImage + "'>"
									txt += "<td>"+ response[i].eventName;
									txt += "<td><button type='button' class='btn btn-danger' id=''>內文</button>";
									//txt += "<td>"+ response[i].content;
									txt += "<td>"+ response[i].startDate;
									txt += "<td>"+ response[i].endDate;
									txt += '<td><button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal" id="queryUpdateData">修改</button>';									
									txt += '<td><button type="button" class="btn btn-danger" id="delete">刪除</button>';
									console.log('searchAllData:OK');
								}
								$('#queryAllEvent').html(txt);								
							}
						});
		});	

		
		var eventId = null;					
		//addEvent
		$(document).on('click', '#add', function() {
			alert("新增成功");
		});
		//選擇圖檔立即顯現
		$("#imageUpload").change(function(){
			var file = $('#imageUpload')[0].files[0];
			var reader = new FileReader;
			reader.onload = function(e) {
				$('#preview_Image').attr('src', e.target.result);
			};
			reader.readAsDataURL(file);
		});
		$("#preview_Image").click(function(){
			$("#imageUpload").click();
		});

		//deleteEvent
		$(document).on('click', '#delete', function() {
			var checkstr = confirm("確定是否刪除該活動?");
			if (checkstr == true) {
				var $tr = $(this).parents("tr");
				eventId = $tr.find("td").eq(0).text(); //抓取id值
				console.log('eventId=' + eventId);
				$(this).parents("tr").remove(); //刪除整個欄位

				$.ajax({
					url : "deleteEvent",
					dataType : "json",
					type : "POST",
					data : {
						eventId : eventId
					},
					success : function(response) {
						console.log(response);
					},
				});
				alert("刪除成功");
			} else {
				return false;
			}
		});

		//queryUpdateData
		$(document).on('click', '#queryUpdateData', function() {
			var $tr = $(this).parents("tr");
			eventId = $tr.find("td").eq(0).text(); //抓取id值
			console.log('eventId=' + eventId);

			$.ajax({
					url : "queryEvent",
					dataType : "json",
					type : "GET",
					data : {eventId : eventId},

					success : function(response) {
						console.log(response);	
						var txt = "活動編號 : "+response.eventId;
						$('input[name="startDate1"]').val(response.startDate);
						$('input[name="endDate1"]').val(response.endDate);								
						$('input[name="productId1"]').val(response.productId);
						$('input[name="eventName1"]').val(response.eventName);
						responseEditorcontent.setData(response.content);							
						$('img[name="eventImage2"]').attr("src","data:image/jpeg;base64,"+response.eventImage+"");
						$('p[name="eventId1"]').val(response.eventId);
						$('#eventId1').html(txt);						 
					},

				});		
		});				
		//searchButton
		$(document).on('click', '#search', function() {
				console.log("searchButton:1");
				console.log("searchcontent:",$("#se1").val());	
				eventId = $("#se1").val();
				$.ajax({
					url : "queryEvent",
					dataType : "json",
					type : "GET",
					data : {eventId : eventId},
					success : function(response) {
						console.log(response);	
						var txt = "<tr><th>活動編號<th>產品編號<th>活動照片<th>活動名稱<th>活動內文<th>開始日期<th>結束日期<th colspan='2'>設定";
						txt += "<tr><td>"+ response.eventId;
						txt += "<td>"+ response.productId;
						txt += "<td><img src='data:image/jpeg;base64," + response.eventImage + "'>"
						txt += "<td>"+ response.eventName;
						txt += "<td>"+ response.content;
						txt += "<td>"+ response.startDate;
						txt += "<td>"+ response.endDate;
						txt += '<td><button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal" id="queryUpdateData">修改</button>';						
						txt += '<td><button type="button" class="btn btn-danger" id="delete">刪除</button>';
						$('#queryAllEvent').html(txt);						 
					},
				});				
			});
		
		
		//UpdateEventData
		$(document).on('click', '#SaveButton', function() {
			var myForm = document.getElementById('updateForm');
			var formData = new FormData(myForm);
			
			var updateImage =$('#imageUpdate').get(0).files[0];			
// 			console.log('content:'+responseEditorcontent.getData());
			console.log(updateImage);
			
			if(updateImage != undefined){				
				formData.append("eventImage1","null");						
				}
			formData.append("eventImage1",updateImage);	
									
			formData.append("content1",responseEditorcontent.getData());			
			formData.append("eventId1",eventId);
				$.ajax({
					url : "updateEvent",
					processData : false,
					contentType : false,
					type : "POST",
					data : formData,
					success : function(response) {
						//console.log(response);	
						console.log("Save ok");	
						alert("修改成功");			 
					},
				});				
			});
		
	</script>
</body>
</html>