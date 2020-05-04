<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
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
    <title>Back-Manager-System_HomePage</title>
</head>

<body>
    <div class="bms">
        <div class="header">
            <h1>GameGuild's 後臺管理系統</h1>
            <div class="logout">
	        	<a href="Logout">登出</a>
	        </div>
        </div>
        
		<div id="asideLeft">
            <ul>
                <li id="product" class="bmsmenu"><a href="#">商品</a></li>
                <li id="event" class="bmsmenu"><a href="#">活動</a></li>
                <li id="other" class="bmsmenu"><a href="#">預留</a></li>
            </ul>
        </div>

        <div class="main">
            <div id="article" class="article">
                <div id="mainDiv">Welcome Back-Manager-System_HomePage</div>
                
                <div id="productDiv" class="section" hidden>
                    <button id="insProduct" class="button">新增產品</button>
                    <button id="hideProductNotSales" class="productListView button">只顯示架上商品</button>

                    <div id="iPDiv" hidden>
                        <form action="xxxController" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="pId">
                            <table>
                            <!-- 	test id -->
                                <tr>
                                    <td>遊戲封面</td>
                                    <td colspan="4">
                                        <img id="Preview" src="../img/BmsDefualtImg.jpg">
                                        <input id="pfile" type="file" name="file" hidden></td>
                                </tr><tr>
                                    <td>遊戲名稱</td>
                                    <td><input type="text" name="pName"></td>
                                    <td>分類</td>
                                    <td>
                                        <select name="tagList">
                                            <option value="0">策略</option>
                                            <option value="1">角色扮演</option>
                                            <option value="2">射擊</option>
                                            <option value="3">模擬</option>
                                            <option value="4">冒險</option>
                                            <option value="5">休閒</option>
                                            <option value="6">運動</option>
                                            <option value="7">恐怖</option>
                                        </select>
                                </td></tr><tr>
                                    <td>價格</td>
                                    <td><input type="text" name="price"></td>
                                </tr><tr>
                                    <td>描述</td>
                                    <td colspan="4">
                                        <textarea name="intro" cols="50" rows="5" placeholder="輸入遊戲的描述"></textarea></td>
                                </tr><tr>
                                    <td>上架時間</td>
                                    <td><input type="date" name="uplTime" id="uplTime"></td>
                                    <td>下架時間</td>
                                    <td><input type="date" name="dwlTime" id="dwlTime"></td>
                                </tr><tr>
                                    <td>
                                        <input type="button" id="sendProductBean" value="確定送出"/></td>
                                    <td>
                                        <input type="button" id="resetProductBean" value="重設"/></td>
                                </tr>
                            </table> 
                        </form>
                       
                    </div>

                    <table id="productListTable" class="productListView">
                        <thead>
                            <tr>
                                <td>產品狀態</td>
                                <td>產品編號</td>
                                <td>產品名稱</td>
                                <td>價格</td>
                                <td>上架時間</td>
                                <td>下架時間</td>
								<td></td>
								<td></td>
                            </tr>
                        </thead>
                        <tbody id="productList">
                        </tbody>
                    </table>

                    <ul class="pagination"></ul>

                </div>

                <div id="eventDiv" class="section" hidden>

					<button id="insEvent" class="button">新增活動</button>
           			<button id="qurEvent" class="productListView button">查詢活動</button>

					<!-- 第一個標籤 -->
							<div id="tab0" class="tabs-panel" style="display: block;" >
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
											<td>產品編號 : <input type="text" name="product_Id"></td>
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
				
							<!-- 第二個標籤 -->
							<div id="tab1" class="tabs-panel" style="width:1000px">
								<div>
									<table>
										<input type="text" id="se1" placeholder="請輸入想搜尋的活動編號">
										<button id="search">查詢</button>
										<button id="searchAllData">查詢全部活動</button>						
									</table>
				
									<table id="queryAllEvent">
									</table>
								</div>
							</div>
				
				       		<!-- 第三個標籤 -->
							<div id="tab2" class="container" hidden>
								<form id="updateForm" name="updateForm"  method="POST" enctype="multipart/form-data" >													
									<table id="updateEvent">
											<tr>
												<td name="eventId1" id="eventId1"></td>
											</tr>
											<tr>
												<td>活動起始時間 : <input type="date" id="startDate1" name="startDate1"></td>
											</tr>
											<tr>
												<td>活動結束時間 : <input type="date" id="endDate1" name="endDate1"></td>
											</tr>
											<tr>
												<td>活動圖檔 : <input type="file" id="imageUpdate" name="eventImage1" multiple="multiple" accept=".png, .jpg, .jpeg"/><img  name="eventImage2" alt="" src="" >	</td>
											</tr>
											<tr>
												<td>產品編號 <input type="text" name="productId1"></td>
											</tr>
											<tr>
												<td>活動標題 : <input type="text" name="eventName1"></td>
											</tr>									
											<tr>
												<td>活動內文 : <textarea id="editor2" name="content1"></textarea></td>
											</tr>
											<tr>
												<td><button type="button" id="SaveButton" class="btn btn-success"data-dismiss="modal">Save</button>
											   <button type="button" class="btn btn-danger"data-dismiss="modal">Close</button></td>
											</tr> 																							
									</table>																																																																																													
								</form>																								
							</div>
											
						</div>
					</div>
				</div>
			</div>		
						

</body>

</html>