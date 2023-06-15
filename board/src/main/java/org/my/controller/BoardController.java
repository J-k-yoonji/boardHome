package org.my.controller;

import org.my.domain.BoardVO;
import org.my.domain.Criteria;
import org.my.domain.PageDTO;
import org.my.service.BoardService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {
	
	private BoardService service;
	
	// 글목록.SELECT + 페이징처리
    //화면쪽으로 글목록을 전달해야 하므로 Model을 파라미터로 지정, 이를 통해 BoardServiceImpl객체의 getList()의 결과를 "list"에 담아서 전닳한다.	
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		log.info("C: list " + cri);
		model.addAttribute("list", service.getListWithPaging(cri));
		
		//총페이지 수를 임의로 123으로 넣음.
		//model.addAttribute("pageMaker", new PageDTO(cri, 123));
		
		// 이제 '실제 모든 게시물의 수 카운트' 해옴!
		int total = service.getTotal(cri);		
		log.info("total: " + total );		
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	// 글작성.(입력 페이지로 진입)-GET 
	@GetMapping("/register")
	public void register() {
		// only 입력페이지를 보여주는 역할만 하므로 별도의 처리는 필요하지 않다. 
	}
	
	// 글작성.INSERT (등록 작업)-POST 
	@PostMapping("/register")
	public String register(BoardVO board, RedirectAttributes rttr) {
		log.info("register: " + board);
		service.resister(board);
		// 글작성(등록) 작업이 끝난 후 다시 목록 화면으로 이동하기 위해서 String을 리턴타입으로 지정, 
		// + 추가적으로 '새롭게 등록된 게시물의 번호(bno)'를 같이 전달하기 위해서 RedirectAttributes를 이용. 일회성데이터. 새로고침시 사라짐.
		rttr.addFlashAttribute("result", board.getBno());
		// 리턴시'redirect:'접두어 사용시 스프링MVC가 내부적으로 response.sendRedirect()를 처리해주기때문에 편리함.
		return "redirect:/board/list";
	}
	
	// 글 상세조회.SELECT : 수정/삭제가 가능한 화면으로 이동하는 것도 같은 방식. @GetMapping이나 @PostMapping은 URL을 배열로도 처리 가능하여, 하나의 메서드로 여러 URL도 처리 가능!
	// @RequestParam : bno값을 좀 더 명시적으로 처리해줌. 쿼리실행에 필요한 인파라미터가 #{bno}하나 뿐이다. 
	// 화면쪽으로 해당bno의 게시글을 전달해야 하므로  Model을 파라미터로 지정, 이를 통해 BoardServiceImpl객체의 get(bno)의 결과를 "board"에 담아서 전닳한다.
	@GetMapping( {"/get", "/modify"} )
	public void get(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, Model model) {
		log.info("/get or modify");
		model.addAttribute("board", service.get(bno));
	}
	
	// 글수정.UPDATE (글작성과 유사.) 수정작업을 시작하는 페이지엔 get방식으로 접근하지만, 실제 수정이 완료되는 작업은 post방식으로 동작하므로 @PostMapping을 이용!
	@PostMapping("/modify")
	public String modify(BoardVO board, RedirectAttributes rttr, @ModelAttribute("cri") Criteria cri) {
		log.info("modify:" + board);
		// 수정 로직 성공시(true반환) "result 정보에 success 담아서 전달!
		if ( service.modify(board) ) {
			rttr.addFlashAttribute("result", "success");
		}
		
		// + 추가적으로 'pageNum값과 amount값'을 같이 전달하기 위해서 RedirectAttributes를 이용. 일회성데이터. 새로고침시 사라짐.
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/board/list";
	}
	
	// 글삭제.DELETE
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, RedirectAttributes rttr, @ModelAttribute("cri") Criteria cri) {
		log.info("remove..." + bno);
		// 삭제 로직 성공시
		if ( service.remove(bno) ) {
			rttr.addFlashAttribute("result", "success");
		}
		
		// + 추가적으로 'pageNum값과 amount값'을 같이 전달하기 위해서 RedirectAttributes를 이용. 일회성데이터. 새로고침시 사라짐.
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/board/list";
	}
	
	
	

}
