<%@ page language="java" contentType="text/html; charset=utf-8"
   %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>百度搜索</title>
<style>
 #mydiv{position:absolute;top:50%;left:50%;margin-left:-200px;margin-top:-50px}
 .mouseOver{background:#708090;color:#fffafa}
 .mouseOut{background:#fffafa;color:#000000}
</style>
</head>
<body>
   <div id="mydiv">
      <!--   输入框 -->
      <input type="text" size="50" id="keyword" onkeyup="getMoreContents()" onblur="keywordBlur()" onfocus="getMoreContents()" />
      <input type="button" width="50rpx" value="百度一下"/>
	   <!--    弹出内容的区域 -->
	   <div id="popDiv">
	      <table id="content_table" background= '#FFFAFA' border='0' cellspacing='0' cellpadding='0'>
	         <tbody id='content_table_body'>
	         </tbody>
	      </table>
	   </div>
   </div>
   
   
<script src="js/jquery-1.11.1.js"></script>
<script type="text/javascript">
	  
	//   js原生写法
	  var xmlHttp;
	  //获得用户关联信息
	  function getMoreContents(){
		  var content=document.getElementById("keyword");
		  //还要判断为不为空，为空什么都不用干
		  if(content.value==""){
			  clearContent();
			  return;
		  }
		  //给服务器发送用户输入的内容
	      xmlHttp=createXMLHttp();
	      
	      //用get方式在url里传数据，escape1防止中文乱码
	      var url="search?keyword="+escape(content.value);
	      
	      //true表示javascript脚本会在send()方法之后执行，而不会等待来自服务器的响应
	      xmlHttp.open("GET",url,true);
	      
	      //xmlHttp绑定回调方法，在xmlHttp状态改变时被调用
	      //xmlHttp的状态0-4，我们只关心4（complete）这个状态，因为只有在数据传输完成之后，调用才有意义
	      xmlHttp.onreadystatechange=callback;
	      xmlHttp.send(null);
	      
	  }
	  
	  //获取XMLHttpRequest()兼容IE的写法
	  function createXMLHttp(){
		  var xmlHttp;
		  if(window.XMLHttpRequest){
			  xmlHttp=new XMLHttpRequest();//兼容IE7及更高级浏览器
		  }else{
			  xmlHttp=new XMLHttpRequest();//兼容IE5、6
		  }
		  return xmlHttp;
	  }
	  
	  //写回调函数
	  function callback(){
		  //4代表完成
		  if(xmlHttp.readyState==4){
			  if(xmlHttp.status==200){
				  
				  //交互成功，获得相应的数据，为json格式（文本格式）
				  var result=xmlHttp.responseText;
				  
				  //解析获得的数据
				  var json=eval("("+result+")");
				  //获得数据之后，就可以动态的显示这些数据了
				  setContent(json);
			  }
		  }
	  }
	  
  //设置相关数据的展示，参数代表的是服务器传递过来的相关数据
	  function setContent(contents){
		  clearContent();
		  //首先获得关联数据的长度，以此来确定生成多少行
		  var size=contents.length;
	
		  //设置内容
		  for(var i=0;i<size;i++){
			  
			  //代表json格式数据的第i个元素
			  var nextNode=contents[i];
			  
			  var tr=document.createElement('tr');
			  var td=document.createElement('td');
			  tr.setAttribute("border","0");
			  td.setAttribute("background","#FFFAFA");
			  
			  td.onmouseover=function(){
				  this.className="mouseOver";
			  };
			  td.onmouseout=function(){
				  this.className="mouseOut";
			  };
			  td.onclick=function(){
			  //此方法实现点击弹出内容后，显示在输入框
			  	
			  }
			  
			  var text=document.createTextNode(nextNode);//可不可以直接写nextNode???
		      td.appendChild(text);
			  tr.appendChild(td);
			  document.getElementById('content_table_body').appendChild(tr);
		  }
		  setLoction();
		  
	  }
  	  function clearContent(){
  		  var contentTableBody = document.getElementById("content_table_body");
  		  var size = contentTableBody.childNodes.length;
  		  for(var i = size-1;i>=0;i--){
  			contentTableBody.removeChild(contentTableBody.childNodes[i]);
  		  }
  		 popDiv.style.border="none";
  	  }
  	  
  	  //当输入框失去焦点
  	  function keywordBlur(){
  		clearContent();
  	  }
  	  
  	  //设置弹框位置样式
  	  function setLoction(){
  		  var keyword = document.getElementById('keyword');
  		  var popDiv = document.getElementById('popDiv');
  		  var content_table = document.getElementById('content_table');
  		  var width = keyword.offsetWidth;
  		  var top = keyword.offsetTop;
  		  var left = keyword.offsetLeft;
  		  var height = keyword.offsetHeight;
  		  popDiv.width = width + 'px';
		  popDiv.top = top + width + 'px';
		  popDiv.left = left+ 'px';
		  content_table.width = top + width + 'px';
		  popDiv.style.border= "1px solid #000000";
  	  }
</script>
</body>
</html>
