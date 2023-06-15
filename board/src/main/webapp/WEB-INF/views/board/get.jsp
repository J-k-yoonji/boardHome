<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>    
    
<%@include file="../includes/header.jsp" %>        

<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">글상세</h1>
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
            
               <div class="form-group">
                 <label>제목</label> <input class="form-control" name='title' value="${board.title}" readonly="readonly"/>
               </div>
               <div class="form-group">
                 <label>내용</label> 
                 <textarea class="form-control" rows="5" name='content' readonly="readonly"><c:out value="${board.content}"/></textarea>
               </div>
               <div class="form-group">
                 <label>작성자</label> <input class="form-control" name='writer' value="${board.writer}" readonly="readonly"/>
               </div>
               <%-- <button data-oper='modify' type="submit" class="btn btn-info" onclick="location.href='../board/modify?bno=${board.bno}';">수정</button> --%>
               
               <form name="myForm" action="/board/remove?bno=${board.bno}" method="POST"></form>
			   
			   <button type="button" class="btn btn-info" onclick="location.href='../board/modify?bno=${board.bno}&pageNum=${cri.pageNum}&amount=${cri.amount}&type=${cri.type}&keyword=${cri.keyword}';">수정</button>
               <button type="button" class="btn btn-danger" onclick="if(!confirm('삭제하시면 복구할 수 없습니다. \n정말로 삭제하시겠습니까?')){return false;}; javascript:document.myForm.submit();">삭제</button>
               <button type="button" class="btn btn-secondary" onclick="location.href='../board/list?pageNum=${cri.pageNum}&amount=${cri.amount}&type=${cri.type}&keyword=${cri.keyword}';">목록으로</button>

               
<!--                <script type="text/javascript">
			   $(document).ready(function() {
				   var formObj = $("form");
			   	   $('button').on("click", function(e){
			   		   e.preventDefault();
			   	   	   
			   		   var operation = $(this).data("oper");
			   		   
			   		   console.log(operation);
			   		   
			   		   if(operation === 'remove'){
			   			   formObj.attr("action", "/board/remove");
			   		   }else if(operation === 'list'){
			   			   // move to list
			   			   formObj.attr("action", "/board/list").attr("method", "get");
			   			   formObj.empty();
			   		   }else {
			   			   formObj.submit();
			   		   }
			   	   });
			   });
			   </script>   --> 

            </div>
            <!-- /.panel-body -->
        </div>
        <!-- /.panel -->
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class='row'>

  <div class="col-lg-12">
	
	<!-- /.panel -->
	<div class="panel panel-default">
	  <div class="panel-heading">
	  	<i class="fa fa-comments fa-fw"></i> Reply
	  	<button id='addReplyBtn' class='btn btn-primary btn-xs pull-right'>New Reply
	  	</button>
	  </div>
	  
	  <!-- /.panel-heading -->
	  <div class="panel-body">
	  
	  	<ul class="chat">
	  	  <!-- start reply -->
<!-- 	  	  <li class="left clearfix" data-rno='11'>
	  	    <div>
	  	      <div class="header">
	  	      	<strong class="primary-font">user00</strong>
	  	      	<small class="pull-right text-muted">2018-01-01 13:13 </small>
	  	      </div>
	  	      <p>Good job!</p>
	  	    </div>
	  	  </li> -->
	  	  <!-- end reply -->
	  	</ul>
	  	<!-- ./ end ul -->
	  </div>
	  <!-- /.panel .chat-panel -->
	  
	  <div align="center" class="panel-footer">
	  
	  </div>
	  
	  
	  
	</div>	
  </div>
  <!-- ./end row -->
</div>

<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">Reply Modal</h4>
            </div>
            <div class="modal-body">
              <div class="form-group">
                <label>Reply</label>
                <input class="form-control" name='reply' value='New Reply!!!!'>
              </div>
              <div class="form-group">
                <label>Replyer</label>
                <input class="form-control" name='replyer' value='replyer'>
              </div>
              <div class="form-group">
                <label>Reply Date</label>
                <input class="form-control" name='replyDate' value='2023-01-01 12:12'>
              </div>
            </div>
            
            <div class="modal-footer">
                <button id='modalModBtn' type="button" class="btn btn-warning">Modify</button>
                <button id='modalRemoveBtn' type="button" class="btn btn-danger">Remove</button>
                <button id='modalRegisterBtn' type="button" class="btn btn-primary">Register</button>
                <button id='modalCloseBtn' type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->

<script type="text/javascript" src="/resources/js/reply.js"></script>

<script>
//console.log("JS TEST");

//replyService.add({});
$(document).ready(function() {
	
  console.log(replyService);
	
  var bnoValue = '<c:out value="${board.bno}"/>';
  var replyUL = $(".chat"); // 댓글 목록 ul 태그.
  
    showList(1);
    
    function showList(page){
    	
      console.log("show list " + page);
    	
      replyService.getList({bno:bnoValue, page: page|| 1 }, function(replyCnt, list) {
    	  
    	console.log("replyCnt: " + replyCnt);
    	console.log("list: " + list);
    	console.log(list);
    	
    	// page번호가 -1로 전달되면 마지막페이지를 찾아서 다시 호출하게 된다.
    	if(page == -1){
    		pageNum = Math.ceil(replyCnt/10.0);
    		showList(pageNum);
    		return;
    	}
    
    	var str=""; //초기화.
    	
    	if(list == null || list.length == 0){
    	  // replyUL.html(""); 댓글페이징 처리하면서 주석처리함. why??
    	  return;
    	}
    	
    	for (var i = 0, len = list.length || 0; i < len; i++) {
    		str += "<li class='left clearfix' data-rno='"+list[i].rno+"'>";
    		str += "  <div><div class='header'><strong class='primary-font'>"+list[i].replyer+"</strong>";
    		str += "  <small class='pull-right text-muted'>" + replyService.displayTime(list[i].replyDate) + "</small></div>";
    		str += "   <p>"+ list[i].reply + "</p></div></li>";
    	}
    	
    	replyUL.html(str);
    	
    	showReplyPage(replyCnt); // 댓글페이징 처리하면서 추가함. 페이지 추가. why?? 
    	
      }); //end function
      
    } //end showList 
    
    // 댓글페이징을 위해 showReplyPage 추가.
    var pageNum = 1;
    var replyPageFooter = $(".panel-footer");
    
    function showReplyPage(replyCnt){
    	var endNum = Math.ceil(pageNum / 10.0) * 10;
    	var startNum = endNum - 9;
    	
    	var prev = startNum != 1;
    	var next = false;
    	
    	if(endNum * 10 >= replyCnt){
    		endNum = Math.ceil(replyCnt/10.0);
    	}
    	
    	if(endNum * 10 < replyCnt){
    		next = true;
    	}
    	
    	var str = "<ul class='pagination'>";
    	
    	if(prev){
    		str+= "<li class='page-item'><a class='page-link' href='"+(startNum -1)+"'>Previous</a></li>";
    	}
    	
    	for(var i = startNum ; i <= endNum; i++){
    		
    		var active = pageNum == i? "active":"";
    		
    		str += "<li class='page-item "+active+" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";
    	}
    	
    	if(next){
    		str+= "<li class='page-item'><a class='page-link' href='" +(endNum + 1)+"'>Next</a></li>";
    	}
    	
    	str += "</ul></div>";
    	
    	console.log(str);
    	
    	replyPageFooter.html(str);
    }
    
    replyPageFooter.on("click", "li a", function(e){
    	e.preventDefault();
    	console.log("page click");
    	
    	var targetPageNum = $(this).attr("href");
    	
    	console.log("targetPageNum: " + targetPageNum);
    	
    	pageNum = targetPageNum;
    	
    	showList(pageNum);
    });
    
    var modal = $(".modal");
    var modalInputReply = modal.find("input[name='reply']");
    var modalInputReplyer = modal.find("input[name='replyer']");
    var modalInputReplyDate = modal.find("input[name='replyDate']");
    
    var modalModBtn = $("#modalModBtn");
    var modalRemoveBtn = $("#modalRemoveBtn");
    var modalRegisterBtn = $("#modalRegisterBtn");
    
    //New Reply버튼 클릭시. 입력에 필요없는 항목들은 안 보이게 처리하고 모달창을 보이게 함.
    $("#addReplyBtn").on("click", function(e){
    	
    	modal.find("input").val(""); // modal내 input 태그의 값을 모두 ""으로 비워줌.
    	modalInputReplyDate.closest("div").hide(); // replyDate값을 가진 input태그가 들어있는 div를 통째로 안보이게 해줌!  
    	modal.find("button[id != 'modalCloseBtn']").hide(); // 모달창 닫기버튼 빼고 다 숨긴 후,
    	
    	modalRegisterBtn.show(); // 댓글 등록 버튼만 추가로 보이게 해줌.
    	
    	$(".modal").modal("show");
    	
    });
    
    // 새 댓글 추가 (등톡 버튼 클릭시) 처리
    modalRegisterBtn.on("click", function(e){
    	
        var reply = {
        	  reply: modalInputReply.val(),
        	  replyer:modalInputReplyer.val(),
        	  bno:bnoValue
        };
        
        replyService.add(reply, function(result){
        
        	alert(result);
        	
        	modal.find("input").val(""); // 추가 후 모든 input태그내 값을 비워줌.
        	modal.modal("hide"); // 모달창 닫음.
        	
        	// showList(1); // 댓글을 정상적으로 추가 처리한 후, 댓글 목록까지 갱신해줘서 화면에 새 댓글이 보이게 해줌.
        	showList(-1); // 댓글페이징 처리하면서 변경! 댓글 추가 후 우선 전체 댓글 숫자파악하게 한 후, 다시 마지막 페이지를 호출해서 이동시킴!
        	
        });
    });
    
    // 댓글 조회 클릭이벤트 처리
    $(".chat").on("click", "li", function(e){
    	var rno = $(this).data("rno");
    	//console.log(rno);
    	replyService.get(rno, function(reply){
    		modalInputReply.val(reply.reply);
    		modalInputReplyer.val(reply.replyer);
    		modalInputReplyDate.val(replyService.displayTime( reply.replyDate)).attr("readonly","readonly");
    		modal.data("rno", reply.rno);
    		
    		modal.find("button[id != 'modalCloseBtn']").hide();
    		modalModBtn.show();
    		modalRemoveBtn.show();
    		
    		$(".modal").modal("show");
    		
    	});
    });
    
    // 댓글 수정 (페이징처리 추가 후 댓글 수정시에도 현재 보고있는 댓글이 포함된 페이지로 이동하도록 showList(1)를 showList(pageNum)으로 수정함.)
    modalModBtn.on("click", function(e){
    	var reply = {rno:modal.data("rno"), reply:modalInputReply.val()};
    	
    	replyService.update(reply, function(result){
    		
    		alert(result);
    		modal.modal("hide");
    		//showList(1); 
    		showList(pageNum); // 현재 보고있는 댓글 페이지의 번호를 호출
    	});
    });
    
    // 댓글 삭제 (페이징처리 추가 후 댓글 삭제시에도 현재 보고있는 댓글이 포함된 페이지로 이동하도록 showList(1)를 showList(pageNum)으로 수정함.)
    modalRemoveBtn.on("click", function(e){
    	var rno = modal.data("rno");
    	
    	replyService.remove(rno, function(result){
    		
    		alert(result);
    		modal.modal("hide");
    		//showList(1);
    		showList(pageNum); // 현재 보고있는 댓글 페이지의 번호를 호출
    		
    	});
    });
    
    
  
});

//댓글추가 테스트
/* replyService.add(
	{reply:"JS TEST", replyer:"tester", bno:bnoValue}
	,
	function(result){
		alert("RESULT: " + result);
	}
);  */

//댓글목록 테스트
/* replyService.getList({bno:bnoValue, page:1}, function(list){
	for(var i =0, len = list.length||0; i < len; i++ ){
		console.log(list[i]);
	}
}); */

//22번 댓글 삭제 테스트
/* replyService.remove(22, function(count) {
	
	console.log(count);
	
	if (count === "success") {
		alert("REMOVED");
	}
}, function(err) {
	alert('ERROR...');
}); */

//21번 댓글 수정 테스트
/* replyService.update({
	rno : 21,
	bno : bnoValue,
	reply : "Modified Reply...."
}, function(result) {
	
	alert("수정 완료...");
	
}); */

//특정 번호 댓글 조회 테스트. get.jsp에서는 단순히 댓글의 번호만을 전달한다.
/* replyService.get(10, function(data){
	console.log(data);
}); */


$(document).ready(function() {
//	console.log(replyService);
});
</script>
           
<%@include file="../includes/footer.jsp" %>                
