package com.org.iopts.detection.service;

import java.util.HashMap;
import java.util.List;

public interface piDetectionService {

	public List<HashMap<String, Object>> selectFindSubpath(HashMap<String, Object> params) throws Exception;
	
	public HashMap<String, Object> selectProcessDocuNum(HashMap<String, Object> params) throws Exception;

	public HashMap<String, Object> selectExceptionDocuNum(HashMap<String, Object> params) throws Exception;

	public HashMap<String, Object> registProcessGroup(HashMap<String, Object> params) throws Exception;
	
	public void registProcess(HashMap<String, Object> params, HashMap<String, Object> GroupMap) throws Exception;
	
	public void registPathException(HashMap<String, Object> params) throws Exception;
	
	public List<HashMap<String, Object>> selectTeamMember(HashMap<String, Object> params) throws Exception;
	
	public void registChange(HashMap<String, Object> params) throws Exception;
}
