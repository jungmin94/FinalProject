package com.pai.spring.member.model.vo;

import java.sql.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Member {
	private String member_id;
	private String member_pw;
	private String member_name;
	private String member_nick;
	private String member_date;
	private String member_gender;
	private String member_email;
	private String member_addr;
	private String member_phone;
	private String member_content;
	private String member_mbti;
	private int member_police;
	private int member_black;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date member_enroll;
	private String status;
	private String authKey;
//	private List<Profile> profile;
	private String member_profile;
}
