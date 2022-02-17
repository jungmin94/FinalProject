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
public class Order {

	private int orderNo;
	private String member_id;
	private Date orderDate;
	private String ordererName;
	private String ordererEmail;
	private String ordererPhone;
	private String receiverName;
	private String receiverAddress;
	private String receiverPhone;
	private List<OrderDetail> orderDetail;
	private int totalOrderPrice;
	private String image; // 구매목록 이미지 출력을 위한 변수
	
	
}
