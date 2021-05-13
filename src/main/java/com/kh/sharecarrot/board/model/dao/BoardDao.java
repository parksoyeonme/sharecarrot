package com.kh.sharecarrot.board.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.sharecarrot.board.model.vo.Board;
import com.kh.sharecarrot.board.model.vo.BoardImage;

public interface BoardDao {

	List<Board> selectBoardList(Map<String, Object> param);

	int getTotalContents();

	int insertBoard(Board board);

	int insertBoardImg(BoardImage boardImg);

}