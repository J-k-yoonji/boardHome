<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>    
    
<%@include file="../includes/header.jsp" %>    
            
<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">글목록</h1>
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <!-- <div class="panel-heading">Board List Page</div> -->
            <!-- /.panel-heading -->
            <div class="panel-body">
<!--            <table width="100%" class="table table-striped table-bordered table-hover" id="dataTables-example"> -->
                <table class="table table-striped table-bordered table-hover" >
                    <thead>
                        <tr>
                            <th width="10%" style="min-width: 60px;">번호</th>
                            <th width="*"   style="min-width: 150px;">제목</th>
                            <th width="20%" style="min-width: 150px;">작성자</th>
                            <th width="15%" style="min-width: 150px;">작성시간</th>
                            <th width="15%" style="min-width: 150px;">수정시간</th>
                        </tr>
                    </thead> 
                    <!-- 추후 tbody채우기 -->
                    
                    <!-- 반복문. Controller를 타고 넘어온 model에 담긴 데이터를 JSTL을 이용하여 출렦한다. -->
                    <c:forEach items="${list}" var="board">
                    <tr align="center">
                      <td><c:out value="${board.bno }" /></td>
                      <%-- <td><c:out value="${board.title }" /></td> --%>
                      <%-- <td align="left"><a href="../board/get?bno=${board.bno}">${board.title }<a/></td> --%>
                      <td align="left"><a class="move" href="${board.bno}">${board.title }<a/></td>
                      <td><c:out value="${board.writer }" /></td>
                      <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${board.regdate }" /></td>
                      <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${board.updateDate }" /></td>
                    </tr>
                    </c:forEach>
                    
                </table>
                <!-- /.table-responsive -->
                
                <table width="100%">
                	<tr align="center">
                		<td align="right" width="100">
                			<button type="button" class="btn btn-primary" onclick="location.href='../board/register';">글쓰기</button>
                		</td>
                </table>
                
                <!-- start Search -->
                <div class='row'>
                  <div class="col-lg-12">
                
                  <form id='searchForm' action="/board/list" method='get'>
                    <select name='type'>
                      <option value="" <c:out value="${pageMaker.cri.type == null ? 'selected' : ''}"/>>------------선택------------</option>
                      <option value="T" <c:out value="${pageMaker.cri.type eq 'T' ? 'selected' : ''}"/>>제목</option>
                      <option value="C" <c:out value="${pageMaker.cri.type eq 'C' ? 'selected' : ''}"/>>내용</option>
                      <option value="W" <c:out value="${pageMaker.cri.type eq 'W' ? 'selected' : ''}"/>>작성자</option>
                      <option value="TC" <c:out value="${pageMaker.cri.type eq 'TC' ? 'selected' : ''}"/>>제목 or 내용</option>
                      <option value="TW" <c:out value="${pageMaker.cri.type eq 'TW' ? 'selected' : ''}"/>>제목 or 작성자</option>
                      <option value="TWC" <c:out value="${pageMaker.cri.type eq 'TWC' ? 'selected' : ''}"/>>제목 or 내용 or 작성자</option>
                    </select>
                    <input type='text' name='keyword' value='${pageMaker.cri.keyword}'/>
                    <input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'/>
                    <input type='hidden' name='amount' value='${pageMaker.cri.amount}'/>
                    <button class='btn btn-default'>검색</button>
                  </form>	
                  
                	
                  </div>
                </div>
                
                <!-- end Search -->
                
                
                <!-- start Pagination -->
                <div align="center" >
			      <ul class="pagination ">
			   
			      	<c:if test="${pageMaker.prev}">
		              <li class="paginate_button previous"><a href="${pageMaker.startPage -1 }">이전</a>
		              </li>
		            </c:if>
		
		            <c:forEach var="num" begin="${pageMaker.startPage}"
		              end="${pageMaker.endPage}">
		              <li class="paginate_button ${pageMaker.cri.pageNum == num ? "active" : "" }"><a href="${num}">${num}</a></li>
		            </c:forEach>
		
		            <c:if test="${pageMaker.next}">
		              <li class="paginate_button next"><a href="${pageMaker.endPage +1 }">다음</a></li>
		            </c:if>
			      	
			      </ul>
				</div>
				<!-- end Pagination -->
				
				<form id='actionForm' action="/board/list" method='get'>
					<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
					<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
					<input type='hidden' name='type' value='${pageMaker.cri.type}'>
					<input type='hidden' name='keyword' value='${pageMaker.cri.keyword}'>
				</form>
                
            </div>
            <!-- /.panel-body -->
        </div>
        <!-- /.panel -->
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<script type="text/javascript">
$(document).ready(function() {
	
  /* form태그 */
  var actionForm = $("#actionForm");

  /* 페이지번호인 a태그를 클릭했을때 */
  $(".paginate_button a").on("click",function(e) {
        /* a태그의 원래 동작은 막고 */
		e.preventDefault();

		console.log('click');
		console.log("${pageMaker.cri.pageNum}");
        /* form태그에서 페이지번호 클릭시 동작 처리를 담당하도록 javascript로 처리함. form태그내 pageNum값이 href의 속성값이 됨!(쿼리스트링 pageNum=1&amount=10 생성!) */
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
        
        /* 아래줄 매우 중요!! 바로 아래의 /board/get 화면으로 가는 클릭이벤트에서도 쓰이는 actionForm 이므로! */
		actionForm.attr("action", "/board/list");
        
        /* actionForm 자체를 submit() */
		actionForm.submit();
  });
  
  /* 글제목 클릭시 */
  $(".move").on("click",function(e) {
        /* a태그의 원래 동작은 막고 */
		e.preventDefault();

		console.log('click');
		
		/* 기존에 id가 bno인 input태그가 있을 경우 값을 초기화 */
		if ($('#bno').val()) {
			console.log($('#bno').val());
			$('#bno').remove();
		}
        /* form태그에서 페이지번호 클릭시 동작 처리를 담당하도록 javascript로 처리함. form태그내 pageNum값이 href의 속성값이 됨!(쿼리스트링 pageNum=1&amount=10 생성!) */
		actionForm.append("<input id='bno' type='hidden' name='bno' value='" + $(this).attr("href") + "'>");
		console.log($('#bno').val());
        actionForm.attr("action", "/board/get");
        /* actionForm 자체를 submit() */
		actionForm.submit();
  });
  
  
});		

/* 검색  버튼의 이벤트 처리 */
var searchForm = $("#searchForm");

$("#searchForm button").on("click", function(e){
	  
	  e.preventDefault();
	  console.log('click');
	  if(!searchForm.find("option:selected").val()){
		  alert("검색종류를 선택하세요");
		  return false;
	  }
	  
	  if(!searchForm.find("input[name='keyword']").val()){
		  alert("키워드를 입력하세요");
		  return false;
	  }
	  
	  /* 브라우저에서 검색버튼을 클릭하면 <form>태그의 전송은 막고, 페이지의 번호는 1이 되도록 처리한다. 화면에서 키워드가 없다면 검색버튼을 눌러도 검색을 하지 않도록 제어한다. */
	  searchForm.find("input[name='pageNum']").val("1");
	  
	  searchForm.submit();
	  
});
</script>
            
<%@include file="../includes/footer.jsp" %>                
