package com.org.iopts.service;

import java.net.ProtocolException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.org.iopts.controller.ExceptionController;
import com.org.iopts.dao.Pi_ExceptionDAO;

import com.org.iopts.util.ReconUtil;
import com.org.iopts.util.SessionUtil;

import net.sf.json.JSONObject;

@Service
public class Pi_ExceptionServiceImpl implements Pi_ExceptionService {
	
	private static Logger logger = LoggerFactory.getLogger(Pi_ExceptionServiceImpl.class);

	@Inject
	private Pi_ExceptionDAO dao;
	
	@Override
	public List<Map<String, Object>> selectFindSubpath(HttpServletRequest request) throws Exception {
		
		String target_id = request.getParameter("target_id");
		String location = request.getParameter("location");

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("target_id", target_id);
		map.put("location", location);
		
		logger.info("selectFindSubpath IMPL");

		List<Map<String, Object>>findMap = dao.selectFindSubpath(map);
		
		return findMap;
	}

	@Override
	@Transactional
	public void registException(HttpServletRequest request) {

		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String reason = request.getParameter("reason");
		String ok_user_no = request.getParameter("ok_user_no");		
		String[] exceptionList = request.getParameterValues("exceptionList[]");

		for (int i = 0; i < exceptionList.length; i++) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("hash_id", exceptionList[i]);
			map.put("user_no", user_no);
			map.put("ok_user_no", ok_user_no);
			map.put("reason", reason);
			
			dao.registException(map);	
		}
	}

	@Override
	@Transactional
	public void deleteException(HttpServletRequest request) {

		String[] exceptionList = request.getParameterValues("exceptionList[]");

		for (int i = 0; i < exceptionList.length; i++) {
			dao.deleteException(exceptionList[i]);
		}
	}
	
	@Override
	@Transactional
	public void registDeletion(HttpServletRequest request) {

		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String[] deletionList = request.getParameterValues("deletionList[]");

		for (int i = 0; i < deletionList.length; i++) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("hash_id", deletionList[i]);
			map.put("user_no", user_no);
			
			dao.registDeletion(map);	
		}
	}

	@Override
	public Map<String, Object> getMatchObjects(HttpServletRequest request, String recon_id, String recon_password, String recon_url) {

		String id = request.getParameter("id");
		Map<String, Object> resultMap = new HashMap<String, Object>();
		Map<String, Object> targetObject = new HashMap<String, Object>();
		try {
			targetObject = dao.getTargetByNode(id);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			resultMap.put("resultCode", -1);
			resultMap.put("resultMessage", e.getMessage());
			return resultMap;
		}
		
		if (targetObject.isEmpty()) {
			resultMap.put("resultCode", -1);
			resultMap.put("resultMessage", "존재하지 않는 노드 ID");
			return resultMap;
			
		}
		String NodeID = (String) targetObject.get("INFO_ID");
		logger.info("NodeID : " + NodeID);
		String TargetID = (String) targetObject.get("TARGET_ID");
		logger.info("TargetID : " + TargetID);
		
		// 여기서 부터는 Recon server에서 데이터 받는
		//https://172.30.1.58:8339/beta/targets/15456464750237578083/matchobjects/1?details=true
		
		logger.info("getMatchObjects doc : " + "/beta/targets/" + TargetID + "/matchobjects/" + NodeID + "?details=true");
		ReconUtil reconUtil = new ReconUtil();
		Map<String, Object> httpsResponse = null;
		try {
			httpsResponse = reconUtil.getServerData(recon_id, recon_password, recon_url + "/beta/targets/" + TargetID + "/matchobjects/" + NodeID + "?details=true", "GET", null);
		} catch (ProtocolException e) {
			// TODO Auto-generated catch block
			resultMap.put("resultCode", -1);
			resultMap.put("resultMessage", e.getMessage());
			return resultMap;
		}
		int resultCode = (int) httpsResponse.get("HttpsResponseCode");
		String resultMessage = (String) httpsResponse.get("HttpsResponseMessage");
		if (resultCode != 200) {
			resultMap.put("resultCode", resultCode);
			resultMap.put("resultMessage", resultMessage);
			return resultMap;
		}
		JSONObject jsonObject = JSONObject.fromObject(httpsResponse.get("HttpsResponseData"));
		logger.info("getMatchObjects jsonObject : " + jsonObject);

		resultMap.put("resultData", jsonObject);
		resultMap.put("resultCode", 0);
		resultMap.put("resultMessage", "SUCCESS");
		return resultMap;
	}

	@Override
	public List<Map<String, Object>> selectExceptionList(HttpServletRequest request) throws Exception {

		Map<String, Object> searchMap = new HashMap<String, Object>();
		
		searchMap.put("status", request.getParameter("status"));
		searchMap.put("target_id", request.getParameter("target_id"));
		searchMap.put("fromDate", request.getParameter("fromDate"));
		searchMap.put("toDate", request.getParameter("toDate"));
		
		return dao.selectExceptionList(searchMap);
	}
	
	@Override
	public List<Map<String, Object>> selectDeletionList(HttpServletRequest request) throws Exception {

		Map<String, Object> searchMap = new HashMap<String, Object>();
		
		searchMap.put("fromDate", request.getParameter("fromDate"));
		searchMap.put("toDate", request.getParameter("toDate"));
		searchMap.put("target_id", request.getParameter("target_id"));
		
		return dao.selectDeletionList(searchMap);
	}

	@Override
	@Transactional
	public void deleteDeletion(HttpServletRequest request) {

		String[] deletionList = request.getParameterValues("deletionList[]");

		for (int i = 0; i < deletionList.length; i++) {
			dao.deleteDeletion(deletionList[i]);
		}
	}

	@Override
	public List<Map<String, Object>> selectExceptionApprList(HttpServletRequest request) throws Exception {

		String ok_user_no = SessionUtil.getSession("memberSession", "USER_NO");
		
		Map<String, Object> searchMap = new HashMap<String, Object>();		
		searchMap.put("user_no", request.getParameter("user_no"));
		searchMap.put("target_id", request.getParameter("target_id"));
		searchMap.put("fromDate", request.getParameter("fromDate"));
		searchMap.put("toDate", request.getParameter("toDate"));
		searchMap.put("ok_user_no", ok_user_no);
		
		return dao.selectExceptionApprList(searchMap);
	}

	@Override
	@Transactional
	public void registExceptionAppr(HttpServletRequest request) {

		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String apprType = request.getParameter("apprType");
		String[] exceptionApprList = request.getParameterValues("exceptionApprList[]");

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("user_no", user_no);
		map.put("apprType", apprType);
		
		for (int i = 0; i < exceptionApprList.length; i++) {
			map.put("idx", exceptionApprList[i]);
			dao.registExceptionAppr(map);
		}  
	}
}
