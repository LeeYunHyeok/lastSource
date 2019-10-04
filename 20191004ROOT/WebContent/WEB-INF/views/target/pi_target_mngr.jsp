<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="../../include/header.jsp"%>

 
		<!-- 업무타이틀(location)
		<div class="banner">
			<div class="container">
				<h2 class="ir">업무명 및 현재위치</h2>
				<div class="title_area">
					<h3>타겟 관리</h3>
					<p class="location">타겟 관리 > 타겟 관리</p>
				</div>
			</div>
		</div>
		<!-- 업무타이틀(location)-->

		<!-- section -->
		<section>
			<!-- container -->
			<div class="container">
			<%@ include file="../../include/menu.jsp"%>

				<!-- content -->
				<div class="content magin_t45">
					<div class="location_area">
						<p class="location">타겟관리 > 타겟조회</p>
					</div>
					<div class="left_area2" style="height: 700px;">
						<h3>서버 리스트</h3> 
						<div class="left_box2" style="overflow: hidden; max-height: 760px; height: 760px;">
		   					<div class="search_area bold">
								<input type="text" id="txt_host" value="" style="width: 320px" placeholder="호스트 이름을 입력하세요.">
								<button type="button" id="btn_search" style="right: -12px;">검색</button>
							</div>
		   					<table id="targetGrid"></table>
		   					<div id="targetGridPager"></div>
						</div>
						<table class="user_info magin_t1">
							<colgroup>
								<col width="65%">
								<col width="35%">
							</colgroup>
							<tr>
								<th style="color:#fff;">총 서버 개수</th>
								<td class="ta_r" id="hostCnt">0대</td>
							</tr>
							<tr>
								<th style="color:#fff;">연결 안된 서버 개수</th>
								<td class="ta_r" id="notLinkHostCnt">0대</td>
							</tr>				
						</table>
					</div>
					
					<div class="grid_top" style="margin-left: 350px; height: 100%;">
						<h3>검출 건 수 TOP N</h3> 
						<div class="left_box2" style="height: 400px; overflow: hidden;">
		   					<table id="topNGrid"></table>
		   				 	<div id="topNGridPager"></div>
		   				</div>
					</div>
					
					<div class="grid_top magin_t3" style="margin-left: 350px;"> 
						<h3>서버 정보</h3>
						<table class="user_info">
							<caption>서버정보</caption>
							<colgroup>
								<col width="15%">
								<col width="35%">
								<col width="15%">
								<col width="35%">
							</colgroup>
							<tbody>
								<tr>
									<th>서버이름</th>
									<td id="HostName">-</td>
									<th>IP</th>
									<td id="agent_ip">-</td>
								</tr>
								<tr>
									<th>OS</th>
									<td id="PlatformName">-</td>
									<th>버전</th>
									<td id="AgentVer">-</td>
								</tr>
								<tr>
									<th>CPU</th>
									<td colspan="3" id="agent_cpu">-</td>
								</tr>
								<tr>
									<th>CORE</th>
									<td id="agent_core">-</td>
									<th>연결상태</th>
									<td id="agent_connected"><span class="diconnect">-</span></td>
								</tr>
								<tr>
									<th>RAM</th>
									<td id="agent_mem">-</td>
									<th>마지막스캔</th>
									<td id="searchDatetime">-</td>
								</tr>
							</tbody>
						</table>
					</div>
					
					<div class="grid_top magin_t3" style="margin-left: 350px;">
						<h3>서버 담당자</h3>
						<div class="left_box2" style="height: 385px; max-height: 385px; overflow: hidden;">
		   					<table id="userGrid"></table>
		   					<div id="userGridPager"></div>
		   				</div>
					</div>
				</div>
			</div>
			<!-- container -->
		</section>
		<!-- section -->

	<%@ include file="../../include/footer.jsp"%>

<script type="text/javascript">

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

// 호스트 검색 fn
function fn_search() {
	var postData = {host : $("#txt_host").val()};
	
	$("#targetGrid").setGridParam({url:"<%=request.getContextPath()%>/target/pi_target_list", postData : postData, datatype:"json" }).trigger("reloadGrid");
	console.log(postData);
}

$(document).ready(function () {
	$('#btn_search').click(function() {
		fn_search();
	});
});
 
$(document).ready(function () {
	//var gridWidth = $("#targetGrid").parent().width();
	//var gridHeight = $("#targetGrid").parent().height();
	$("#targetGrid").jqGrid({
// 		url: 'data.json',
		url: "<%=request.getContextPath()%>/target/pi_target_list",
		postData : {}, 
		datatype:"json", 
//		datatype: "local",
	   	mtype : "POST",
	   	ajaxGridOptions : {
			type    : "POST",
			async   : true
		},
		colNames:['호스트 이름','연결상태', '연결상태', '최종 스캔날짜', '등록일자',
			'에이전트 버전',
			'에이전트 플랫폼',
			'에이전트 플랫폼이름',
			'에이전트 플랫폼 적합성',
			'에이전트 사용 확인 유무',
			'에이전트 설치한 유저',
			'에이전트가 설치된 서버의 cpu',
			'에이전트가 설치된 서버의 cpu 코어 수',
			'확인필요',
			'에이전트가 설치된 서버의 메모리(byte)',
			'에이전트 설치 시간 unix time',
			'에이전트가 설치된 서버의 ip',
			'TARGET_ID'
		],
		colModel: [      
			{ index: 'AGENT_NAME', 			name: 'AGENT_NAME', 		width: 210 },
			{ index: 'AGENT_CONNECTED1', 	name: 'AGENT_CONNECTED1',	width: 65, align: 'center', formatter:ifConnect},
			{ index: 'AGENT_CONNECTED', 	name: 'AGENT_CONNECTED',	width: 250, align: 'center', hidden:true},
			{ index: 'SEARCH_DATETIME',		name: 'SEARCH_DATETIME',	width: 250, align: 'center', hidden:true},
			{ index: 'REGDATE',				name: 'REGDATE', 			width: 250, align: 'center', hidden:true},
			{ index: 'AGENT_VERSION',		name: 'AGENT_VERSION', 		width: 250, align: 'center', hidden:true},
			{ index: 'AGENT_PLATFORM',		name: 'AGENT_PLATFORM', 	width: 250, align: 'center', hidden:true},
			{ index: 'AGENT_PLATFORM_COMPATIBILITY',		name: 'AGENT_PLATFORM_COMPATIBILITY', 	width: 250, align: 'center', hidden:true},
			{ index: 'AGENT_VERIFIED',		name: 'AGENT_VERIFIED', 	width: 250, align: 'center', hidden:true},
 			{ index: 'AGENT_CONNECTED',		name: 'AGENT_CONNECTED', 	width: 250, align: 'center', hidden:true},
			{ index: 'AGENT_USER',			name: 'AGENT_USER', 		width: 250, align: 'center', hidden:true},
			{ index: 'AGENT_CPU',			name: 'AGENT_CPU', 			width: 250, align: 'center', hidden:true},
			{ index: 'AGENT_CORES',			name: 'AGENT_CORES', 		width: 250, align: 'center', hidden:true},
			{ index: 'AGENT_BOOT',			name: 'AGENT_BOOT', 		width: 250, align: 'center', hidden:true},
			{ index: 'AGENT_RAM',			name: 'AGENT_RAM', 			width: 250, align: 'center', hidden:true},
			{ index: 'AGENT_STARTED',		name: 'AGENT_STARTED', 		width: 250, align: 'center', hidden:true},
			{ index: 'AGENT_CONNECTED_IP',	name: 'AGENT_CONNECTED_IP', width: 250, align: 'center', hidden:true},
			{ index: 'TARGET_ID', 			name: 'TARGET_ID', 			width: 500, hidden : true }
		],
		loadonce: true, // this is just for the demo
		viewrecords: true, // show the current page, data rang and total records on the toolbar
		width: 300,
		height: 700,
	   	autowidth: true,
		shrinkToFit: true,
		rownumbers : false, // 행번호 표시여부
		rownumWidth : 35, // 행번호 열의 너비	
		rowNum:25,
	   	rowList:[25,50,100],			
		pager: "#targetGridPager",
		//jqgrid의 특성상 - rowpos의 이벤트는 onSelectCell, beforeEditCell 다 해주어야 함
	  	onSelectRow : function(rowid,celname,value,iRow,iCol) {
	  		
	  		$("#topNGrid").clearGridData();		// 우측 grid data 초기화...
	  		
	  		var postData = {target : $(this).jqGrid('getCell', rowid, 'TARGET_ID')};
	  		$("#userGrid").setGridParam({url:"<%=request.getContextPath()%>/target/selectTargetUserList", postData : postData, datatype:"json" }).trigger("reloadGrid");
	  		$("#topNGrid").setGridParam({url:"<%=request.getContextPath()%>/target/selectAdminServerFileTopN", postData : postData, datatype:"json" }).trigger("reloadGrid");
	  		
	  		$("#HostName").html($(this).jqGrid('getCell', rowid, 'AGENT_NAME'));
	  		$("#AgentVer").html($(this).jqGrid('getCell', rowid, 'AGENT_VERSION'));
	  		$("#Platform").html($(this).jqGrid('getCell', rowid, 'AGENT_PLATFORM'));
	  		$("#PlatformName").html($(this).jqGrid('getCell', rowid, 'AGENT_PLATFORM_COMPATIBILITY'));

	  		//if (isNull($(this).jqGrid('getCell', rowid, 'AGENT_VERIFIED'))) $("#confirmYN").html("&nbsp;");
	  		//else if ($(this).jqGrid('getCell', rowid, 'AGENT_VERIFIED') == "1") $("#confirmYN").html("검증 됨");
	  		//else $("#confirmYN").html("검증 안됨");
		
			var AGENT_CONNECTED = $(this).jqGrid('getCell', rowid, 'AGENT_CONNECTED');
			if (AGENT_CONNECTED == "1") {
	  			$("#agent_connected").html("<span>연결됨</span>");

				$("#agent_connected").css({
					'background-image': 'url(/resources/assets/images/icon_con.png)',
					'background-repeat' : 'no-repeat',
					'background-position-x' : '20%',
			    	'background-position-y' : '50%'
				}); 
			}
			else { 
	  			$("#agent_connected").html("<span class='diconnect'>연결안됨</span>");

				$("#agent_connected").css({
					'background-image': 'url(/resources/assets/images/icon_dicon.png)',
					'background-repeat' : 'no-repeat',
					'background-position-x' : '20%',
			    	'background-position-y' : '50%'
				}); 
			}
	  		//$("#agent_user").html($(this).jqGrid('getCell', rowid, 'AGENT_USER'));
	  		$("#agent_cpu").html($(this).jqGrid('getCell', rowid, 'AGENT_CPU'));
	  		$("#agent_core").html($(this).jqGrid('getCell', rowid, 'AGENT_CORES'));

	  		var agentRam = $(this).jqGrid('getCell', rowid, 'AGENT_RAM');
	  		agentRam = Math.round(agentRam/1024/1024/1024);
	  		$("#agent_mem").html(agentRam + " GB");

	  		if (isNull($(this).jqGrid('getCell', rowid, 'AGENT_CONNECTED_IP'))) $("#agent_ip").html("&nbsp;");
	  		else $("#agent_ip").html($(this).jqGrid('getCell', rowid, 'AGENT_CONNECTED_IP'));

	  		$("#searchDatetime").html($(this).jqGrid('getCell', rowid, 'SEARCH_DATETIME'));
	  	},
		loadComplete: function(data) {
			
			fn_drawTopNGrid(); 
			
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
	    },
	    gridComplete : function() {
	    }
	});
	
	$("#targetGridPager_left").css("display", "none");
	$("#targetGridPager_right").css("display", "none");

// 	var postData = {};
//	$("#targetGrid").setGridParam({url:"<%=request.getContextPath()%>/target/pi_target_list", postData : postData, datatype:"json" }).trigger("reloadGrid");

	var gridWidth = $("#userGrid").parent().width();
	var gridHeight = 285; //$("#targetGrid").parent().height();
	$("#userGrid").jqGrid({
		//url: 'data.json',
		datatype: "local",
	   	mtype : "POST",
	   	ajaxGridOptions : {
			type    : "POST",
			async   : true
		},
		colNames:['담당자','직책','사원번호','부서명'],
		colModel: [
			{ index: 'USER_NAME', 	name: 'USER_NAME', 	editable: true,width: 200 },
			{ index: 'JIKGUK', 		name: 'JIKGUK', 	width: 200 },
			{ index: 'USER_NO', 	name: 'USER_NO', 	width: 200 },
			{ index: 'TEAM_NAME', 	name: 'TEAM_NAME', 	width: 200 },
		],
		id: "USER_NO",
		loadonce:true,
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
		pager: "#userGridPager",
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
});

function fn_drawTopNGrid() {
	
	var gridWidth = $("#topNGrid").parent().width();
	$("#topNGrid").jqGrid({
		url: "<%=request.getContextPath()%>/target/selectAdminServerFileTopN",
		datatype: "local",
	   	mtype : "POST",
		colNames:['경로','소유자','검출 갯수'],
		colModel: [
			{ index: 'PATH', 	name: 'PATH', 	editable: true, width: 500 },
			{ index: 'OWNER', 	name: 'OWNER', 	width: 150, align: "center" },
			{ index: 'CNT', 	name: 'CNT', 	width: 150, align: "right" },
		],
		loadonce:true,
	   	autowidth: true,
		shrinkToFit: true,
		viewrecords: true, // show the current page, data rang and total records on the toolbar
		width: gridWidth,
		height: 300,
		rownumbers : false, // 행번호 표시여부
		rownumWidth : 35, // 행번호 열의 너비	
		rowNum:20,
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

</script>

</body>
</html>