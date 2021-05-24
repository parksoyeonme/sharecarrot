package com.kh.sharecarrot.notice.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class NoticeImage {
	/*
	 * "BOARD_IMG_ID" NUMBER NOT NULL,
	 *  "BOARD_IMG_ORIGIN" VARCHAR2(200) NOT NULL,
	 * "BOARD_IMG_RENAMED" VARCHAR2(200) NOT NULL,
	 *  "BOARD_NO" NUMBER NOT NULL,
	 * 
	 * constraint pk_board_image_id primary key (board_img_id), constraint
	 * fk_board_image_board_no foreign key (board_no) references board(board_no) );
	 */
		private int boardImgId;
		private String boardImgOrigin;
		private String boardtImgRenamed;
		private int boardNo;
	
}
