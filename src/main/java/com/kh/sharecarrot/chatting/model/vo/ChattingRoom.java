package com.kh.sharecarrot.chatting.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ChattingRoom {

//	ROOM_NO        NOT NULL NUMBER       
//	ROOM_BUYER_ID  NOT NULL VARCHAR2(20) 
//	ROOM_SELLER_ID NOT NULL VARCHAR2(20) 

	private int roomNo;
	private String roomBuyerId;
	private String roomSellerId;
	
}
