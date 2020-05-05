$(window).on('load', function () {
    // Menu 選擇後的動作
    $(".bmsmenu").on("click", function () {
        let menuSelect = $(this).attr("id")
        if (menuSelect == "product") {
            getProductList("productJsonView")
        } else if (menuSelect == "event") {
            eventView()
        }
    })
    
//    alert((new Date()).format("yyyy/MM/ddThh:mm:ss"))

    // Menu 點擊活動後呼叫之函數
    function eventView() {
        $("#eventDiv").show().siblings().hide()
        $("#tab1").show();
        $("#tab0").hide();
        
        createEventPagesNum();
    }

	// Menu 點擊商品後呼叫之函數
	function getProductList(urlStr){
		$.getJSON(urlStr, function( jdata ){
             productList = jdata;
             productView();
        })
    }

    // Menu點擊商品後呼叫之函數
    // 將Json物件[Product]轉成表格並顯示
    function productView() {
        let txt // = "<table>"
        for (let i = productList.length - 1; i >= 0; i--) {
            let now = new Date()
            let uplt = productList[i].uploadTime
            let dwlt = productList[i].downloadTime
            let saleStatus = (Compare(now, dwlt) ? 0 : Compare(now, uplt) ? 1 : 2)
            txt += "<tr class='" + pStatus[saleStatus] + "'>"
            txt += "<td class='pStatus'>" + pStatus[saleStatus+3] + "</td>"
            txt += "<td>" + productList[i].productId + "</td>"
            txt += "<td>" + productList[i].productName + "</td>"
            txt += "<td>" + productList[i].tag + "</td>"
            txt += "<td>" + productList[i].price + "</td>"
            txt += "<td>" + productList[i].uploadTime + "</td>"
            txt += "<td>" + productList[i].downloadTime + "</td>"
            txt += "<td><button class='upl'>修改</button></td>"
            txt += "<td><button class='del'>刪除</button></td>"
            txt += "</tr>"
        }
        $("#productDiv").show().siblings().hide()
        
        if($("#insProduct").text()!="新增產品"){
        	productEdit = false
        	$("#insProduct").click()
//        	$("#iPDiv").hide()
//        	$("#productListTable").show()
//        	$("ul.pagination").show()
        }
        $("#productDiv").find("tbody#productList").html(txt).show()

        // 對修改/刪除的按鈕新增事件 (刪除)
        $(".upl,.del").on("click", function () {
            let id = parseInt($(this).parent().parent().find("td").eq(1).html())
            if ($(this).hasClass("del")) {
                if (confirm("您確定要刪除 產品編號:" + id + " 的產品嗎 ?")) {
                    txt = "您已確定刪除!";
                    $.ajax({
                        method: "GET",
                        url: 'product.del/' + id,
                    })
                    .done(function (data) {
                        alert("產品編號 " + id + " 的產品已成功刪除！");
                        getProductList("productJsonView")
                    })
                } else {
                    txt = "您已取消刪除！";
                }
            }
            if ($(this).hasClass("upl")) {
            	console.log(productList)
                let p = findProductById(id);
                console.log(p)
                $(".productListView,.pagination").hide()
                $("#iPDiv").show()
                $("#insProduct").text("放棄修改")
                $("#iPDiv").find("input[name=pId]").val(p.productId)
                $("#iPDiv").find("input[type=text][name=pName]").val(p.productName)
                $("#iPDiv").find("input[type=text][name=price]").val(p.price)
                $("#iPDiv").find("input[type=text][name=tag]").val(p.tag)
                $("#iPDiv").find("select[name=tagList]").val(tagList.indexOf(p.tag)-8)
                $("#iPDiv").find("textarea[name=intro]").val(p.intro)
                if(p.productImage != null){
                	$("#iPDiv").find("img#Preview").attr("src", "data:image/jpeg;base64," + p.productImage)
                }else{
                	$("#iPDiv").find("img#Preview").attr("src", imgDefault)
            	}
                $("#iPDiv").find("input[type=date][name=uplTime]").val(left(p.uploadTime,10))
                $("#iPDiv").find("input[type=date][name=dwlTime]").val(left(p.downloadTime,10))
                // 現在的時間已經超過上架時間(即為已經開始販售之商品)不可再修改上架時間
                if(Compare(new Date(), p.uploadTime)){
                    $("#iPDiv").find("input[type=date][name=uplTime]").attr('disabled', true)
                }else{
                    $("#iPDiv").find("input[type=date][name=uplTime]").attr('disabled', false)
                }
            }
        })
        createProductPageNum()
    }

    // 點擊新增產品按鈕的事件->若有進行修改按下取消按鈕 跳出詢問放棄的視窗 是則隱藏視窗 並清空資料
    $("#insProduct").click( function () {
        let actionName = $("input[name=pId]").val()!=""?"修改":"新增"
        // $("#iPDiv").load("insertProduct.html")
        if((!productEdit && $("#iPDiv").is(":visible")) || productEdit && $("#iPDiv").is(":visible") && confirm("是否要放棄本次的" + actionName + "？")){
            $("#iPDiv").hide()
            $("input[name=pId]").val("")
            productEdit = false
            $(".productListView,.pagination").show()
            $("#insProduct").text("新增產品")
            $("#iPDiv").find("input[type=date][name=uplTime]").attr('disabled', false)
        }else{
            if(!productEdit){
                $("#insProduct").text("放棄" + actionName)
                $("#iPDiv").find("input[type=text],input[type=Date]").val("")
                $("#iPDiv").find("input[type=Date]").val((new Date()).format("yyyy/MM/dd"))
                $("#iPDiv").find("textarea").val("")
                $("#iPDiv").find("img").attr("src", imgDefault)
                $("#iPDiv").find("input[type=file]").val("")
                $("#iPDiv").show()
                // $("#iPDiv").find("input[type=date][name=uplTime]").attr('disabled',
				// false)
                $(".productListView,.pagination").hide()
            }
        }
    })

    // 新增/修改商品中的重設按鈕 若是修改則回覆該筆資料本來的樣子 不是則清空
    $("#resetProductBean").on("click", function() {
        id= $("input[name=pId]").val()
        if(id != ""){
            p = findProductById( id )
            $("#iPDiv").find("input[type=hidden][name=pId]").val(p.productId)
            $("#iPDiv").find("input[type=text][name=pName]").val(p.productName)
            $("#iPDiv").find("input[type=text][name=price]").val(p.price)
            $("#iPDiv").find("select[name=tagList]").val(tagList.indexOf(p.tag)-8)
            $("#iPDiv").find("textarea[name=intro]").val(p.intro)
            $("#iPDiv").find("img#Preview").attr("src", "data:image/jpeg;base64," + p.productImage)
            $("#iPDiv").find("input[type=date][name=uplTime]").val(p.uploadTime.format("yyyy/MM/dd"))
            $("#iPDiv").find("input[type=date][name=dwlTime]").val(p.downloadTime.format("yyyy/MM/dd"))
        }else{
            $("#iPDiv").find("input:not([type=button]),textarea").val("")
            $("#iPDiv").find("img#Preview").attr("src", imgDefault)
            $("#iPDiv").find("select[name=tagList]").val(0)
        }
        $("#iPDiv").find("input[type=file]").val("")
    })
    
    // 新增/修改商品中的送出按鈕
    $("input#sendProductBean").on("click", function() {
    	var formdata = new FormData();
    	formdata.append("id" , $("input[name=pId]").val())
    	formdata.append("pName" , $("input[name=pName]").val())
    	formdata.append("price" , $("input[name=price]").val())
    	formdata.append("intro" , $("input[name=price]").val())
    	formdata.append("tag" , tagList[parseInt($("select[name=tagList]").val())+8])
    	formdata.append("uplTime" , $("input[name=uplTime]").val())
    	formdata.append("dwlTime" , $("input[name=dwlTime]").val())
    	formdata.append("file" , $("input#pfile").get(0).files[0])
    	
    	$.ajax({
			url: "productBean",
			type: "POST",
			data: formdata,
		    async: false,
		    cache: false,
		    contentType: false,
		    processData: false,
		    success: function(data){
				alert("您已成功新增了一筆資料")
			},
			error: function(data){
				alert("新增時發生了技術性的失誤！")
			}
		}).done(function() {
			getProductList("productJsonView")
		})
    })

    // 圖片直接替代 input/file
    $('#pfile').on("change", function () {
        var file = $('#pfile')[0].files[0];
        var reader = new FileReader;
        reader.onload = function (e) {
            $('#Preview').attr('src', e.target.result);
        };
        reader.readAsDataURL(file);
        productEdit = true
    });
    $("#Preview").on("click", function() {
        $("#pfile").click();
    })

    // 產品的上/下架時間 判斷 (目前只有判斷 下架日必須在上架日之後 且兩個日期都是[目前時間]之後)
    $("input[type=date]#uplTime").attr("min", (new Date()).format("yyyy-MM-dd")).on("change", function(){
        if(Date.parse($(this).val()).valueOf() > Date.parse($("input[type=date]#dwlTime").val()).valueOf() && Date.parse($("input[type=date]#dwlTime").val()).valueOf != null) {
            alert("到期日不得超過開始日")
            $("input[type=date]#dwlTime").val($(this).val())
        }
        $("input[type=date]#dwlTime").attr("min", $(this).val())
    })

    // 顯示/隱藏目前沒有再販售的商品
    $("#hideProductNotSales").on("click", function() {
        if($(".expired,.notyet").hasClass("hideClass")){
            $(".expired,.notyet").removeClass("hideClass")
            $(this).text("只顯示正在販售的商品")
        }else {
            $(".expired,.notyet").addClass("hideClass")
            $(this).text("顯示全部商品")
        }
        createProductPageNum()
    })

    // 判斷新增/修改狀態有沒有進行動作(方便關掉視窗時提醒放棄修改)
    $("#iPDiv").find("input,textarea").on("change", function() {
        productEdit = true
    })

    // 產生產品的頁碼
    function createProductPageNum(){
        pAllPage = Math.ceil( $("#productList>tr:not(.hideClass)").length / pPerPageNum )
        let txt = "<li><a href='#' class='button special'>Previous</a></li>"
        for(let i=0;i<pAllPage;i++){
            txt += "<li class='page'><a href='#'>" + (i + 1) + "</a></li>"
        }
        txt += "<li><a href='#' class='button special'>Next</a></li>"
        $("ul.pagination").html(txt)

        // 此為翻頁的事件(翻到第幾頁)
        function turningPPage(page) {
            trLen = $("#productList>tr:not(.hideClass)").length
            $("#productList>tr:not(.hideClass)").hide()
            for(let i=(page-1)*pPerPageNum;i<page*pPerPageNum;i++){
                $("#productList>tr:not(.hideClass)").eq(i).show()
            }
        }

        
        // 點擊上/下頁的動作
        $("a.button.special").on("click", function() {
            let page = parseInt($("li.page.current>a").text())
            actionName = $(this).text()
            if( page > 1 && actionName == "Previous" ){
				$("li.page").eq(page-2).addClass("current").siblings().removeClass("current")
                turningPPage(page-1)
            }else if( page < pAllPage && actionName == "Next" ){
				$("li.page").eq(page).addClass("current").siblings().removeClass("current")
                turningPPage(page+1)
            }
        })

        // 點擊頁碼後的動作
        $("li.page>a").on("click", function() {
            $(this).closest("li.page").addClass("current").siblings().removeClass("current")
            turningPPage($(this).text())
        })
        
        // 讓一開始都在第一頁
        $("li.page>a").eq(0).click()


    }
// ------------------------------------------ 以下為活動的 JS -------------------------------------------------
//活動標籤跳選
    $("#insEvent").click(function(){
    	$("#tab2").hide();
    	$("#tab1").hide();
    	$("#tab0").show();
    	$("#selectButton").hide();
    });
    
    $("#qurEvent").click(function(){
    	$("#tab2").hide();
    	$("#tab0").hide();
    	$("#tab1").show();
    	$("#selectButton").show();
    	createEventPagesNum();
    })
	
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
	
	// 修改
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
	
	
	// ShowQueryAllEvent
	function reloadAllEvent(){
		console.log('QueryAll:run');
	$.ajax({
		url : "queryAllEvent",
		dataType : "json",
		type : "GET",
		success : function(response) {
			console.log('queryResopnse', response);
			// console.log('QueryAll:2');
			var txt = "";
			for (let i = response.length-1; i >= 0; i--) {
				var id = response[i].eventId;
				txt += "<tr><td>"+ response[i].eventId;
				txt += "<td>"+ response[i].productId;
				txt += "<td><img src='data:image/jpeg;base64," + response[i].eventImage + "' style='width:200px;hight:150px;'>";
				txt += "<td>"+ response[i].eventName;
				txt += "<td><button class='contentButton' type='button' >內文</button>";		
				txt += "<td>"+ response[i].startDate;
				txt += "<td>"+ response[i].endDate;
				txt += '<td><button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal" id="queryUpdateData">修改</button>';				
				txt += '<td><button type="button" class="btn btn-danger" id="delete">刪除</button>';
				txt += "<tr class='content' hidden><td id='"+id+"' colspan='9'>"+response[i].content+"</td></tr>"
						
			}
			$('#queryAllEvent').html(txt);

			$("button.contentButton").on("click",function(){
				console.log('content');
				$(this).closest("tr").next().toggle();
		    })
		    createEventPagesNum();
			console.log('ShowQueryAllEvent:OK');
		}
	});
	}
	
	// searchAllData
	$(document).on('click', '#searchAllData', function() {
		$.ajax({
			url : "queryAllEvent",
			dataType : "json",
			type : "GET",
			success : function(response) {
				console.log('queryResopnse',response);								
				var txt = "";
				for (let i = 0; i < response.length; i++) {
					var id = response[i].eventId;
					txt += "<tr><td>"+ response[i].eventId;
					txt += "<td>"+ response[i].productId;
					txt += "<td><img src='data:image/jpeg;base64," + response[i].eventImage + "' style='width:200px;hight:150px;'>";
					txt += "<td>"+ response[i].eventName;
					txt += "<td><button class='contentButton' type='button' >內文</button>";
					txt += "<td>"+ response[i].startDate;
					txt += "<td>"+ response[i].endDate;
					txt += '<td><button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal" id="queryUpdateData">修改</button>';									
					txt += '<td><button type="button" class="btn btn-danger" id="delete">刪除</button>';
					txt += "<tr class='content' hidden><td id='"+id+"' colspan='9'>"+response[i].content+"</td></tr>";
					console.log('searchAllData:OK');
				}
				$('#queryAllEvent').html(txt);	
				//
				$("button.contentButton").on("click",function(){
					console.log('content');
			       // $(this).closest("tr").next("tr.content").removeClass("hideClass")//.css("background-color","red")
					$(this).closest("tr").next().toggle();
			    })
			}
		});
	})
	
	var eventId = null;					
	// addEvent
	$(document).on('click', '#add', function() {
		alert("新增成功");
	});
	// 選擇圖檔立即顯現
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
	//
	$("#imageUpdate").change(function(){
		var file = $('#imageUpdate')[0].files[0];
		var reader = new FileReader;
		reader.onload = function(e) {
			$('#preview_Image2').attr('src', e.target.result);
		};
		reader.readAsDataURL(file);
	});
	$("#preview_Image2").click(function(){
		$("#imageUpdate").click();
	});

	// deleteEvent
	$(document).on('click', '#delete', function() {
		var checkstr = confirm("確定是否刪除該活動?");
		if (checkstr == true) {
			var $tr = $(this).parents("tr");
			eventId = $tr.find("td").eq(0).text(); // 抓取id值
			console.log('eventId=' + eventId);
			$(this).parents("tr").remove(); // 刪除整個欄位

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

	// queryUpdateData
	$(document).on('click', '#queryUpdateData', function() {
		var $tr = $(this).parents("tr");
		eventId = $tr.find("td").eq(0).text(); // 抓取id值
		console.log('eventId=' + eventId);
		$("#tab0").hide();
		$("#tab1").hide();
		$("#tab2").show();
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
	// searchButton
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
				var txt = "";
				txt += "<tr class='thistr'><td>"+ response.eventId;
				txt += "<td>"+ response.productId;
				txt += "<td><img src='data:image/jpeg;base64," + response.eventImage + "' style='width:200px;hight:150px;'>";
				txt += "<td>"+ response.eventName;
				txt += "<td><button class='contentButton' type='button' >內文</button>";			
				txt += "<td>"+ response.startDate;
				txt += "<td>"+ response.endDate;
				txt += '<td><button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal" id="queryUpdateData">修改</button>';						
				txt += '<td><button type="button" class="btn btn-danger" id="delete">刪除</button>';	
				txt += "<tr class='content' hidden><td  colspan='9'>"+response.content+"</td></tr>";
				$('#queryAllEvent').html(txt);	
				$("button.contentButton").on("click",function(){
					console.log('content');
					$(this).closest("tr").next().toggle();
			    })
//			    $(".thistr").on("click",function(){
//					console.log('content');
//					$(this).closest("tr").next().toggle();
//			    })
			},
		});				
	});
	
	
	// UpdateEventData
	$(document).on('click', '#SaveButton', function() {
		var myForm = document.getElementById('updateForm');
		var formData = new FormData(myForm);
		
		var updateImage =$('#imageUpdate').get(0).files[0];			
// console.log('content:'+responseEditorcontent.getData());
		console.log(updateImage);
		console.log("eventId1:",eventId);
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
					// console.log(response);
					console.log("Save ok");	
					alert("修改成功");	
					$("#tab1").show();
					$("#tab2").hide();
					// location.reload();
					reloadAllEvent();
				},
			});				
		});
	$(document).ready(function(){
		reloadAllEvent()
		createEventPagesNum()
	});
})


//-----活動頁面
 	// 產生活動的頁碼
	var ePerPageNum = 4;	//一頁幾筆
	var eAllPage=1;
	//var page = $("li.page>a").val();

	function createEventPagesNum(){
		var allDatalen = $("#tab1 tr:not(.content)").length;
		console.log('ePage',$("#tab1 tr:not(.content)").length);
		eAllPage = Math.ceil( (allDatalen) / ePerPageNum )
		let txt = "<li><a href='#' class='button special'>Previous</a></li>" //上一頁
		for(let i=0;i<eAllPage;i++){
	        txt += "<li class='page'><a href='#'>" + (i + 1) + "</a></li>"	//頁碼數
	    }	
		txt += "<li><a href='#' class='button special'>Next</a></li>"	//下一頁
	    $("#tab1 ul.pagination").html(txt)	
	
	

        // 此為翻頁的事件(翻到第幾頁)
        function turningEPage(page) {
			console.log('page',page);
            trLen = $("#queryAllEvent tr:not(.content)").length
            $("#queryAllEvent tr").hide()
            for(let i=(page-1)*ePerPageNum;i<page*ePerPageNum;i++){
                $("#queryAllEvent tr:not(.content)").eq(i).show()
            }
        }

     
            // 點擊上/下頁的動作
            $("#tab1 a.button.special").on("click", function() {
            	console.log('thispage',parseInt($("#tab1 li.page.current>a").text()))
                let page = parseInt($("#tab1 li.page.current>a").text())
                actionName = $(this).text()
                if( page > 1 && actionName == "Previous" ){
    				$("#tab1 li.page").eq(page-2).addClass("current").siblings().removeClass("current")
                    turningEPage(page-1)
                }else if( page < eAllPage && actionName == "Next" ){
    				$("#tab1 li.page").eq(page).addClass("current").siblings().removeClass("current")
                    turningEPage(page+1)
                }
            })

            // 點擊頁碼後的動作
            $("#tab1 li.page>a").on("click", function() {
                $(this).closest("li.page").addClass("current").siblings().removeClass("current")
                turningEPage($(this).text())
            })

            // 讓一開始都在第一頁
            //turningEPage(1)
            $("#tab1 li.page").eq(0).find("a").click()
            
	}    
//jquery test
	

// ---------------------------------------------------- End Document.ready -----------------------------------------------


// 取字串左邊 num 位出來
function left(str, num) {
    return str.substring(0,num)
}

// 用產品編號查詢該產品的物件
function findProductById(id) {
	for (let i = 0; i < productList.length; i++) {
        if (parseInt(productList[i].productId) == parseInt(id)) {
            return productList[i]
        }
    }
}

// 傳入兩個時間參數 x, y 並比較 x 是否比 y 大，是則回傳 true
function Compare(x, y) {
    a = Date.parse(x).valueOf()
    b = Date.parse(y).valueOf()
    if (a > b) {
        return true
    } else {
        return false
    }
}

// 新增 JavaScript Data格式設定 .format 函數
// 參考資源 https://dotblogs.com.tw/felixfu/2014/12/29/147856
Date.prototype.format = function(fmt){
    var o = {
        "M+": this.getMonth() + 1, // 月份
        "d+": this.getDate(), // 日
        "h+": this.getHours(), // 小时
        "m+": this.getMinutes(), // 分
        "s+": this.getSeconds(), // 秒
        "q+": Math.floor((this.getMonth() + 3) / 3), // 季度
        "S": this.getMilliseconds() // 毫秒
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
}

var productList;
var imgDefault = "../img/BmsDefualtImg.jpg"
var productEdit = false
var pPerPageNum = 5
var pAllPage = 0
var pPage = 0

// 遊戲分類中英文對照參考
// https://blog.xuite.net/foreveriori/game/33551587-%E9%81%8A%E6%88%B2%E9%A1%9E%E5%9E%8B%E8%8B%B1%E6%96%87%E5%90%8D%E8%A9%9E%E8%A7%A3%E9%87%8B
var tagList = [
    "RTS",// "策略",
    "RPG",// "角色扮演",
    "STG",// "射擊",
    "Action",// "模擬",
    "AVG",// "冒險",
    "ETC",// "休閒",
    "SPG",// "運動",
    "Horror",// "恐怖"
    "策略",
    "角色扮演",
    "射擊",
    "模擬",
    "冒險",
    "休閒",
    "運動",
    "恐怖"
]

// 產品狀態表
var pStatus = [
    "expired",
    "valid",
    "notyet",
    "已下架",
    "販售中",
    "未上架"
]

// 找分類陣列中索引
function tagListIndexOf(str) {
    for(let i=0;i<tagList.length;i++){
        if(str==tagList[i]){
            return i
        }
    }
}




