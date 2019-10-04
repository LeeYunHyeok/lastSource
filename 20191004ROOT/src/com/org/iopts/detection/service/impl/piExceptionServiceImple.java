package com.org.iopts.detection.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.org.iopts.detection.dao.piExceptionDAO;
import com.org.iopts.detection.service.piExceptionService;
import com.org.iopts.util.SessionUtil;

@Service("exceptionService")
@Transactional
public class piExceptionServiceImple implements piExceptionService {
	
	private static Logger log = LoggerFactory.getLogger(piExceptionServiceImple.class);

	@Inject
	private piExceptionDAO exceptionDao;

	@Override
	public List<HashMap<String, Object>> selectExceptionList(HashMap<String, Object> params) throws Exception {
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		params.put("user_no", user_no);

		return exceptionDao.selectExceptionList(params);
	}

	@Override
	public List<HashMap<String, Object>> selectExeptionPath(HashMap<String, Object> params) throws Exception {
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		params.put("user_no", user_no);

		return exceptionDao.selectExeptionPath(params);
	}

	@Override
	public Map<String, Object> selectDocuNum(HashMap<String, Object> params) throws Exception {
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		params.put("user_no", user_no);

		Map<String, Object> memberMap = exceptionDao.selectDocuNum(params);
		log.info("selectDocuNum : " + memberMap);

		return memberMap;
	}

	@Override
	public HashMap<String, Object> registPathExceptionCharge(HashMap<String, Object> params) throws Exception
	{
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		params.put("user_no", user_no);

		exceptionDao.registPathExceptionCharge(params);

		return params;
	}

	@Override
	public void updateExcepStatus(HashMap<String, Object> params, HashMap<String, Object> chargeMap) throws Exception
	{
		log.info("updateProcessStatus 로그체크 1");

		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		List<String> idxList = (List<String>)params.get("idxList");

		Map<String, Object> map = new HashMap<String, Object>();
		for (int i = 0; i < idxList.size(); i++) 
		{
			map.put("idx", idxList.get(i));
			map.put("user_no", user_no);
			map.put("ok_user_no", params.get("ok_user_no"));
			map.put("apprType", params.get("apprType"));
			map.put("path_ex_charge_id", chargeMap.get("path_ex_charge_id"));
			map.put("comment", params.get("comment"));

			exceptionDao.updateExceptionGroupStatus(map);
		}
	}

	@Override
	public List<HashMap<String, Object>> exceptionApprovalAllListData(HashMap<String, Object> params) throws Exception {
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");

		params.put("user_no", user_no);

		return exceptionDao.exceptionApprovalAllListData(params);
	}

	@Override
	public List<HashMap<String, Object>> exceptionApprovalListData(HashMap<String, Object> params) throws Exception {
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String user_grade = SessionUtil.getSession("memberSession", "USER_GRADE");

		params.put("user_no", user_no);
		params.put("user_grade", user_grade);

		return exceptionDao.exceptionApprovalListData(params);
	}

	@Override
	public List<HashMap<String, Object>> selectExceptionGroupPath(HashMap<String, Object> params) throws Exception
	{
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String user_grade = SessionUtil.getSession("memberSession", "USER_GRADE");

		String charge_id = (String)params.get("CHARGE_ID_LIST");
		List<String> charge_id_list = new ArrayList<String>();
		if(charge_id != null && !"".equals(charge_id)) {
			StringTokenizer st = new StringTokenizer(charge_id,",");
			while(st.hasMoreTokens()) {
				charge_id_list.add(st.nextToken());
			}
		}

		params.put("user_no", user_no);
		params.put("user_grade", user_grade);
		params.put("charge_id_list", charge_id_list);

		return exceptionDao.selectExceptionGroupPath(params);
	}

	/**
	 * 결재 리스트 - 결재
	 */
	@Override
	public void updateExcepApproval(HashMap<String, Object> params) throws Exception
	{
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String charge_id = (String)params.get("chargeIdList");

		List<String> chargeIdList = new ArrayList<String>();
		if(charge_id != null && !"".equals(charge_id)) {
			StringTokenizer st = new StringTokenizer(charge_id, ",");
			while(st.hasMoreTokens()) {
				chargeIdList.add(st.nextToken());
			}
		}

		HashMap<String, Object> map = new HashMap<String, Object>();
		for (int i = 0; i < chargeIdList.size(); i++) 
		{
			map.put("chargeIdList", chargeIdList.get(i));
			map.put("user_no",  user_no);
			map.put("apprType", params.get("apprType"));
			map.put("reason",   params.get("reason"));

			exceptionDao.updateExceptionApproval(map);
		}
	}
}