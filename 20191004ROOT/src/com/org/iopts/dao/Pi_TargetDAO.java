package com.org.iopts.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.org.iopts.dto.Pi_TargetVO;
import com.org.iopts.dto.Pi_Target_ManageVO;

@Repository("Pi_TargetDAO")
public class Pi_TargetDAO {

	private static final Logger logger = LoggerFactory.getLogger(Pi_TargetDAO.class);

	@Autowired
    private SqlSession sqlSession;

	private static final String Namespace = "target";
	
	public List<Map<String, Object>> selectTargetManage() throws Exception {
		
		return sqlSession.selectList(Namespace+".selectTargetManage");
	}

	public List<Map<String, Object>> selectTargetList(String host) throws Exception {
		
		return sqlSession.selectList(Namespace+".selectTargetList", host);
	}

	public List<Map<String, Object>> selectTargetUser(Map<String, Object> map) throws Exception {
		
		return sqlSession.selectList(Namespace+".selectTargetUser", map);
	}

	public void deleteTargetUser(Map<String, Object> map) throws Exception {
		
		sqlSession.delete(Namespace+".deleteTargetUser", map);
	}
	
	public void registTargetUser(Map<String, Object> map) throws Exception {

		sqlSession.insert(Namespace+".registTargetUser", map);
	}

	public int insertTarget(List<Pi_TargetVO> list) throws Exception {
		int ret = 0;
		ret = sqlSession.insert(Namespace+".insertTargets", list);
		return ret;
	}

	public List<Map<String, Object>> selectUserTargetList(Map<String, Object> searchMap) throws Exception {
		
		return sqlSession.selectList(Namespace+".selectUserTargetList", searchMap);
	}

	public List<Map<String, Object>> selectTargetUserList(String target) throws Exception {
		
		return sqlSession.selectList(Namespace+".selectTargetUserList", target);
	}

	public List<Map<String, Object>> selectServerFileTopN(Map<String, Object> searchMap) {

		return sqlSession.selectList(Namespace + ".selectServerFileTopN", searchMap);
	}

	public List<Map<String, Object>> selectAdminServerFileTopN(Map<String, Object> searchMap) {
		return sqlSession.selectList(Namespace + ".selectAdminServerFileTopN", searchMap);
	}

}
