package com.kh.sharecarrot.transactionhistory.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class TransactionHistory {

//	PRODUCT_ID NOT NULL VARCHAR2(15) 
//	REVIEW_YN           CHAR(1)      
//	SHOP_ID    NOT NULL VARCHAR2(15) 
//	MEMBER_ID  NOT NULL VARCHAR2(20) 

	private String productId;
	private boolean reviewYn;
	private String shopId;
	private String memberId;
	
}
