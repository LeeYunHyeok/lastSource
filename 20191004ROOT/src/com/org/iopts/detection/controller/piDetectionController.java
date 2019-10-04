package com.org.iopts.detection.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.org.iopts.detection.service.piDetectionService;
import com.org.iopts.service.Pi_TargetService;
import com.org.iopts.service.Pi_UserService;
import com.org.iopts.util.SessionUtil;

@Controller
@RequestMapping(value = "/detection")
public class piDetectionController 
{
	private static Logger log = LoggerFactory.getLogger(piDetectionController.class);

	@Autowired Pi_TargetService targetservice;
	@Autowired Pi_UserService userService;
	@Autowired piDetectionService service;

	@RequestMapping(value = "/pi_detection_regist", method = {RequestMethod.GET, RequestMethod.POST})
	public String pi_detection_regist (Locale locale, HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception 
	{
		log.info("사용자화면 - 메인 - 검출리스트");

		model.addAttribute("menuKey", "detectionMenu");
		model.addAttribute("menuItem", "detectionRegist");

		List<Map<String, Object>> targetList = targetservice.selectUserTargetList(request);
		model.addAttribute("targetList", targetList);

		Map<String, Object> teamManager = userService.selectTeamManager();
		model.addAttribute("teamManager", teamManager);	

		Map<String, Object> member = SessionUtil.getSession("memberSession");
		model.addAttribute("memberInfo", member);

		log.info("mamber : " + member);

		return "/detection/pi_detection_regist";
	}

	@RequestMapping(value = "/pi_server_list", method = {RequestMethod.GET, RequestMethod.POST})
	public String pi_server_list (HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) {
		log.info("사용자화면 - 서버 리스트  - 서버 리스트");
		
		model.addAttribute("menuKey", "detectionMenu");
		model.addAttribute("menuItem", "serverList");
		
		Map<String, Object> member = SessionUtil.getSession("memberSession");
		model.addAttribute("memberInfo", member);
		
		
		return "/detection/pi_server_list";		
	}

	// 사용자용 화면 - 검출리스트
	@RequestMapping(value="/selectFindSubpath", method={RequestMethod.POST})
	@ResponseBody
    public List<HashMap<String, Object>> selectFindSubpath(@RequestParam HashMap<String, Object> params) throws Exception 
	{
		log.info("selectFindSubpath");

		List<HashMap<String, Object>> findSubpathList = service.selectFindSubpath(params);

		return findSubpathList;
    }

	// 검출 리스트 - 처리 문서 번호 조회
	@RequestMapping(value="/selectProcessDocuNum", method={RequestMethod.POST})
	@ResponseBody 
    public HashMap<String, Object> selectProcessDocuNum(@RequestParam HashMap<String, Object> params) throws Exception 
	{
		HashMap<String, Object> docuNum = service.selectProcessDocuNum(params);

		return docuNum;
    }

	// 검출 리스트 - 경로 예외 문서 번호 조회
	@RequestMapping(value="/selectExceptionDocuNum", method={RequestMethod.POST})
	@ResponseBody 
    public HashMap<String, Object> selectExceptionDocuNum(@RequestParam HashMap<String, Object> params) throws Exception 
	{
		HashMap<String, Object> docuNum = service.selectExceptionDocuNum(params);

		return docuNum;
    }

	// 검출리스트 - 처리 - 저장
	@RequestMapping(value="/registProcess", method={RequestMethod.POST}, produces="application/json; charset=UTF-8")
	@ResponseBody
    public HashMap<String, Object> registProcess(@RequestBody HashMap<String, Object> params) throws Exception 
	{
		log.info("registProcess 시작");

		HashMap<String, Object> GroupMap = new HashMap<String, Object>();
		HashMap<String, Object> map = new HashMap<String, Object>();

		try {
			map = service.selectProcessDocuNum(params);
			params.put("group_id", map.get("SEQ"));

			GroupMap = service.registProcessGroup(params);
			service.registProcess(params, GroupMap);
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

	// 검출리스트 - 경로예약 - 저장
	@RequestMapping(value="/registPathException", method={RequestMethod.POST}, produces="application/json; charset=UTF-8")
	@ResponseBody
    public HashMap<String, Object> registPathException(@RequestBody HashMap<String, Object> params) throws Exception 
	{
		log.info("registPathException 시작");

		HashMap<String, Object> GroupMap = new HashMap<String, Object>();
		HashMap<String, Object> map = new HashMap<String, Object>();

		try {
			map = service.selectExceptionDocuNum(params);
			params.put("path_ex_group_id", map.get("SEQ"));

			service.registPathException(params);
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

	// 검출리스트 - 결재자 선택 - user_grade 0 이상
	@RequestMapping(value="/selectTeamMember", method={RequestMethod.POST})
	@ResponseBody
    public List<HashMap<String, Object>> selectTeamMember(@RequestParam HashMap<String, Object> params) throws Exception 
	{
		return service.selectTeamMember(params);
    }

	// 검출 리스트 - 경로변경 저장
	@RequestMapping(value="/registChange", method={RequestMethod.POST})
	@ResponseBody
    public  Map<String, Object> registChange(@RequestBody HashMap<String, Object> params) throws Exception 
	{
		log.info("registChange 시작");

		Map<String, Object> result = new HashMap<String, Object>();

		try {
			service.registChange(params);
		}
		catch (Exception e) {
			result.put("resultCode", -1);
			result.put("resultMessage", e.getMessage());
			return result;
		}
			
		result.put("resultCode", 0);
		result.put("resultMessage", "SUCCESS");

		return result;
    }
}