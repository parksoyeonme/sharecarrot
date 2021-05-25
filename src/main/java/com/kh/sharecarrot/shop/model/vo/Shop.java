package com.kh.sharecarrot.shop.model.vo;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Shop {
		private String shopId;
		private int shopTotalScore;
		private int shopVisitCount;
		private int shopSellCount;
		private String shopMemo;
		private String memberId;
		
		
}
