package com.org.iopts.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.org.iopts.dto.Pi_Scan_HostVO;
import com.org.iopts.dto.Pi_ScheduleVO;

public interface Pi_ScanService {
	
	public List<Map<String, Object>> selectSchedules(HttpServletRequest request) throws Exception;
	
	public List<Pi_ScheduleVO> selectSchedule(String schedule_status) throws Exception;

	public Map<String, Object> changeSchedule(HttpServletRequest request, String recon_id, String recon_password, String recon_url) throws Exception;

	public Map<String, Object> viewSchedule(HttpServletRequest request, String recon_id, String recon_password, String recon_url) throws Exception;
	
	public List<Pi_Scan_HostVO> selectScanHost() throws Exception;
	
	public List<Map<String, Object>> selectLocationList() throws Exception;
	
	public List<Map<String, Object>> selectDatatypeList() throws Exception;
	
	public List<Map<String, Object>> selectDatatypeListMod(HttpServletRequest request) throws Exception;

	public Map<String, Object> registSchedule(HttpServletRequest request, String recon_id, String recon_password, String recon_url) throws Exception;

	public Map<String, Object> getProfileDetail(HttpServletRequest request, String recon_id, String recon_password, String recon_url) throws Exception;

	public List<Map<String, Object>> viewScanHistory(HttpServletRequest request);

	public List<Map<String, Object>> viewScanPolicy(HttpServletRequest request);

	public Map<String, Object> registPolicy(HttpServletRequest request) throws Exception;

	public void resetDefaultPolicy(HttpServletRequest request);

	public void updateDefaultPolicy(HttpServletRequest request);

}