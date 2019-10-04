package com.org.iopts.service;

import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.annotation.JsonValue;
import com.org.iopts.dao.Pi_DashDAO;
import com.org.iopts.dto.Pi_AgentVO;
import com.org.iopts.dto.Pi_TotalDatetypeVO;
import com.org.iopts.util.ReconUtil;
import com.org.iopts.util.SessionUtil;
import com.sun.xml.internal.bind.v2.runtime.unmarshaller.XsiNilLoader.Array;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Service
public class Pi_DashServiceImpl implements Pi_DashService {
	private static Logger logger = LoggerFactory.getLogger(Pi_DashServiceImpl.class);
	@Inject
	private Pi_DashDAO dao;
	
	@Inject
	private Pi_TargetService targetservice;
	
	@Override
	public List<Pi_AgentVO> selectDashMenu() throws Exception {
		// TODO Auto-generated method stub
		String user_id = SessionUtil.getSession("memberSession", "USER_NO");
		logger.info("user_id=============================" + user_id);
		return dao.selectDashMenu(user_id);
	}

	@Override
	public Map<String, Object> selectDashInfo(HttpServletRequest request, String recon_id, String recon_password, String recon_url) throws Exception {
		String target_id = request.getParameter("target_id");
		
		if(target_id == null) {
			target_id = "";
		}
		
		Map<String, Object> returnMap = dao.selectDashInfo(target_id);
		
		/**
		 * 여기서 리콘을 연결해서
		 * API 호출 : https://172.30.1.58:8339/beta/targets/6486283965405758392/consolidated
		 * 여기서 나오는 값증에 제일 위에 값 하나를 가져와서
		 */
		
		ReconUtil reconUtil = new ReconUtil();
		Map<String, Object> httpsResponse = null;
		
		httpsResponse = reconUtil.getServerData(recon_id, recon_password, recon_url + "/beta/targets/" + target_id + "/isolated", "GET", null);
		
		JSONArray jsonArray = JSONArray.fromObject(httpsResponse.get("HttpsResponseData"));
		logger.info("getMatchObjects jsonObject : " + jsonArray);
		Object[] arr = jsonArray.toArray();
		String lastDate = arr[0].toString();

		long unixTime = Long.parseLong(lastDate) * 1000;
	    Date date = new Date(unixTime);
	    returnMap.put("REGDATE", date);
	    logger.info("returnMap chk : " + returnMap);
		return returnMap;
	}
	
	@Override
	public Map<String, Object> selectlastScanDate(HttpServletRequest request) {
		logger.info("selectlastScanDate");
		String target_id = request.getParameter("target_id");
		logger.info("target_id check : "+ target_id);
		return dao.selectlastScanDate(target_id);
	}
	
	/*
	@Override
	public List<Object> selectDatatype(HttpServletRequest request) throws Exception {
		// TODO Auto-generated method stub
		String user_id = SessionUtil.getSession("memberSession", "USER_NO");
		String target_id = request.getParameter("target_id");
		String days = request.getParameter("days");
		String date = null;
		
		Map<String, Object> type = new HashMap<>();
		List<Map<String, Object>> Data = null;
		Map<String, Object> real_data = new HashMap<>();
		List<Object> returnData = new ArrayList<>();
		int search_day = 0;
		int search_month = 0;
		type.put("user_id", user_id);
		if(target_id == null || target_id.equals("")) {
			
			if(days.equals("days")) {
				search_day = 7;
				type.put("date", search_day);
				Data = dao.selectDatatypeAll_day(type);
				logger.info("Data check1 : " + Data);
			} else if(days.equals("month")) {
				search_day = 30;
				type.put("date", search_day);
				Data = dao.selectDatatypeAll_day(type);
				logger.info("Data check2 : " + Data);
			} else if(days.equals("three_month")) {
				search_day = 90;
				type.put("date", search_day);
				Data = dao.selectDatatypeAll_day(type);
				logger.info("Data check3 : " + Data);
			} else if(days.equals("six_month")) {
				search_month = 6;
				Data = dao.selectDatatypeAll(user_id);
			} else {
				search_month = 12;
				Data = dao.selectDatatypeAll(user_id);
			}
			
		} else {
			type.put("target_id", target_id);
			if(days.equals("days")) {
				search_day = 7;
				type.put("date", search_day);
				Data = dao.selectDatatype_days(type);
			} else if(days.equals("month")) {
				search_day = 30;
				type.put("date", search_day);
				Data =  dao.selectDatatype_days(type);
			} else if(days.equals("three_month")) {
				search_day = 90;
				type.put("date", search_day);
				Data = dao.selectDatatype_days(type);
			} else if(days.equals("six_month")) {
				search_month = 6;
				type.put("date", search_day);
				Data = dao.selectDatatype(target_id);
			} else {	// 1년
				search_month = 12;
				Data = dao.selectDatatype(target_id);
			}
		}
		for(int i = 0; i < Data.size(); i++) { 
			Pi_TotalDatetypeVO vo = new Pi_TotalDatetypeVO();
			vo.setType1(Data.get(i).get("TYPE1").toString());
			vo.setType2(Data.get(i).get("TYPE2").toString());
			vo.setType3(Data.get(i).get("TYPE3").toString());
			vo.setType4(Data.get(i).get("TYPE4").toString());
			vo.setType5(Data.get(i).get("TYPE5").toString());
			vo.setType6(Data.get(i).get("TYPE6").toString());
			vo.setTotal(Data.get(i).get("TOTALS").toString());
			vo.setRegdate(Data.get(i).get("REGDATE").toString());
			
			real_data.put((String) Data.get(i).get("REGDATE").toString(), vo);
			logger.info("real_data chk : "+ real_data.toString());
		}
		
		if(search_month == 0) {
			SimpleDateFormat format = new SimpleDateFormat("yyyy.MM.dd");
			Date time = new Date();
			Calendar time_set = Calendar.getInstance();
			time_set.setTime(time);
			time_set.add(time_set.DATE, -search_day);
			for(int i = 0; i <= search_day; i++) {
				date = format.format(time_set.getTime());
				
				logger.info("date chk : "+ date);
				logger.info("real chk : " + real_data.get(date));
				
				
				Pi_TotalDatetypeVO vo = new Pi_TotalDatetypeVO();
				if(real_data.get(date) != null) {
					returnData.add(real_data.get(date));
				} else if(real_data.get(date) == null){
					vo.setType1("0");
					vo.setType2("0");
					vo.setType3("0");
					vo.setType4("0");
					vo.setType5("0");
					vo.setType6("0");
					vo.setTotal("0");
					vo.setRegdate(date);
					returnData.add(vo);
				}
				time_set.add(time_set.DATE, 1);
			}
		} else {
			SimpleDateFormat format = new SimpleDateFormat("yyyy.MM");
			Date time = new Date();
			Calendar time_set = Calendar.getInstance();
			time_set.setTime(time);
			time_set.add(time_set.MONTH, (-search_month+1));
			for(int i = 0; i < search_month; i++) {
				date = format.format(time_set.getTime());
				Pi_TotalDatetypeVO vo = new Pi_TotalDatetypeVO();
				if(real_data.get(date) != null) {
					returnData.add(real_data.get(date));
				} else if(real_data.get(date) == null){
					vo.setType1("0");
					vo.setType2("0");
					vo.setType3("0");
					vo.setType4("0");
					vo.setType5("0");
					vo.setType6("0");
					vo.setTotal("0");
					vo.setRegdate(date);
					returnData.add(vo);
				}
				time_set.add(time_set.MONTH, 1);
			}
		}
		
		return returnData;
	}*/

	@Override
	public List<Map<String,Object>> selectDatatype(HttpServletRequest request) throws Exception {
		logger.info("selectDatatype");
		
		// 7일
		String days = request.getParameter("days");
		String target_id = request.getParameter("target_id");
		
		logger.info("chk : " + days + " , " + target_id);
		
		Map<String, Object> type = new HashMap<String, Object>();
		List<Map<String, Object>> Data = null;
		int search_day = 0;
		int search_month = 0;
		
		if(target_id == null || target_id.equals("")) {
			
			if(days.equals("days")) {
				search_day = 7;
				type.put("date", search_day);
				logger.info("type chk : " + type.toString());
				Data = dao.selectDatatypeAll_day(type);
				logger.info("Data check1 : " + Data);
			} else if(days.equals("month")) {
				search_day = 30;
				type.put("date", search_day);
				Data = dao.selectDatatypeAll_day(type);
			} else if(days.equals("three_month")) {
				search_day = 90;
				type.put("date", search_day);
				Data = dao.selectDatatypeAll_day(type);
			} else if(days.equals("six_month")) {
				search_month = 6;
				type.put("date", search_month);
				Data = dao.selectDatatypeAll(type);
			} else {
				search_month = 12;
				type.put("date", search_month);
				Data = dao.selectDatatypeAll(type);
			}
			
		} 
		else {
			type.put("target_id", target_id);
			if(days.equals("days")) {
				search_day = 7;
				type.put("date", search_day);
				logger.info("type chk : " + type.toString());
				Data = dao.selectDatatype_days(type);
				logger.info("Data check1 : " + Data);
				
			} else if(days.equals("month")) {
				search_day = 30;
				type.put("date", search_day);
				Data =  dao.selectDatatype_days(type);
			} else if(days.equals("three_month")) {
				search_day = 90;
				type.put("date", search_day);
				Data = dao.selectDatatype_days(type);
			} else if(days.equals("six_month")) {
				search_month = 6;
				type.put("date", search_month);
				Data = dao.selectDatatype(type);
			} else {	// 1년
				search_month = 12;
				type.put("date", search_month);
				Data = dao.selectDatatype(type);
			}
		}
		return Data;
	}
	
	@Override
	public Map<String, Object> selectDatatypes(HttpServletRequest request) throws Exception {
		// TODO Auto-generated method stub
		List<String> datatype = new ArrayList<String>();
		datatype.add("RRN");
		datatype.add("FOREIGNER");
		datatype.add("DRIVER");
		datatype.add("PASSPORT");
		datatype.add("ACCOUNT_NUM");
		datatype.add("CARD_NUM");
		String user_id = SessionUtil.getSession("memberSession", "USER_NO");
		Map<String, Object> data = new HashMap<String, Object>();
		Map<String, Object> result = new HashMap<String, Object>();
		for(int i = 0; i < datatype.size(); i++) {
			data.put("datatype", datatype.get(i));
			data.put("user_id", user_id);
			result.put(datatype.get(i), dao.selectDatatypes(data));
		}
		return result;
	}

	@Override
	public List<Object> selectSystemCurrent(HttpServletRequest request) {
		logger.info("selectSystemCurrent check");
		return dao.selectSystemCurrent();
	}
	
	@Override
	public List<Object> selectJumpUpHost(HttpServletRequest request) {
		logger.info("selectJumpUpHost check");
		return dao.selectJumpUpHost();
	}

}
