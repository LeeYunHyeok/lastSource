package com.org.iopts.controller;

import java.util.ArrayList;
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
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.org.iopts.dto.Pi_AgentVO;
import com.org.iopts.dto.Pi_TargetVO;
import com.org.iopts.service.Pi_UserService;
import com.org.iopts.service.Pi_AgentService;
import com.org.iopts.service.Pi_DashService;
import com.org.iopts.service.Pi_TargetService;
import com.org.iopts.util.ReconUtil;
import com.org.iopts.util.ServletUtil;
import com.org.iopts.util.SessionUtil;

import net.sf.json.JSONObject;

/**
 * Handles requests for the application home page.
 */

@Controller
@Configuration
@PropertySource("classpath:/property/config.properties")
public class HomeController { 

	private static Logger logger = LoggerFactory.getLogger(HomeController.class);

	@Value("${recon.id}")
	private String recon_id;

	@Value("${recon.password}")
	private String recon_password;

	@Value("${recon.url}")
	private String recon_url;

	@Inject
	private Pi_UserService service;

	@Inject
	private Pi_TargetService targetservice;

	@Inject
	private Pi_AgentService agetnservice;

	@Inject
	private Pi_DashService dashservice;
	
	@RequestMapping(value = { "/" }, method = RequestMethod.GET)
	public String home(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		return "main";
	}

	/**
	 * 	여기 다가 입력된 pi_user 테이블에 user_id 확인해서 등록된 사용자가 아니면 로그인 안되게 해 주세요.
	 * 로그인이 성공하면 pi_userlog 테이블에 이력 쌓아 주세요.
	 * job_info 칼럼에 : LOGIN(SUCCESS), LOGIN(FAIL)
	 */
	@RequestMapping(value = "/login", method = { RequestMethod.POST })
	public @ResponseBody Map<String, Object> login(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("/login");
		
		// 사용자번호 + 비밀번호로 로그인 하는 경우
		Map<String, Object> memberMap = new HashMap<String, Object>(); 
		try {
			memberMap = service.selectMember(request);
		}
		catch(Exception e) {
			memberMap.put("resultCode", -100);
			memberMap.put("resultMessage", "시스템오류입니다.\n관리자에게 문의하세요.");
			e.printStackTrace();
		}
		
		model.addAttribute("memberInfo", memberMap.get("member"));
		model.addAttribute("user_grade", memberMap.get("user_grade"));

		return memberMap;
	}

	@RequestMapping(value = "/NCLoginTestENC", method = {RequestMethod.GET, RequestMethod.POST})
	public String NCLoginTestENC(Model model, HttpSession session) 
	{
		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("resultCode", 1);
		resultMap.put("resultMessage", "Log-Out");

		return "NCLoginTestENC";
	}

	@RequestMapping(value = "/NCLoginTestEndVerify", method = RequestMethod.POST)
	public String NCLoginTestEndVerify(Model model, HttpSession session, HttpServletRequest request) 
	{
		model.addAttribute("ticket", request.getParameter("ticket"));
		model.addAttribute("ssoid", request.getParameter("ssoid"));

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("resultCode", 1);
		resultMap.put("resultMessage", "Log-Out");

		return "NCLoginTestEndVerify";
	}

	@RequestMapping(value = "/changeAuthCharacter", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> changeAuthCharacter(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			resultMap = service.changeAuthCharacter(request);
		}
		catch(Exception e) {
			resultMap.put("resultCode", -100);
			resultMap.put("resultMessage", "시스템오류입니다.</br>관리자에게 문의하세요.");
			e.printStackTrace();
		}
		
		model.addAttribute("memberInfo", resultMap.get("member"));

		return resultMap;
	}

	@RequestMapping(value = "/ssoLogin", method = { RequestMethod.POST })
	public @ResponseBody Map<String, Object> ssoLogin(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception 
	{
		String sso_type = request.getParameter("sso_type");

		logger.info("/login");
		
		// 사용자번호 + 비밀번호로 로그인 하는 경우
		Map<String, Object> memberMap = new HashMap<String, Object>(); 
		try {
			if ("success".equals(sso_type)) 
				memberMap = service.selectSSOMember(request);
			else
				throw new Exception();
		}
		catch(Exception e) {
			memberMap.put("resultCode", -100);
			memberMap.put("resultMessage", "시스템오류입니다.\n관리자에게 문의하세요.");
			e.printStackTrace();
		}

		model.addAttribute("memberInfo", memberMap.get("member"));
		model.addAttribute("user_grade", memberMap.get("user_grade"));

		return memberMap;
	}

	@RequestMapping(value = "/logout", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> logout(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		
		service.logout(request);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("resultCode", 0);
		resultMap.put("resultMessage", "Log-Out");
		
		return resultMap;
	}
	
	@RequestMapping(value = "/piboard", method = RequestMethod.GET)
	public String main(Locale locale, Model model) throws Exception {
		
		logger.info("Start piboard");

		logger.info("dash_menu");

		List<Pi_AgentVO> aList = dashservice.selectDashMenu();

		model.addAttribute("aList", aList);
		
		Map<String, Object> member = SessionUtil.getSession("memberSession");
		model.addAttribute("memberInfo", member);
		
		logger.info("tlist size :"+aList.size());
		
		return "dashboard/dash_main";
	}

	@RequestMapping(value = "/header", method = RequestMethod.GET)
	public String header(Locale locale, Model model) throws Exception {

		logger.info("header");

		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();

		ServletUtil u = new ServletUtil(request);
		u.getIp();

		return "header";
	}

	@RequestMapping(value = "/footer", method = RequestMethod.GET)
	public String footer(Locale locale, Model model) throws Exception {

		logger.info("footer");

		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();

		ServletUtil u = new ServletUtil(request);
		u.getIp();

		return "footer";
	}
	
	

	@RequestMapping(value = "/dash_main", method = RequestMethod.GET)
	public String dash_main(Locale locale, Model model) throws Exception {

		logger.info("dash_main");
		List<Map<String, Object>> targetList = targetservice.selectTargetManagement();
		List<Pi_AgentVO> dashList = null;

		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();

		String target_id = request.getParameter("target_id"); // jsp의 자바스크립트를 통해 받아온 호스트 이름
		logger.info("dash_main_target : " + target_id);

		if (targetList != null && targetList.size() != 0) {
			if (target_id != null) {
				dashList = agetnservice.dashAgent_Info(target_id); // 값을 받으면 DB에 호스트 결과를 받아 옴
				model.addAttribute("target_id", target_id);
			} else {
				dashList = agetnservice.dashAgent_Info((String) targetList.get(0).get("TARGET_ID")); // 메뉴에서 클릭시 맨처음 타겟리스트의 에이전트 내용을 받아옴
				model.addAttribute("target_id", (String) targetList.get(0).get("TARGET_ID"));
			}
			model.addAttribute("targetList", targetList);
			if (dashList != null) {
				model.addAttribute("agentList", dashList);
			}
		}

		return "dashboard/dash_main";
	}
	
	@RequestMapping(value="/pi_targetInfo", method={RequestMethod.POST})
    public @ResponseBody Map<String, Object> pi_targetInfo(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("pi_targetInfo");
		Map<String, Object> targetInfo = dashservice.selectDashInfo(request, recon_id, recon_password, recon_url);
		return targetInfo;
    }
	
	@RequestMapping(value="/pi_datatype", method={RequestMethod.POST})
    public @ResponseBody List<Map<String,Object>> pi_datatype(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("pi_datatype");
		List<Map<String,Object>> datatypeList = dashservice.selectDatatype(request);
		
		return datatypeList;
    }
	
	@RequestMapping(value="/pi_datatypes", method={RequestMethod.POST})
    public @ResponseBody Map<String, Object> pi_datatypes(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("pi_datatypes");
		Map<String, Object> datatypesList = dashservice.selectDatatypes(request);
		return datatypesList;
    }
	
	@RequestMapping(value="/pi_systemcurrent", method={RequestMethod.POST})
	public @ResponseBody List<Object> selectSystemCurrent (HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("pi_systemcurrent");
		List<Object> datatypesList = dashservice.selectSystemCurrent(request);
		return datatypesList;
	}
	
	@RequestMapping(value="/selectJumpUpHost", method={RequestMethod.POST})
	public @ResponseBody List<Object> selectJumpUpHost (HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("selectJumpUpHost");
		List<Object> datatypesList = dashservice.selectJumpUpHost(request);
		return datatypesList;
	}
	
	@RequestMapping(value="/selectlastScanDate", method={RequestMethod.POST})
	public @ResponseBody Map<String, Object> selectlastScanDate (HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response){
		logger.info("selectlastScanDate");
		Map<String, Object> scanDate = dashservice.selectlastScanDate(request);
		
		return scanDate;
	}
	
	@RequestMapping(value = { "/ReconTest", "/ReconTest" }, method = RequestMethod.GET)
	public String ReconTest(Locale locale, Model model) throws Exception {

		ReconUtil reconUtil = new ReconUtil();
		/**
		 * 데이터를 가져오는 로직과 파싱 , insert 로직은 srviceImpl로 옮기시는 것이 좋습니다.
		 */
		/*
		 * // 1. ‘https://172.30.1.58:8339/beta/groups/all’ // doc =
		 * reconUtil.getServerData(recon_id, recon_password,
		 * recon_url+"/beta/groups/all", "GET", null); //
		 * logger.info("/beta/groups/all :" + doc.toString());
		 * 
		 * // 2. ‘/beta/agents’ doc = reconUtil.getServerData(recon_id, recon_password,
		 * recon_url+"/beta/agents", "GET", null); logger.info("/beta/agents :" +
		 * doc.toString());
		 * 
		 * // 3. ‘/beta/targets/619591177460534829/matchobjects’ doc =
		 * reconUtil.getServerData(recon_id, recon_password,
		 * recon_url+"/beta/targets/619591177460534829/matchobjects", "GET", null);
		 * logger.info("/beta/target/[target_id]/matchsobject :" + doc.toString());
		 * 
		 * // 4. ‘/beta/schedules’ doc = reconUtil.getServerData(recon_id,
		 * recon_password, recon_url+"/beta/schedules", "GET", null);
		 * logger.info("/beta/schedules :" + doc.toString());
		 * 
		 * // 5. ‘/beta/schedules?completed=true’ doc =
		 * reconUtil.getServerData(recon_id, recon_password,
		 * recon_url+"/beta/schedules?completed=true", "GET", null);
		 * logger.info("/beta/schedules?completed= true :" + doc.toString());
		 * 
		 * // 6. ‘/beta/datatypes/profiles’ doc = reconUtil.getServerData(recon_id,
		 * recon_password, recon_url+"/beta/datatypes/profiles", "GET", null);
		 * logger.info("/beta/datatypes/profiles :" + doc.toString());
		 * 
		 * // 7. ‘/beta/datatypes/profiles?details=true’ doc =
		 * reconUtil.getServerData(recon_id, recon_password,
		 * recon_url+"/beta/datatypes/profiles?details=true", "GET", null);
		 * logger.info("/beta/datatypes/profiles?details=true :" + doc.toString());
		 * 
		 * // 8. ‘/beta/targets/619591177460534829/matchobjects/13127129315531939159’
		 * doc = reconUtil.getServerData(recon_id, recon_password,
		 * recon_url+"/beta/targets/619591177460534829/matchobjects/1", "GET", null);
		 * logger.
		 * info("/beta/targets/619591177460534829/matchobjects/13127129315531939159 :" +
		 * doc.toString());
		 */

//		9.	‘/beta/schedules’  : Data 입력 Post로 전송 해야함.
		// 여기서 부터는 Recon server에 데이터 넣는 테스트 -> 스케줄 추가 등록
		// JSON Data 만들기
		JSONObject jsonMain = new JSONObject();
		JSONObject jsonpause = new JSONObject();
		JSONObject jsonTarget = new JSONObject();
		JSONObject jsonLocations = new JSONObject();

		jsonLocations.put("id", "8987302884414283716");
		jsonLocations.put("subpath", "string");
		jsonTarget.put("id", "548122207921155732");
		jsonTarget.put("locations", jsonLocations);

		jsonpause.put("days", 2);
		jsonpause.put("start", 66600);
		jsonpause.put("end", 34200);

		jsonMain.put("label", "aaa");
		jsonMain.put("targets", jsonTarget);

		String[] profiles = { "16966619905757791327" };

		jsonMain.put("profiles", profiles);
		jsonMain.put("start", "2019-03-05 18:00");
		jsonMain.put("timezone", "Default");
		jsonMain.put("repeat_days", 14);
		jsonMain.put("repeat_months", 0);
		jsonMain.put("cpu", "low");
		jsonMain.put("throughput", 0);
		jsonMain.put("memory", 0);
		jsonMain.put("capture", false);
		jsonMain.put("trace", true);
		jsonMain.put("pause", jsonpause);

		Map<String, Object> httpsResponse = reconUtil.getServerData(recon_id, recon_password, recon_url + "/beta/schedules", "POST", jsonMain.toString());

		int resultCode = (Integer) httpsResponse.get("HttpsResponseCode");
		String resultMessage = (String) httpsResponse.get("HttpsResponseMessage");
		if (resultCode != 200) {
			// Recon Server Data 오류 인 경우
			logger.info("Recon Server Error == " + resultCode + " : " + resultMessage);
		}

		// 여기서 부터는 Recon server에서 데이터 받는 테스트
		httpsResponse = reconUtil.getServerData(recon_id, recon_password, recon_url + "/beta/groups/all", "GET", null);
		resultCode = (Integer) httpsResponse.get("HttpsResponseCode");
		resultMessage = (String) httpsResponse.get("HttpsResponseMessage");
		if (resultCode != 200) {
			// Recon Server Data 오류 인 경우
			logger.info("Recon Server Error == " + resultCode + " : " + resultMessage);
		}

		Document doc = (Document) httpsResponse.get("HttpsResponseData");

		List<Pi_TargetVO> list = new ArrayList<Pi_TargetVO>();
		// Find Group id ==> 4493621271884028236
		NodeList nodeList = doc.getElementsByTagName("group");
		Node node = nodeList.item(0);
		Element element = (Element) node.getChildNodes();
		String GroupID = element.getElementsByTagName("id").item(0).getTextContent();
		logger.info("GroupID :" + GroupID);

		nodeList = doc.getElementsByTagName("targets");
		logger.info(" " + nodeList.getLength());
		for (int i = 0; i < nodeList.getLength(); i++) {
			node = nodeList.item(i);

			if (node.getNodeType() == Node.ELEMENT_NODE) {
				element = (Element) node.getChildNodes();
				logger.info("Current Element :" + node.getNodeName());
				String TargetID = element.getElementsByTagName("id").item(0).getTextContent();
				String TargetName = element.getElementsByTagName("name").item(0).getTextContent();
				String TargetComments = element.getElementsByTagName("comments").item(0).getTextContent();
				String TargetSearchTime = element.getElementsByTagName("search_time").item(0).getTextContent();
				String TargetSearchStatus = element.getElementsByTagName("search_status").item(0).getTextContent();
				String TargetPlatform = element.getElementsByTagName("platform").item(0).getTextContent();

				NodeList nodeListError = element.getElementsByTagName("errors");
				Node nodeError = nodeListError.item(0);
				Element elementError = (Element) nodeError.getChildNodes();
				String notice = elementError.getElementsByTagName("notice").item(0).getTextContent();
				String error = elementError.getElementsByTagName("error").item(0).getTextContent();
				String critical = elementError.getElementsByTagName("critical").item(0).getTextContent();

				NodeList nodeListMatches = element.getElementsByTagName("matches");
				Node nodeMatches = nodeListMatches.item(0);
				Element elementMatches = (Element) nodeMatches.getChildNodes();
				String test = elementMatches.getElementsByTagName("test").item(0).getTextContent();
				String match = elementMatches.getElementsByTagName("match").item(0).getTextContent();
				String prohibited = elementMatches.getElementsByTagName("prohibited").item(0).getTextContent();

				Pi_TargetVO vo = new Pi_TargetVO();
				// Target 기본정보
				vo.setGroup_id(GroupID);
				vo.setTarget_id(TargetID);
				vo.setComments(TargetComments);
				vo.setSearch_status(TargetSearchStatus);
				vo.setName(TargetName);
				vo.setPlatform(TargetPlatform);
				// Target-Error 기본정보
				vo.setCritical(critical);
				vo.setError(error);
				vo.setNotice(notice);

				vo.setTest(test);
				vo.setProhibited(prohibited);
				vo.setMatchcnt(match);

				list.add(vo);
			}
		}

		logger.info("Before Insert");
		int ret = 0;
		try {
			ret = targetservice.insertTarget(list);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			// e.printStackTrace();
			logger.info("ERROR ========================================");
			logger.info(e.getMessage());
			ret = -999;
		}

		logger.info("targetservice.insertTarget == " + ret);
		return null;
	}

}