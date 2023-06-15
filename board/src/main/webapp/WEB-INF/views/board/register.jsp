<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>    
    
<%@include file="../includes/header.jsp" %>        

<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">글작성</h1>
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
            
            <script type="text/javascript">
            	function validateForm(form) { // 필수 입력 항목 확인
            		if (form.title.value == "") {
            			alert("제목을 입력하세요.");
            			form.title.focus();
            			return false;
            		}
            		else if (form.content.value == "") {
            			alert("내용을 입력하세요.");
            			form.content.focus();
            			return false;
            		}
            		else if (form.writer.value == "") {
            			alert("작성자를 입력하세요.");
            			form.writer.focus();
            			return false;
            		} else {
            	         alert(" 글작성이 완료되었습니다! ");

            			 formObj.submit();

            	    }
            	}
            </script>
            
             <form name="writeFrm" role="form" action="/board/register" 
                   method="post" onsubmit="return validateForm(this);">    
               <div class="form-group">
                 <label>제목</label> <input class="form-control" name='title'/>
               </div>
               <div class="form-group">
                 <label>내용</label> <textarea class="form-control" rows="5" name='content'></textarea>
               </div>
               <div class="form-group">
                 <label>작성자</label> <input class="form-control" name='writer'/>
               </div>
               <button type="submit" class="btn btn-primary">작성완료</button>
               <button type="reset" class="btn btn-secondary">초기화</button>
               <button type="button" class="btn btn-secondary" onclick="location.href='../board/list.do';">목록으로</button>
             </form>          

            </div>
            <!-- /.panel-body -->
        </div>
        <!-- /.panel -->
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->
           
<%@include file="../includes/footer.jsp" %>                
