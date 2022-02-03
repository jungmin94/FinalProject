package com.pai.spring.market.model.vo;

import java.sql.Date;
import java.util.List;

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
	private String largeCategory;
	private String middleCategory;
	private String image;
	private String sizeImage;
	private int totalCell;
	private int avgGrade;
	private int minPrice;  // DB에는 없지만 해당 제품의 최솟값을 담기 위한 변수
	private List<GoodsDetails> goodsDetails;
	private List<GoodsDetailImage> goodsDetailImage;
	
}


