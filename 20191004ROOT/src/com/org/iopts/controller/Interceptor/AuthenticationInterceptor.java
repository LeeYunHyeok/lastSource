package com.org.iopts.controller.Interceptor;


import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.org.iopts.util.SessionUtil;

public class AuthenticationInterceptor extends HandlerInterceptorAdapter {

	private static final Logger logger = LoggerFactory.getLogger(AuthenticationInterceptor.class);
	
	// preHandle() : 컨트롤러보다 먼저 수행되는 메서드
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

		if( handler instanceof HandlerMethod == false ) {
            // return true이면  Controller에 있는 메서드가 아니므로, 그대로 컨트롤러로 진행
            return true;
        }

		logger.info("preHandle request.getRequestURI :" + request.getRequestURI());

        String DocumentRoot = request.getContextPath();
        HttpSession session = request.getSession(true); 

        if (session.getAttribute("memberSession") == null ) {
        	logger.info("memberSession null");
        	if (excludeUrl(request)) return true; //이동하는 url이 예외 url 일경우
        	logger.info("excludeUrl false");
        	if (isAjaxRequest(request)) { //Ajax 콜인지 아닌지 판단
        		//response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
                //return false;
        	}
        	logger.info("isAjaxRequest");
            response.sendRedirect(DocumentRoot + "/");
            return false;
        }
        else {
        	if (request.getRequestURI().equals("/")) {
        		if(SessionUtil.getSession("memberSession", "USER_GRADE").equals("9")) {
        			response.sendRedirect(DocumentRoot + "/piboard");
        		} else {
        			response.sendRedirect(DocumentRoot + "/detection/pi_detection_regist");
        		}
        	}
        }
		return true;
	}

	private boolean excludeUrl(HttpServletRequest request) {

		String uri = request.getRequestURI().toString().trim();
	    if (uri.equals("/") || uri.equals("/login") || uri.equals("/NCLoginTestENC") || uri.equals("/NCLoginTestEndVerify") || uri.equals("/ssoLogin")) {
            return true;
        } 
	    else {
	    	return false;
	    }
	}
	 
	private boolean isAjaxRequest(HttpServletRequest request) {
	    if (("xmlhttprequest").equalsIgnoreCase(request.getHeader("X-Requested-With"))) {
	    	return true;
	    }
	    return false;
	}
	
	// 컨트롤러가 수행되고 화면이 보여지기 직전에 수행되는 메서드
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		if ((!excludeUrl(request)) && (!isAjaxRequest(request))) {
			if (modelAndView != null) {
				Map<String, Object> model = modelAndView.getModel();
				model.put("memberInfo", SessionUtil.getSession("memberSession"));

			}
		}
		super.postHandle(request, response, handler, modelAndView);
	}

}
