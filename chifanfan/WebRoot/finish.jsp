<%@ page language="java" import="java.util.*"  pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page language="java" %> 


<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>已经成功点餐</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
    <%
	request.setCharacterEncoding("unicode") ;// 设置的是统一编码
	String menu = request.getParameter("menu");
	String telnum = request.getParameter("telnum");
	%>
	<h2>您的手机号尾数是：<%=telnum %></h2>
	
	<%
	try{
		Class.forName("org.gjt.mm.mysql.jdbc.Driver").newInstance(); 
	}catch(ClassNotFoundException e){
		e.printStackTrace();
	}  
	String url ="jdbc:mysql://localhost:3306/chifanfan?user=root&password=1234" ;
	
	Connection conn= DriverManager.getConnection(url);   
	Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);   
	String sqlfind = "select foodname,price from food where guid =" + menu;
	ResultSet nameandprice = stmt.executeQuery(sqlfind);
	if(telnum.length()!=4){
	%>
	<h3>请输入四位手机尾数</h3>
	<script language="javascript" type="text/javascript">
		function goback(){history.back();}
		setInterval(goback,1000);
	</script>
	
	<%
	}
	else if(nameandprice.next()){
		String sql="insert into orderform values("+Integer.parseInt(telnum)+"," + '"'+ nameandprice.getString("foodname")+ '"' + ","+nameandprice.getString("price")+")";   
		
		try{
			stmt.execute(sql);  //如果订餐失败，这句话会抛出异常，就不会把订餐成功这句话打印出来了 
			
			out.print("您已经成功订餐！");	
			
		}catch(SQLException e){
			e.printStackTrace();
			out.print("订餐失败，可能是由于您今天已经订过了");
		}
		
	}
	else{
%>
	<h3>您没有选择任何食物，难度不饿吗，再给你次机会吧</h3>
	<script language="javascript" type="text/javascript">
		function goback(){history.back();}
		setInterval(goback,2500);
	</script>
<%
	}
	
	 
	nameandprice.close();   
	stmt.close();   
	conn.close();   
	%>   
  </body>
</html>
