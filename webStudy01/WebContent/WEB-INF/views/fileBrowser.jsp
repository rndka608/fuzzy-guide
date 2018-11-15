<%@page import="kr.or.ddit.web.model2.FileListGenerator"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
	FileListGenerator fig = new FileListGenerator();
	//서블릿에 있는 파일리스트를 가져온다.
	File[] files = (File[])request.getAttribute("files");
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	
	function moveFile(fileAddr){
		var fform = document.fileForm;
		fform.fileAddress.value = fileAddr;
		fform.submit();
	}
	
</script>
</head>
<body>
	<form name="fileForm" action="<%=request.getContextPath()%>/fileBrowser.do"> 
	<ul>
	<%
		for(File tmp : files){
			String url =tmp.getAbsolutePath();
			url = url.replaceAll("\\\\", "/");
			if(tmp.isDirectory()){
		%>
			<li><a href="javascript:moveFile('<%=url %>');"><%=tmp.getName() %></a></li>		
		<% 	
		} else {
		%>
			<li><a href="void(0)" onclick="alert('폴더없음');return false;"><%=tmp.getName() %></a></li>			
		<% 
		}
		}
	%>
	</ul>
	<%
		String backurl = files[0].getParentFile().getAbsolutePath();
		backurl = backurl.substring(0, backurl.lastIndexOf("\\"));
		backurl = backurl.replaceAll("\\\\","/");
		
		if(backurl.contains("WebContent")){
		%>
			<a href="javascript:moveFile('<%=backurl%>');">뒤로가기</a>
		<%
		}
		%>
	<input value="" name="fileAddress" type="hidden"/>		
	</form>
</body>
</html>