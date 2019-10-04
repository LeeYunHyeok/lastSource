package com.org.iopts.controller;

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

import com.org.iopts.service.Pi_TargetService;
import com.org.iopts.util.SessionUtil;

/**
 * Handles requests for the application home page.
 */

@Controller
@RequestMapping(value = "/target")
public class TargetController {

	private static Logger logger = LoggerFactory.getLogger(TargetController.class);
	
	@Inject
	private Pi_TargetService targetservice;

	@RequestMapping(value = "/pi_target_mngr", method = RequestMethod.GET)
	public String pi_target_mngr(Locale locale, Model model) throws Exception {

		logger.info("pi_target_mngr");
		
		model.addAttribute("menuKey", "targetMenu");
		model.addAttribute("menuItem", "targetMgr");		
		 
		return "target/pi_target_mngr";
	}

	@RequestMapping(value = "/pi_target_assign", method = RequestMethod.GET)
	public String pi_target_assign(Locale locale, Model model) throws Exception {

		logger.info("pi_target_assign");
		model.addAttribute("menuKey", "targetMenu");
		model.addAttribute("menuItem", "targetAssign");		

		return "target/pi_target_assign";
	}

	@RequestMapping(value="/pi_target_list", method={RequestMethod.POST})
    public @ResponseBody List<Map<String, Object>> pi_target_list(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("pi_target_list");
		
		List<Map<String, Object>> targetList = targetservice.selectTargetList(request);
		
		return targetList;
    }

	@RequestMapping(value="/selectTargetUser", method={RequestMethod.POST})
    public @ResponseBody List<Map<String, Object>> selectTargetUser(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("selectTargetUser");
		
		List<Map<String, Object>> targetList = targetservice.selectTargetUser(request);
		
		return targetList;
    }

	@RequestMapping(value="/registTargetUser", method={RequestMethod.POST})
    public @ResponseBody Map<String, Object> registTargetUser(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("registTargetUser");

		Map<String, Object> map = new HashMap<String, Object>();
		try {
			targetservice.registTargetUser(request);	
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

	@RequestMapping(value="/selectUserTargetList", method={RequestMethod.POST})
    public @ResponseBody List<Map<String, Object>> selectUserTargetList(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		List<Map<String, Object>> targetList = targetservice.selectUserTargetList(request);
		
		return targetList;
    }

	@RequestMapping(value="/selectTargetUserList", method={RequestMethod.POST})
    public @ResponseBody List<Map<String, Object>> selectTargetUserList(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		List<Map<String, Object>> targetList = targetservice.selectTargetUserList(request);
		
		return targetList;
    }
	
	@RequestMapping(value = "/selectServerFileTopN", method = RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> selectServerFileTopN(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) {
		List<Map<String, Object>> targeList = targetservice.selectServerFileTopN(request);
		
		return targeList;
	}
	
	@RequestMapping(value = "/selectAdminServerFileTopN", method = RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> selectAdminServerFileTopN(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) {
		List<Map<String, Object>> targeList = targetservice.selectAdminServerFileTopN(request);
		
		return targeList;
	}

	// 견본품 제공 엑셀 Import
	@RequestMapping(value="/targetManagerUpload", method={RequestMethod.POST})
    public @ResponseBody Map<String,Object> targetManagerUpload(HttpSession session, HttpServletRequest request, Model model) {
		logger.info("/targetManagerUpload");

		return targetservice.targetManagerUpload(request);
    }
}
