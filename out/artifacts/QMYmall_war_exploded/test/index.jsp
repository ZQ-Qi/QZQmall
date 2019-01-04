<%--
  Created by IntelliJ IDEA.
  User: QZQ
  Date: 2018-12-21
  Time: 10:40
  To change this template use File | Settings | File Templates.
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
    <script src="../js/jquery.min.js"></script>
    <script src="testjs.js"></script>
</head>
<body>
<!-- AJAX方式下不需要用表单来提交数据,因此不用写表单标签 -->
<!-- AJAX方式不需要name属性，需要id属性 -->
输入用户名后，当光标离开用户名输入框，即响应onblur事件。
用户名：<input type="text" id="username" onblur="verify()"/>
密   码：<input type="text" id="password"/>

<!-- 这个div用来存入服务器返回的信息，开始为空 -->
<!-- id属性定义是为了利用dom的方式找到一个节点进行操作 -->
<div id="result"></div>

</body>
</html>
