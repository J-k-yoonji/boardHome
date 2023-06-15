package org.my.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import lombok.extern.log4j.Log4j;

@Getter
@Setter
@ToString
public class Criteria {

	private int pageNum; // 현재 페이지 번호
	private int amount;  /// 한 페이지당 보여줄 게시글 갯수
	
	private String type;
	private String keyword;
	
	public Criteria() {
		this(1,10);
	}
	
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	public String[] getTypeArr() {
		// 검색조건이 각 글자 (T,W,C)로 구성되어 있으므로, 검색 조건을 배열로 만들어서 한번에 처리하기 위함이다! getTypeArr()을 이용해 MyBatis동적태그를 활용할 수 있다.
		return type == null ? new String[] {} : type.split("");
	}
		
}

