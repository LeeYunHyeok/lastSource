<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="../../resources/assets/css/font-awesome.min.css"/>

				<h2 class="ir">왼쪽메뉴</h2>
				<div class="lnb">
					<div class="magin_t45">
			<c:if test="${menuItem == 'detectionRegist'}">
						<h3>검출 관리</h3>
						<!-- left menu-->
						<ul class="menu_list">
							<li>
								<h4 class="ir">검출 관리</h4>
								<ul>
									<li class="detectionList">
										<a href="javascript:void(0)" class="on">검출 리스트</a>
									</li>
									<li class="approvalListB">
										<a href="<%=request.getContextPath()%>/approval/pi_search_list">결재 관리</a>
									</li>
									<li class="serverListB">
										<a href="<%=request.getContextPath()%>/detection/pi_server_list">서버리스트</a>
									</li>
								</ul>
			</c:if>
			<c:if test="${menuItem == 'approvalList'}">
						<h3>검출 관리</h3>
						<!-- left menu-->
						<ul class="menu_list">
							<li>
								<h4 class="ir">검출 관리</h4>
								<ul>
									<li class="detectionListB">
										<a href="<%=request.getContextPath()%>/detection/pi_detection_regist">검출 리스트</a>
									</li>
									<li class="approvalList">
										<a href="javascript:void(0)" class="on">결재 관리</a>
									</li>
									<li class="serverListB">
										<a href="<%=request.getContextPath()%>/detection/pi_server_list">서버리스트</a>
									</li>
								</ul>
			</c:if>
			<c:if test="${menuItem == 'serverList'}">
						<h3>검출 관리</h3>
						<!-- left menu-->
						<ul class="menu_list">
							<li>
								<h4 class="ir">검출 관리</h4>
								<ul>
									<li class="detectionListB">
										<a href="<%=request.getContextPath()%>/detection/pi_detection_regist">검출 리스트</a>
									</li>
									<li class="approvalListB">
										<a href="<%=request.getContextPath()%>/approval/pi_search_list">결재 관리</a>
									</li>
									<li class="serverList">
										<a href="javascript:void(0)" class="on">서버리스트</a>
									</li>
								</ul>
			</c:if>
							</li>
						</ul>
					</div>
				</div>