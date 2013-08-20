<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; utf-8">
<title>今天的订餐结果如下</title>
</head>
<body>
<% 
	try{
		Class.forName("org.gjt.mm.mysql.jdbc.Driver").newInstance(); 
	}catch(ClassNotFoundException e){
		e.printStackTrace();
	}  
	String url ="jdbc:mysql://localhost:3306/chifanfan?user=root&password=1234" ;
	
	Connection conn= DriverManager.getConnection(url);   
	Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);   
	String sqlfind = "select count(food) as cnt, food ,price from orderform group by food";
	ResultSet rs = stmt.executeQuery(sqlfind);
	int total = 0;
	String summary = "";
	while(rs.next()){
		total += Integer.parseInt(rs.getString("cnt"));
		summary += rs.getString("cnt");
		summary += "份";
		summary += rs.getString("food");
		summary += "，";
	}
	%>
<h2><%=summary %>一共<%=total %>份</h2>
<%
	rs.close();   
	stmt.close();   
	conn.close();   
%>  

<script type="text/javascript">
		function copytoclip()  
		{  
			var obj = document.getElementsByTagName("h2");
		    window.clipboardData.setData('text', obj[0].innerHTML);  
		    alert("复制成功");  
		} 
</script>

<button id="tt" onclick="copytoclip()">点击复制</button>
</body>
</html>