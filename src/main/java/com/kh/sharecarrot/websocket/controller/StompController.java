package com.kh.sharecarrot.websocket.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;

import com.kh.sharecarrot.chatting.model.service.ChattingService;
import com.kh.sharecarrot.chatting.model.vo.ChattingMessage;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
public class StompController {

	/**
	 * @MessageMapping prefix제외하고 작성할 것
	 * 
	 * @param msg
	 * @return
	 */
	
	@Autowired
	private ChattingService chattingService;
	
	@MessageMapping("/chattingRoom/{roomNo}")
	@SendTo("/chattingRoom/{roomNo}")
	public ChattingMessage chattingMessage(@RequestBody ChattingMessage msg,
			@DestinationVariable String roomNo) {
		log.info("{}",msg);
		//db저장 로직등이 가능
//		int result = chattingService.insertChattingMessage(msg);
		return msg;
	}

}
