 package com.pai.spring.message.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
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

//------------------------받은족지--------------------------------------------------------------
	
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
	
	//받은쪽지 다중 삭제
	@RequestMapping(value="/deleteRecvMsg.do", produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String deleteRecvMsg(@RequestParam(value="checkArrTest[]") List<Integer> checkArr) {
		System.out.println(checkArr);
		int num=0;
		for(int i=0; i<checkArr.size(); i++) {
			int deleteRecvMsg = service.deleteRecvMsg(checkArr.get(i));
			if(deleteRecvMsg!=0) {
				num++;
			}
		}
		Map<String, Object> result = Map.of("result", num+"개의 쪽지를 삭제 완료하였습니다.");
		System.out.println(result);
		return new Gson().toJson(result);
		
	}
	

	
	//받은쪽지 상세보기
	@RequestMapping(value="/recvMsgDetail.do",produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String recvMsgDetail(int msgNo) {
		Map msg = service.selectRecvMsgDetail(msgNo);
		
		//메세지 읽음여부가 N인경우 아직 읽기전 -> 상세보기시 Y처리 및 읽은 시간 등록 필요
		if(msg.get("MSGREADCHECK").equals("N")) {
			service.recvMsgRead(msgNo);
		}
		System.out.println(msg.get("MSGREADCHECK"));
	
		return new Gson().toJson(msg);
	}
	
	//받은쪽지 상세보기화면에서 삭제
	@RequestMapping(value="/deleteRecvMsgOne.do", produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String deleteRecvMsg(int msgNo) {
		System.out.println(msgNo);
		
		Map<String, Object> result;
		int deleteRecvMsg = service.deleteRecvMsg(msgNo);
		if(deleteRecvMsg==1) {
			result = Map.of("result", "쪽지 삭제 완료하였습니다.");
		} else {
			result = Map.of("result", "쪽지 삭제에 실패하였습니다.");
			
		}
	
		System.out.println(result);
		return new Gson().toJson(result);
		
	}
	
//-------------------------------보낸쪽지-----------------------------------------------------------------
	
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
	
	
	//보낸쪽지 다중 삭제
	@RequestMapping(value="/deleteSendMsg.do", produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String deleteSendMsg(@RequestParam(value="checkArrTest[]") List<Integer> checkArr) {
		System.out.println(checkArr);
		int num=0;
		for(int i=0; i<checkArr.size(); i++) {
			int deleteSendMsg = service.deleteSendMsg(checkArr.get(i));
			if(deleteSendMsg!=0) {
				num++;
			}
		}
		Map<String, Object> result = Map.of("result", num+"개의 쪽지를 삭제 완료하였습니다.");
		System.out.println(result);
		return new Gson().toJson(result);
		
	}
	
	//보낸쪽지 상세페이지에서 삭제
	@RequestMapping(value="/deleteSendMsgOne.do", produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String deleteSendMsg(int msgNo) {
		System.out.println(msgNo);
		
		Map<String, Object> result;
		int deleteSendMsg = service.deleteSendMsg(msgNo);
		if(deleteSendMsg==1) {
			result = Map.of("result", "쪽지 삭제 완료하였습니다.");
		} else {
			result = Map.of("result", "쪽지 삭제에 실패하였습니다.");
			
		}
	
		System.out.println(result);
		return new Gson().toJson(result);
		
	}
	
	
	//보낸쪽지 상세보기
	@RequestMapping(value="/sendMsgDetail.do",produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String sendMsgDetail(int msgNo) {
		Map msg = service.selectSendMsgDetail(msgNo);
	
		return new Gson().toJson(msg);
	}
	
	//쪽지보내기
	@RequestMapping(value="/sendMessage.do", method=RequestMethod.POST, produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String sendMessage(@RequestParam Map param) {
		System.out.println(param);
		int msg = service.sendMessage(param);
		//Map<String, Object> result = Map.of("sendId",param.get("sendId"), "recvId",param.get("recvId"), "sendNick",param.get("sendNick"));
		//System.out.println(result);
	
		return new Gson().toJson(param);
	}
	
	//안읽은 쪽지개수
	@RequestMapping(value="/msgCount.do")
	@ResponseBody
	public String selectUnreadMsg(String memberId) {
		int msgCount = service.selectUnreadMsg(memberId);
		return new Gson().toJson(msgCount);
	}
	
	//읽기전 발송취소
	@RequestMapping(value="/cancelSendMsg.do", produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String cancelSendMsg(int msgNo) {
		int cancel = service.cancelSendMsg(msgNo);
		System.out.println("msgNo"+msgNo);
		System.out.println("cancel"+cancel);
		Map<String, Object> result;
		if(cancel==1) {
			result = Map.of("result", "발송 전 취소 완료하였습니다.");
		} else {
			result = Map.of("result", "취소 실패하였습니다.");
		}
		return new Gson().toJson(result);
		
	}

	
	
}
