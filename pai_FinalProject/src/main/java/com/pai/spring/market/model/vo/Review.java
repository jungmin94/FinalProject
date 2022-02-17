package com.pai.spring.market.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Review {

	private int reviewNo;
	private String member_id;
	private int goodsNo;
	private String goodsName;
	private int grade;
	private String reviewText;
	private Date reviewDate;
	private OrderDetail orderDetail;
	
}
