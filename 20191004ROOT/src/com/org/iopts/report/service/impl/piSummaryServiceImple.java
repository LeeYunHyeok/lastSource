package com.org.iopts.report.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.org.iopts.report.dao.piSummaryDAO;
import com.org.iopts.report.service.piSummaryService;
import com.org.iopts.util.SessionUtil;

@Service("piSummaryService")
@Transactional
public class piSummaryServiceImple implements piSummaryService {
	
	private static Logger log = LoggerFactory.getLogger(piSummaryServiceImple.class);

	@Inject
	private piSummaryDAO summaryDao;

	@Override
	public List<HashMap<String, Object>> searchSummaryList(HashMap<String, Object> params) throws Exception {

		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		params.put("user_no", user_no);			// 사용자

		return summaryDao.searchSummaryList(params);
	}
}