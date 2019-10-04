package com.org.iopts.service;

import java.net.ProtocolException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.org.iopts.controller.ExceptionController;
import com.org.iopts.dao.Pi_ScanDAO;
import com.org.iopts.dto.Pi_Scan_HostVO;
import com.org.iopts.dto.Pi_ScheduleVO;
import com.org.iopts.util.ReconUtil;
import com.org.iopts.util.SessionUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Service
public class Pi_ScanServiceImpl implements Pi_ScanService {
	
	private static Logger logger = LoggerFactory.getLogger(Pi_ScanServiceImpl.class);
	
	@Inject
	private Pi_ScanDAO dao;

	@Override
	public List<Map<String, Object>> selectSchedules(HttpServletRequest request) throws Exception {
		// TODO Auto-generated method stub

		String fromDate = request.getParameter("fromDate");
		String toDate = request.getParameter("toDate");
		String searchType = request.getParameter("searchType");
		String hostName = request.getParameter("hostName");
		JSONArray searchArray = JSONArray.fromObject(searchType);
		
		Map<String, Object> search = new HashMap<String,Object>();
		search.put("fromDate", fromDate);
		search.put("toDate", toDate);
		search.put("hostName", hostName);
		search.put("searchType", searchArray);
		
		return dao.selectSchedules(search);
	}

	@Override
	public List<Pi_ScheduleVO> selectSchedule(String schedule_status) throws Exception {
		// TODO Auto-generated method stub
		return dao.selectSchedule(schedule_status);
	}

	@Override
	public List<Pi_Scan_HostVO> selectScanHost() throws Exception {
		// TODO Auto-generated method stub
		return dao.selectScanHost();
	}

	@Override
	public Map<String, Object> changeSchedule(HttpServletRequest request, String recon_id, String recon_password, String recon_url) throws Exception {

		//https://172.30.1.58:8339/beta/schedules/98/Action
		String id = request.getParameter("id");
		String task = request.getParameter("task");
		logger.info("getMatchObjects doc : " + "/beta/schedules/" + id + "/" + task);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		ReconUtil reconUtil = new ReconUtil();
		Map<String, Object> httpsResponse = null;
		try {
			httpsResponse = reconUtil.getServerData(recon_id, recon_password, recon_url + "/beta/schedules/" + id + "/" + task, "POST", null);
		} catch (ProtocolException e) {
			// TODO Auto-generated catch block
			resultMap.put("resultCode", -1);
			resultMap.put("resultMessage", e.getMessage());
			return resultMap;
		}

		int resultCode = (int) httpsResponse.get("HttpsResponseCode");
		String resultMessage = (String) httpsResponse.get("HttpsResponseMessage");
		if ((resultCode != 200) && (resultCode != 204)) {
			resultMap.put("resultCode", resultCode);
			resultMap.put("resultMessage", resultMessage);
			return resultMap;
		}
		// 작업변경이 성공하면 DB도 변경 해 준다.
     	String changedTask = "scheduled";
     	switch (task) {
     	case "deactivate" :
     		changedTask = "deactivated";
     		break;
     	case "skip" :
     		changedTask = "scheduled";
     		break;
     	case "pause" :
     		changedTask = "pause";
     		break;
     	case "restart" :
     		changedTask = "scheduled";
     		break;
     	case "stop" :
     		changedTask = "stoped";
     		break;
     	case "cancel" :
     		changedTask = "cancelled";
     		break;
     	case "reactivate" :
     		changedTask = "scheduled";
     		break;
 		default :
     		changedTask = "scheduled";
 		break;
     	}
		Map<String, Object> inputMap = new HashMap<String, Object>();
		inputMap.put("SCHEDULE_ID", id);
		inputMap.put("SCHEDULE_STATUS", changedTask);
  	 	dao.changeSchedule(inputMap);
  	
		resultMap.put("resultCode", 0);
		resultMap.put("resultMessage", "SUCCESS");
		return resultMap;
	}

	@Override
	public Map<String, Object> viewSchedule(HttpServletRequest request, String recon_id, String recon_password, String recon_url) throws Exception {

		//https://masterIP:8339/beta/schedules/98?details=true
		String id = request.getParameter("id");
		logger.info("getMatchObjects doc : " + "/beta/schedules/" + id + "?details=true");

		Map<String, Object> resultMap = new HashMap<String, Object>();
		ReconUtil reconUtil = new ReconUtil();
		Map<String, Object> httpsResponse = null;
		try {
			httpsResponse = reconUtil.getServerData(recon_id, recon_password, recon_url + "/beta/schedules/" + id + "?details=true", "GET", null);
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

		ArrayList<String> datatypeList = new ArrayList<String>();     
		JSONArray datatypeJson = jsonObject.getJSONArray("profiles");
		if (datatypeJson != null) { 
		   for (int i = 0; i < datatypeJson.size(); i++){ 
			   datatypeList.add(datatypeJson.get(i).toString());
		   } 
			Map<String, Object> datatypeMap = new HashMap<String, Object>();
			datatypeMap.put("DATATYPE", datatypeList);
			
			List<Map<String, Object>> datatypeLabelList = dao.selectDataTypes(datatypeMap);
			jsonObject.put("profilesLabel", datatypeLabelList);
		} 
		
		Long next_scan = jsonObject.getLong("next_scan");
		java.util.Date time = new java.util.Date(next_scan * 1000);
		jsonObject.put("next_scanDate", time);
		
		resultMap.put("resultData", jsonObject);
		resultMap.put("resultCode", 0);
		resultMap.put("resultMessage", "SUCCESS");
		return resultMap;
	}
	
	@Override
	public List<Map<String, Object>> selectLocationList() throws Exception {
		
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String user_grade = SessionUtil.getSession("memberSession", "USER_GRADE");
		
		Map<String, Object> map = new HashMap<String, Object>();		
		
		if (user_grade.equals("0")) { // 일반 사용자인 경우
			map.put("user_no", user_no);
		}
		else {
			map.put("user_no", "");
		}
		
		return dao.selectLocationList(map);
	}
	
	@Override
	public List<Map<String, Object>> selectDatatypeList() throws Exception {

		
		List<Map<String, Object>> dataTypeArr = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> map = dao.selectDatatypeList();
		
		for (int i = 0; i < map.size(); i++) {
			Map<String, Object> dataTypes = map.get(i);
			
			int version = (int) dataTypes.get("VERSION");
			String label = (String) dataTypes.get("DATATYPE_LABEL");
			int key = ((Double) dataTypes.get("RNUM")).intValue();
			
			List<Map<String, Object>> dataTypeVersions = dao.selectDatatypeVersion(label);
			Map<String, Object> dataTypeMap = new HashMap<String, Object>();

			dataTypeMap.put("KEY", key);
			dataTypeMap.put("DATATYPE_LABEL", label);
			dataTypeMap.put("VERSION", version);
			dataTypeMap.put("DATATYPE_ID", dataTypeVersions);
			
			dataTypeArr.add(dataTypeMap);
		}

		return dataTypeArr;
	}
	
	@Override
	public List<Map<String, Object>> selectDatatypeListMod(HttpServletRequest request) throws Exception {

		
		List<Map<String, Object>> dataTypeArr = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> map = dao.selectDatatypeList();
		List<Map<String, Object>> policy = this.viewScanPolicy(request);

		String sDatatypeId = (String) policy.get(0).get("datatype_id");
		if (sDatatypeId == null) {
			return null;
		}
		String[] aDatatypeId = sDatatypeId.split(",");

		for (int i = 0; i < map.size(); i++) 
		{
			Map<String, Object> dataTypes = map.get(i);

			int version = (int) dataTypes.get("VERSION");
			String label = (String) dataTypes.get("DATATYPE_LABEL");
			int key = ((Double) dataTypes.get("RNUM")).intValue();
			
			List<Map<String, Object>> dataTypeVersions = dao.selectDatatypeVersion(label);
			Map<String, Object> dataTypeMap = new HashMap<String, Object>();

			dataTypeMap.put("KEY", key);
			dataTypeMap.put("DATATYPE_LABEL", label);
			dataTypeMap.put("VERSION", version);
			dataTypeMap.put("DATATYPE_ID", dataTypeVersions);

			loopOut:
			for (int j = 0; j < aDatatypeId.length; j++) {
				for (int k = 0; k < dataTypeVersions.size(); k++)
				{
					if (aDatatypeId[j].equals(dataTypeVersions.get(k).get("DATATYPE_ID"))) {
						dataTypeMap.put("CHECKED", 1);
						break loopOut;
					}
				}
			}
			dataTypeArr.add(dataTypeMap);
		}

		return dataTypeArr;
	}

	@Override
	public Map<String, Object> registSchedule(HttpServletRequest request, String recon_id, String recon_password, String recon_url) throws Exception {

		logger.info("getMatchObjects doc : " + "/beta/schedules");
		String scheduleData = request.getParameter("scheduleData");
		ReconUtil reconUtil = new ReconUtil();
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		Map<String, Object> httpsResponse = reconUtil.getServerData(recon_id, recon_password, recon_url+"/beta/schedules", "POST", scheduleData);

		int resultCode = (int) httpsResponse.get("HttpsResponseCode");
		String resultMessage = (String) httpsResponse.get("HttpsResponseMessage");
		
		resultMap.put("resultCode", resultCode);
		resultMap.put("resultMessage", resultMessage);
		return resultMap;
	}

	@Override
	public Map<String, Object> getProfileDetail(HttpServletRequest request, String recon_id, String recon_password, String recon_url) throws Exception {
		//https://172.30.1.58:8339/beta/datatypes/profiles/13973816057316668091?details=true
		
		String id = request.getParameter("datatypeId");
		logger.info("getMatchObjects doc : " + "/beta/datatypes/profiles/" + id + "?details=true");

		Map<String, Object> resultMap = new HashMap<String, Object>();
		ReconUtil reconUtil = new ReconUtil();
		Map<String, Object> httpsResponse = null;
		try {
			httpsResponse = reconUtil.getServerData(recon_id, recon_password, recon_url + "/beta/datatypes/profiles/" + id + "?details=true", "GET", null);
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
		
		resultMap.put("resultData", jsonObject);
		resultMap.put("resultCode", 0);
		resultMap.put("resultMessage", "SUCCESS");
		return resultMap;
	}

	@Override
	public List<Map<String, Object>> viewScanHistory(HttpServletRequest request) {
		String target_id = request.getParameter("target_id");
		
		Map<String, Object> historyList = new HashMap<String,Object>();
		historyList.put("target_id", target_id);
		
		return dao.viewScanHistory(historyList);
	}

	@Override
	public List<Map<String, Object>> viewScanPolicy(HttpServletRequest request) {
		String idx = request.getParameter("idx");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("idx", idx);
		
		return dao.viewScanPolicy(map);
	}

	@Override
	public Map<String, Object> registPolicy(HttpServletRequest request) throws Exception {
		
		String policy_name = request.getParameter("policy_name");
		String policy_version = request.getParameter("policy_version");
		String comment = request.getParameter("comment");
		String datatype = request.getParameter("datatype");
		String label = request.getParameter("label");
		
		String pauseDays = request.getParameter("pauseDays");
		String pauseMonth = request.getParameter("pauseMonth");
		String pauseFrom = request.getParameter("pauseFrom");
		String pauseTo = request.getParameter("pauseTo");
		
		String cpu = request.getParameter("cpu");
		String data = request.getParameter("data");
		String memory = request.getParameter("memory");
		
		String trace = request.getParameter("trace");
		String dmz = request.getParameter("dmz");
		String check = request.getParameter("default_check");
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("datatype", datatype);
		map.put("policy_name", policy_name);
		map.put("policy_version", policy_version);	
		
		map.put("comment", comment);
		map.put("schedule_label", label);
		
		map.put("schedule_pause_days", pauseDays);
		map.put("schedule_pause_month", pauseMonth);
		map.put("schedule_pause_from", pauseFrom);
		map.put("schedule_pause_to", pauseTo);
		
		map.put("schedule_cpu", cpu);
		map.put("schedule_data", data);
		map.put("schedule_memory", memory);
		
		map.put("schedule_trace", trace);
		map.put("dmz", dmz);
		map.put("check", check);
		
		logger.info("map check : " + map);
		
		dao.registPolicy(map);
		
		return map;
		
	}

	@Override
	public void resetDefaultPolicy(HttpServletRequest request) {
		logger.info("resetDefaultPolicy request : " + request);
		dao.resetDefaultPolicy(request);
	}

	@Override
	public void updateDefaultPolicy(HttpServletRequest request) {
		logger.info("updateDefaultPolicy");
		String idx = request.getParameter("idx");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("idx", idx);
		dao.updateDefaultPolicy(map);
	}

}
