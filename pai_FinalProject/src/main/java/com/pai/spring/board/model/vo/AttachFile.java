package com.pai.spring.board.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
public class AttachFile {
	private int attachFileNo;
	private int boardNo;
	private String attachFileName;
}
