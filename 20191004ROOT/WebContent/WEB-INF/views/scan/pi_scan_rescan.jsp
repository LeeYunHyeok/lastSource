<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="../../include/header.jsp"%>

<!-- 업무타이틀(location)
		<div class="banner">
			<div class="container">
				<h2 class="ir">업무명 및 현재위치</h2>
				<div class="title_area">
					<h3>스캔 관리</h3>
					<p class="location">스캔 관리 > 스캔 스캐줄</p>
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
				<p class="location">스캔 관리 > 재검색 정책</p>
			</div>
			<div class="grid_top">
				<h3>재검색 정책</h3>
				<div class="list_sch">
					<div class="sch_area">
						<button type="button" name="button" class="btn_new" id="btnDefaultPolicy">기본 정책 설정</button>
						<button type="button" name="button" class="btn_new" id="btnPolicyRegist">정책 등록</button>
						<button type="button" name="button" class="btn_new" id="btnPolicyModify">정책 변경</button>
					</div>
				</div>
			</div>
			<div class="left_box2 heightM minW" style="overflow: hidden; max-height: 700px; height: 700px;">
				<table id="targetGrid"></table>
			</div>
		</div>
	</div>
	<!-- container -->
</section>
<!-- section -->
<!-- section -->
<%@ include file="../../include/footer.jsp"%>
<script>

function createRadio(cellvalue, options, rowObject) {
	var value = options['rowId'];
    var str = '<input type="radio" name="gridRadio" value="' + value + '" id="gridRadio' + value + '">';
    return str;
}

$(document).ready(function () { 
	
	
	$("#btnPolicyRegist").click(function(){
		window.location = "${pageContext.request.contextPath}/scan/pi_policy_insert";
	});
	
	var gridWidth = $("#targetGrid").parent().width();
	var gridHeight = $("#targetGrid").parent().height();
	$("#targetGrid").jqGrid({
		//url: 'data.json',
		url: "<%=request.getContextPath()%>/scan/viewScanPolicy",
		datatype: "json",
	   	mtype : "POST",
	   	ajaxGridOptions : {
			type    : "POST",
			async   : true
		},
		colNames:['','','이름','버전','닐짜','기타', '기본정책'],
		colModel: [
			{ index: 'CHKBOX', 		name: 'CHKBOX',		width: 10,  align: 'center', editable: true, edittype: 'checkbox', 
				editoptions: { value: '1:0' }, formatoptions: { disabled: false }, formatter: createRadio
			},
			{ index: 'idx', 			name: 'idx',				align: 'center',	width: 10},
			{ index: 'policy_name', 	name: 'policy_name',		align: 'center',	width: 150},
			{ index: 'policy_version', 	name: 'policy_version', 	align: 'center',	width: 150},
			{ index: 'DATE', 			name: 'DATE',		 		align: 'center',	width: 150},
			{ index: 'comment', 		name: 'comment', 			align: 'center',	width: 150},
			{ index: 'default_check', 	name: 'default_check', 		hidden:true}
		],
	    search: true,			
		loadonce:true,
		viewrecords: true, // show the current page, data rang and total records on the toolbar
		width: gridWidth,
		height: gridHeight,
		loadonce: true, // this is just for the demo
		rownumbers : false, // 행번호 표시여부
		rownumWidth : 75, // 행번호 열의 너비	
		rowNum:25, 
	   	rowList:[25,50,100],
		pager: "#targetGridPager",
	  	onSelectRow : function(rowid,celname,value,iRow,iCol) {
	  		var rowid = $("#targetGrid").getGridParam("selrow");
	  		console.log("rowid : "+rowid);
	  		$("#gridRadio" + rowid).prop('checked', true);
	  	},
	  	afterEditCell: function(rowid, cellname, value, iRow, iCol){
			if (cellname == 'CHKBOX'){
			    $("#targetGrid").saveCell(iRow,iCol);
			}   
		},  
		loadComplete: function(data) {
			for(var i=0 ; i < data.length ; i++){
				if(data[i].default_check == 1){
					i += 1
					$("#gridRadio" + i).prop('checked', true);
				}
			}
	    },
	    gridComplete : function() {
	    }
	}).filterToolbar({
		  autosearch: true,
		  stringResult: true,
		  searchOnEnter: true,
		  defaultSearch: "cn"
	});
	
	
	$("#btnDefaultPolicy").click(function(){
		
		var rowid = $("#targetGrid").getGridParam("selrow");
		if (rowid == null) {
			alert("정책을 먼저 등록해주세요.")
		} else {
			var defaultChk = confirm("선택한 정책을 기본정책으로 설정하시겠습니까?");
			var setDefaultidx =  {idx: $("input:radio[name=gridRadio]:checked").val()};
			
			if (defaultChk) { 
				$.ajax({
			        type: "POST",
			        url: "/scan/updateDefaultPolicy/",
			        async: false,
			        data: setDefaultidx,
			        success: function (resultMap) {
			        	
			        	console.log(resultMap);
				        if (resultMap.resultCode == 0) {
				        	alert("기본 정책이 변경 되었습니다.");
				        	return;
					    }
				        else {
				        	alert("기본 정책 변경을 실패 하였습니다.");
				        	console.log(resultMap.resultMessage);
						}
			        },
			        error: function (request, status, error) {
			            alert("기본 정책 변경을 실패 하였습니다.");
			        }
			    });
			} else {
				
			}
		}
		
	});
	
	$("#btnPolicyModify").click(function(){

		if ($("input:radio[name=gridRadio]:checked").val() == null) {
			alert("변경할 정책을 선택하세요")
		} else {
			var form = document.createElement('form');
			var objs;

			objs = document.createElement('input');
	        objs.setAttribute('type', 'hidden');
	        objs.setAttribute('name', "idx");
			objs.setAttribute('value', $("input:radio[name=gridRadio]:checked").val());
			form.appendChild(objs);
			form.setAttribute('method', 'post');
			form.setAttribute('action', "/scan/pi_scan_modify");
			document.body.appendChild(form);
			form.submit();
		}
	}); 
		
});
</script>

</body>
</html>