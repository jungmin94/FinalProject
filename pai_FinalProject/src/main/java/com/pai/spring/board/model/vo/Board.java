package com.pai.spring.board.model.vo;

import java.sql.Date;
import java.util.List;

import com.pai.spring.member.model.vo.Member;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Board {
	
	private int boardNo;
	private Member boardWriter;
	private String boardTitle;
	private String boardContent;
	private String boardCategory;
	private Date boardEnrollDate;
	private int boardReadCount;
	private int recommendCount;
	private List<AttachFile> attachFile;
	private List<BoardComment> comment;
}
