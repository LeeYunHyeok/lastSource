package com.org.iopts.detection.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.org.iopts.detection.service.piExceptionService;
import com.org.iopts.service.Pi_UserService;
import com.org.iopts.util.SessionUtil;

@Controller
@RequestMapping(value = "/excepter")
public class piExceptionController {

	private static Logger log = LoggerFactory.getLogger(piExceptionController.class);

	@Inject
	private Pi_UserService userService;

	@Inject
	private piExceptionService service;

	@RequestMapping(value = "/pi_exception_list", method = {RequestMethod.GET, RequestMethod.POST})
	public String pi_exception_list (Model model) throws Exception 
	{
		log.info("사용자화면 - 결재 관리 - 경로 예외 리스트");
		
		model.addAttribute("menuKey", "detectionMenu");
		model.addAttribute("menuItem", "approvalList");
		
		Map<String, Object> member = SessionUtil.getSession("memberSession");
		model.addAttribute("memberInfo", member);
		
		Map<String, Object> teamManager = userService.selectTeamManager();
		model.addAttribute("teamManager", teamManager);	
		
		return "/detection/pi_exception_list";
	}
	
	@RequestMapping(value = "/pi_exception_approval_list", method = {RequestMethod.GET, RequestMethod.POST})
	public String pi_exception_approval_list (Model model) throws Exception 
	{
		log.info("사용자화면 - 결재 관리 - 경로 예외 결재 리스트");
		
		model.addAttribute("menuKey", "detectionMenu");
		model.addAttribute("menuItem", "approvalList");
		
		Map<String, Object> member = SessionUtil.getSession("memberSession");
		model.addAttribute("memberInfo", member);
		
		Map<String, Object> teamManager = userService.selectTeamManager();
		model.addAttribute("teamManager", teamManager);
		model.addAttribute("user_grade", teamManager.get("user_grade"));
				
		return "/detection/pi_exception_approval_list";
	}

	@RequestMapping(value="/selectExceptionList", method={RequestMethod.POST}, produces="application/json; charset=UTF-8")
	@ResponseBody
    public List<HashMap<String, Object>> selectExceptionList(Model model, @RequestParam HashMap<String, Object> params) throws Exception 
	{
		log.info("selectExceptionList");

		Map<String, Object> member = SessionUtil.getSession("memberSession");
		model.addAttribute("memberInfo", member);

		List<HashMap<String, Object>> searchList = service.selectExceptionList(params);
		
		return searchList;
    }

	@RequestMapping(value="/selectExeptionPath", method={RequestMethod.POST}, produces="application/json; charset=UTF-8")
	@ResponseBody
    public List<HashMap<String, Object>> selectProcessPath(Model model, @RequestBody HashMap<String, Object> params) throws Exception 
	{
		Map<String, Object> member = SessionUtil.getSession("memberSession");
		model.addAttribute("memberInfo", member);

		List<HashMap<String, Object>> searchList = service.selectExeptionPath(params);
		model.addAttribute("searchList", searchList);

		return searchList;
    }

	// 문서 번호 불러오기
	@RequestMapping(value="/selectDocuNum", method={RequestMethod.POST})
	@ResponseBody 
    public Map<String, Object> selectDocuNum(Model model, @RequestParam HashMap<String, Object> params) throws Exception 
	{
		Map<String, Object> docuNum = service.selectDocuNum(params);

		return docuNum;
    }

	// 결재 관리 - 경로예외 리스트 - 결재 요청
	@RequestMapping(value="/registPathExceptionCharge", method={RequestMethod.POST}, produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
    public Map<String, Object> registPathExceptionCharge(@RequestBody HashMap<String, Object> params) throws Exception 
	{
		Map<String, Object> result = new HashMap<String, Object>();
		HashMap<String, Object> chargeMap = new HashMap<String, Object>();

		try {
			chargeMap = service.registPathExceptionCharge(params);
			service.updateExcepStatus(params, chargeMap);
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

	// 경로 예외 결재 리스트
	@RequestMapping(value="/exceptionApprovalListData", method={RequestMethod.POST})
	@ResponseBody
	public List<HashMap<String, Object>> exceptionApprovalListData(Model model, @RequestParam HashMap<String, Object> params) throws Exception 
	{
		Map<String, Object> member = SessionUtil.getSession("memberSession");
		model.addAttribute("memberInfo", member);

		List<HashMap<String, Object>> searchList = service.exceptionApprovalListData(params);

		return searchList;
	}

	// 경로 예외 결재 리스트
	@RequestMapping(value="/exceptionApprovalAllListData", method={RequestMethod.POST})
	@ResponseBody
	public List<HashMap<String, Object>> exceptionApprovalAllListData(Model model, @RequestParam HashMap<String, Object> params) throws Exception 
	{
		Map<String, Object> member = SessionUtil.getSession("memberSession");
		model.addAttribute("memberInfo", member);

		List<HashMap<String, Object>> searchList = service.exceptionApprovalAllListData(params);

		return searchList;
	}

	// 정탐/오탐 결재 리스트 - 조회
	@RequestMapping(value="/selectExceptionGroupPath", method=RequestMethod.POST, produces="application/json; charset=UTF-8")
	@ResponseBody
	public List<HashMap<String, Object>> selectExceptionGroupPath(Model model, @RequestBody HashMap<String, Object> params) throws Exception 
	{
		Map<String, Object> member = SessionUtil.getSession("memberSession");
		model.addAttribute("memberInfo", member);

		List<HashMap<String, Object>> searchList = service.selectExceptionGroupPath(params);
		model.addAttribute("searchList", searchList);

		return searchList;
	}

	// 결재관리 - 경로예외 결재 리스트 - 결재
	@RequestMapping(value="/updateExcepApproval", method={RequestMethod.POST}, produces="application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, Object> updateExcepApproval(@RequestBody HashMap<String, Object> params) throws Exception 
	{
		log.info("updateExcepApproval 시작");
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			service.updateExcepApproval(params);
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