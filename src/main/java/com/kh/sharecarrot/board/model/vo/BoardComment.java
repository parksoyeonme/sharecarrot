package com.kh.sharecarrot.board.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BoardComment {

	private String boardCommentId;
	private String boardCommentContent;
	private int boardCommentLevel;
	private String boardCommentRef;
	private Date boardCommentEnrollDate;
	private String boardCommentDelFlag;
	private String boardNo;
	private String memberId;
	
}
