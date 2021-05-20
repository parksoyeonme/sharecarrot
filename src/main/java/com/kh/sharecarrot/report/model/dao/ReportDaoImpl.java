package com.kh.sharecarrot.report.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.sharecarrot.board.model.vo.BoardLike;
import com.kh.sharecarrot.report.model.vo.Report;

@Repository
public class ReportDaoImpl implements ReportDao {

	@Autowired
	private SqlSessionTemplate session;

	@Override
	public List<Report> selectReportList() {
		return session.selectList("report.selectReportList", "");
	}

	@Override
	public Report selectOneReprotDetail(int no) {
		return session.selectOne("report.selectOneReprotDetail", no);
	}

	@Override
	public int updateReportYn(int no) {
		return session.update("report.updateReportYn", no);
	}
	
}
