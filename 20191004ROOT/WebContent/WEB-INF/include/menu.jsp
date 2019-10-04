<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

				<h2 class="ir">왼쪽메뉴</h2>
				<div class="lnb">
					<div class="magin_t45">
			<c:if test="${menuItem == 'userMain'}">
						<h3>사용자 관리</h3>
						<!-- left menu-->
						<ul class="menu_list">
							<li>
								<h4 class="ir">사용자 관리</h4>
								<ul>
									<li>
										<a href="javascript:void(0)" class="on">사용자관리</a>
									</li>
									<li>
										<a href="<%=request.getContextPath()%>/user/pi_userlog_main">접속로그관리</a>
									</li>
								</ul>
			</c:if>
			<c:if test="${menuItem == 'userLog'}">
						<h3>사용자 관리</h3>
						<!-- left menu-->
						<ul class="menu_list">
							<li>
								<h4 class="ir">사용자 관리</h4>
								<ul>
									<li>
										<a href="<%=request.getContextPath()%>/user/pi_user_main">사용자관리</a>
									</li>
									<li>
										<a href="javascript:void(0)" class="on">접속로그관리</a>
									</li>
								</ul>
			</c:if>
			<c:if test="${menuItem == 'targetMgr'}">
						<h3>타겟 관리</h3>
						<!-- left menu-->
						<ul class="menu_list">
							<li>
								<h4 class="ir">타겟 관리</h4>
								<ul>
									<li>
										<a href="javascript:void(0)" class="on">타겟 조회</a>
									</li>
				<c:if test="${memberInfo.USER_GRADE != '0'}">
									<li>
										<a href="<%=request.getContextPath()%>/target/pi_target_assign">타겟 담당자 관리</a>
									</li>
				</c:if>
								</ul>
			</c:if>
			<c:if test="${menuItem == 'targetAssign'}">
						<h3>타겟 관리</h3>
						<!-- left menu-->
						<ul class="menu_list">
							<li>
			
								<h4 class="ir">타겟 관리</h4>
								<ul>
									<li>
										<a href="<%=request.getContextPath()%>/target/pi_target_mngr">타겟 조회</a>
									</li>
				<c:if test="${memberInfo.USER_GRADE != '0'}">
									<li>
										<a href="javascript:void(0)" class="on">타겟 담당자 관리</a>
									</li>
				</c:if>
								</ul>
			</c:if>
			<c:if test="${menuItem == 'exceptionRegist'}">
						<h3>예외처리 관리</h3>
						<!-- left menu-->
						<ul class="menu_list">
							<li>
									<h4 class="ir">예외처리 관리 </h4>
									<ul>
										<li>
											<a href="javascript:void(0)" class="on">검출 관리</a>
										</li>
										<li>
											<a href="<%=request.getContextPath()%>/exception/pi_exception_list">예외 리스트</a>
										</li>
										<li>
											<a href="<%=request.getContextPath()%>/exception/pi_exception_deletion">삭제 리스트</a>
										</li>
				<c:if test="${memberInfo.USER_GRADE != '0'}">
										<li>
											<a href="<%=request.getContextPath()%>/exception/pi_exception_appr">예외처리 승인</a>
										</li>
				</c:if>
                                        <li>
                                            <a href="<%=request.getContextPath()%>/report/pi_report_summary">보고서</a>
                                        </li>
									</ul>
			</c:if>
			<c:if test="${menuItem == 'exceptionList'}">
						<h3>예외처리 관리</h3>
						<!-- left menu-->
						<ul class="menu_list">
							<li>
									<h4 class="ir">예외처리 관리 </h4>
									<ul>
										<li>
											<a href="<%=request.getContextPath()%>/exception/pi_exception_regist">검출 관리</a>
										</li>
										<li>
											<a href="javascript:void(0)" class="on">예외 리스트</a>
										</li>
										<li>
											<a href="<%=request.getContextPath()%>/exception/pi_exception_deletion">삭제 리스트</a>
										</li>
				<c:if test="${memberInfo.USER_GRADE != '0'}">
										<li>
											<a href="<%=request.getContextPath()%>/exception/pi_exception_appr">예외처리 승인</a>
										</li>
				</c:if>
                                        <li>
                                            <a href="<%=request.getContextPath()%>/report/pi_report_summary">보고서</a>
                                        </li>
									</ul>
			</c:if>
			<c:if test="${menuItem == 'exceptionDeletion'}">
						<h3>예외처리 관리</h3>
						<!-- left menu-->
						<ul class="menu_list">
							<li>
									<h4 class="ir">예외처리 관리 </h4>
									<ul>
										<li>
											<a href="<%=request.getContextPath()%>/exception/pi_exception_regist">검출 관리</a>
										</li>
										<li>
											<a href="<%=request.getContextPath()%>/exception/pi_exception_list">예외 리스트</a>
										</li>
										<li>
											<a href="javascript:void(0)" class="on">삭제 리스트</a>
										</li>
				<c:if test="${memberInfo.USER_GRADE != '0'}">
										<li>
											<a href="<%=request.getContextPath()%>/exception/pi_exception_appr">예외처리 승인</a>
										</li>
				</c:if>
                                        <li>
                                            <a href="<%=request.getContextPath()%>/report/pi_report_summary">보고서</a>
                                        </li>
									</ul>
			</c:if>
			<c:if test="${menuItem == 'exceptionAppr'}">
						<h3>예외처리 관리</h3>
						<!-- left menu-->
						<ul class="menu_list">
							<li>
									<h4 class="ir">예외처리 관리 </h4>
									<ul>
										<li>
											<a href="<%=request.getContextPath()%>/exception/pi_exception_regist">검출 관리</a>
										</li>
										<li>
											<a href="<%=request.getContextPath()%>/exception/pi_exception_list">예외 리스트</a>
										</li>
										<li>
											<a href="<%=request.getContextPath()%>/exception/pi_exception_deletion">삭제 리스트</a>
										</li>
				<c:if test="${memberInfo.USER_GRADE != '0'}">
										<li>
											<a href="javascript:void(0)" class="on">예외처리 승인</a>
										</li>
				</c:if>
                                        <li>
                                            <a href="<%=request.getContextPath()%>/report/pi_report_summary">보고서</a>
                                        </li>
									</ul>
			</c:if>
            <c:if test="${menuItem == 'reportAppr'}">
                        <h3>예외처리 관리</h3>
                        <!-- left menu-->
                        <ul class="menu_list">
                            <li>
                                    <h4 class="ir">예외처리 관리 </h4>
                                    <ul>
                                        <li>
                                            <a href="<%=request.getContextPath()%>/exception/pi_exception_regist">검출 관리</a>
                                        </li>
                                        <li>
                                            <a href="<%=request.getContextPath()%>/exception/pi_exception_list">예외 리스트</a>
                                        </li>
                                        <li>
                                            <a href="<%=request.getContextPath()%>/exception/pi_exception_deletion">삭제 리스트</a>
                                        </li>
                <c:if test="${memberInfo.USER_GRADE != '0'}">
                                        <li>
                                            <a href="<%=request.getContextPath()%>/exception/pi_exception_appr">예외처리 승인</a>
                                        </li>
                </c:if>
                                        <li>
                                            <a href="javascript:void(0)" class="on">보고서</a>
                                        </li>
                                    </ul>
            </c:if>
			<c:if test="${menuItem == 'scanMgr'}">
						<h3>스캔 관리</h3>
						<!-- left menu-->
						<ul class="menu_list">
							<li>
									<h4 class="ir">스캔 관리</h4>
									<ul>
										<li>
											<a href="javascript:void(0)" class="on">스캔 스캐줄</a>
										</li>
										<li>
											<a href="<%=request.getContextPath()%>/scan/pi_scan_rescan">재검색 스캔</a>
										</li>
										<!-- <li>
											<a href="<%=request.getContextPath()%>/scan/pi_scan_history">스캔 히스토리</a>
										</li> -->
									</ul>
			</c:if>
			<c:if test="${menuItem == 'rescan'}">
						<h3>스캔 관리</h3>
						<!-- left menu-->
						<ul class="menu_list">
							<li>
									<h4 class="ir">스캔 관리</h4>
									<ul>
										<li>
											<a href="<%=request.getContextPath()%>/scan/pi_scan_main" >스캔 스캐줄</a>
										</li>
										<li>
											<a href="javascript:void(0)" class="on">재검색 스캔</a>
										</li>
										<!--<li>
											<a href="<%=request.getContextPath()%>/scan/pi_scan_history">스캔 히스토리</a>
										</li> -->
									</ul>
			</c:if>
			<c:if test="${menuItem == 'history'}">
					
						<h3>스캔 관리</h3>
						<!-- left menu-->
						<ul class="menu_list">
							<li>
									<h4 class="ir">스캔 관리</h4>
									<ul>
										<li>
											<a href="<%=request.getContextPath()%>/scan/pi_scan_main" >스캔 스캐줄</a>
										</li>
										<li>
											<a href="<%=request.getContextPath()%>/scan/pi_scan_rescan">재검색 스캔</a>
										</li>
										<!-- 
										<li>
											<a href="javascript:void(0)" class="on">스캔 히스토리</a>
										</li>
										 -->
									</ul>
			</c:if>
			
			
							</li>
							
						</ul>
					</div>
				</div>