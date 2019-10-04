package com.org.iopts.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.org.iopts.dto.Pi_AgentVO;
import com.org.iopts.dto.Pi_TargetVO;
import com.org.iopts.dto.Pi_Target_ManageVO;
import com.org.iopts.dto.Pi_TotalDatetypeVO;

@Repository
public class Pi_DashDAO {	

	private static final Logger logger = LoggerFactory.getLogger(Pi_DashDAO.class);

	@Autowired
    @Resource(name = "sqlSession")
    private SqlSession sqlSession;

	private static final String Namespace = "dashmapper";
	
	public List<Pi_AgentVO> selectDashMenu(String user_id) throws Exception {
		return sqlSession.selectList(Namespace+".selectDashMenu",user_id);
	}
	
	public Map<String, Object> selectDashInfo(String target_id) throws Exception {
		return sqlSession.selectOne(Namespace+".selectDashInfo",target_id);
	}
	
	public Map<String, Object> selectlastScanDate(String target_id) {
		return sqlSession.selectOne(Namespace+".selectlastScanDate", target_id);
	}
	
	public List<Map<String, Object>> selectDatatypeAll(Map<String, Object> type) throws Exception {
		return sqlSession.selectList(Namespace+".selectDatatypeAll",type);
	}
	
	public List<Map<String, Object>> selectDatatypeAll_day(Map<String, Object> type) throws Exception {
		return sqlSession.selectList(Namespace+".selectDatatypeAll_day",type);
	}
	
	public List<Map<String, Object>> selectDatatype_days(Map<String, Object> type) throws Exception {
		return sqlSession.selectList(Namespace+".selectDatatype_days", type);
	}
	
	public List<Map<String, Object>> selectDatatype(Map<String, Object> type) throws Exception {
		return sqlSession.selectList(Namespace+".selectDatatype", type);
	}
	
	public List<Map<String, Object>> selectDatatypes(Map<String, Object> data) throws Exception {
		return sqlSession.selectList(Namespace + ".selectDatatypes",data);
	}

	public List<Object> selectSystemCurrent() {
		return sqlSession.selectList(Namespace + ".selectSystemCurrent");
	}
	
	public List<Object> selectJumpUpHost() {
		return sqlSession.selectList(Namespace + ".selectJumpUpHost");
	}

}