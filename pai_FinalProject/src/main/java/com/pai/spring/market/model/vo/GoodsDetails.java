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
public class GoodsDetails {

	private String color;
	private String size;
	private int goodsNo;
	private String goodsName;
	private int invenCount;
	private int price;
	
}
