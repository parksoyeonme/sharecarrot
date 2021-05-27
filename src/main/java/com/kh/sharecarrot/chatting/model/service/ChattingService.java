package com.kh.sharecarrot.chatting.model.service;

import java.util.List;
import java.util.Map;

import com.kh.sharecarrot.chatting.model.vo.ChattingMessage;
import com.kh.sharecarrot.chatting.model.vo.ChattingRoom;

public interface ChattingService {



	List<ChattingMessage> selectMessageList(int roomNo);

	ChattingRoom selectRoomNo(Map<String, Object> param);

	int insertChattingRoom(Map<String, Object> param);

}
