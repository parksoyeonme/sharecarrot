package com.kh.sharecarrot.board.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.sharecarrot.board.model.dao.BoardDao;
import com.kh.sharecarrot.board.model.vo.Board;
import com.kh.sharecarrot.board.model.vo.BoardImage;

@Service
public class BoardServiceImpl implements BoardService{

	@Autowired
	private BoardDao boardDao;

	@Override
	public List<Board> selectBoardList(Map<String, Object> param) {
		return boardDao.selectBoardList(param);
	}

	@Override
	public int getTotalContents(String boardCategory) {
		return boardDao.getTotalContents(boardCategory);
	}

	@Override
	public int insertBorad(Board board) {
		int result = 0;
		//1. board객체 등록
		result = boardDao.insertBoard(board);
		
		//2.boardImageList 등록
		if(!board.getBoardImageList().isEmpty()) {
			for(BoardImage boardImg : board.getBoardImageList()) {
				boardImg.setBoardNo(board.getBoardNo());
				result = boardDao.insertBoardImg(boardImg);
			}
		}
		return result;
	}

	@Override
	public int boardDelete(int boardNo) {
		return boardDao.boardDelete(boardNo);
	}

	@Override
	public Board selectOneBoard(int boardNo) {
		return boardDao.selectOneBoard(boardNo);
	}
}
