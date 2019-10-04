package com.org.iopts.service;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.xml.parsers.ParserConfigurationException;

import org.apache.poi.openxml4j.exceptions.OpenXML4JException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.xml.sax.SAXException;

import com.org.iopts.dao.Pi_TargetDAO;
import com.org.iopts.dto.Pi_TargetVO;
import com.org.iopts.dto.Pi_Target_ManageVO;
import com.org.iopts.util.DataUtil;
import com.org.iopts.util.ExcelSheetParser;
import com.org.iopts.util.SessionUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


@PropertySource("classpath:/property/config.properties")

@Service
public class Pi_TargetServiceImpl implements Pi_TargetService {

	private static final Logger logger = LoggerFactory.getLogger(Pi_TargetServiceImpl.class);
	
	@Resource(name = "Pi_TargetDAO")
	private Pi_TargetDAO dao;

	@Value("${saveAttchPath}")
	private String saveAttchPath;
	
	Map<String,Object> readerMap = new HashMap<String,Object>();
	
	@Override
	public List<Map<String, Object>> selectTargetManagement() throws Exception {
		// TODO Auto-generated method stub
		return dao.selectTargetManage();
	}

	@Override
	public List<Map<String, Object>> selectTargetList(HttpServletRequest request) throws Exception {
		// TODO Auto-generated method stub

		String host = request.getParameter("host");
		
		return dao.selectTargetList(host);
	}
	
	@Override
	public List<Map<String, Object>> selectTarget() throws Exception {
		// TODO Auto-generated method stub
		return dao.selectTargetManage();
	}

	@Override
	public List<Map<String, Object>> selectTargetUser(HttpServletRequest request) throws Exception {
		// TODO Auto-generated method stub
		String target = request.getParameter("target");
		String insa_code = SessionUtil.getSession("memberSession", "INSA_CODE");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("target", target);
		map.put("insa_code", insa_code);
		
		return dao.selectTargetUser(map);
	}

	@Override
	@Transactional
	public void registTargetUser(HttpServletRequest request) throws Exception {

		Map<String, Object> map = new HashMap<String, Object>();
		String target = request.getParameter("target");
		String userList = request.getParameter("userList");

		JSONArray userArray = JSONArray.fromObject(userList);

		if (userArray.size() != 0) {
			for (int i = 0; i < userArray.size(); i++) {
				JSONObject userMap = (JSONObject) userArray.get(i);
				map.put("target", target);
				map.put("user_no", userMap.getString("userNo"));
				
				if (userMap.getString("chk").equals("1")) {
					dao.registTargetUser(map);
				}
				else {
					dao.deleteTargetUser(map);
				}
			}
		}
	}
	
	/**
	 * Targets Insert
	 * @throws Exception 
	 */
	@Override
	@Transactional
	public int insertTarget(List<Pi_TargetVO> list) throws Exception {
		return dao.insertTarget(list);
	}

	@Override
	public List<Map<String, Object>> selectUserTargetList(HttpServletRequest request) throws Exception {

		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String user_grade = SessionUtil.getSession("memberSession", "USER_GRADE");
		String host = request.getParameter("host");
		
		Map<String, Object> searchMap = new HashMap<String, Object>();
		List<Map<String, Object>> map = new ArrayList<Map<String, Object>>();
		
		searchMap.put("user_no", user_no);
		searchMap.put("host", host);
		map = dao.selectUserTargetList(searchMap);	
		return map;
	}

	@Override
	public List<Map<String, Object>> selectTargetUserList(HttpServletRequest request) throws Exception {

		String target = request.getParameter("target");

		return dao.selectTargetUserList(target);
	}

	@Override
	public List<Map<String, Object>> selectServerFileTopN(HttpServletRequest request) {
		String target = request.getParameter("target");
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");

		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("target_id"  , target);
		searchMap.put("user_no"  , user_no);
		
		logger.info(searchMap.toString());
		return dao.selectServerFileTopN(searchMap);
	}
	
	@Override
	public List<Map<String, Object>> selectAdminServerFileTopN(HttpServletRequest request) {
		String target = request.getParameter("target");

		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("target_id"  , target);
		
		logger.info(searchMap.toString());
		return dao.selectAdminServerFileTopN(searchMap);
	}
	
	//견본품제공 엑셀 upload
	public Map<String,Object> targetManagerUpload(HttpServletRequest request) {

		// 엑셀을 읽기 전 전처리. 엑셀의 형식 확인하고 서버에 저장. 공통 아래
		Map<String,Object> resultMap = validUploadFile(request);
		int result = Integer.parseInt((String) resultMap.get("resultCode"));
		if (result != 0) {
			return resultMap;
		}
		// 엑셀을 읽기 전 전처리  end

		File targetFile = new File((String) resultMap.get("FilePath"));		
		//HashMap<String, String> mapHeader = setExcelHeader("supplySample");	
		ExcelSheetParser.Sender receiver = setReceiver();	
		ExcelSheetParser excelSheetParser = new ExcelSheetParser(targetFile, 4, receiver);
		
		try {
			excelSheetParser.excute();
		} catch (IOException | OpenXML4JException
				| ParserConfigurationException | SAXException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		JSONArray jsonArray = (JSONArray) readerMap.get("list");
		/**
		 * 여기서 jsonArray를 DAO를 태워서 Insert SQL 하면 됨.......
		 * 혹시 target 명을 엑셀에 담아주면 그걸 찾는 로직은 추가 필요 
		 */
				
		for (int i = 0; i < jsonArray.size(); i++) {
			JSONObject jsonObject = jsonArray.getJSONObject(i);
			
			// 엑셀의 컬럼 수가 네개가 아니면 오류....
			if (jsonObject.size() != 4) {
				resultMap.put("resultCode", "-5");
				resultMap.put("resultMessage", "File Format Exception<BR><BR>Excel 내용을 확인하세요");
				return resultMap;
			}
			String Col1 = jsonObject.getString("1");
			String Col2 = jsonObject.getString("2");
			String Col3 = jsonObject.getString("3");
			String Col4 = jsonObject.getString("4");

			logger.info("Col1 : " + Col1 + "Col2 : " + Col2 + "Col3 : " + Col3 + "Col4 : " + Col4);
		}

		logger.info(jsonArray.toString());
		resultMap.put("Data", jsonArray);
		resultMap.put("resultCode", "0");
		resultMap.put("resultMessage", "SUCCESS");

		return resultMap;
	}

	public ExcelSheetParser.Sender setReceiver() {
		ExcelSheetParser.Sender receiver = new ExcelSheetParser.Sender() {		
			@Override
			public void onTerminated(JSONArray listData) {
				//setData(listData);
				
				readerMap.put("list", listData);
			}
		};
		
		return receiver;
	}

	public Map<String, Object> validUploadFile(HttpServletRequest request) { //excel 헤더 컬럼 담기.

		Map<String,Object> resultMap = new HashMap<String,Object>();
		
		MultipartHttpServletRequest mpartReq = null;
		mpartReq = (MultipartHttpServletRequest) request;
	
		Iterator<String> iter = mpartReq.getFileNames(); 
		MultipartFile mpartFile = null; 

		if (!iter.hasNext()) {
			resultMap.put( "resultCode", "-9");
			resultMap.put( "resultMessage","File Not Found");
			return resultMap;
		}

		String fileName = iter.next(); // 내용을 가져와서 
		if ("".equals(fileName)) {
			resultMap.put( "resultCode", "-8");
			resultMap.put( "resultMessage","File Name Not Found");
			return resultMap;
		}

		mpartFile = mpartReq.getFile(fileName);
		String orgFileName = null;
		try {
			orgFileName = new String(mpartFile.getOriginalFilename().getBytes("8859_1"), "UTF-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
			resultMap.put( "resultCode", "-8");
			resultMap.put( "resultMessage","File Name UnsupportedEncodingException");
			return resultMap;
		}

		// 확장자  
		String ext = orgFileName.substring(orgFileName.lastIndexOf('.')); 
		if ((!ext.equalsIgnoreCase(".xls")) && (!ext.equalsIgnoreCase(".xlsx"))){ 
			// 첨부 파일이 EXCEL이 아니면....
			resultMap.put( "resultCode", "-7");
			resultMap.put( "resultMessage","Not Excel File");
			return resultMap;
		} 

		String targetFileName = null;
		try {
			targetFileName = DataUtil.makeEncFileName();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			resultMap.put( "resultCode", "-6");
			resultMap.put( "resultMessage","File Encription Fail");
			return resultMap;
		}
		targetFileName = targetFileName + ext;
		// String saveAttchPath = "./upload";
		
		// 디레토리가 없다면 생성 
		File saveDir = new File(saveAttchPath); 
		if (!saveDir.isDirectory()) { 
			saveDir.mkdirs(); 
		} 

		// 설정한 path에 파일저장 
		File targetFile = new File(saveAttchPath + File.separator + targetFileName); 
		try {
			mpartFile.transferTo(targetFile);
		} catch (IllegalStateException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			resultMap.put( "resultCode", "-5");
			resultMap.put( "resultMessage","File Move Fail");
			return resultMap;
		}

		logger.info(saveAttchPath + File.separator + targetFileName);
		resultMap.put( "resultCode", "0");
		resultMap.put( "FilePath", saveAttchPath + File.separator + targetFileName);
		resultMap.put( "resultMessage","Upload File Valid");
		return resultMap;
	}

}
