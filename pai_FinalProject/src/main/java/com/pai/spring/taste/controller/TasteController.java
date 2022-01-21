package com.pai.spring.taste.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/taste")
public class TasteController {
	
	@RequestMapping("/taste.do")
	public String tasteTest() {
		return "taste/tasteTest";
	}
	
}
