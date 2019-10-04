package com.org.iopts.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.org.iopts.dto.MemberVO;

@Repository
public class Pi_UserDAO {

	static final Logger logger = LoggerFactory.getLogger(Pi_UserDAO.class);

	@Autowired
	@Resource(name = "sqlSession")
	private SqlSession sqlSession;

	static final String Namespace = "com.org.iopts.mapper.UserMapper";

	public Map<String, Object>  selectMember(Map<String, Object> map) throws Exception {

		return sqlSession.selectOne(Namespace + ".selectMember", map);
	}

	public Map<String, Object>  selectSSOMember(Map<String, Object> map) throws Exception {

		return sqlSession.selectOne(Namespace + ".selectSSOMember", map);
	}

	public List<Map<String, Object>>  selectTeamMember(Map<String, Object> map) throws Exception {

		return sqlSession.selectList(Namespace + ".selectTeamMember", map);
	}

	public Map<String, Object>  selectTeamManager(String boss_name) throws Exception {

		return sqlSession.selectOne(Namespace + ".selectTeamManager", boss_name);
	}
	
	public void insertMemberLog(Map<String, Object> userLog) throws Exception {
		
		sqlSession.insert(Namespace + ".insertMemberLog", userLog);
	}

	public List<Map<String, Object>> selectUserLogList(Map<String, Object> search) throws Exception {
		
		return sqlSession.selectList(Namespace + ".selectUserLogList",search);
	}

	public int changeAuthCharacter(Map<String, Object> map) throws Exception {
		
		return sqlSession.insert(Namespace + ".updatePassword", map);
	}

	public String selectAccessIP(String user_no) throws Exception {

		return sqlSession.selectOne(Namespace + ".selectAccessIP", user_no);
	}

	public void changeAccessIP(Map<String, Object> input) throws Exception {
		
		sqlSession.insert(Namespace + ".changeAccessIP", input);
	}

	public List<Map<String, Object>> selectManagerList() throws Exception {
		
		return sqlSession.selectList(Namespace + ".selectManagerList");
	}
	
	public void changeManagerList(Map<String, Object> map) throws Exception {

		sqlSession.insert(Namespace+".changeManagerList", map);
	}

	public List<Map<String, Object>> selectTeamCode() throws Exception {
		
		return sqlSession.selectList(Namespace + ".selectTeamCode");
	}

	public Map<String, Object> chkDuplicateUserNo(String userNo) throws Exception {
		
		return sqlSession.selectOne(Namespace + ".chkDuplicateUserNo", userNo);
	}
	
	public void createUser(Map<String, Object> map) throws Exception {

		sqlSession.insert(Namespace+".createUser", map);
	}
}
