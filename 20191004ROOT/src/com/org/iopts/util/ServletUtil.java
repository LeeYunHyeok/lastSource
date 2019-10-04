package com.org.iopts.util;

import java.net.InetAddress;
import java.net.UnknownHostException;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ServletUtil {
	private static final Logger logger = LoggerFactory.getLogger(ServletUtil.class);
	private HttpServletRequest request;
	
	public ServletUtil(HttpServletRequest r) {
		this.request=r;
	}
	
	public String getIp() {
		 
		InetAddress myIP = null;
		try {
			myIP = InetAddress.getLocalHost();
		} catch (UnknownHostException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String ip = request.getRemoteAddr();

        if (ip == null) {
            ip = request.getHeader("X-Forwarded-For");
        }
        if (ip == null) {
            ip = request.getRemoteAddr();
        }
        if (ip == null) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null) {
            ip = request.getHeader("WL-Proxy-Client-IP"); // ������
        }
        if (ip == null) {
            ip = request.getHeader("HTTP_CLIENT_IP");
        }
        if (ip == null) {
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");
        }
        
        return ip;
 
    }

}
