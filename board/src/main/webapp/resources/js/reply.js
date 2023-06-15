console.log("Reply Module........");

var replyService = (function(){
	
	// 댓글 추가. add 메서드(함수)
	function add(reply, callback){
		console.log("add reply.........");
		
		$.ajax({
			type : 'post',
			url : '/replies/new',
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
				if (callback) {
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		})
	}
	
	// 댓글 목록. json으로 가져옴!
	function getList(param, callback, error) {
		var bno = param.bno;
		var page = param.page || 1;
		
		$.getJSON("/replies/pages/" + bno + "/" + page + ".json",
			function(data) {
			  if (callback) {
				  //callback(data); // 댓글 목록만 가져오는 경우
				  callback(data.replyCnt, data.list); // 댓글 숫자와 목록을 가져오는 경우 (댓글페이징 처리를 위해 변경!)
			  } 
		    }).fail(function(xhr, status, err) {
		  if (error) {
				error();
		  }
		});
	}
	
	// 댓글 삭제. DELETE방식으로 해당 URL을 호출하는 것뿐! remove() 함수 추가.
	function remove(rno, callback, error) {
		$.ajax({
			type : 'delete',
			url : '/replies/' + rno,
			success : function(deleteResult, status, xhr) {
				if (callback) {
					callback(deleteResult);
				}
			},
			error : function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		});
	}
	
	// 댓글 수정. 
	function update(reply, callback, error) {
		
		console.log("RNO: " + reply.rno);
		
		$.ajax({
			type : 'put',
			url : 'replies' + reply.rno,
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
				if (callback) {
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		});
	}
	
	// 댓글 조회. GET방식으로 동작.
	function get(rno, callback, error) {
		$.get("/replies/" + rno + ".json", function(result) {
			if (callback) {
				callback(result);
			}
		}).fail(function(whr, status, err) {
			if (error) {
				error();
			}
		});
	}
	
	
	// 시간에 대한 처리 (p.417)
	function displayTime(timeValue) {
		var today = new Date();
		var gap = today.getTime() - timeValue;  //  .getTime() 으로 얻어온 값 : millisecond 즉 1/1000초. 참고로 음수가 나타날 경우 1970년 이전을 의미
		var dateObj = new Date(timeValue);
		var str = "";
		
		if (gap < (1000 * 60 * 60 * 24)) {  // 오늘시간에서 해당댓글작성시간을 뺀 값이 하루이상 차이가나지 않는다면. (24시간이 지난 댓글은 날짜만 표시.)
			
	      var hh = dateObj.getHours();
		  var mi = dateObj.getMinutes();
		  var ss = dateObj.getSeconds();
			
		  return [ (hh > 9 ? '' : '0') + hh, ':', (mi > 9 ? '' : '0') + mi, 
		    	                             ':', (ss > 9 ? '': '0') + ss ].join('');
		} else {
		    var yy = dateObj.getFullYear();
		    var mm = dateObj.getMonth() + 1; // getMonth() is zero-based
		    var dd = dateObj.getDate();
		    
		    return [ yy, '/', (mm > 9 ? '' : '0') + mm, '/', (dd > 9 ? '' : '0') + dd ].join('');
		}
	}
	;
	
	return { 
   		 add : add, 
		 getList : getList, 
		 remove : remove,	
		 update : update,
		 get : get,
		 displayTime : displayTime
    };
	
})();

