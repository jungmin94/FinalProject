package com.pai.spring.message.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.pai.spring.common.PageBar;
import com.pai.spring.message.model.service.MessageService;
import com.pai.spring.message.model.vo.Message;

@Controller
@RequestMapping("/message")
public class MessageController {
	
	@Autowired
	private MessageService service;

	@RequestMapping(value="/sendMessage", method=RequestMethod.POST)
	public ModelAndView sendMessage(@RequestParam Map param, ModelAndView mv) {
		mv.addObject("param", param);
		mv.setViewName("message/sendMessage");
		return mv;
	}
	
	//쪽지함으로 이동
	@RequestMapping(value="/messageBox.do", method=RequestMethod.POST)
	public ModelAndView messageBox(@RequestParam Map param, ModelAndView mv) {
		mv.addObject("param", param);
		System.out.println(param);
		mv.setViewName("message/messageBox");
		return mv;
	}
	
	//받은쪽지함
	@RequestMapping(value="/recvBox.do", produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String recvMsgBox(String memberId, @RequestParam(value="cPage",defaultValue="1") int cPage,
			@RequestParam(value="numPerpage",defaultValue="10") int numPerpage) {
		
		Map<String,Object> param = new HashMap();
		param.put("memberId", memberId);
		param.put("cPage", cPage);
		param.put("numPerpage", numPerpage);
		
		List<Message> list = service.selectRecvMessage(memberId, cPage, numPerpage);
		int totalData = service.selectRecvMessageCount(memberId);
		System.out.println(list);
		
		Map<String, Object> result = Map.of("memberId", memberId, "pageBar",PageBar.getPageBar(totalData, cPage, numPerpage, 10, "messageBox.do", "recvMsgBox"),"list",list);
		return new Gson().toJson(result);
	}
	
	//받은쪽지 삭제
//	@RequestMapping(value="/deleteRecvMsg.do")
//	public ModelAndView deleteRecvMsg(String msgNo) {
//		//개별 삭제, 다중 삭제 모두 데이터 메세지번호 가져와야함
//		//delete처리가 아닌 받은편지 삭제처리 유무를 Y값으로 변경 -> 사실상 업데이트 -> db에서 실제 삭제가 아님
//		
//	}
	
//	@RequestMapping(value="/messageBox.do", produces="text/plain;charset=UTF-8")
//	public ModelAndView messageBox(ModelAndView mv, String memberId, @RequestParam(value="cPage",defaultValue="1") int cPage,
//			@RequestParam(value="numPerpage",defaultValue="10") int numPerpage) {
//		
//		Map<String,Object> param = new HashMap();
//		param.put("memberId", memberId);
//		param.put("cPage", cPage);
//		param.put("numPerpage", numPerpage);
//		
//		List<Message> list = service.selectRecvMessage(memberId, cPage, numPerpage);
//		int totalData = service.selectRecvMessageCount(memberId);
//		
//		mv.addObject("totalContents",totalData);
//		mv.addObject("pageBar",PageBar.getPageBar(totalData, cPage, numPerpage, 10, "messageBox.do", "recvMsgBox"));
//		//new Gson().toJson(list);
//		mv.addObject("list",list);
//		mv.addObject("memberId",memberId);
//		mv.setViewName("message/messageBox");
//		return mv;
//	}
	
	//받은쪽지 상세보기
	@RequestMapping(value="/recvMsgDetail.do",produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String recvMsgDetail(int msgNo) {
		Map msg = service.selectRecvMsgDetail(msgNo);
	
		return new Gson().toJson(msg);
	}
	
	//보낸쪽지함
	@RequestMapping(value="/sendMsg.do", produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String sendMsgBox(String sendId, @RequestParam(value="cPage",defaultValue="1") int cPage,
			@RequestParam(value="numPerpage",defaultValue="10") int numPerpage) {
		
		Map<String,Object> param = new HashMap();
		param.put("sendId", sendId);
		param.put("cPage", cPage);
		param.put("numPerpage", numPerpage);
		
		List<Message> list = service.selectSendMsg(sendId, cPage, numPerpage);
		int totalData = service.selectSendMessageCount(sendId);
		Map<String, Object> result = Map.of("pageBar",PageBar.getPageBar(totalData, cPage, numPerpage, 10, "sendMsg.do", "sendMsgBox"),"list",list);
		
		return new Gson().toJson(result);
	}
	
}
