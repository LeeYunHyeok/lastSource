package com.org.iopts.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.org.iopts.dto.MemberVO;

public interface Pi_UserService {
	
	public Map<String, Object> selectMember(HttpServletRequest request) throws Exception;
	
	public Map<String, Object> selectSSOMember(HttpServletRequest request) throws Exception;

	public List<Map<String, Object>> selectTeamMember(HttpServletRequest request) throws Exception;
	
	public Map<String, Object> selectTeamManager() throws Exception;
	
	public void insertMemberLog(Map<String, Object> userLog) throws Exception;
	
	public List<Map<String, Object>> selectUserLogList(HttpServletRequest request) throws Exception;
	
	public Map<String, Object> changeAuthCharacter(HttpServletRequest request) throws Exception;
	
	public String selectAccessIP() throws Exception;
	
	public void changeAccessIP(HttpServletRequest request) throws Exception;
	
	public void logout(HttpServletRequest request) throws Exception;
	
	public List<Map<String, Object>> selectManagerList(HttpServletRequest request) throws Exception;

	public void changeManagerList(HttpServletRequest request) throws Exception;
	
	public List<Map<String, Object>> selectTeamCode() throws Exception;
	
	public Map<String, Object> chkDuplicateUserNo(HttpServletRequest request) throws Exception;

	public void createUser(HttpServletRequest request) throws Exception;
}
