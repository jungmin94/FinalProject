package com.pai.spring.market.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class GoodsDetailImage {

	private int imgNo;
	private int goodsNo;
	private String goodsName;
	private String filePath;
	
}
