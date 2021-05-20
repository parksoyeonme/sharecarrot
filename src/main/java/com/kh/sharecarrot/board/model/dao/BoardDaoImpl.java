package com.kh.sharecarrot.board.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.sharecarrot.board.model.vo.Board;
import com.kh.sharecarrot.board.model.vo.BoardComment;
import com.kh.sharecarrot.board.model.vo.BoardImage;
import com.kh.sharecarrot.board.model.vo.BoardLike;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class BoardDaoImpl implements BoardDao{
	
	@Autowired
	private SqlSessionTemplate session;

	@Override
	public List<Board> selectBoardList(Map<String, Object> param) {
		int cPage = (int)param.get("cPage");
		int limit = (int)param.get("numPerPage");
		int offset = (cPage -1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		log.info("limit = {}", limit);
		log.info("offset = {}", offset);
		return session.selectList("board.selectBoardList", param, rowBounds);
	}

	@Override
	public int getTotalContents(String boardCategory) {
		return session.selectOne("board.getTotalContents", boardCategory);
	}

	@Override
	public int insertBoard(Board board) {
		return session.insert("board.insertBoard", board);
	}

	@Override
	public int insertBoardImg(BoardImage boardImg) {
		return session.insert("board.insertBoardImg",boardImg);
	}

	@Override
	public int boardDelete(int boardNo) {
		return session.delete("board.deleteBoard", boardNo);
	}

	@Override
	public Board selectOneBoard(int boardNo) {
		return session.selectOne("board.selectOneBoard", boardNo);
	}

	@Override
	public int updateBoard(Board board) {
		return session.update("board.updateBoard", board);
	}

	@Override
	public int deleteBoardImg(String id) {
		return session.delete("board.deleteBoardImg", id);
	}

	@Override
	public List<BoardLike> selectBoardLikeList(String memberId) {
		return session.selectList("board.selectBoardLikeList", memberId);
	}

	@Override
	public int updateBoardLike(Map<String, Object> param) {
		return session.update("board.updateBoardLike", param);
	}

	@Override
	public int insertBoardLike(Map<String, Object> param) {
		return session.insert("board.insertBoardLike", param);
	}

	@Override
	public int deleteBoardLike(Map<String, Object> param) {
		return session.delete("board.deleteBoardLike", param);
	}

	@Override
	public int boardCommentInsert(BoardComment boardComment) {
		return session.insert("board.insertBoardComment", boardComment);
	}

	@Override
	public List<BoardComment> boardCommentSelect(int boardNo) {
		return session.selectList("board.selectBoardCommentList", boardNo);
	}

	@Override
	public int boardCommentUpdate(BoardComment boardComment) {
		return session.update("board.boardCommentUpdate", boardComment);
	}

	@Override
	public int boardCommentDelete(String boardCommentId) {
		return session.update("board.boardCommentDelete", boardCommentId);
	}

}
