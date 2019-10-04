package com.org.iopts.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.org.iopts.dto.Pi_AgentVO;

public interface Pi_DashService {
	
	public List<Pi_AgentVO> selectDashMenu() throws Exception;
	
	public Map<String, Object> selectDashInfo(HttpServletRequest request, String recon_id, String recon_password, String recon_url) throws Exception;
	
	public List<Map<String,Object>> selectDatatype(HttpServletRequest request) throws Exception;
	
	public Map<String, Object> selectDatatypes(HttpServletRequest request) throws Exception;

	public List<Object> selectSystemCurrent(HttpServletRequest request);

	public List<Object> selectJumpUpHost(HttpServletRequest request);

	public Map<String, Object> selectlastScanDate(HttpServletRequest request);

}
