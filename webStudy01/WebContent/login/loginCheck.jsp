<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 1. 파라미터 확보 -->
<!-- 2. 검증(필수 데이터) -->
<!-- 3. 불통 -->
<!-- 	이동(loginForm.jsp, 기존에 입력했던 아이디를 그대로 전달할 수 있는 방식.) -->
<!-- 4. 통과 -->
<!-- 	4-1. 인증(아이디==비번) -->
<!-- 	4-2. 인증 성공 : 웰컴 페이지로 이동(원본 요청을 제거하고 이동) -->
<!-- 	4-3. 인증 실패 : 이동(loginForm.jsp, 기존에 입력했던 아이디를 그대로 전달할 수 있는 방식. ) -->

<%
	request.setCharacterEncoding("UTF-8"); //특수문자가 들어올 수도 있으니까 인코딩해준다.
	
	String id = request.getParameter("mem_id"); 
	String pass = request.getParameter("mem_pass");
	String goPage = null; // 도착지 설정
	//검증
	boolean redirect = false;
	if(id==null || id.trim().length()==0 ||pass==null || pass.trim().length()==0 ){
// 		goPage = "/login/loginForm.jsp?error=1";
		goPage = "/login/loginForm.jsp";
		redirect = true;
		session.setAttribute("error", 1);
		session.setAttribute("message", "아이디나 비번 누락");
	}else{
		if(id.equals(pass)){
			goPage = "/";
			redirect = true;
			session.setAttribute("authMember", id);
		}else{
// 			goPage = "/login/loginForm.jsp?error=1";		
			goPage = "/login/loginForm.jsp";		
			redirect = true;
		session.setAttribute("error", 1);
		session.setAttribute("message", "비번 오류로 인증 실패");
		}
		
	}	
	if(redirect){
		response.sendRedirect(request.getContextPath() + goPage);
	}else{
		RequestDispatcher rd = request.getRequestDispatcher(goPage);
		rd.forward(request, response); //request안에는 파라미터가 들어있음 그 파라미터를 고스란히 도착지쪽으로 넘겨준다.
	}
	
	
%>	