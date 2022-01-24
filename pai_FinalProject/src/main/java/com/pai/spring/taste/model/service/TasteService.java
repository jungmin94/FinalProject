package com.pai.spring.taste.model.service;

import java.util.List;
import java.util.Map;

import com.pai.spring.taste.model.vo.Taste;

public interface TasteService {
	Taste selectTasteOne(String member_id);
	int insertTaste(Map param);
	List<Taste> selectTasteList(Map param);
	int updateTaste(Map param);
}
