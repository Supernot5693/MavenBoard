package ino.web.freeBoard.controller;

import ino.web.freeBoard.dto.FreeBoardDto;
import ino.web.freeBoard.service.FreeBoardService;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class FreeBoardController {

	@Autowired
	private FreeBoardService freeBoardService;

	@RequestMapping("/main.ino")
	@ResponseBody
	public ModelAndView main(HttpServletRequest request,@RequestParam Map<String, Object> sMap){
		ModelAndView mav = new ModelAndView();
		
		System.out.println("before " +sMap);
		
		String pageNum = (String) sMap.get("pageNum");
		
		int currentPage = 1;
		if(pageNum !=null||pageNum==""){
			currentPage = Integer.parseInt(pageNum);
		}
		
		// 전체 데이터의 갯수
		int dataCount = freeBoardService.getDataCount(sMap);
		// 한 화면에 표시할 데이터의 갯수
		int numPerPage = 5;
		
		int pageCount = 0;
		pageCount = dataCount/numPerPage;
		if(dataCount % numPerPage!=0){
			pageCount++;
		}
		
		int totalPage =  pageCount;
		
		if(currentPage > totalPage){
			currentPage = totalPage;
		}
		
		int start = (currentPage-1)*numPerPage+1;
		int end = currentPage*numPerPage;
		
		sMap.put("start", start);
		sMap.put("end", end);
		
		System.out.println("after " +sMap);
		
		List<Map<String, Object>> list = freeBoardService.freeBoardList(sMap);
		List<Map<String, Object>> sType = freeBoardService.selectType();
		List<Map<String, Object>> cType = freeBoardService.codeType();
		mav.setViewName("boardMain");
		mav.addObject("freeBoardList",list);
		mav.addObject("totalPage", totalPage);
		mav.addObject("sType",sType);
		mav.addObject("cType",cType);
		return mav;
	}

	@RequestMapping("/freeBoardInsert.ino")
	public ModelAndView freeBoardInsert(HttpServletRequest request){
		ModelAndView mav = new ModelAndView();
		
		List<Map<String, Object>> cType = freeBoardService.codeType();
		
		mav.setViewName("freeBoardInsert");
		mav.addObject("cType", cType);
		
		return mav;
	}

	@RequestMapping("/freeBoardInsertPro.ino")
	@ResponseBody
	public Map<String, Object> freeBoardInsertPro(HttpServletRequest request, FreeBoardDto dto){
		Map<String, Object> map = freeBoardService.freeBoardInsertPro(dto);
		return map;
	}

	@RequestMapping("/freeBoardDetail.ino")
	public ModelAndView freeBoardDetail(HttpServletRequest request){
		
		int num = Integer.parseInt(request.getParameter("num"));
		
		FreeBoardDto dto = freeBoardService.getDetailByNum(num);
		
		ModelAndView mav = new ModelAndView("freeBoardDetail", "freeBoardDto", dto);
		
		List<Map<String, Object>> cType = freeBoardService.codeType();
		mav.addObject("cType",cType);
		
		return mav;
	}

	@RequestMapping("/freeBoardModify.ino")
	@ResponseBody
	public Map<String, Object> freeBoardModify(HttpServletRequest request, FreeBoardDto dto){
		
		Map<String, Object> hMap = freeBoardService.freeBoardModify(dto);
		
		return hMap;
	}


	@RequestMapping("/freeBoardDelete.ino")
	@ResponseBody
	public Map<String, Object> FreeBoardDelete(HttpServletRequest request, FreeBoardDto dto){
		
		int num = dto.getNum();
		
		Map<String, Object> dMap = freeBoardService.FreeBoardDelete(num);
		
		return dMap;
	}
	@RequestMapping("/freeBoardSearch.ino")
	@ResponseBody
	public Map<String, Object> searchList(HttpServletRequest request,@RequestParam Map<String, Object> sMap){
		
		System.out.println("before " +sMap);
		
		String pageNum = (String) sMap.get("pageNum");
		
		int currentPage = 1;
		if(pageNum !=null||pageNum==""){
			currentPage = Integer.parseInt(pageNum);
		}
		
		// 전체 데이터의 갯수
		int dataCount = freeBoardService.getDataCount(sMap);
		// 한 화면에 표시할 데이터의 갯수
		int numPerPage = 5;
		
		int pageCount = 0;
		pageCount = dataCount/numPerPage;
		if(dataCount % numPerPage!=0){
			pageCount++;
		}
		
		int totalPage =  pageCount;
		
		if(currentPage > totalPage){
			currentPage = totalPage;
		}
		
		int start = (currentPage-1)*numPerPage+1;
		int end = currentPage*numPerPage;
		
		sMap.put("start", start);
		sMap.put("end", end);
		
		System.out.println("after " +sMap);
		
		int numPerBlock=5;
		int currentPageSetup;
		int page;
		String sb = "";
		
		if(currentPage==0||totalPage==0){
			sb = "";
		}
		currentPageSetup = (currentPage/numPerBlock)*numPerBlock;
		
		if(currentPage % numPerBlock==0){
			currentPageSetup = currentPageSetup - numPerBlock;
		}
		
		// 이전 버튼
		if(totalPage>numPerBlock && currentPageSetup>0){
			sb+="<a href='#' id='page' name='page' onclick='pagee();>+이전</a> ";
		}
		
		page = currentPageSetup + 1;
		
		while(page <=totalPage && page <=(currentPageSetup + numPerBlock)){
			if(page == currentPage){
				sb+="<font color='Fuchsia'>" + page + "</font> ";
			}else{
				sb+="<a href='#' id='page' name='page' onclick='pagee("+ page +");'>"+ page + "</a> ";
			}
			page++;
		}
		
		// �떎�쓬
		if(totalPage - currentPageSetup > numPerBlock){
			sb+="<a href='#' id='page' name='page' onclick='pagee();'>다음</a> ";
		}
		
		List<Map<String, Object>> list = freeBoardService.freeBoardList(sMap);
		sMap.put("totalPage", totalPage);
		sMap.put("currentPage", currentPage);
		/*sMap.put("sb", sb);*/
		sMap.put("list",list);
		return sMap;
	}
	
	@RequestMapping("/freeBoardCheckDelete.ino")
	@ResponseBody
	public Map<String, Object> checkDelete(HttpServletRequest request,@RequestParam(value="checkArr[]") List<String> list){
		
		ArrayList<String> checkArray = new ArrayList<String>();
		Map<String, Object> cMap = new HashMap<>();
		
		for(int i=0;i<list.size();i++){
			checkArray.add(list.get(i));
		}
		
		System.out.println(checkArray);
		
		cMap = freeBoardService.freeBoardCheckDelete(checkArray);
		
		return cMap;
	}
	
}