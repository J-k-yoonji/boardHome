<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>    
    
<%@include file="../includes/header.jsp" %>        

<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">글수정</h1>
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
<!--             <div class="panel-heading">Board Register</div> -->
            <!-- /.panel-heading -->
            <div class="panel-body">
            
               <form role="form" action="/board/modify" method="post">
               <!-- 추가 -->
               <input type='hidden' name='pageNum' value='${cri.pageNum}'>
			   <input type='hidden' name='amount' value='${cri.amount}'>
			   <input type='hidden' name='type' value='${cri.type}'>
			   <input type='hidden' name='keyword' value='${cri.keyword}'>
			   
               <div class="form-group">
                 <input type="hidden" class="form-control" name='bno' value="${board.bno}" />
               </div>
               <!-- 날짜 2개 포맷적용 안할시 '400 – Bad Request' 에러남! -->
               <div class="form-group">
                 <input type="hidden" class="form-control" name='regdate' value='<fmt:formatDate pattern = "yyyy/MM/dd" value = "${board.regdate}" />' />
               </div>
               <div class="form-group">
                 <input type="hidden" class="form-control" name='updateDate' value='<fmt:formatDate pattern = "yyyy/MM/dd" value = "${board.updateDate}" />' />
               </div>
               <div class="form-group">
                 <label>제목</label> <input id="title" class="form-control" name='title' value="${board.title}" />
               </div>
               <div class="form-group">
                 <label>내용</label> 
                 <textarea id="content" class="form-control" rows="5" name='content' ><c:out value="${board.content}"/></textarea>
               </div>
               <div class="form-group">
                 <label>작성자</label> <input class="form-control" name='writer' value="${board.writer}" readonly="readonly"/>
               </div>
               
               
               <%-- <button type="submit" data-oper='modify' class="btn btn-info" onclick="location.href='../board/modify?bno=${board.bno}';">수정</button> --%>
               <!-- <button type="submit" data-oper='modify' class="btn btn-success">수정완료</button> -->
               <button type="submit" class="btn btn-success" onClick="return validateForm()">수정 완료</button>
               <button type="button" class="btn btn-danger" onclick="if(!confirm('삭제하시면 복구할 수 없습니다. \n정말로 삭제하시겠습니까?')){return false;}; javascript:document.myForm.submit();">삭제</button>
               <button type="submit" class="btn btn-secondary" onclick="location.href='../board/list?pageNum=${cri.pageNum}&amount=${cri.amount}&type=${cri.type}&keyword=${cri.keyword}';">목록으로</button>
               <!-- <button type="button" class="btn btn-secondary" onclick="location.href='../board/list';">목록으로</button> -->
               </form>
               
               <form name="myForm" action="/board/remove?bno=${board.bno}" method="POST"></form>

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

}); 
 
 // 게시글 전체 업로드 함수
 function validateForm() {
	 var formObj = $("form");
     if ($('#title').val() == "") {
         alert("제목을 입력해주십시오");
         $('#title').focus();
         return false;
     } else if ($('#content').val() == "") {
         alert("내용을 입력해주십시오");
         $('#content').focus();
         return false;
     } else {
         alert(" 글수정이 완료되었습니다! ");

		 formObj.attr("action", '/board/modify');
		 formObj.submit();

     }
 }
</script>
           
<%@include file="../includes/footer.jsp" %>                
