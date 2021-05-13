package com.kh.sharecarrot.board.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BoardImage {

	private int boardImgId;
	private String boardImgOrigin;
	private String boardImgRenamed;
	private int boardNo;
}
