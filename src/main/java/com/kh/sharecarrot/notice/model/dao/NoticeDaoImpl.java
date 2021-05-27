package com.kh.sharecarrot.notice.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.sharecarrot.notice.model.vo.Notice;
import com.kh.sharecarrot.report.model.vo.Report;

@Repository
public class NoticeDaoImpl implements NoticeDao {

	@Autowired
	private SqlSessionTemplate session;

	@Override
	public List<Notice> selectNoticetList(Map<String, Object> param) {
		int cPage = (int)param.get("cPage");
		
		int limit = (int)param.get("numPerPage");
		int offset = (cPage - 1) * limit; // 1 -> 0, 2 -> 5, 3 -> 10....
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return session.selectList("notice.selectNoticetList", null, rowBounds);
	}

	@Override
	public int getTotalContents() {
		return session.selectOne("notice.getTotalContents");
	}

	@Override
	public Notice selectOneNoticeDetail(int no) {
		return session.selectOne("notice.selectOneNoticeDetail", no);
		
	}

	@Override
	public int updatenoticeYn(int no) {
		return session.update("notice.updatenoticeYn", no);
	}

	@Override
	public int insertNotice(Notice notice) {
			return session.insert("notice.insertNotice", notice);
	}

	

	
	
}
