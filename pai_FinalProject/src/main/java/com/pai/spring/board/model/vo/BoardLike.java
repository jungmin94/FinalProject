package com.pai.spring.board.model.vo;

 
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class BoardLike {
	private int likeNo;
	private int boardNo;
	private String memberId;

}
