package com.pai.spring.message.model.vo;

import java.sql.Timestamp;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.pai.spring.member.model.vo.Member;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@JsonIgnoreProperties(ignoreUnknown = true)
public class Message {
	private int msgNo;
	private Member sendId;
	private Member recvId;
	private String msgTitle;
	private String msgContent;
	private Timestamp msgSendTime;
	private Timestamp msgReadTime;
	private String msgReadCheck;
	private String msgSendDel;
	private String msgRecvDel;

}
