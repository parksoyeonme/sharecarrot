package com.kh.sharecarrot.utils.model.vo;

import java.sql.Date;
import java.util.List;

import com.kh.sharecarrot.product.model.vo.ProductImage;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class jjimListExt extends JjimList{

	private String productName;
	private int productPrice;
	private Date productRegDate;
	
	private List<ProductImage> productImageList;
}
