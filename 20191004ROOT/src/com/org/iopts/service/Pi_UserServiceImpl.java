package com.org.iopts.service;

import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.org.iopts.dao.Pi_UserDAO;
import com.org.iopts.util.ServletUtil;
import com.org.iopts.util.SessionUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Service
public class Pi_UserServiceImpl implements Pi_UserService {

	private static Logger logger = LoggerFactory.getLogger(Pi_UserServiceImpl.class);

	@Inject
	private Pi_UserDAO dao;

	@Override
	public Map<String, Object> selectMember(HttpServletRequest request) throws Exception {

		// Session clear
		SessionUtil.closeSession("memberSession");
		ServletUtil servletUtil = new ServletUtil(request);
		String clientIP = servletUtil.getIp();
		String user_no = request.getParameter("user_no");
		String password = request.getParameter("password");
		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("user_no", user_no);
		searchMap.put("password", password);
		
		// User Log 남기기
		Map<String, Object> userLog = new HashMap<String, Object>();
		userLog.put("user_no", user_no);
		userLog.put("menu_name", "LOGIN");		
		userLog.put("user_ip", clientIP);
		userLog.put("job_info", "Log-In Success");

		Map<String, Object> resultMap = new HashMap<String, Object>();
		Map<String, Object> memberMap = dao.selectMember(searchMap);

		// 사용자번호가 틀린 경우
		if ((memberMap == null) || (memberMap.size() == 0)) {
			resultMap.put("resultCode", -1);
			resultMap.put("resultMessage", user_no + "는 존재하지 않는 ID 입니다.");
			
			userLog.put("job_info", "Log-In Fail(Invalid User No)");
			dao.insertMemberLog(userLog);
			return resultMap;
		}
		// 비밀번호가 틀린 경우
		if (!(memberMap.get("PASSWORD").equals("Y"))) {
			resultMap.put("resultCode", -2);
			resultMap.put("resultMessage", "비밀번호 오류 입니다.");

			userLog.put("job_info", "Log-In Fail(Invalid Password)");
			dao.insertMemberLog(userLog);
			return resultMap;			
		}

		// 비밀번호가 틀린 경우
		logger.info((String) memberMap.get("USER_GRADE"));
		logger.info((String) memberMap.get("ACCESS_IP"));
		if ((memberMap.get("USER_GRADE").equals("9"))) {

			String accessIP = (String) memberMap.get("ACCESS_IP");
			
			if(accessIP.equals("")) {
				resultMap.put("resultCode", -3);
				resultMap.put("resultMessage", "최고관리자의 접근IP가 없습니다.");
				
				userLog.put("job_info", "Log-In Fail(Access IP is Null)");
				dao.insertMemberLog(userLog);
				return resultMap;			
			}

			String[] accessIPs = accessIP.split(",");
			if (!Arrays.asList(accessIPs).contains(clientIP)) {
				resultMap.put("resultCode", -3);
				resultMap.put("resultMessage", "등록되지 않은 최고관리자 접근IP입니다.");
				userLog.put("job_info", "Log-In Fail(Access IP is Invalid)");
				dao.insertMemberLog(userLog);
				return resultMap;			
			}

		}
		
		// 관리자/일반사용자 분리
//		if ((memberMap.get("USER_GRADE").equals("0"))) {
//			resultMap.put("user_grade", );
//		}
		
		Object str = memberMap.get("USER_GRADE");
		System.out.println("user_grade 확인 = "+str);
		
		dao.insertMemberLog(userLog);
		
		resultMap.put("resultCode", 0);
		resultMap.put("resultMessage", "로그인 성공");
		resultMap.put("user_grade", str);
		resultMap.put("member", memberMap);
		System.out.println("resultMap 확인 = "+ resultMap);
		
		// 사용자 세션 등록
		SessionUtil.setSession("memberSession", memberMap);

		return resultMap;
	}

	@Override
	public Map<String, Object> selectSSOMember(HttpServletRequest request) throws Exception 
	{
		// Session clear
		SessionUtil.closeSession("memberSession");
		ServletUtil servletUtil = new ServletUtil(request);
		String clientIP = servletUtil.getIp();
		String user_no = request.getParameter("user_no");
		String password = request.getParameter("password");

		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("user_no", user_no);
		searchMap.put("password", password);
		
		// User Log 남기기
		Map<String, Object> userLog = new HashMap<String, Object>();
		userLog.put("user_no", user_no);
		userLog.put("menu_name", "LOGIN");		
		userLog.put("user_ip", clientIP);
		userLog.put("job_info", "Log-In Success");

		Map<String, Object> resultMap = new HashMap<String, Object>();
		Map<String, Object> memberMap = dao.selectSSOMember(searchMap);
logger.info(""+memberMap);
		// 사용자번호가 틀린 경우
		if ((memberMap == null) || (memberMap.size() == 0)) {
			resultMap.put("resultCode", -1);
			resultMap.put("resultMessage", user_no + "는 존재하지 않는 ID 입니다.");
			
			userLog.put("job_info", "Log-In Fail(Invalid User No)");
			dao.insertMemberLog(userLog);
			return resultMap;
		}
		// 비밀번호가 틀린 경우
		if (!(memberMap.get("PASSWORD").equals("Y"))) {
			resultMap.put("resultCode", -2);
			resultMap.put("resultMessage", "비밀번호 오류 입니다.");

			userLog.put("job_info", "Log-In Fail(Invalid Password)");
			dao.insertMemberLog(userLog);
			return resultMap;			
		}

		// 비밀번호가 틀린 경우
		logger.info((String) memberMap.get("USER_GRADE"));
		logger.info((String) memberMap.get("ACCESS_IP"));
		if ((memberMap.get("USER_GRADE").equals("9"))) {

			String accessIP = (String) memberMap.get("ACCESS_IP");
			
			if(accessIP.equals("")) {
				resultMap.put("resultCode", -3);
				resultMap.put("resultMessage", "최고관리자의 접근IP가 없습니다.");
				
				userLog.put("job_info", "Log-In Fail(Access IP is Null)");
				dao.insertMemberLog(userLog);
				return resultMap;			
			}

			String[] accessIPs = accessIP.split(",");
			if (!Arrays.asList(accessIPs).contains(clientIP)) {
				resultMap.put("resultCode", -3);
				resultMap.put("resultMessage", "등록되지 않은 최고관리자 접근IP입니다.");
				userLog.put("job_info", "Log-In Fail(Access IP is Invalid)");
				dao.insertMemberLog(userLog);
				return resultMap;			
			}

		}
		
		// 관리자/일반사용자 분리
//		if ((memberMap.get("USER_GRADE").equals("0"))) {
//			resultMap.put("user_grade", );
//		}
		
		Object str = memberMap.get("USER_GRADE");
		System.out.println("user_grade 확인 = "+str);
		
		dao.insertMemberLog(userLog);
		
		resultMap.put("resultCode", 0);
		resultMap.put("resultMessage", "로그인 성공");
		resultMap.put("user_grade", str);
		resultMap.put("member", memberMap);
		System.out.println("resultMap 확인 = "+ resultMap);
		
		// 사용자 세션 등록
		SessionUtil.setSession("memberSession", memberMap);

		return resultMap;
	}

	@Override
	public List<Map<String, Object>> selectTeamMember(HttpServletRequest request) throws Exception {

		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("insa_code", SessionUtil.getSession("memberSession", "INSA_CODE"));
		searchMap.put("user_no", SessionUtil.getSession("memberSession", "USER_NO"));
		
		return dao.selectTeamMember(searchMap);
	}
	
	@Override
	public Map<String, Object> selectTeamManager() throws Exception {

		String boss_name = SessionUtil.getSession("memberSession", "USER_NO");
		
		return dao.selectTeamManager(boss_name);
	}
	
	@Override
	@Transactional
	public Map<String, Object> changeAuthCharacter(HttpServletRequest request) throws Exception {

		Map<String, Object> resultMap = new HashMap<String, Object>();
		ServletUtil servletUtil = new ServletUtil(request);
		
		String oldPassword = request.getParameter("oldPassword");
		String newPasswd = request.getParameter("newPasswd");
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		
		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("user_no", user_no);
		searchMap.put("oldPassword", oldPassword);
		searchMap.put("newPasswd", newPasswd);
		
		int ret = dao.changeAuthCharacter(searchMap);

		// User Log 남기기
		Map<String, Object> userLog = new HashMap<String, Object>();
		userLog.put("user_no", user_no);
		userLog.put("menu_name", "PASSWORD CHANGE");		
		userLog.put("user_ip", servletUtil.getIp());
		userLog.put("job_info", "Log-In Success");

		if (ret == 1) {
			resultMap.put("resultCode", 0);
			resultMap.put("resultMessage", "비밀번호가 변경되었습니다.");
			userLog.put("job_info", "Password Change Success");
			
			dao.insertMemberLog(userLog);
		}
		else {
			resultMap.put("resultCode", -1);
			resultMap.put("resultMessage", "현재 비밀번호가 다릅니다.");
			userLog.put("job_info", "Password Change Fail");
			
			dao.insertMemberLog(userLog);
		}
		
		return resultMap;
	}
	
	@Override
	public List<Map<String, Object>> selectUserLogList(HttpServletRequest request) throws Exception {

		String fromDate = request.getParameter("fromDate");
		String toDate = request.getParameter("toDate");
		String userNo = request.getParameter("userNo");
		String userName = request.getParameter("userName");
		
		Map<String, Object> search = new HashMap<String, Object>();
		search.put("userNo", userNo);
		search.put("userName", userName);
		search.put("fromDate", fromDate);
		search.put("toDate", toDate);

		return dao.selectUserLogList(search);
	}

	@Override
	@Transactional
	public void insertMemberLog(Map<String, Object> userLog) throws Exception {
		
		dao.insertMemberLog(userLog);
	}
	
	@Override
	public String selectAccessIP() throws Exception {

		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String accessIP = dao.selectAccessIP(user_no);

		return accessIP;
	}

	@Override
	@Transactional
	public void changeAccessIP(HttpServletRequest request) throws Exception {

		String accessIP = request.getParameter("accessIP");
		String userNo = SessionUtil.getSession("memberSession", "USER_NO");

		Map<String, Object> input = new HashMap<String, Object>();
		input.put("userNo", userNo);
		input.put("accessIP", accessIP);
		
		dao.changeAccessIP(input);
	}

	@Override
	@Transactional
	public void logout(HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession(true); 
		if (session.getAttribute("memberSession") != null ) {
			// User Log 남기기 (session이 살아있는 경우)
			ServletUtil servletUtil = new ServletUtil(request);
			String clientIP = servletUtil.getIp();
			String user_no = SessionUtil.getSession("memberSession", "USER_NO");
			
			Map<String, Object> userLog = new HashMap<String, Object>();
			userLog.put("user_no", user_no);
			userLog.put("menu_name", "LOGOUT");		
			userLog.put("user_ip", clientIP);
			userLog.put("job_info", "Log-Out");
			
			SessionUtil.closeSession("memberSession");
			
			dao.insertMemberLog(userLog);
		}
	}
	
	@Override
	public List<Map<String, Object>> selectManagerList(HttpServletRequest request) throws Exception {
		
		return dao.selectManagerList();
	}

	@Override
	@Transactional
	public void changeManagerList(HttpServletRequest request) throws Exception {

		Map<String, Object> map = new HashMap<String, Object>();
		String userList = request.getParameter("userList");

		JSONArray userArray = JSONArray.fromObject(userList);

		if (userArray.size() != 0) {
			for (int i = 0; i < userArray.size(); i++) {
				JSONObject userMap = (JSONObject) userArray.get(i);
				map.put("userNo", userMap.getString("userNo"));		
				map.put("userGrade", userMap.getString("userGrade"));				
				dao.changeManagerList(map);
			}
		}
	}
	
	@Override
	public List<Map<String, Object>> selectTeamCode() throws Exception {
		
		return dao.selectTeamCode();
	}
	
	@Override
	public Map<String, Object> chkDuplicateUserNo(HttpServletRequest request) throws Exception {
		
		String userNo = request.getParameter("userNo");
		
		return dao.chkDuplicateUserNo(userNo);
	}

	@Override
	@Transactional
	public void createUser(HttpServletRequest request) throws Exception {

		Map<String, Object> map = new HashMap<String, Object>();

		String userNo = request.getParameter("userNo");
		String password = request.getParameter("password");
		String jikwee = request.getParameter("jikwee");
		String team = request.getParameter("team");
		String jikguk = request.getParameter("jikguk");
		String userName = request.getParameter("userName");

		map.put("userNo", userNo);
		map.put("userName", userName);
		map.put("password", password);
		map.put("jikwee", jikwee);
		map.put("jikguk", jikguk);
		map.put("team", team);
		map.put("grade", "0");
		
		dao.createUser(map);
	}
}
