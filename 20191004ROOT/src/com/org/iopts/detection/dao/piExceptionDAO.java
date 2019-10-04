package com.org.iopts.detection.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

public interface piExceptionDAO {

	public List<HashMap<String, Object>> selectExceptionList(HashMap<String, Object> params) throws SQLException;
	
	public List<HashMap<String, Object>> selectExeptionPath(HashMap<String, Object> params) throws SQLException;

	public Map<String, Object> selectDocuNum(HashMap<String, Object> params) throws SQLException;

	public void registPathExceptionCharge(HashMap<String, Object> params) throws SQLException;

	public void updateExceptionGroupStatus(Map<String, Object> params) throws SQLException;

	public List<HashMap<String, Object>> exceptionApprovalAllListData(HashMap<String, Object> params) throws SQLException;

	public List<HashMap<String, Object>> exceptionApprovalListData(HashMap<String, Object> params) throws SQLException;

	public List<HashMap<String, Object>> selectExceptionGroupPath(HashMap<String, Object> params) throws SQLException;

	public void updateExceptionApproval(HashMap<String, Object> params) throws SQLException;
}