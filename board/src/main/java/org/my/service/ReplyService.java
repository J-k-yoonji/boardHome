package org.my.service;

import java.util.List;

import org.my.domain.Criteria;
import org.my.domain.ReplyPageDTO;
import org.my.domain.ReplyVO;

public interface ReplyService {
	
	// 댓글 추가 C
	public int register(ReplyVO vo);
	
	// 특정 댓글 읽기 R
	public ReplyVO get(Long rno);
	
	// 특정 댓글 수정 U
	public int modify(ReplyVO vo);

	// 특정 댓글 삭제 D
	public int remove(Long rno);
	
	// 각 게시물 댓글목록 페이징.
	public List<ReplyVO> getList(Criteria cri, Long bno);
	
	// 댓글 페이징 관련
	public ReplyPageDTO getListPage(Criteria cri, Long bno);
}
