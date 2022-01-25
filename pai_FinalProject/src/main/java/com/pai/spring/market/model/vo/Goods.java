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
public class Goods {

	private int goodsNo;
	private String goodsName;
	private String goodsOutput;
	private Date goodsEnrollDate;
	private String largeCategoty;
	private String middleCategoty;
	private String image;
	private String sizeImage;
	
}
