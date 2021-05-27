package com.kh.sharecarrot.chatting.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.sharecarrot.chatting.model.dao.ChattingDao;
import com.kh.sharecarrot.chatting.model.vo.ChattingMessage;
import com.kh.sharecarrot.chatting.model.vo.ChattingRoom;

@Service
public class ChattingServiceImpl implements ChattingService{

	@Autowired
	private ChattingDao chattingDao;



	@Override
	public List<ChattingMessage> selectMessageList(int roomNo) {
		return chattingDao.selectMessageList(roomNo);
	}


	@Override
	public ChattingRoom selectRoomNo(Map<String, Object> param) {
		return chattingDao.selectRoomNo(param);
	}


	@Override
	public int insertChattingRoom(Map<String, Object> param) {
		return chattingDao.insertChattingRoom(param);
	}

}
