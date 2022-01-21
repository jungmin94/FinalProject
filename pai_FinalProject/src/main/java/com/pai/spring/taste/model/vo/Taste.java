package com.pai.spring.taste.model.vo;

import com.pai.spring.member.model.vo.Member;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Taste {
	private String exam01;
	private String exam02;
	private String exam03;
	private String exam04;
	private String exam05;
	private Member member_id;

}
