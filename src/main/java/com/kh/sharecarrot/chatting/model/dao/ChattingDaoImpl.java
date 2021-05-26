package com.kh.sharecarrot.chatting.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.sharecarrot.chatting.model.vo.ChattingMessage;
import com.kh.sharecarrot.chatting.model.vo.ChattingRoom;

@Repository
public class ChattingDaoImpl implements ChattingDao {

	@Autowired
	private SqlSessionTemplate session;


	@Override
	public List<ChattingMessage> selectMessageList(int roomNo) {
		return session.selectList("chat.selectMessageList", roomNo);
	}

	@Override
	public ChattingRoom selectRoomNo(Map<String, Object> param) {
		return session.selectOne("chat.selectRoomNo", param);
	}
	
	
	
}
