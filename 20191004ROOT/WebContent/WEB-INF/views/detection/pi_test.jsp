<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../../include/header2.jsp"%>

<!-- 검출관리 -->

<!-- section -->
<section>
	<!-- container -->
	<div class="container">
	<%@ include file="../../include/menu2.jsp"%>
		<div>
			<div>
			<h1>테스트화면</h1>
			</div>
		
			<table class="tbl_input">
				<tbody>
					<tr>
						<th><p id="${item.TARGET_ID}" class="sta_tit" style="cursor:pointer;">item name</p></th>
					</tr>
					<tr>
						<th style="padding-top: 10px;"><p id="${item.TARGET_ID}" class="sta_tit" style="cursor:pointer;">item name</p></th>
					</tr>
					<tr style="display:none;">
						<td style="padding-bottom: 10px;">
							<input type="checkbox" name="chkLocation" id="${targetid}_${item.LOCATION_ID}" data-targetid="${targetid}" data-targetname="${targetname}" data-locationname="${item.NAME}" data-locationid="${item.LOCATION_ID}" onchange="var e=event||window.event; fnUpdateLocation(this,e);"> 
							<label for="check1">${item.NAME} on target ${targetname}</label>
						</td>
					</tr>
					<tr>
						<td>
							<br/>경로 :
							<input type="text" value="" style="padding-left: 5px;" class="width85" onkeyup="var e=event||window.event; fnLocationAdd(this, e);" >
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div>
			<div id="locationList">
			
			</div>
		</div>		
		
	</div>
	<!-- container -->
</section>
<!-- section -->


<script>

function fnLocationAdd(element, e) {
	
	// keycode 13 = enter
	if (e.keyCode != 13) return;0
	if (isNull($(element).val())) return;;

	//console.log(element);
	//console.log(e);

	var time = Date.parse(new Date());
	var targetid = $(element).data("targetid");
	var targetname = $(element).data("targetname");
	// 주의 : 임의로 등록된 Location의 경우 All local files의 LocationID(8987302884414283716)로 넣는다.	 
	var locationid = "8987302884414283716";
	var locationname = $(element).val();
	var id = targetid + "_" + locationid + "_" + time;

	var datas = "data-locationtype='userdefined' data-targetid='" + targetid + "' data-targetname='" + targetname + "' data-locationname='" + locationname + "' data-locationid='" + locationid + "'";
	var scanLocation = "<tr " + datas + " id='" + id + "'>";
	scanLocation += "<th style='text-align:left'> - All files on drive " + locationname + " on target " + targetname + "</th>";
	scanLocation += "<td>";
	scanLocation += "<button type='button' name='button' style='cursor:pointer; color:#1973ba; float:right;' onclick='fnLocationRemove(this);'>remove</button></td>";
	scanLocation += "</tr>";
 
	$("#locationList").append( locationname );
	$(element).val("");
}

</script>
</body>
</html>



/* <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../../include/header2.jsp"%>

<!-- 검출관리 -->


<!-- section -->
<section>
	<!-- container -->
	<div class="container">
	<%@ include file="../../include/menu2.jsp"%>

		<!-- content -->
		<div class="content magin_t45">
			<div class="location_area">
				<p class="location">검출 관리 > 서버 리스트</p>
			</div>
			<div class="left_area2">
				<h3>서버 리스트</h3>
				<div class="left_box2" style="overflow: hidden; max-height: 580px; height: 580px;">
   					<table id="targetGrid"></table>
   					<div id="targetGridPager"></div>
				</div>
				<table class="user_info magin_t1">
					<colgroup>
						<col width="65%">
						<col width="35%">
					</colgroup>
					<tr>
						<th>총 서버 개수</th>
						<td class="ta_r" id="hostCnt">0대</td>
					</tr>
					<tr>
						<th>연결 안된 서버 개수</th>
						<td class="ta_r" id="notLinkHostCnt">0대</td>
					</tr>				
				</table>
			</div>

			<div class="grid_top" style="margin-left: 350px;">
				<h3>파일 TOP N</h3>
				<div class="sch_left" style=" position: absolute; right: 11px; top: 0; width: 300px;">
					검색 : <input type="text" id="txt_host" value="" class="edt_sch" style="width: 263px;">
					<button id="btn_search" class="btn_sch">검색</button>
				</div>
				<div class="left_box2" style="height: 385px; max-height: 385px; overflow: hidden;">
   					<table id="topNGrid"></table>
   					<div id="topNGridPager"></div>
   				</div>
			</div>
		</div>
	</div>
	<!-- container -->
</section>
<!-- section -->

<%@ include file="../../include/footer2.jsp"%>
	
<script>
function ifConnect (cellvalue, options, rowObject) {
	switch (rowObject["AGENT_CONNECTED"]) {
	case '1':
		return '<img src="<%=request.getContextPath()%>/resources/assets/images/icon_con.png" />';
		break;
	case '0':
		return '<img src="<%=request.getContextPath()%>/resources/assets/images/icon_dicon.png" />';
	    break;
    default :
    	return '<img src="<%=request.getContextPath()%>/resources/assets/images/icon_dicon.png" />';
    break;
    }
}
	
$(document).ready(function () {
	
	fn_drawTargetGrid();
	//var gridWidth = $("#targetGrid").parent().width();
	//var gridHeight = $("#targetGrid").parent().height();
	var postData = {};
	$("#targetGrid").setGridParam({url:"<%=request.getContextPath()%>/target/selectUserTargetList", postData : postData, datatype:"json" }).trigger("reloadGrid");

	$('#btn_search').click(function() {
		fn_search();
		/*
		if ($("#txt_host").val() == "") {
			alert("검색할 호스트 이름을 입력하세요");
			console.log("false");
		} else {
			fn_search();
		}
		*/
	});

	//$('#btn_search').click();

});

function fn_drawTargetGrid() {
	var gridWidth = 300;
	var gridHeight = 490;

	$("#targetGrid").jqGrid({
		//url: 'data.json',
		datatype: "local",
	   	mtype : "POST",
	   	ajaxGridOptions : {
			type    : "POST",
			async   : true
		},
		colNames:['호스트 이름','연결상태', '연결상태', 'TARGET_ID'
		],
		colModel: [      
			{ index: 'AGENT_NAME', 			name: 'AGENT_NAME', 		width: 210 },
			{ index: 'AGENT_CONNECTED1', 	name: 'AGENT_CONNECTED1',	width: 65, align: 'center', formatter:ifConnect},
			{ index: 'AGENT_CONNECTED', 	name: 'AGENT_CONNECTED',	width: 250, align: 'center', hidden:true},
			{ index: 'TARGET_ID', 			name: 'TARGET_ID', 			width: 500, hidden : true }
		],
		loadonce: true, // this is just for the demo
		viewrecords: true, // show the current page, data rang and total records on the toolbar
		width: gridWidth,
		height: gridHeight,
	   	autowidth: true,
		shrinkToFit: true,
		rownumbers : false, // 행번호 표시여부
		rownumWidth : 35, // 행번호 열의 너비	
		rowNum:25,
	   	rowList:[25,50,100],			
		pager: "#targetGridPager",
		//jqgrid의 특성상 - rowpos의 이벤트는 onSelectCell, beforeEditCell 다 해주어야 함
	  	onSelectRow : function(rowid,celname,value,iRow,iCol) {

	  		var postData = {target : $(this).jqGrid('getCell', rowid, 'TARGET_ID')};
	  		$("#topNGrid").setGridParam({url:"<%=request.getContextPath()%>/target/selectServerFileTopN", postData : postData, datatype:"json" }).trigger("reloadGrid");
	  		
	  	},
		loadComplete: function(data) {

			if (data.records == 0) {
				fn_drawTopNGrid(); 
				return;
			}
			
			console.log(data);
			$(this).setSelection(1);
			var rowCount = 0;
			var notLinkRowCount = 0;
			
			var userData = $("#targetGrid").jqGrid('getGridParam', 'data');
    		$.each(userData, function(idx, rowId) {
    			rowCount++;
    			rowData = userData[idx];
    			
        		if (rowData.AGENT_CONNECTED != '1') {
        			notLinkRowCount++;
        		}
    		});

			$("#hostCnt").html(rowCount + "대");
			$("#notLinkHostCnt").html(notLinkRowCount + "대");
			
			var postData = {target : $(this).jqGrid('getCell', 1, 'TARGET_ID')};
	  		$("#topNGrid").setGridParam({url:"<%=request.getContextPath()%>/target/selectServerFileTopN", postData : postData, datatype:"json" }).trigger("reloadGrid");
	  		
	    },
	    gridComplete : function() {
	    }
	});
	
	$("#targetGridPager_left").css("display", "none");
	$("#targetGridPager_right").css("display", "none");
}

function fn_drawTopNGrid() {
	
	var gridWidth = $("#topNGrid").parent().width();
	var gridHeight = 285; //$("#targetGrid").parent().height();
	$("#topNGrid").jqGrid({
		//url: "<%=request.getContextPath()%>/target/selectServerFileTopN",
		datatype: "local",
	   	mtype : "POST",
		colNames:['경로','소유자','검출 갯수'],
		colModel: [
			{ index: 'PATH', 	name: 'PATH', 	editable: true, width: 500 },
			{ index: 'OWNER', 	name: 'OWNER', 	width: 150, align: "center" },
			{ index: 'TYPE', 	name: 'TYPE', 	width: 150, align: "right" },
		],
		loadonce:false,
	   	autowidth: true,
		shrinkToFit: true,
		viewrecords: true, // show the current page, data rang and total records on the toolbar
		width: gridWidth,
		height: gridHeight,
		rownumbers : false, // 행번호 표시여부
		rownumWidth : 35, // 행번호 열의 너비	
		rowNum:25,
	   	rowList:[25,50,100],
	   	//editurl: 'clientArray',
	   	//cellEdit : true,
	   	//cellsubmit: 'clientArray',
	   	//multiselect:true,
		pager: "#topNGridPager",
		//jqgrid의 특성상 - rowpos의 이벤트는 onSelectCell, beforeEditCell 다 해주어야 함
	  	onSelectRow : function(rowid,celname,value,iRow,iCol) {	
	  		
	  	},
	  	afterSaveCell : function(rowid,name,val,iRow,ICol){ // 로우 데이터 변경하고 엔터치거나 다른 셀 클릭했을때 발동
	    },
	  	afterSaveRow : function(rowid,name,val,iRow,ICol){ // 로우 데이터 변경하고 엔터치거나 다른 셀 클릭했을때 발동
	    },
		loadComplete: function(data) {
			//console.log(data);
	    },
	    gridComplete : function() {
	    }
	});
}

function fn_search() {
	var postData = {host : $("#txt_host").val()};
	
	$("#targetGrid").setGridParam({url:"<%=request.getContextPath()%>/target/selectUserTargetList", postData : postData, datatype:"json" }).trigger("reloadGrid");
	console.log(postData);
}

</script>
</body>
</html> */