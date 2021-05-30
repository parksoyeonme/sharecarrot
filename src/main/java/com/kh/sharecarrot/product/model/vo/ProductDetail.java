package com.kh.sharecarrot.product.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductDetail extends Product{

	private int shopVisitCount;
	private int shopTotalScore;
	private String memberId;
	private String profileRenamed;
	private String shopId;
	private int shopProductCount;
}
