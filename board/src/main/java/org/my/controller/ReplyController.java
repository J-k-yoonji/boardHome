package org.my.controller;

import org.my.domain.Criteria;
import org.my.domain.ReplyPageDTO;
import org.my.domain.ReplyVO;
import org.my.service.ReplyService;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping("/replies/")
@RestController
@Log4j
@AllArgsConstructor
public class ReplyController {
	
	private ReplyService service;
	
	// C: 댓글 작성 
	// POST방식으로만 동작, 브라우저에서 '댓글데이터'전송시 JSON 데이터로만 처리, 문자열(댓글 create처리결과)을 반환. 
	// @RequestBody : json 이나 xml 형식의 데이터를 담아서 요청을 보낼 때 사용.
	@PostMapping(value = "/new", consumes = "application/json", produces = { MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody ReplyVO vo) {
		log.info("ReplyVO: " + vo);
		
		int insertCount = service.register(vo);
		
		log.info("Reply INSERT COUNT: " + insertCount);
		
		return insertCount == 1 ? new ResponseEntity<>("success", HttpStatus.OK) 
				                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR); 
	}
	
	// R: 댓글 목록 (페이징 차후 적용) // 페이징 적용 후 : 리턴 자료형을 List<ReplyVO>에서 ReplyPageDTO로 바꿔줌! 
	// @PathVariable : URL경로에 있는 값을 파라미터로 추출하려고 할 때 사용!
	@GetMapping(value = "/pages/{bno}/{page}", produces = { MediaType.APPLICATION_XML_VALUE,
															MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<ReplyPageDTO> getList(@PathVariable("page") int page,
												 @PathVariable("bno") Long bno) {
		
		
		Criteria cri = new Criteria(page,10);
		log.info("get Reply List bno : " + bno);
		log.info("cri : " + cri);
		
//		return new ResponseEntity<>(service.getList(cri, bno), HttpStatus.OK);
		return new ResponseEntity<>(service.getListPage(cri, bno), HttpStatus.OK);
	}
	
	// R: 댓글 조회 
	@GetMapping(value = "/{rno}", produces = { MediaType.APPLICATION_XML_VALUE,
			                                   MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<ReplyVO> get(@PathVariable("rno") Long rno) {
		
		log.info("get: " + rno);
		
		// 데이터와 에러메시지를 함께 전달!
		return new ResponseEntity<>(service.get(rno), HttpStatus.OK);
	}
	
	// D: 댓글 삭제
	@DeleteMapping(value= "/{rno}", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> remove(@PathVariable("rno") Long rno) {
		log.info("remove: " + rno);
		
		return service.remove(rno) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
										: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		
	}
	
	// U: 댓글 수정 - json형태로 전달되어 오는 데이터(vo)와 파라미터로 전달되어 오는 댓글번호(rno)를 처리하는 메서드.
	// @RequestBody로 처리되는 데이터는 일반 파라미터나 @PathVariable파라미터를 처리할 수 없기 때문에 따로 직접 처리(setRno)해줘야하는 부분을 주의해야 한다! 
	@RequestMapping(method = { RequestMethod.PUT, RequestMethod.PATCH },
			        value = "/{rno}", consumes = "application/json", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> modify(@RequestBody ReplyVO vo, 
										 @PathVariable("rno") Long rno) {
		vo.setRno(rno);
		log.info("rno: " + rno);
		log.info("modify: " + vo);
		return service.modify(vo) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				                       : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	

}
