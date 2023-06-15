package org.my.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {

	private int startPage;
	private int endPage;
	private boolean prev, next;
	
	private int total;
	private Criteria cri;
	
	public PageDTO(Criteria cri, int total) {
		this.cri = cri;
		this.total = total;
		
		this.endPage = (int) (Math.ceil(cri.getPageNum() / 10.0)) * 10;
		
		//페이징 시작 번호 계산
		this.startPage = this.endPage - 9;
		
		//total을 통한 endPage 재계산. realEnd : 정말 마지막 페이지 번호.(총페이지번호)
		int realEnd = (int) (Math.ceil((total * 1.0) / cri.getAmount()));
		
		if (realEnd < this.endPage) {
			this.endPage = realEnd;
		}
		
		//이전 버튼
		this.prev = this.startPage >1;
		
		//다음 버튼
		this.next = this.endPage < realEnd;
	}
}
