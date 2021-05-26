package com.kh.sharecarrot.chatting.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ChattingMessage {

//	MESSAGE_TEXT   NOT NULL VARCHAR2(300) 
//	MESSAGE_DATE            DATE          
//	ROOM_NO        NOT NULL NUMBER        
//	ROOM_BUYER_ID  NOT NULL VARCHAR2(20)  
//	ROOM_SELLER_ID NOT NULL VARCHAR2(20) 
	private String messageText;
	private Date messageDate;
	private int roomNo;
	private String roomBuyerId;
	private String roomSellerId;
	
}
