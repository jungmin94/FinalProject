package com.pai.spring.chatting.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import com.pai.spring.chatting.model.service.ChattingService;
import com.pai.spring.chatting.model.vo.ChatMessage;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/chatting")
@Slf4j
public class ChattingController {

	@Autowired
	ServletContext servletContext;

	@Autowired
	private ChattingService chattingService;

	@RequestMapping("/toSeeMyChatroomInfo.do")
	public String myChatRoomInfo() {

		return "chatting/enterMyChattingRoom";

	}

	@RequestMapping("/toSeeAllChatroomInfo.do")
	public String allChatRoomInfo() {

		return "chatting/enterAllChattingRoom";

	}

	@RequestMapping("/toEnterChatroom.do")
	public String enterChattingRoom(String id) {
		return "chatting/myMbtiChattingArea";

	}

	@RequestMapping("/toEnterAllChatroom.do")
	public String enterAllChattingRoom(String id) {
		return "chatting/allMbtiChattingArea";

	}

	@RequestMapping(value = "/getAttendenceList.do", method = RequestMethod.POST)
	public @ResponseBody List<String> attendenceList(@RequestParam(value = "chatroomUser") String chatroomUser,
			String chatroomName, String chatUserMbti) throws Exception {

		ChatMessage cMsg = ChatMessage.builder().senderId(chatroomUser).chatRoomName(chatroomName)
				.senderMbti(chatUserMbti).build();
		int result = chattingService.insertChatRoom(cMsg);

		// 읽어오는 서비스 호출

		List<String> resultChatroom = chattingService.attendenceChatroom();
		List<String> resultUser = chattingService.attendenceList(chatroomName);

		String resultList = "";

		for (int i = 0; i < resultUser.size(); i++) {
			resultList += resultUser.get(i) + " ";
			resultList += resultChatroom.get(i) + " ";
		}

		return resultUser;
	}

	@RequestMapping(value = "/removeAttendenceList.do", method = RequestMethod.POST)
	public @ResponseBody List<String> removeFromAttendenceList(
			@RequestParam(value = "chatroomUser") String chatroomUser, String chatroomName, String chatUserMbti)
			throws Exception {

		ChatMessage cMsg = ChatMessage.builder().senderId(chatroomUser).chatRoomName(chatroomName)
				.senderMbti(chatUserMbti).build();

		int result = chattingService.deleteChatRoom(cMsg);
		// 읽어오는 서비스 호출
		List<String> resultList = chattingService.attendenceList(chatroomUser);

		Map<String, String> resultMap = new HashMap<>();

		for (int i = 0; i < resultList.size(); i++) {
			resultMap.put("userId", chatroomUser);
		}

		return resultList;
	}

	@RequestMapping(value = "/uploadFile.do", method = RequestMethod.POST)
	public @ResponseBody ChatMessage write(ChatMessage cMsg, @RequestParam("upFile") MultipartFile[] files, Model model,
			HttpSession session, HttpServletRequest req) throws IllegalStateException, IOException {

		// 전달된 파일 업로드 처리하기
		// 1. 저장경로 불러오기
		String path = req.getServletContext().getRealPath("/resources/upload/chatting/");
		File f = new File(path);

		if (!f.exists())
			f.mkdirs();

		for (MultipartFile mf : files) {
			if (!mf.isEmpty()) {
				// 파일 리네임 처리를 직접 처리

				String originalFileName = mf.getOriginalFilename();
				String ext = originalFileName.substring(originalFileName.lastIndexOf("."));
				// 리네임 규칙 설정
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssss");
				int rndNum = (int) (Math.random() * 1000);
				String renameFile = sdf.format(System.currentTimeMillis()) + "_" + rndNum + ext;

				// 리네임 명으로 파일 저장하기
				// multipartFile클래스에서 파일을 저장하는 메소드를 제공함. -> transferTo(파일객체);
				try {
					mf.transferTo(new File(path + renameFile));

					cMsg.setUploadFile(renameFile);

				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}

		return cMsg;

	}

	@RequestMapping(value = "/download.do", method = RequestMethod.POST)
	public @ResponseBody void fileDownload(String fileName, HttpServletRequest req, HttpServletResponse res,
			@RequestHeader(value = "User-agent") String header) {

		String path = req.getServletContext().getRealPath("/resources/upload/chatting/");

		String fullPath = path + fileName;

		File tempFile = new File(fullPath);

		Map<String, Object> model = new HashMap<>();

		model.put("downloadFile", tempFile);

//			File saveFile = new File (path + fileName);
//			BufferedInputStream bis = null;
//			ServletOutputStream sos = null;
//			
//			try {
//				bis = new BufferedInputStream(new FileInputStream(saveFile));
//				sos = res.getOutputStream();
//				boolean isMs = header.contains("Trident") || header.contains("MSIE");
//				String encodeStr = "";
//				
//				if (isMs) {
//					encodeStr = URLEncoder.encode(fileName, "UTF-8");
//					encodeStr = encodeStr.replaceAll("\\+", "%20");
//				} else {
//					encodeStr = new String (fileName.getBytes("UTF-8"),"ISO-8859-1");
//				}
//				res.setContentType("application/octet-stream;charset=utf-8");
//				res.setHeader("Content-Disposition", "attachment;filename=\"" + encodeStr + "\"");
//				int read = -1;
//				while ((read = bis.read()) != -1) {
//					sos.write(read);
//				}
//			} catch (IOException e) {
//				e.printStackTrace();
//			} finally {
//				try {
//					bis.close();
//					sos.close();
//				} catch (IOException e) {
//					e.printStackTrace();
//				}
//			}
		File file = (File) model.get("downloadFile");

		res.setContentType("application/download; utf-8");
		res.setContentLength((int) file.length());

		String resultFileName = null;

		// if(ie){
		// 브라우저 정보에 따라 utf-8변경
		if (req.getHeader("User-Agent").indexOf("MSIE") > -1) {

			try {
				resultFileName = URLEncoder.encode(file.getName(), "utf-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}

		} else {

			try {
				resultFileName = new String(file.getName().getBytes("utf-8"));
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		} // end if;

		res.setHeader("Content-Disposition", "attachment; filename=\"" + resultFileName + "\";");
		res.setHeader("Content-Transfer-Encoding", "binary");
		OutputStream out = null;
		try {
			out = res.getOutputStream();
		} catch (IOException e1) {
			e1.printStackTrace();
		}
		FileInputStream fis = null;

		// 파일 카피 후 마무리
		try {
			fis = new FileInputStream(file);
			FileCopyUtils.copy(fis, out);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (fis != null) {
				try {
					fis.close();
				} catch (Exception e) {
				}
			}
		} // try end;
		try {
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

}
