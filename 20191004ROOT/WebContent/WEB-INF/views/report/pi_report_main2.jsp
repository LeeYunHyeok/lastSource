<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="../../include/header.jsp"%>

<!-- section -->
<section>
	<!-- container -->
	<div class="container">
	<%@ include file="../../include/menu.jsp"%>
		<!-- content -->
		<div class="content magin_t45">
			<div class="location_area">
				<p class="location">리포트관리 > 전체서버 리포트</p>
			</div>
			<!-- <div class="left_area2">
				<h3>서버 리스트</h3>
				<div class="left_box2"
					style="overflow: hidden; max-height: 732px; height: 732px;">
					<div class="search_area bold">
						<input type="text" id="txt_host" value="" style="width: 300px"
							placeholder="호스트 이름을 입력하세요.">
						<button type="button" id="btn_search" style="right: 5px;">검색</button>
					</div>
					<table id="targetGrid"></table>
					<div id="targetGridPager"></div>
				</div>
			</div>
 -->
			<div class="grid_top">
				<h3>임시 데이터 가져오기</h3>

				<div class="list_sch">
					<div class="sch_area">
						<button type="button" name="button" class="btn_new"
							id="btnExceptionRegist">예외 등록</button>
						<button type="button" name="button" class="btn_new"
							id="btnDeletionRegist">삭제 등록</button>
					</div>
				</div>
			</div>
			<div class="left_box2"
				style="overflow: hidden; max-height: 732px; height: 732px;">
				<table id="targetGrid"></table>
			</div>


			<div class="grid_top" style="margin-left: 350px;">
				<table style="width: 100%;">
					<tr>
						<td><h3>VIEW TABLE 가져오기</h3></td>
						<td class="btn_area" style="text-align: right; padding: 0px;">
							<button type="button" id="btnRegistTargetUser" style="margin: 0px;">다운로드</button>
						</td>
					</tr>
				</table>
				<div class="left_box2" style="overflow: hidden; max-height: 732px; height: 732px;">
					<table id="targetGrid"></table>
					<div id="targetGridPager"></div>
				</div>
			</div>
		</div>
	</div>
</section>
<%@ include file="../../include/footer.jsp"%>

<script type="text/javascript">
var postData = {target_id : $("#hostSelect").val()};
var gridWidth = $("#targetGrid").parent().width();
$("#targetGrid").jqGrid({
	url: "<%=request.getContextPath()%>/exception/selectFindSubpath",
	postData : postData,
	datatype: "json",
   	mtype : "POST",
   	ajaxGridOptions : {
		type    : "POST",
		async   : true
	},
	colNames:['호스트','주민번호','외국인번호','여권번호','운전번호','합계'],
	colModel: [		
		{ index: 'OWNER',		name: 'OWNER',		width: 200, align: 'center'},
		{ index: 'TYPE1',		name: 'TYPE1', 		width: 100, align: 'right', formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}},
		{ index: 'TYPE2',		name: 'TYPE2', 		width: 100, align: 'right', formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}},
		{ index: 'TYPE3',		name: 'TYPE3', 		width: 100, align: 'right', formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}},
		{ index: 'TYPE4',		name: 'TYPE4', 		width: 100, align: 'right', formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}},
		{ index: 'TYPE',		name: 'TYPE', 		width: 100, align: 'right', formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}},
	],
	loadonce :true,
	viewrecords: false, // show the current page, data rang and total records on the toolbar
	width: gridWidth,
	height: 660,
	loadonce: true, // this is just for the demo
   	autowidth: true,
	shrinkToFit: true,
	rownumbers : false, // 행번호 표시여부
	rownumWidth : 75, // 행번호 열의 너비	
	rowNum:1000000,
	// multiselect:true,
   	// rowList:[10,20,30],			
	// pager: "#targetGridPager",
	// enable tree grid
	treeGrid:true,
	treeGridModel :"adjacency",
    ExpandColumn :"SHORTNAME",
    ExpandColClick: true,
    //caption: "Tree Grid Example",
    treeReader :{
		level_field :"LEVEL",
		parent_id_field :"PID",
		leaf_field : "LEAF",
		expand_field : "EXPAND"
	},
	jsonReader : {
		id : "ID"
	}
});
</script>

</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="../../include/header.jsp"%>

<section>
	<!-- container -->
	<div class="container">
	<%@ include file="../../include/menu.jsp"%>
		<div class="content magin_t45">
			<div class="location_area">
				<p class="location">리포트관리 > 전체서버 리포트</p>
			</div>
			<!-- <div class="left_area2">
				<h3>서버 리스트</h3>
				<div class="left_box2"
					style="overflow: hidden; max-height: 732px; height: 732px;">
					<div class="search_area bold">
						<input type="text" id="txt_host" value="" style="width: 300px"
							placeholder="호스트 이름을 입력하세요.">
						<button type="button" id="btn_search" style="right: 5px;">검색</button>
					</div>
					<table id="targetGrid"></table>
					<div id="targetGridPager"></div>
				</div>
			</div>
 -->
			<div class="grid_top" style="margin-left: 350px;">
				<table style="width: 100%;">
					<tr>
						<td><h3>VIEW TABLE 가져오기</h3></td>
						<td class="btn_area" style="text-align: right; padding: 0px;">
							<button type="button" id="btnRegistTargetUser" style="margin: 0px;">다운로드</button>
						</td>
					</tr>
				</table>
				<div class="left_box2" style="overflow: hidden; max-height: 732px; height: 732px;">
					<table id="targetGrid"></table>
					<div id="targetGridPager"></div>
				</div>
			</div>
		</div>
	</div>
</section>
<%@ include file="../../include/footer.jsp"%>

<script type="text/javascript">
jQuery("#targetGrid").jqGrid({
	datatype: "local",
	height: 250,
   	colNames:['호스트이름','검출시간', '주민번호', '외국인번호','여권번호','운전번호','합계'],
   	colModel:[
   		{name:'id',index:'id', width:60, sorttype:"int"},
   		{name:'invdate',index:'invdate', width:90, sorttype:"date"},
   		{name:'name',index:'name', width:100},
   		{name:'amount',index:'amount', width:80, align:"right",sorttype:"float"},
   		{name:'tax',index:'tax', width:80, align:"right",sorttype:"float"},		
   		{name:'total',index:'total', width:80,align:"right",sorttype:"float"},		
   		{name:'note',index:'note', width:150, sortable:false}		
   	],
   	multiselect: true,
   	caption: "Manipulating Array Data"
});
var mydata = [
		{id:"1",invdate:"2007-10-01",name:"test",note:"note",amount:"200.00",tax:"10.00",total:"210.00"},
		{id:"2",invdate:"2007-10-02",name:"test2",note:"note2",amount:"300.00",tax:"20.00",total:"320.00"},
		{id:"3",invdate:"2007-09-01",name:"test3",note:"note3",amount:"400.00",tax:"30.00",total:"430.00"},
		{id:"4",invdate:"2007-10-04",name:"test",note:"note",amount:"200.00",tax:"10.00",total:"210.00"},
		{id:"5",invdate:"2007-10-05",name:"test2",note:"note2",amount:"300.00",tax:"20.00",total:"320.00"},
		{id:"6",invdate:"2007-09-06",name:"test3",note:"note3",amount:"400.00",tax:"30.00",total:"430.00"},
		{id:"7",invdate:"2007-10-04",name:"test",note:"note",amount:"200.00",tax:"10.00",total:"210.00"},
		{id:"8",invdate:"2007-10-03",name:"test2",note:"note2",amount:"300.00",tax:"20.00",total:"320.00"},
		{id:"9",invdate:"2007-09-01",name:"test3",note:"note3",amount:"400.00",tax:"30.00",total:"430.00"}
		];
for(var i=0;i<=mydata.length;i++)
	jQuery("#list4").jqGrid('addRowData',i+1,mydata[i]);
</script>

</body>
</html>