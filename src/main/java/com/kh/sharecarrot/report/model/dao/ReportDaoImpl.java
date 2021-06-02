package com.kh.sharecarrot.report.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.sharecarrot.board.model.vo.BoardLike;
import com.kh.sharecarrot.report.model.vo.Report;
import com.kh.sharecarrot.report.model.vo.ReportImage;

@Repository
public class ReportDaoImpl implements ReportDao {

	@Autowired
	private SqlSessionTemplate session;

	@Override
	public Report selectOneReprotDetail(int no) {
		return session.selectOne("report.selectOneReprotDetail", no);
	}

	@Override
	public int updateReportYn(int no) {
		return session.update("report.updateReportYn", no);
	}

	@Override
	public int getTotalContents() {
		return session.selectOne("report.getTotalContents");
	}

	@Override
	public List<Report> selectReportList(Map<String, Object> param) {
		int cPage = (int)param.get("cPage");
		
		int limit = (int)param.get("numPerPage");
		int offset = (cPage - 1) * limit; // 1 -> 0, 2 -> 5, 3 -> 10....
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return session.selectList("report.selectReportList", param, rowBounds);
	}

	@Override
	public int insertReport(Report report) {
		return session.insert("report.insertReport", report);
	}

	@Override
	public int insertReportImg(ReportImage reportImg) {
		return session.insert("report.insertReportImg", reportImg);
	}

	@Override
	public List<ReportImage> selectReprotImageDetail(int no) {
		return session.selectList("report.selectReprotImageDetail", no);
	}

	@Override
	public ReportImage selectOneReportImage(int no) {
		return session.selectOne("report.selectOneReportImage", no);
	}

	@Override
	public List<Map<String, Object>> selectReportByDate(String searchDate) {
		return session.selectList("report.selectReportByDate", searchDate);
	}

	
	
}
