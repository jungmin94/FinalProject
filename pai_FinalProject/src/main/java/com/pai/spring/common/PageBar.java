package com.pai.spring.common;

public class PageBar {
	public static String getPageBar(int totalData, int cPage,
			int numPerpage, int pageBarSize, String url, String fn) {
		String pageBar="";
		int totalPage=(int)Math.ceil((double)totalData/numPerpage);
		int pageNo=((cPage-1)/pageBarSize)*pageBarSize+1;
		int pageEnd=pageNo+pageBarSize-1;
		
		pageBar+="<ul class='pagination justify-content-center pagination-sm'>";
		if(pageNo==1) {
			pageBar+="<li class='page-item disabled'>";
			pageBar+="<a class='page-link' href='#'>&laquo;</a>";
			pageBar+="</li>";
		}else {
			pageBar+="<li class='page-item'>";
			pageBar+="<a class='page-link' href='javascript:"+fn+"("+(pageNo-1)+")'>&laquo;</a>";
			pageBar+="</li>";
		}
		
		while(!(pageNo>pageEnd||pageNo>totalPage)) {
			if(cPage==pageNo) {
				pageBar+="<li class='page-item active'>";
				pageBar+="<a class='page-link' href='#'>"+pageNo+"</a>";
				pageBar+="</li>";
			}else {
				pageBar+="<li class='page-item'>";
				pageBar+="<a class='page-link' href='javascript:"+fn+"("+(pageNo)+")'>"+pageNo+"</a>";
				pageBar+="</li>";
			}
			pageNo++;
		}
		
		if(pageNo>totalPage) {
			pageBar+="<li class='page-item disabled'>";
			pageBar+="<a class='page-link' href='#'>&raquo;</a>";
			pageBar+="</li>";
		}else {
			pageBar+="<li class='page-item'>";
			pageBar+="<a class='page-link' href='javascript:"+fn+"("+(pageNo)+")'>&raquo;</a>";
			pageBar+="</li>";
		}
		pageBar+="</ul>";
//		pageBar+="<script>";
//		pageBar+="function fn_paging(cPage){";
//		pageBar+="location.assign('"+url+"?cPage='+cPage);";
//		pageBar+="}";
//		pageBar+="</script>";
		
		
		
		
		return pageBar;
		
	}
}
