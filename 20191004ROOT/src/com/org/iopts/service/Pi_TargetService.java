package com.org.iopts.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.org.iopts.dto.Pi_TargetVO;
import com.org.iopts.dto.Pi_Target_ManageVO;

public interface Pi_TargetService {
	
	public List<Map<String, Object>> selectTarget() throws Exception;
	
	public List<Map<String, Object>> selectTargetManagement() throws Exception;
	
	public List<Map<String, Object>> selectTargetList(HttpServletRequest request) throws Exception;
	
	public List<Map<String, Object>> selectTargetUser(HttpServletRequest request) throws Exception;	

	public void registTargetUser(HttpServletRequest request) throws Exception;
	
	// Targets Insert
	int insertTarget(List<Pi_TargetVO> list) throws Exception;
	
	public List<Map<String, Object>> selectUserTargetList(HttpServletRequest request) throws Exception;

	public List<Map<String, Object>> selectTargetUserList(HttpServletRequest request) throws Exception;

	public List<Map<String, Object>> selectServerFileTopN(HttpServletRequest request);

	public List<Map<String, Object>> selectAdminServerFileTopN(HttpServletRequest request);	
	
	// 타켓 담당자 엑셀 업로드 
	Map<String,Object> targetManagerUpload(HttpServletRequest request);
	
}
