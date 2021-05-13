package com.kh.sharecarrot.board.model.vo;

import java.sql.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Board {
	private int boardNo;
	private String boardTitle;
	private String boardContent;
	private Date boardEnrollDate;
	private Date boardUpdateDate;
	private String boardDeleteYN;
	private String boardCategory;
	private int boardLike;
	private String memberId;
	
	private List<BoardImage> boardImageList;
}
