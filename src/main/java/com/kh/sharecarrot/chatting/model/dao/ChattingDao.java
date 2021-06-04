package com.kh.sharecarrot.chatting.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.sharecarrot.chatting.model.vo.ChattingMessage;
import com.kh.sharecarrot.chatting.model.vo.ChattingRoom;

public interface ChattingDao {



	List<ChattingMessage> selectMessageList(int roomNo);

	ChattingRoom selectRoomNo(Map<String, Object> param);

	int insertChattingRoom(Map<String, Object> param);

	List<ChattingRoom> selectRoomList(String loginMemberId);

	int insertChattingMessage(ChattingMessage chattingMessage);

	String selectLastChat(int roomNo);

}
