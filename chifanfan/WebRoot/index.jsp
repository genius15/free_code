<%@ page language="java" import="java.util.*"  pageEncoding="UTF-8" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>欢迎使用吃饭饭点餐系统</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
  </head>
  
  <body onload = "getMenu()">
    <% 
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("E"); 
		java.util.Date currentTime = new java.util.Date();//得到当前系统时间 
		String str_date1 = formatter.format(currentTime); //将日期时间格式化 
	%>
    <center><h2>今天是<%=str_date1 %>，请点餐</h2></center>
    
    <script language="javascript">
		var xmlHttp ;
		var sentence = document.getElementsByTagName("h2")[0].innerHTML;
		var day = sentence.substring(5,6);
		var dayalabo;
		if("一" == day){
			dayalabo = 1;
		}else
		if("二" == day){
			dayalabo = 2;
		}else
		if("三" == day){
			dayalabo = 3;
		}else
		if("四" == day){
			dayalabo = 4;
		}else
		if("五" == day){
			dayalabo = 5;
		}
		
		function createXMLHttp(){
			if(window.XMLHttpRequest){
				xmlHttp = new XMLHttpRequest() ;
			} else {
				xmlHttp = new ActiveXObject("Microsoft.XMLHTTP") ;
			}
		}
		function getMenu(){
			createXMLHttp() ;
			xmlHttp.open("POST","menu"+dayalabo+".xml") ;
			
			xmlHttp.onreadystatechange = getMenuCallback ;
			xmlHttp.send(null) ;
		}
		function getMenuCallback(){
			if(xmlHttp.readyState == 4){
				if(xmlHttp.status == 200){
					var allitems = xmlHttp.responseXML.getElementsByTagName("menu")[0].childNodes ;	// 取得全部的menu下的节点
					var select = document.getElementById("menuid") ;
					select.length = 1 ;	// 每次选择一个
					select.options[0].selected = true ;	// 第一个为选中的状态
					for(var i=0;i<allitems.length;i++){
						var item = allitems[i] ;
						var option = document.createElement("option") ;
						var food = item.getElementsByTagName("food")[0].firstChild.nodeValue ;
						var price = item.getElementsByTagName("price")[0].firstChild.nodeValue;
						var id = item.getElementsByTagName("id")[0].firstChild.nodeValue;
						option.setAttribute("value",id);
						option.appendChild(document.createTextNode(food+" "+price+"元")) ;
						select.appendChild(option) ;
					}
				}
			}
		}
	</script>
    <form action="finish.jsp" method="get">
    	<div>
    		<select name="menu" id="menuid">   
			       <option value="0">-请选择-</option> 
			             
		    </select>  <br>
		    	输入手机号后四位：
		    <input name = "telnum" type="text"/>
		    <input type="submit" value="提交"/> <br>   		
    	</div>
    </form>
  </body>
</html>
