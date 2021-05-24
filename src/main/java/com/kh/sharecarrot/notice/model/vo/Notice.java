package com.kh.sharecarrot.notice.model.vo;

import java.sql.Date;
import java.util.Set;

import org.springframework.security.core.authority.SimpleGrantedAuthority;

import com.kh.sharecarrot.member.model.vo.Member;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Notice {
	
	/*"BOARD_NO"	NUMBER		NOT NULL,
	"BOARD_TITLE"	VARCHAR2(200)		NOT NULL,
	"BOARD_CONTENT"	VARCHAR2(2000)		NOT NULL,
	"BOARD_ENROLL_DATE"	DATE	DEFAULT SYSDATE	NULL,
	"BOARD_UPDATE_DATE"	DATE	DEFAULT SYSDATE	NULL,
	"BOARD_DELETE_YN"	CHAR(1)	DEFAULT 'N',
	"BOARD_CATEGORY"	CHAR(2)		NULL,
	"BOARD_LIKE"	NUMBER	DEFAULT 0,
	"MEMBER_ID"	VARCHAR2(20)		NOT NULL,
    
    constraint pk_board_no  primary key(board_no),
    constraint fk_board_member_id foreign key(member_id) references member(member_id),
    constraint ck_board_delete_yn check(board_delete_yn in ('Y','N'))*/
	
	private int boardNo;
	private String boardTitle;
	private String boardContent;
	private Date boardEnrollDate;
	private Date boardUpdateDate;
	private char boardDeleteYn;
	private char boardCategory;
	private String memberId;
	
}
