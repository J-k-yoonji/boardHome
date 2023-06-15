package org.my.service;

import java.util.List;

import org.my.domain.BoardVO;
import org.my.domain.Criteria;

// 비즈니스 계층. 메서드이름은 현실적인 로직의 이름으로 명명. 
public interface BoardService {
	
	// INSERT. 하나의 게시글 정보(BoardVO board)를 가져와 등록하는 메서드. 리턴은 x(void).
	public void resister(BoardVO board);
	
	// SELECT. 특정한 bno에 해당하는 게시글 하나를 조회해 가져옴.
	public BoardVO get(Long bno);
	
	// UPDATE. 하나의 게시글 정보(BoardVO board)를 가져와 수정하는 메서드. boolean 타입으로 로직 성공 여부를 리턴. 
	public boolean modify(BoardVO board);
	
	// DELETE. 특정한 bno에 해당하는 게시물 하나를 가져와 삭제하는 메서드. boolean 타입으로 로직 성공 여부를 리턴. 
	public boolean remove(Long bno);
	
    // public List<BoardVO> getList();
	// SELECT. 다수의 게시글 목록을 조회해 가져옴. + 페이징 적용.  
	public List<BoardVO> getListWithPaging(Criteria cri);
	
	// 실제 모든 게시물의 수 카운트.
	public int getTotal(Criteria cri);

}
