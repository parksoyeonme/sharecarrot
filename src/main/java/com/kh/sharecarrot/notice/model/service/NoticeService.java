package com.kh.sharecarrot.notice.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.kh.sharecarrot.notice.model.vo.Notice;
import com.kh.sharecarrot.report.model.vo.Report;


public interface NoticeService {
	List<Notice> selectNoticeList(Map<String, Object> param);

	int getTotalContents();

	Notice selectOneNoticeDetail(int no);

	int updatenoticeYn(int no);

	int insertNotice(Notice notice);


	int deleteForm(int no);

	int noticeUpdateForm(Notice notice);

	

	

	



}
