<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ include file="../../include/header.jsp"%>
<style>
h3 {
	margin : 40px 0 15px 0;
}
</style>

		<!-- section -->
		<section id="section">
			<!-- container -->
			<div class="container_main">

				<!-- left list-->
				<div class="left_area">
					<h3 class="serverListB"> 서버리스트(농협은행)</h3>
					<div class="left_box">
						<div class="left_list">
						   <div id="tree">
						      <ul>
						         <li class="folder expanded">농협은행
		 				            <ul>
						               <c:forEach items="${aList}" var="agent">
						                   <li class="external">
						                     <!--  <a href="${agent.target_id}" title="${agent.target_id}"> ${agent.agent_name} (${agent.agent_connected_ip}) </a> -->
						                     <a title="${agent.target_id}"> 
						                     <c:choose>
						                     	<c:when test="${agent.agent_connected == true}"><img src="<%=request.getContextPath()%>/resources/assets/images/icon_con.png" /></c:when>
						                     	<c:when test="${agent.agent_connected == false}"><img src="<%=request.getContextPath()%>/resources/assets/images/icon_dicon.png" /></c:when>
						                     </c:choose>
						                     ${agent.agent_name} 
						                     	<c:if test="${fn:length(agent.agent_connected_ip) < 1}">(연결 안됨) </c:if>
						                     	<c:if test="${fn:length(agent.agent_connected_ip) > 1}"> (${agent.agent_connected_ip}) </c:if>
						                     </a>
						                   </li>
						               </c:forEach>
						            </ul>
						         </li>
						      </ul>
						   </div>
						</div>
					</div>
						<table class="user_info magin_t1">
							<colgroup>
								<col width="65%">
								<col width="35%">
							</colgroup>
							<tr>
								<th>총 서버 개수</th>
								<td class="ta_r" id="hostCnt">${fn:length(aList) }대</td>
							</tr>
						</table>
					<div class="left_box magin_t1" style="height: 314px;"> 
						<ul> 
							<li><input type="checkbox" name="pi_type" id="rrn" value="rrn" checked="checked">주민등록번호</li>
							<li><input type="checkbox" name="pi_type" id="foreigner" value="foreigner" checked="checked">외국인등록번호</li>
							<li><input type="checkbox" name="pi_type" id="driver" value="driver" checked="checked">운전면허번호</li>
							<li><input type="checkbox" name="pi_type" id="passport" value="passport" checked="checked">여권번호</li>
							<li><input type="checkbox" name="pi_type" id="account" value="account" disabled>계좌번호</li>
							<li><input type="checkbox" name="pi_type" id="card" value="card" disabled>카드번호</li>
						</ul>
					</div>
				</div> 
 
				<!-- chart area -->
				<div class="chart_area">  
					<h2 class="ir">차트정보</h2>
					<ul>
					  <li class="width80">
					   <h3>4대 개인정보 유형(30일추이)</h3>
					    <div class="date">
					      <select class="" id="days">
					        <option value="days">7일 전</option>
					        <option value="month">1개월 전</option>
					        <option value="three_month">3개월 전</option>
					        <option value="six_month">6개월 전</option>
					        <option value="year" selected>1년 전</option>
					      </select>
					    </div>
					    <div class="chart_box width_57" style="height: 35vw;">
					      <div id="main_graph" style="height: 34vw; width: 57vw;"></div>
							<script type="text/javascript">
						<!-- 첫번째 개인정보 유형 그래프 -->
							function resizeGraph_One(result, status, ansyn) {
								
								console.log(result);
								
								var regdate = [];
								var type1 = [];
								var type2 = [];
								var type3 = [];
								var type4 = [];
								var type5 = [];
								var type6 = [];
								var days = [];
								
								 for(var i = 0; i < result.length; i++){
									days.push(result[i].DAYS);
									type1.push(result[i].TYPE1);
									type2.push(result[i].TYPE2);
									type3.push(result[i].TYPE3);
									type4.push(result[i].TYPE4);
									type5.push(result[i].TYPE5);
									type6.push(result[i].TYPE6);
								} 
								
								var echartPie = echarts.init(document.getElementById('main_graph'));
								echartPie.setOption({
									// 제목
									title : {
										text : '4대 개인정보 유형',
										subtext : '리스트',
										textStyle : {
											fontFamily: 'S-CoreDream-5Medium',
											fontSize : '1vw',
											color : '#5d4fff'
										},
										show : false
									},
									tooltip : {
										trigger : 'axis',
										axisPointer : {
											type : 'shadow'
										}
									},
									// 상단 옵션 데이터 종류
									legend : {
										data : [ '주민등록번호', '외국인등록번호', '운전면허번호', '여권번호', '계좌번호', '카드번호' ]
									},
									
									// 가로
									xAxis : [ {
										type : 'category',
										data : days
									} ],
									// 세로
									yAxis : [ {
										type : 'value'
									} ],
									series : [ {
										name : '주민등록번호',
										type : 'bar',
										data : type1
									}, {
										name : '외국인등록번호',
										type : 'bar',
										data : type2
									}, {
										name : '운전면허번호',
										type : 'bar',
										data : type3
									}, {
										name : '여권번호',
										type : 'bar',
										data : type4
									}, {
										name : '계좌번호',
										type : 'bar',
										data : type5
									}, {
										name : '카드번호',
										type : 'bar',
										data : type6
									} ],
									// 상단 차트종류 옵션 버튼
									toolbox : {
										show : true,
										textStyle: {
											fontFamily: 'S-CoreDream-5Medium',
											fontSize: '1vw'
										},
										feature : {
											dataView : {
												show : true,
												readOnly : false,
												title : '데이터'
											},
											magicType : {
												show : true,
												title: {
										          line: '선형차트',
										          bar: '막태차트',
												},
												type : [ 'line', 'bar' ]
											}, 
											restore : {
												show : true,
												title : '복원'
											},
											saveAsImage : {
												show : true,
												title : '이미지로저장',
												leng : ['저장']
											},
											
										}
									},
								});
							}
						</script>
					    </div>
					  </li>
					  <li style="width: 12vw;">
					    <h3>타겟 정보</h3>
					    <div class="chart_box" style="background: #d6e4ed;">
					      <table>
					        <tr>
					          <td>
					            <p class="target_tit">서버이름</p>
					            <p class="target_info" id="server_name">전체 서버</p>
					          </td>
					        </tr>
					        <tr>
					          <td>
					            <p class="target_tit">OS</p>
					            <p class="target_info" id="os"> </p>
					          </td>
					        </tr>
					        <tr>
					          <td>
					            <p class="target_tit">연결상태</p>
					            <p class="target_info"><span class="diconnect" id="connected"> </span></p>
					          </td>
					        </tr>
					        <tr>
					          <td>
					            <p class="target_tit">IP</p>
					            <p class="target_info" id="ip"> </p>
					          </td>
					        </tr>
					        <tr>
					          <td>
					            <p class="target_tit">Memory</p>
					            <p class="target_info" id="memory"> </p>
					          </td>
					        </tr>
					        <tr>
					          <td>
					            <p class="target_tit">CORE</p>
					            <p class="target_info" id="core"> </p>
					          </td>
					        </tr>
					        <tr>
					          <td>
					            <p class="target_tit">마지막 스캔날짜</p>
					            <p class="target_info" id="last_date"> </p>
					          </td>
					        </tr>
					        <tr>
					          <td>
					            <p class="target_tit">이전 스캔날짜</p>
					            <p class="target_info" id="previous_date"> </p>
					          </td>
					        </tr>
					      </table>
					    </div>
					  </li>
					</ul>
					<div class="clear_l" ></div>

					<ul>
					  <li class="width25" id="rrn_list">
					    <h3>주민등록번호</h3>
					    <div class="chart_box" style="height: 220px; overflow:auto; background: #fefff0;">
					    	<table id="rrn_tbl">
					    	</table>
					    </div>
					  </li>
					  <li class="width25" id="foreigner_list">
					    <h3>외국인등록번호</h3>
					    <div class="chart_box" style="height: 220px; overflow:auto; background: #fefff0;">
					    	<table id="foreigner_tbl">
					    	</table>
					    </div>
					  </li>
					  <li class="width25" id="driver_list">
					    <h3>운전면허</h3>		
					    <div class="chart_box" style="height: 220px; overflow:auto; background: #fefff0;">
							<table id="driver_tbl" >
					    	</table>
					    </div>
					  </li>
					  <li class="width25" id="passport_list">
					    <h3>여권번호</h3>
					    <div class="chart_box" style="height: 220px; overflow:auto; background: #fefff0;">
					    	<table id="passport_tbl">
					    	</table>
					    </div>
					  </li>
					  <li class="width25" id="account_num_list">
					    <h3>계좌번호</h3>
					    <div class="chart_box" style="height: 220px; overflow:auto; background: #fefff0;">
					    	<table id="account_num_tbl">
					    	</table>
					    </div>
					  </li>
					  <li class="width25" id="card_num_list">
					    <h3>카드번호</h3>
					    <div class="chart_box" style="height: 220px; overflow:auto; background: #fefff0;">
					    	<table id="card_num_tbl">
					    	</table>
					    </div>
					  </li>
					</ul>
					<ul>  
						<li style="margin-top: 40px; margin-bottom: 20px; width: 100%;" > 
							<div class="chart_box" style="height: 560px;">
								<div id=circleGraph style="height: 100%; width: 50%; float: left;"></div>
								<script type="text/javascript"> 
								<!-- 원그래프  -->
								function circleGraph(result, status, ansyn) {
									
									var total = [];
									var error = [];
									var searched = [];
									var wait = [];
									var complete = [];
									var pause = [];
									var notconnect = [];
									
									$.each(result, function(key, value){
									    $.each(value, function(key, value){
									        if(key == "TOTAL") total.push(value);
									        if(key == "ERROR") error.push(value);
									        if(key == "SEARCHED") searched.push(value);
									        if(key == "WAIT") wait.push(value);
									        if(key == "COMPLETE") complete.push(value);
									        if(key == "PAUSE") pause.push(value);
									        if(key == "NOTCONNECT") notconnect.push(value);
									        
									    });
									});
								
									var echartdoughnut = echarts.init(document.getElementById('circleGraph'));
									echartdoughnut.setOption({
										title : {
									        text: '시스템현황',
									        x:'center',
									        textStyle: {
												fontFamily: 'S-CoreDream-5Medium',
												fontSize: 20
											}
									    },
									    tooltip : {
									        trigger: 'item',
									        formatter: "{a} <br/>{b} : {c} ({d}%)"
									    }, 
									    legend: {
									        left: 'center',
									        bottom: 10,
									        data:['오류','검색중','조치완료','대기', '일시정지']
									    },
										textStyle: {
											fontFamily: 'S-CoreDream-5Medium',
											fontSize: 16
										},
									    series : [
									        {
									            name: '시스템현황',
									            type: 'pie',
									            radius : ['45%', '70%'],
									            center: '50%',
									            data:[
									                {value:error, name:'오류'},
									                {value:searched, name:'검색중'},
									                {value:wait, name:'대기'},
									                {value:complete, name:'조치완료'},
									                {value:pause, name:'일시정지'}
									            ],
									            itemStyle: {
									                emphasis: {
									                    shadowBlur: 10,
									                    shadowOffsetX: 0,
									                    shadowColor: 'rgba(0, 0, 0, 0.5)'
									                }
									            }
									        }
									    ]
									});
									var totalDiv;
									totalDiv = "<div id='spanid' style='display:inline-block; position:absolute; left: 50%; top:50%; transform: translateX(-50%) translateY(-50%); text-align:center;'>";
									totalDiv += '<h2>미접속수 : ' + notconnect + '</h2>';
									totalDiv += '<h1>총 대상수 : ' + total + '</h1></div>';
									
									$("#circleGraph").append(totalDiv);
								}
								</script>
								
								<div id=bar_graph style="height: 100%; width: 50%; float: left;"></div>
								<script type="text/javascript">
								<!-- 바 그래프  -->
								function bar_graph(result, status, ansyn) {
									var total = [];
									var total_pre = [];
									var total_gap = [];
									var name = [];
									
									$.each(result, function(key, value){
									    $.each(value, function(key, value){
									    	if(key == "TOTAL") total.push(value);
									    	if(key == "TOTAL_PRE") total_pre.push(value);
									        if(key == "TOTAL_GAP") total_gap.push(value);
									        if(key == "name") name.push(value);
									    });
									    
									});
									
									total.reverse();
									total_pre.reverse();
									name.reverse();
									
									var echartbar = echarts.init(document.getElementById('bar_graph'));
									echartbar.setOption({
									 title: {
									        text: '급등서버순위',
									        textStyle: {
												fontSize: 20
											}
									    },
									    tooltip: {
									    	
									        trigger: 'axis',
									        axisPointer: {
									            type: 'shadow'
									        }
									    },
									 	// 상단 옵션 데이터 종류
										legend : {
											data : [ '마지막 검색결과', '이전 검색 결과']
										},
									    grid: {
									        left: '3%',
									        right: '4%',
									        bottom: '3%',
									        containLabel: true
									    },
									    textStyle: {
											fontFamily: 'S-CoreDream-5Medium',
											fontSize: 16
										},
									    xAxis: {
									        type: 'value',
									        boundaryGap: [0, 0.01]
									    },
									    yAxis: {
									        type: 'category',
									        data: name
									    },
									    series: [
									        {
									            name: '마지막 검색결과',
									            type: 'bar',
									            data: total
									        },
									        {
									            name: '이전 검색 결과',
									            type: 'bar',
									            data: total_pre
									        }
									    ]
									});
								}
								</script>
							</div>  
						</li>
					</ul>
				</div>
			<div class="clear"></div>
		</div>
		</section>
	<%@ include file="../../include/footer.jsp"%>
<script type="text/javascript">
var ch_target_id = "";
function change_target_id(target_id) {
	ch_target_id = target_id;
}
$(document).ready(function() {
	
	$.ajax({
		type: "POST",
		url: "/pi_systemcurrent",
		async : false,
		data : postData,
		dataType : "json",
	    success: circleGraph,
	    error: function (request, status, error) {
			alert("fail");
	        console.log("ERROR : ", error);
	    }
	});
	
	$.ajax({
		type: "POST",
		url: "/selectJumpUpHost",
		async : false,
		data : postData,
		dataType : "json",
	    success: bar_graph,
	    error: function (request, status, error) {
			alert("fail");
	        console.log("ERROR : ", error);
	    }
	});
	
	$("#days").on("change", function(){
		var postData = {
			days : $("#days").val(),
			target_id : ch_target_id
		};
		
		$.ajax({
			type: "POST",
			url: "/pi_datatype",
			async : false,
			data : postData,
			dataType : "json",
		    success: resizeGraph_One,
		    error: function (request, status, error) {
				alert("fail");
		        console.log("ERROR : ", error);
		    }
		});
	});
	
	var postData = {
		days : $("#days").val()
	};
	$.ajax({
		type: "POST",
		url: "/pi_datatype",
		async : false,
		data : postData,
		dataType : "json",
	    success: resizeGraph_One,
	    error: function (request, status, error) {
			alert("fail");
	        console.log("ERROR : ", error);
	    }
	});
	
	$.ajax({
		type: "POST",
		url: "/pi_datatypes",
		async : false,
		data : "",
		dataType : "json",
	    success: function(data) {
	    	console.log(data); 
			datatype(data.RRN, "rrn");
			datatype(data.FOREIGNER, "foreigner");
			datatype(data.DRIVER, "driver");
			datatype(data.PASSPORT, "passport");
			datatype(data.ACCOUNT_NUM, "account_num");
			datatype(data.CARD_NUM, "card_num"); 
		},
	    error: function (request, status, error) {
			alert("fail");
	        console.log("ERROR : ", error);
	    }
	});
	
});

   $(function() {
      $("#tree")
            .fancytree(
                  {
                     autoActivate : false, // we use scheduleAction()
                     autoCollapse : true,
                     autoFocus: true,
                     autoScroll : true,
                     checkbox: false,
                     selectMode : 2,
                     clickFolderMode : 3, // expand with single click
                     minExpandLevel : 2,
                     tabindex : "-1", // we don't want the focus frame
                     // toggleEffect: { effect: "blind", options: {direction: "vertical", scale: "box"}, duration: 2000 },
                     // scrollParent: null, // use $container
                     tooltip : function(event, data) {
                        return data.node.platform;
                     },
                     
                     focus : function(event, data) {
                        var node = data.node;
                        // Auto-activate focused node after 1 second
                        if (node.data.href) {
                            node.scheduleAction("activate", 1000);
                        }
                     },
                     blur : function(event, data) {
                        data.node.scheduleAction("cancel");
                     },
                     beforeActivate : function(event, data) {
                        var node = data.node;

                        if (node.data.href
                              && node.data.target === "_blank") {
                           window.open(node.data.href, "_blank");
                           return false; // don't activate
                        }
                     },
                     activate : function(event, data) {
                        var node = data.node, orgEvent = data.originalEvent
                              || {};

                        // Open href (force new window if Ctrl is pressed)
                        //if (node.data.href) {
                        //   console.log("Click_____________ Href " + href);
                        //}
                        // When an external link was clicked, we don't want the node to become
                        // active. Also the URL fragment should not be changed
                        if (node.data.target === "_blank") {
                           return false;
                        }
                        // Append #HREF to URL without actually loading content
                        // (We check for this value on page load re-activate the node.)
                        if (window.parent && parent.history
                              && parent.history.pushState) {
                           parent.history.pushState({
                              title : node.title
                           }, "", "" + (node.data.href || ""));
                        }
                     },
                     click : function(event, data) {
                        var target_id = data.node.tooltip;
                        console.log("Click_____________" + target_id);
                        change_target_id(target_id);
                        var postData = {
                        	target_id : target_id,
                        	days : $("#days").val()
                        }
                    	$.ajax({
                    		type: "POST",
                    		url: "/pi_datatype",
                    		async : false,
                    		data : postData,
                    		dataType : "json",
                    	    success: resizeGraph_One,
                    	    error: function (request, status, error) {
                    	        console.log("ERROR : ", error);
                    	    }
                    	});
                        
                        
                        $.ajax({
                    		type: "POST",
                    		url: "/pi_targetInfo",
                    		async : false,
                    		data : postData,
                    		dataType : "json",
                    	    success: function(data) {
                    	    	
                    	    	if(data != null && data.length != 0){
                    	    		var memory = data.AGENT_RAM/1024/1024/1024;
                    	    		$("#server_name").html(data.AGENT_NAME);
                    	    		if(data.AGENT_CONNECTED_IP == null) {
                    	    			$("#ip").html(" ");
                    	    		}else {
                    	    			$("#ip").html(data.AGENT_CONNECTED_IP);
                    	    		}
                    	    		if(data.AGENT_CONNECTED == false){
                    	    			$("#connected").html("연결안됨");
                    	    		}else{ 
                    	    			$("#connected").html("연결됨");
                    	    		}
                    	    		$("#os").html(data.AGENT_PLATFORM_COMPATIBILITY);
                    	    		$("#memory").html(Math.round(memory) + "GB");
                    	    		if(data.AGENT_CORES == null){
                    	    			$("#core").html(" ");
                    	    		}else{
                    	    			$("#core").html(data.AGENT_CORES + "CORE");
                    	    		}
                    	    		if(data.AGENT_STARTED != '1970-01-01 09:00:01'){
                    	    			$("#last_date").html(data.AGENT_STARTED);
                    	    		} else {
                    	    			$("#last_date").html(" ");
                    	    		}
                    	    		if(data != null && data.length != 0){
	                     	    		console.log(data.REGDATE);
	                     	    		var date = new Date(data.REGDATE);
	                     	    		var iso = date.toISOString().match(/(\d{4}\-\d{2}\-\d{2})T(\d{2}:\d{2}:\d{2})/)
	                     	    		var lastBefore = iso[1] + ' ' + iso[2]
	                     	    		console.log(lastBefore);
	                     	    		
	                     	    		$("#previous_date").html(lastBefore);
	                     	    	} else{
	                     	    		$("#previous_date").html(" ");	
	                     	    	}
                    	    	}
                    	    	/*
                    	    	$.ajax({
		                     		type: "POST",
		                     		url: "<%=request.getContextPath()%>/selectlastScanDate",
		                     		async : false,
		                     		data : postData,
		                     		dataType : "json",
		                     	    success: function(returnMap){
		                     	    	
		                     	    	
		                     	    },
		                     	    error: function (scanDate) {
		                	    		$("#previous_date").html(" ");
		                    	    }
	                    	    });
                    	    	*/
                    	    },
                    	    error: function (request, status, error) {
                	    		$("#server_name").html("전체 서버");
                	    		$("#connected").html(" ");
                	    		$("#ip").html(" ");
                	    		$("#os").html(" ");
                	    		$("#memory").html(" ");
                	    		$("#core").html(" ");
                	    		$("#last_date").html(" ");
                	    		$("#previous_date").html(" ");
                    	    }
                    	});
                     }
                  });
      // On page load, activate node if node.data.href matches the url#href
      var tree = $(":ui-fancytree").fancytree("getTree"), frameHash = window.parent
            && window.parent.location.hash;

      if (frameHash) {
         frameHash = frameHash.replace("", "");
         tree.visit(function(n) {
            if (n.data.href && n.data.href === frameHash) {
               n.setActive();
               return false; // done: break traversal
            }
         });
      }
   });
  
function datatype(result, type) {
	if(result.length != 0){
		for(var i = 0; i < result.length; i++){
			var addRow = "";
			addRow += "<tr><td>" + result[i].NAME + "\n" + result[i].IP + "</td>"
			
			var regexp = /\B(?=(\d{3})+(?!\d))/g;
			var type1 = String(result[i].TYPE1).replace(regexp, ',');
			
			addRow += '<td style="text-align: right;">' + type1 + '</td>'
			
			
			$("#" + type + "_tbl").append(addRow);
			
		}
	}
}

// 기본 4개 표기
$("#account_num_list").hide();
$("#card_num_list").hide();

//개인정보 타입 선택 및 4개이상 선택시 disabled 처리
$(document).ready(function() {
	$("input[name=pi_type]:checkbox").change(function() { // 체크박스 변경되면 나오는 펑션
		if (4 == $("input[name=pi_type]:checkbox:checked").length){ // 최대 4개까지 선택가능
			$(":checkbox:not(:checked)").attr("disabled", "disabled");
		} else {
			$("input[name=pi_type]:checkbox").removeAttr("disabled");
		}
		
		// 데이터타입 check 되면 화면에 보이기 or 숨기기
		if ($("#rrn").is(":checked")){ 
			$("#rrn_list").show();
		} else {
			$("#rrn_list").hide();
		}
		if ($("#foreigner").is(":checked")){ 
			$("#foreigner_list").show();
		} else {
			$("#foreigner_list").hide();
		}
		if ($("#driver").is(":checked")){ 
			$("#driver_list").show();
		} else {
			$("#driver_list").hide();
		}
		if ($("#passport").is(":checked")){ 
			$("#passport_list").show();
		} else {
			$("#passport_list").hide();
		}
		if ($("#account").is(":checked")){ 
			$("#account_num_list").show();
		} else {
			$("#account_num_list").hide();
		}
		if ($("#card").is(":checked")){ 
			$("#card_num_list").show();
		} else {
			$("#card_num_list").hide();
		}
		
	});
	
});


function exception(target_id) {
	var form = document.createElement("form");
	var input   = document.createElement("input");
	input.type   = "hidden";
	input.name  = "target_id";
	input.value  = target_id;
	form.action = "<%=request.getContextPath()%>/exception/pi_exception_regist";
	form.method = "post";
	
	
	form.appendChild(input);
	document.body.appendChild(form);
	form.submit();
	/* var target_id = $("#"+id).find("title").text(); */
}
</script>
</body>
</html>

