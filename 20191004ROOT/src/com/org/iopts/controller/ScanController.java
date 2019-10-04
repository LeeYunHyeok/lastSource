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
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.org.iopts.service.Pi_ScanService;
import com.org.iopts.service.Pi_TargetService;
import com.org.iopts.util.SessionUtil;


/**
 * Handles requests for the application home page.
 */

@Controller
@PropertySource("classpath:/property/config.properties")
@Configuration
@RequestMapping(value = "/scan", method = {RequestMethod.POST,RequestMethod.GET})
public class ScanController {

	private static Logger logger = LoggerFactory.getLogger(ScanController.class);

	@Value("${recon.id}")
	private String recon_id;

	@Value("${recon.password}")
	private String recon_password;

	@Value("${recon.url}")
	private String recon_url;

	@Inject
	private Pi_ScanService scheduleservice;
	
	@Inject
	private Pi_TargetService targetservice;

	@RequestMapping(value = "/pi_scan_main", method = RequestMethod.GET)
	public String pi_scan_main(Locale locale, Model model) throws Exception {
		logger.info("pi_scan_main");

		Calendar cal = new GregorianCalendar(Locale.KOREA);
	    SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd");
	    String curDate = fm.format(cal.getTime());

	    cal.setTime(new Date());
	    cal.add(Calendar.MONTH, -1);	     
	    String befDate = fm.format(cal.getTime());

		model.addAttribute("befDate", befDate);
		model.addAttribute("curDate", curDate);

		model.addAttribute("menuKey", "scanMenu");
		model.addAttribute("menuItem", "scanMgr");
		
		return "scan/pi_scan_main";
	}

	@RequestMapping(value="/pi_scan_rescan", method={RequestMethod.POST})
	public String pi_scan_rescan(Locale locale, Model model) throws Exception {
		logger.info("pi_scan_rescan");
		
		model.addAttribute("menuKey", "scanMenu");
		model.addAttribute("menuItem", "rescan");
		
		return "scan/pi_scan_rescan";
    }
	
	@RequestMapping(value="/pi_scan_history", method={RequestMethod.POST})
	public String pi_scan_history(Locale locale, Model model, HttpServletRequest request) throws Exception {
		logger.info("pi_scan_history");
		
		List<Map<String, Object>> targetList = targetservice.selectUserTargetList(request);
		model.addAttribute("targetList", targetList);
		
		model.addAttribute("menuKey", "scanMenu");
		model.addAttribute("menuItem", "history");
		
		return "scan/pi_scan_history";
    }
	
	@RequestMapping(value="/pi_scan_schedule", method={RequestMethod.POST})
    public @ResponseBody List<Map<String, Object>> pi_scan_schedule(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("pi_scan_schedule");
		
		List<Map<String, Object>> schedulList = scheduleservice.selectSchedules(request);
		
		return schedulList;
    }
	
	@RequestMapping(value="/changeSchedule", method={RequestMethod.POST})
    public @ResponseBody Map<String, Object> changeSchedule(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("changeSchedule");
		
		Map<String, Object> schedulList = new HashMap<String, Object>();
		try {
			schedulList = scheduleservice.changeSchedule(request, recon_id, recon_password, recon_url);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			schedulList.put("resultCode", -1);
			schedulList.put("resultMessage", e.getMessage());
		}
		
		return schedulList;
    }

	@RequestMapping(value="/viewSchedule", method={RequestMethod.POST})
    public @ResponseBody Map<String, Object> viewSchedule(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("viewSchedule");
		
		Map<String, Object> schedulList = scheduleservice.viewSchedule(request, recon_id, recon_password, recon_url);
		
		return schedulList;
    }
	// schedule 등록 화면 호출
	@RequestMapping(value = "/pi_scan_regist", method = RequestMethod.GET)
	public String pi_scan_regist(Locale locale, Model model) throws Exception {
		logger.info("pi_scan_regist");

		model.addAttribute("menuKey", "scanMenu");
		model.addAttribute("menuItem", "scanMgr");
		
		List<Map<String, Object>> locationList  = scheduleservice.selectLocationList();
		model.addAttribute("locationList", locationList);
		
		List<Map<String, Object>> datatypeList  = scheduleservice.selectDatatypeList();
		model.addAttribute("datatypeList", datatypeList);
		

		Calendar cal = new GregorianCalendar(Locale.KOREA);
	    SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd");
	    String today = fm.format(cal.getTime());

		model.addAttribute("today", today);
		
		return "scan/pi_scan_regist";
	}
	
	@RequestMapping(value="/pi_scan_modify", method={RequestMethod.POST})
	public String pi_scan_modify(Locale locale, Model model, HttpServletRequest request) throws Exception {
		logger.info("pi_scan_modify");

		model.addAttribute("menuKey",  "scanMenu");
		model.addAttribute("menuItem", "rescan");
		model.addAttribute("idx",      request.getParameter("idx"));
		
		List<Map<String, Object>> locationList  = scheduleservice.selectLocationList();
		model.addAttribute("locationList", locationList);

		List<Map<String, Object>> datatypeList  = scheduleservice.selectDatatypeListMod(request);
		model.addAttribute("datatypeList", datatypeList);

		return "scan/pi_scan_modify";
    }

	@RequestMapping(value="/pi_policy_insert", method={RequestMethod.POST})
	public String pi_policy_insert(Locale locale, Model model, HttpServletRequest request) throws Exception {
		logger.info("pi_policy_insert");

		model.addAttribute("menuKey",  "scanMenu");
		model.addAttribute("menuItem", "rescan");
		
		List<Map<String, Object>> datatypeList  = scheduleservice.selectDatatypeList();
		model.addAttribute("datatypeList", datatypeList);

		return "scan/pi_policy_insert";
    }
	
	@RequestMapping(value="/registSchedule", method={RequestMethod.POST})
    public @ResponseBody Map<String, Object> registSchedule(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("registSchedule");
		
		Map<String, Object> schedulList = scheduleservice.registSchedule(request, recon_id, recon_password, recon_url);
		
		return schedulList;
    }

	@RequestMapping(value="/getProfileDetail", method={RequestMethod.POST})
    public @ResponseBody Map<String, Object> getProfileDetail(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("getProfileDetail");
		
		Map<String, Object> schedulList = scheduleservice.getProfileDetail(request, recon_id, recon_password, recon_url);
		
		return schedulList;
    }
	
	/**
	 * 스캔 히스토리 화면에서 데이터 불러오는 로직
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/viewScanHistory", method = RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> viewScanHistory(HttpServletRequest request, Model model) {
		logger.info("viewScanHistory");
		
		List<Map<String, Object>> historyList = scheduleservice.viewScanHistory(request);
		logger.info("historyList chk : " + historyList);
		model.addAttribute("historyList", historyList);
		return historyList;
	}
	
	/**
	 * 재검색 정책 화면에서 데이터 불러오는 로직
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/viewScanPolicy", method = RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> viewScanPolicy(HttpServletRequest request){
		logger.info("viewScanPolicy");
		
		List<Map<String, Object>> policyList = scheduleservice.viewScanPolicy(request);
		
		return policyList;
	}
	
	/**
	 * scan policy 등록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/registPolicy", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> registPolicy(HttpServletRequest request, Model model){
		logger.info("registPolicy");
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			scheduleservice.registPolicy(request);
		}
		catch (Exception e) {
			resultMap.put("resultCode", -1);
			resultMap.put("resultMessage", e.getMessage());
			return resultMap;
		}
			
		resultMap.put("resultCode", 0);
		resultMap.put("resultMessage", "SUCCESS");
		
		return resultMap;
		
	}
	
	@RequestMapping(value = "/updateDefaultPolicy", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> updateDefaultPolicy(HttpServletRequest request, Model model){
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			scheduleservice.resetDefaultPolicy(request);
			scheduleservice.updateDefaultPolicy(request);
		}
		catch (Exception e) {
			resultMap.put("resultCode", -1);
			resultMap.put("resultMessage", e.getMessage());
			return resultMap;
		}
			
		resultMap.put("resultCode", 0);
		resultMap.put("resultMessage", "SUCCESS");
		
		return resultMap;
	}
	
}
