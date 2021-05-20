package com.kh.sharecarrot.board.model.service;

import java.util.List;
import java.util.Map;

import com.kh.sharecarrot.board.model.vo.Board;
import com.kh.sharecarrot.board.model.vo.BoardComment;
import com.kh.sharecarrot.board.model.vo.BoardLike;

public interface BoardService {

	List<Board> selectBoardList(Map<String, Object> param);

	int getTotalContents(String boardCategory);

	int insertBorad(Board board);

	int boardDelete(int boardNo);

	Board selectOneBoard(int boardNo);

	int updateBorad(Board board, String[] boardImgId);

	List<BoardLike> selectBoardLikeList(String memberId);

	int updateBoardLike(Map<String, Object> param);

	int boardCommentInsert(BoardComment boardComment);

	List<BoardComment> boardCommentSelect(int boardNo);

	int boardCommentUpdate(BoardComment boardComment);

	int boardCommentDelete(String boardCommentId);

}
