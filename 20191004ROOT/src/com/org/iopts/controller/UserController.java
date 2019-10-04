package com.org.iopts.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.org.iopts.dto.Pi_AgentVO;
import com.org.iopts.dto.Pi_Target_ManageVO;
import com.org.iopts.service.Pi_UserService;
import com.org.iopts.service.Pi_AgentService;
import com.org.iopts.service.Pi_TargetService;
import com.org.iopts.util.ServletUtil;
import com.org.iopts.util.SessionUtil;

/**
 * Handles requests for the application home page.
 */

@Controller
@RequestMapping(value = "/user")
public class UserController {

	private static Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@Inject
	private Pi_UserService service;
	
	@RequestMapping(value = "/pi_user_main", method = RequestMethod.GET)
	public String pi_user_main(Locale locale, Model model) throws Exception {

		logger.info("pi_user_main");
		model.addAttribute("menuKey", "userMenu");
		model.addAttribute("menuItem", "userMain");
		
		String accessIP = service.selectAccessIP();
		model.addAttribute("accessIP", accessIP);
		
		List<Map<String, Object>> teamMap = service.selectTeamCode();
		model.addAttribute("teamMap", teamMap);
		
		Calendar cal = new GregorianCalendar(Locale.KOREA);
	    SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd");
	    String fromDate = fm.format(cal.getTime());

	    cal.setTime(new Date());
	    cal.add(Calendar.MONTH, +1);	     
	    String toDate = fm.format(cal.getTime());

		model.addAttribute("fromDate", fromDate);
		model.addAttribute("toDate", toDate);
		
		return "user/pi_user_main";
	}

	@RequestMapping(value = "/pi_userlog_main", method = RequestMethod.GET)
	public String pi_userlog(Locale locale, Model model) throws Exception {

		logger.info("pi_userlog_main");
		model.addAttribute("menuKey", "userMenu");
		model.addAttribute("menuItem", "userLog");

		Calendar cal = new GregorianCalendar(Locale.KOREA);
	    SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd");
	    String toDate = fm.format(cal.getTime());

	    cal.setTime(new Date());
	    cal.add(Calendar.MONTH, -1);	     
	    String fromDate = fm.format(cal.getTime());

		model.addAttribute("fromDate", fromDate);
		model.addAttribute("toDate", toDate);
		
		return "user/pi_userlog_main";
	}
	
	@RequestMapping(value="/pi_userlog_list", method={RequestMethod.POST})
    public @ResponseBody List<Map<String, Object>> pi_userlog_list(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("pi_userlog_list");
		List<Map<String, Object>> userlogList = service.selectUserLogList(request);
		
		return userlogList;
    }
	
	@RequestMapping(value = "/changeAccessIP", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> changeAccessIP(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {

		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			service.changeAccessIP(request);
		}
		catch(Exception e) {
			resultMap.put("resultCode", -100);
			resultMap.put("resultMessage", "시스템오류입니다.</br>관리자에게 문의하세요.");
			e.printStackTrace();
		}

		resultMap.put("resultCode", 0);
		resultMap.put("resultMessage", "SUCCESS");
		
		return resultMap;
	}

	@RequestMapping(value="/selectManagerList", method={RequestMethod.POST})
    public @ResponseBody List<Map<String, Object>> selectManagerList(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {

		logger.info("selectManagerList");
		List<Map<String, Object>> userlogList = service.selectManagerList(request);
		
		return userlogList;
    }

	@RequestMapping(value="/selectTeamMember", method={RequestMethod.POST})
    public @ResponseBody List<Map<String, Object>> selectTeamMember(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {

		logger.info("selectTeamMember");
		List<Map<String, Object>> teamMemberList = service.selectTeamMember(request);
		
		return teamMemberList;
    }

	@RequestMapping(value="/changeManagerList", method={RequestMethod.POST})
    public @ResponseBody Map<String, Object> changeManagerList(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("changeManagerList");

		Map<String, Object> map = new HashMap<String, Object>();
		try {
			service.changeManagerList(request);	
		}
		catch (Exception e) {
			map.put("resultCode", -1);
			map.put("resultMessage", e.getMessage());
			return map;
		}

		map.put("resultCode", 0);
		map.put("resultMessage", "SUCCESS");
		return map;
    }

	@RequestMapping(value="/chkDuplicateUserNo", method={RequestMethod.POST})
    public @ResponseBody Map<String, Object> chkDuplicateUserNo(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {

		logger.info("chkDuplicateUserNo");
		Map<String, Object> dupUserNo = service.chkDuplicateUserNo(request);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("resultCode", 0);
		map.put("resultMessage", "SUCCESS");
		map.put("UserMap", dupUserNo);
		
		return map;
    }

	@RequestMapping(value="/createUser", method={RequestMethod.POST})
    public @ResponseBody Map<String, Object> createUser(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("createUser");

		Map<String, Object> map = new HashMap<String, Object>();
		try {
			service.createUser(request);	
		}
		catch (Exception e) {
			map.put("resultCode", -1);
			map.put("resultMessage", e.getMessage());
			return map;
		}

		map.put("resultCode", 0);
		map.put("resultMessage", "SUCCESS");
		return map;
    }
	
	
}
