package com.org.iopts.detection.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

public interface piDetectionDAO {

	public List<HashMap<String, Object>> selectFindSubpath(HashMap<String, Object> params) throws SQLException;

	public HashMap<String, Object> selectProcessDocuNum(HashMap<String, Object> params) throws SQLException;

	public HashMap<String, Object> selectExceptionDocuNum(HashMap<String, Object> params) throws SQLException;

	public void registProcessGroup(HashMap<String, Object> params) throws SQLException;

	public void registProcess(HashMap<String, Object> params) throws SQLException;
	
	public void registPathExceptionGroup(HashMap<String, Object> insertExcepGroupMap) throws SQLException;
	
	public int preCheckRegistPathException(HashMap<String, Object> insertExcepMap) throws SQLException;
	
	public void registPathException(HashMap<String, Object> insertExcepMap) throws SQLException;
	
	public List<HashMap<String, Object>> selectTeamMember(HashMap<String, Object> params) throws SQLException;
	
	public void registChange(HashMap<String, Object> insertExcepMap) throws SQLException;
	
	public List<HashMap<String, Object>> selectHashId(HashMap<String, Object> params) throws SQLException;
}
