package com.kh.sharecarrot.board.model.vo;

import lombok.AllArgsConstructor;

import lombok.NoArgsConstructor;

import lombok.Data;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BoardLike {

	private String memberId;
	private int boardNo;
}
