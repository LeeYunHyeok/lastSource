package com.org.iopts.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.org.iopts.dto.Pi_Scan_HostVO;
import com.org.iopts.dto.Pi_ScheduleVO;
import com.org.iopts.dto.Pi_TargetVO;
import com.org.iopts.dto.Pi_Target_ManageVO;

@Repository
public class Pi_ScanDAO {	

	private static final Logger logger = LoggerFactory.getLogger(Pi_ScanDAO.class);

	@Autowired
    @Resource(name = "sqlSession")
    private SqlSession sqlSession;

	private static final String Namespace = "ScanMapper";
	
	public List<Map<String, Object>> selectSchedules(Map<String, Object> search) throws Exception {
		return sqlSession.selectList(Namespace+".selectSchedules", search);
	}
	
	public List<Pi_ScheduleVO> selectSchedule(String schedule_status) throws Exception {
		return sqlSession.selectList(Namespace+".selectSchedule", schedule_status);
	}
	
	public List<Pi_Scan_HostVO> selectScanHost() throws Exception {
		return sqlSession.selectList(Namespace+".selectScanHost");
	}

	public List<Map<String, Object>> selectDataTypes(Map<String, Object> datatypeMap) throws Exception {
		return sqlSession.selectList(Namespace+".selectDataTypes", datatypeMap);
	}

	public void changeSchedule(Map<String, Object> map) throws Exception {

		sqlSession.update(Namespace+".changeSchedule", map);
	}

	public List<Map<String, Object>> selectLocationList(Map<String, Object> map) throws Exception {
		
		return sqlSession.selectList(Namespace + ".selectLocationList", map);
	}

	public List<Map<String, Object>> selectDatatypeList() throws Exception {
		
		return sqlSession.selectList(Namespace + ".selectDatatypeList");
	}

	public List<Map<String, Object>> selectDatatypeVersion(String label) throws Exception {
		
		return sqlSession.selectList(Namespace + ".selectDatatypeVersion", label);
	}

	public List<Map<String, Object>> viewScanHistory(Map<String, Object> historyList) {
		
		return sqlSession.selectList(Namespace + ".viewScanHistory", historyList);
	}

	public void registPolicy(Map<String, Object> map) {
		sqlSession.insert(Namespace + ".registPolicy", map);
	}

	public void resetDefaultPolicy(HttpServletRequest request) {
		sqlSession.update(Namespace + ".resetDefaultPolicy", request);
	}

	public void updateDefaultPolicy(Map<String, Object> map) {
		sqlSession.update(Namespace + ".updateDefaultPolicy", map);		
	}

	public List<Map<String, Object>> viewScanPolicy(Map<String, Object> map) {
		return sqlSession.selectList(Namespace + ".viewScanPolicy", map);
	}

}