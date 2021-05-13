package com.kh.sharecarrot.board.model.service;

import java.util.List;
import java.util.Map;

import com.kh.sharecarrot.board.model.vo.Board;

public interface BoardService {

	List<Board> selectBoardList(Map<String, Object> param);

	int getTotalContents();

	int insertBorad(Board board);

}
