package com.org.iopts.detection.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

public interface piApprovalDAO {

	public List<HashMap<String, Object>> searchProcessList(HashMap<String, Object> params) throws SQLException;

	public List<HashMap<String, Object>> selectTeamMember(HashMap<String, Object> searchMap) throws SQLException;

	public Map<String, Object> selectDocuNum(HashMap<String, Object> params) throws SQLException;

	public List<HashMap<String, Object>> selectProcessPath(HashMap<String, Object> params) throws SQLException;

	public void registProcessCharge(HashMap<String, Object> params) throws SQLException;

	public void updateProcessingGroupStatus(Map<String, Object> params) throws SQLException;

	public void updateProcessingStatus(Map<String, Object> params) throws SQLException;

	public void approvalPlus(HashMap<String, Object> params) throws SQLException;

	public List<HashMap<String, Object>> searchApprovalAllListData(HashMap<String, Object> params) throws SQLException;

	public List<HashMap<String, Object>> searchApprovalListData(HashMap<String, Object> params) throws SQLException;

	public List<HashMap<String, Object>> selectProcessGroupPath(HashMap<String, Object> params) throws SQLException;

	public List<HashMap<String, Object>> selectDataProcessingGroupId(HashMap<String, Object> params) throws SQLException;

	public void updateProcessApproval(HashMap<String, Object> params) throws SQLException;

	public void updateDataProcessing(HashMap<String, Object> params) throws SQLException;
	
	public List<HashMap<String, Object>> selectScanPolicy() throws SQLException;

	public List<HashMap<String, Object>> selectReScanTarget(HashMap<String, Object> params) throws SQLException;
}