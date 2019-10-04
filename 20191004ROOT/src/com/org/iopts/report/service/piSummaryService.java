package com.org.iopts.report.service;

import java.util.HashMap;
import java.util.List;

public interface piSummaryService {

	// 정탐/오탐 리스트 조회
	public List<HashMap<String, Object>> searchSummaryList(HashMap<String, Object> params) throws Exception;
}