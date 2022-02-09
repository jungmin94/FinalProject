package com.pai.spring.board.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class BoardDeclare {
	private int boardNo;
	private String declareWriter;
	private String declareContent;
	private Date declareDate;
	private String declareResult;
	private Date declareResultDate;
	private String boardTitle;
	private String boardWriter;
	private int declareNo;
	private int declareCount;
}
