package com.org.iopts.detection.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.org.iopts.dao.Pi_DetectionDAO;
import com.org.iopts.detection.dao.piApprovalDAO;
import com.org.iopts.detection.service.piApprovalService;
import com.org.iopts.util.SessionUtil;

@Service("approvalService")
@Transactional
public class piApprovalServiceImple implements piApprovalService {
	
	private static Logger log = LoggerFactory.getLogger(piApprovalServiceImple.class);
	
	@Inject
	private Pi_DetectionDAO detectionDao;

	@Inject
	private piApprovalDAO approvalDao;

	@Override
	public List<HashMap<String, Object>> searchProcessList(HashMap<String, Object> params) throws Exception {

		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		params.put("user_no", user_no);			// 사용자

		return approvalDao.searchProcessList(params);
	}

	@Override
	public List<HashMap<String, Object>> selectTeamMember(HttpServletRequest request) throws Exception {
		HashMap<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("insa_code", SessionUtil.getSession("memberSession", "INSA_CODE"));
		searchMap.put("user_no", SessionUtil.getSession("memberSession", "USER_NO"));
		
		return approvalDao.selectTeamMember(searchMap);
	}

	@Override
	public Map<String, Object> selectDocuNum(HashMap<String, Object> params) throws Exception {
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		params.put("user_no", user_no);

		Map<String, Object> memberMap = approvalDao.selectDocuNum(params);
		log.info("selectDocuNum : " + memberMap);

		return memberMap;
		
	}

	@Override
	public List<HashMap<String, Object>> selectProcessPath(HashMap<String, Object> params) throws Exception {
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		params.put("user_no", user_no);

		return approvalDao.selectProcessPath(params);
	}

	@Override
	public HashMap<String, Object>  registProcessCharge(HashMap<String, Object> params) throws Exception
	{
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		params.put("user_no", user_no);

		approvalDao.registProcessCharge(params);
		
		return params;
	}

	@Override
	public void updateProcessStatus(HashMap<String, Object> params, Map<String, Object> chargeMap) throws Exception
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
			map.put("data_processing_charge_id", chargeMap.get("data_processing_charge_id"));
			map.put("data_processing_group_id", params.get("groupId"));
			map.put("comment", params.get("comment"));

			approvalDao.updateProcessingGroupStatus(map);
			approvalDao.updateProcessingStatus(map);
		}
	}
	
	@Override
	public void approvalPlus(HashMap<String, Object> params) throws Exception
	{
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		params.put("user_no", user_no);

		approvalDao.approvalPlus(params);
	}

	/**
	 * 정탐/오탐 결재 리스트
	 */
	@Override
	public List<HashMap<String, Object>> searchApprovalAllListData(HashMap<String, Object> params) throws Exception {
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String user_grade = SessionUtil.getSession("memberSession", "USER_GRADE");

		params.put("user_no", user_no);

		return approvalDao.searchApprovalAllListData(params);
	}

	/**
	 * 정탐/오탐 결재 리스트
	 */
	@Override
	public List<HashMap<String, Object>> searchApprovalListData(HashMap<String, Object> params) throws Exception {
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String user_grade = SessionUtil.getSession("memberSession", "USER_GRADE");

		params.put("user_no", user_no);
		params.put("user_grade", user_grade);

		return approvalDao.searchApprovalListData(params);
	}

	/**
	 * 정탐/오탐 결재 리스트 - 조회
	 */
	@Override
	public List<HashMap<String, Object>> selectProcessGroupPath(HashMap<String, Object> params) throws Exception
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

		return approvalDao.selectProcessGroupPath(params);
	}

	/**
	 * 정탐/오탐 결재 리스트 - 결재
	 */
	@Override
	public void updateProcessApproval(HashMap<String, Object> params) throws Exception
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
		List<HashMap<String, Object>> group = null;
		for (int i = 0; i < chargeIdList.size(); i++) 
		{
			map.put("chargeIdList", chargeIdList.get(i));
			map.put("user_no",  user_no);
			map.put("apprType", params.get("apprType"));
			map.put("reason",   params.get("reason"));

			group = approvalDao.selectDataProcessingGroupId(map);

			approvalDao.updateProcessApproval(map);
			for (int j = 0; j < group.size(); j++) {
				map.put("group_id", group.get(j).get("GROUP_ID"));
				approvalDao.updateDataProcessing(map);
			}
		}
	}

	/**
	 * 정탐/오탐 결재 리스트 - 재검색 스캔정보
	 */
	@Override
	public List<HashMap<String, Object>> selectScanPolicy() throws Exception
	{
		return approvalDao.selectScanPolicy();
	}

	/**
	 * 정탐/오탐 결재 리스트 - 재검색 선택 Target 정보
	 */
	@Override
	public List<HashMap<String, Object>> selectReScanTarget(HashMap<String, Object> params) throws Exception
	{
		List<String> group_list = (List<String>)params.get("groupList");
		params.put("group_list", group_list);

		return approvalDao.selectReScanTarget(params);
	}
}