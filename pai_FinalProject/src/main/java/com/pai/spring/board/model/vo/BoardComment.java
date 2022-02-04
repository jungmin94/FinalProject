package com.pai.spring.board.model.vo;

import java.sql.Date;

import com.pai.spring.member.model.vo.Member;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;


@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class BoardComment { 
	
	private int commentNo;
	private int commentLevel;
	private String commentWriter;
	private String commentContent;
	private int boardRef;
	private int commentRef;
	private Date commentDate;
}
