package com.kh.sharecarrot.board.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.sharecarrot.board.model.vo.Board;
import com.kh.sharecarrot.board.model.vo.BoardImage;

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

}
