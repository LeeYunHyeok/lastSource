package com.org.iopts.report.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.HashMap;

public interface piSummaryDAO {

	public List<HashMap<String, Object>> searchSummaryList(HashMap<String, Object> params) throws SQLException;
}