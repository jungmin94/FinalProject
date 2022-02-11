package com.pai.spring.market.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class OrderDetail {

	private int orderDetailNo;
	private int orderNo;
	private int goodsNo;	
	private String goodsName;
	private String orderColor;
	private String orderSize;
	private String mbtiLogo;
	private int orderCount;
	private int orderPrice;
	
}
