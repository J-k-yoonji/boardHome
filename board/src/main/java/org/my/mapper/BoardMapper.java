package org.my.mapper;

import java.util.List;

import org.my.domain.BoardVO;
import org.my.domain.Criteria;

public interface BoardMapper {

	//@Select("select * from tbl_board where bno > 0")
	
	// 글목록. 저장된 게시글 데이터를 "select"해와야 하므로 List<BoardVO>.
	public List<BoardVO> getList();

	// 글목록 + 페이징처리. Criteria객체 타입을 파라미터로 사용하는 메서드.
	public List<BoardVO> getListWithPaging(Criteria cri);
	
	// 글작성1. inert만 처리되고 생성된 PK값은 알 필요가 없는 경우. 
	public void insert(BoardVO board);
	
	// 글작성2. inert문을 통해 생성된 게시글의 PK값(bno)을 알아야 하는 경우
	public void insertSelectKey(BoardVO board);
	
	// 글조회. 게시글 테이블의 PK인 글 보유번호(bno)를 이용해서 해당 게시글에 대한 데이터를 불러온다.
	public BoardVO read(Long bno);
	
	// 글삭제. 몇건의 데이터가 삭제되었는지도 (영향받았는지) 반환. 정상적으로 1행이상의 데이터가 삭제되면 1이상의 값을 반환. 
	public int delete(Long bno);
	
	// 글수정. 삭제처럼 몇 개의 데이터가 수정되었는지 반환되도록  int타입으로 메서드를 설계한다. 또한 수정시 최종수정시간(updateDate)칼럼만 수정시 시간으로 변경해준다!
	public int update(BoardVO board);
	
	// 실제 모든 게시물의 수 카운트. cri는 검색에서 필요하므로 파라미터로 전달받는 것임.
	public int getTotalCount(Criteria cri);
	
	
	
}
