package com.kh.sharecarrot.chatting.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.sharecarrot.board.model.vo.Board;
import com.kh.sharecarrot.chatting.model.service.ChattingService;
import com.kh.sharecarrot.chatting.model.vo.ChattingMessage;
import com.kh.sharecarrot.chatting.model.vo.ChattingRoom;
import com.kh.sharecarrot.shop.model.service.ShopService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/chat")
public class ChattingController {
	
	@Autowired
	private ChattingService chattingService;
	
	@Autowired
	private ShopService shopService;
	
	@GetMapping("/chattingRoom.do")
	private void chattingRoom(@RequestParam String roomBuyerId, @RequestParam String shopId) {
		log.info("@@chatting buyer : {}, shop : {}", roomBuyerId, shopId);
		//shopId로 memberId 구해오기
		String roomSellerId = shopService.selectMemberId(shopId);
		
		Map<String, Object> param = new HashMap<>();
		param.put("roomBuyerId", roomBuyerId);
		param.put("roomSellerId", roomSellerId);
		
		//방번호 찾기
		ChattingRoom chattingRoom = chattingService.selectRoomNo(param);
		log.info("chatting roomNo : {}", chattingRoom.getRoomNo());
		
		//이전 대화내역 불러오기
		List<ChattingMessage> chattingMessageList = chattingService.selectMessageList(chattingRoom.getRoomNo());
		log.info("chatting Message : {}", chattingMessageList);
		
		
	}
	
}
