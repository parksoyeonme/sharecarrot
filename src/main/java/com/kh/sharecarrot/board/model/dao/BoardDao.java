package com.kh.sharecarrot.board.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.sharecarrot.board.model.vo.Board;

public interface BoardDao {

	List<Board> selectBoardList(Map<String, Object> param);

	int getTotalContents();

}
