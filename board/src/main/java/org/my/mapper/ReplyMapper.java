package org.my.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.my.domain.Criteria;
import org.my.domain.ReplyVO;

public interface ReplyMapper {
	
	// 댓글 추가 C
	public int insert(ReplyVO vo);
	
	// 특정 댓글 읽기 R
	public ReplyVO read(Long rno);
	
	// 특정 댓글 삭제 D
	public int delete (Long rno);
	
	// 특정 댓글 수정 U
	public int update(ReplyVO reply);
	
	// 각 게시물 댓글목록 페이징.
	public List<ReplyVO> getListWithPaging(@Param("cri") Criteria cri, @Param("bno") Long bno); 
	
	// 댓글의 숫자 파악
	public int getCountByBno(Long bno);
	
}

