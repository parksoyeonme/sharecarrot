package com.kh.sharecarrot.notice.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.sharecarrot.notice.model.vo.Notice;

public interface NoticeDao {

	List<Notice> selectNoticetList(Map<String, Object> param);

	int getTotalContents();

	Notice selectOneNoticeDetail(int no);

	int updatenoticeYn(int no);

	int insertNotice(Notice notice);


	int deleteForm(int no);

	int noticeUpdateForm(Notice notice);

	
	

	

}
