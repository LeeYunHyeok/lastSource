package com.org.iopts.report.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.org.iopts.report.service.piSummaryService;
import com.org.iopts.service.Pi_UserService;
import com.org.iopts.util.SessionUtil;

@Controller
@RequestMapping(value = "/report")
@Configuration
@PropertySource("classpath:/property/config.properties")
public class piSummaryController {

	private static Logger log = LoggerFactory.getLogger(piSummaryController.class);

	@Inject
	private Pi_UserService userService;

	@Inject
	private piSummaryService service;

	/*
	 * 
	 */
	@RequestMapping(value = "/pi_report_summary", method = {RequestMethod.GET, RequestMethod.POST})
	public String pi_search_list (Model model) throws Exception 
	{
		model.addAttribute("menuKey", "exceptionMenu");
		model.addAttribute("menuItem", "reportAppr");

		Map<String, Object> teamManager = userService.selectTeamManager();
		model.addAttribute("teamManager", teamManager);		

		return "/report/pi_report_summary";		
	}

	// 
	@RequestMapping(value="/searchSummaryList", method={RequestMethod.POST})
	@ResponseBody
	public List<HashMap<String, Object>> searchSummaryList(Model model, @RequestParam HashMap<String, Object> params) throws Exception 
	{
		Map<String, Object> member = SessionUtil.getSession("memberSession");
		model.addAttribute("memberInfo", member);

		List<HashMap<String, Object>> searchList = service.searchSummaryList(params);

		return searchList;
	}
}