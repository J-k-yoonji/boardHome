package org.my.service;

import java.util.List;

import org.my.domain.BoardVO;
import org.my.domain.Criteria;
import org.my.mapper.BoardMapper;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService {
	
	//spring 4.3이상에서 자동 처리 (Add unimplemented method)
	private BoardMapper mapper;

	// 글작성.
	@Override
	public void resister(BoardVO board) {
		log.info("resister......" + board);
		mapper.insertSelectKey(board);
	}

	// 글상세 조회.
	@Override
	public BoardVO get(Long bno) {
		log.info("get......" + bno);
		return mapper.read(bno);
	}

	/*
	 * mapper의 수정/삭제 메서드 실행 후 정상적으로 수정/삭제 가 이뤄지면 1이라는 값이 반환되기 때문에 (1개의 게시글이 영향받음.)
	 * '=='연산자를 이용하여 
	 * 반환되는 값이 1로 같으면 true(로직성공), 값이 0 이면  false(로직실패)로 처리할 수 있다.
	*/	
	// 글수정.
	@Override
	public boolean modify(BoardVO board) {
		log.info("modify......" + board);
		return mapper.update(board) == 1;
	}

	// 글삭제.
	@Override
	public boolean remove(Long bno) {
		log.info("remove......" + bno);
		return mapper.delete(bno) == 1;
	}

	// 글목록 조회.
	//@Override
	//public List<BoardVO> getList() {
	//	log.info("getList..........");
	//	return mapper.getList();
	//}
	
	// 글목록 조회 + 페이징처리.
	@Override
	public List<BoardVO> getListWithPaging(Criteria cri) {
		log.info("get List with criteria: " + cri);
		return mapper.getListWithPaging(cri);
	}

	// 실제 모든 게시물의 수 카운트.
	@Override
	public int getTotal(Criteria cri) {
		log.info("get total count");
		return mapper.getTotalCount(cri);
	}
	
	// 비즈니스 계층 구현 완료. 이제 프레젠테이션 계층인 웹의 구현을 하러가자!


}
