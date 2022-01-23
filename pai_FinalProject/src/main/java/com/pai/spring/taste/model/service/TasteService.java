package com.pai.spring.taste.model.service;

import java.util.Map;

import com.pai.spring.taste.model.vo.Taste;

public interface TasteService {
	Taste selectTasteOne(String member_id);
	int insertTaste(Taste t);
}
