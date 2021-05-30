package com.kh.sharecarrot.main.model.vo;

import java.sql.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.kh.sharecarrot.product.model.vo.ProductImage;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MainProduct {
//	PRODUCT_ID       NOT NULL CHAR(15)       
//	PRODUCT_NAME     NOT NULL VARCHAR2(200)  
//	PRODUCT_PRICE    NOT NULL NUMBER         
//	PRODUCT_YNH               CHAR(1)        
//	PRODUCT_REG_DATE          DATE           
//	PRODUCT_CONTENT  NOT NULL VARCHAR2(4000) 
//	PRODUCT_DEL_FLAG          CHAR(1)        
//	SHOP_ID          NOT NULL CHAR(15)       
//	CATEGORY_CODE    NOT NULL CHAR(3)     
	
		private String productId;
		private String productName;
		private int productPrice;
		
		private String productImgRenamed;
}
