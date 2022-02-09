package com.pai.spring.message.model.vo;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MessageBox {
	private String sendId;
	private String sendNick;
	private String recvId;
	private String recvNick;
	private String msgTitle;
	private String msgContent;
//	private Timestamp msgSendTime;
//	private Timestamp msgReadTime;
}
