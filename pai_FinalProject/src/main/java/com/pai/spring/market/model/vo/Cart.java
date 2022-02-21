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
public class Cart {

	private int cartNo;
	private String member_id;
	private int goodsNo;
	private String image;
	private String goodsName;
	private String color;
	private String size;
	private String mbtiLogo;
	private Date addCartDate;
	private int count;
	private int price;
	
}
