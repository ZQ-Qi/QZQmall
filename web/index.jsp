<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%--
  Created by IntelliJ IDEA.
  User: QZQ
  Date: 2018-07-02
  Time: 15:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<%@ page import="DBTest" %>--%>
<html>
<head lang="en">
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="css/bootstrap.min.css"/>
  <link rel="stylesheet" href="css/flat-ui.min.css"/>
  <script src="js/jquery.min.js"></script>
  <script src="js/bootstrap.min.js"></script>
  <script src="js/flat-ui.min.js"></script>
  <title>图书商城</title>
  <style>
    .row{
      margin-top: 20px;;
    }
    .center{
      text-align: center;
    }
    .pagination{
      background: #cccccc;
    }
    img{
      width: 100%;
      height: 200px;
      display: block;
    }
    h3{
      font-size: 20px;
      height: 50px; /* 设置固定高度限制为2行，超高隐藏，防止因标题过长而导致各模块大小不一致*/
      overflow: hidden;
    }
  </style>
  <script>
      $(function(){
          $('#myTabs a').click(function (e) {
              $(this).tab('show')
          });
      })
  </script>
</head>
<body>
<%
  // 定义每个图书的bookid(GET方法跳转查书),bookname,price,picpath
  String[][] bookid = new String[4][8];
  String[][] bookname = new String[4][8];
  String[][] price = new String[4][8];
  String[][] picpath = new String[4][8];

  // 连接数据库，获取对应类别下图书数据
  String sql = "select bookid, bookname, price, picpath from book where category = ? ";
  Connection con = db.DBCPUtils.getConnection();
  PreparedStatement pstmt = con.prepareStatement(sql);
  // 检索不同分类下的图书，并将其信息记录于数组中

  pstmt.setString(1,"计算机");
  ResultSet resultSet = pstmt.executeQuery();
  int k = 0;
  for(int i=0;i<8;i++){
    if(resultSet.next()){
      bookid[k][i] = resultSet.getString("bookid");
      bookname[k][i] = resultSet.getString("bookname");
      price[k][i] = resultSet.getString("price");
      picpath[k][i] = resultSet.getString("picpath");
    }else{
      bookid[k][i] = "0000";
      bookname[k][i] = "N/A";
      price[k][i] = "0.00";
      picpath[k][i] = "img/book/0000.jpg";
    }
  }
  pstmt.setString(1,"外语学习");
  resultSet = pstmt.executeQuery();
  k = 1;
  for(int i=0;i<8;i++){
    if(resultSet.next()){
      bookid[k][i] = resultSet.getString("bookid");
      bookname[k][i] = resultSet.getString("bookname");
      price[k][i] = resultSet.getString("price");
      picpath[k][i] = resultSet.getString("picpath");
    }else{
      bookid[k][i] = "0000";
      bookname[k][i] = "N/A";
      price[k][i] = "0.00";
      picpath[k][i] = "img/book/0000.jpg";
    }
  }
  pstmt.setString(1,"经济管理");
  resultSet = pstmt.executeQuery();
  k = 2;
  for(int i=0;i<8;i++){
    if(resultSet.next()){
      bookid[k][i] = resultSet.getString("bookid");
      bookname[k][i] = resultSet.getString("bookname");
      price[k][i] = resultSet.getString("price");
      picpath[k][i] = resultSet.getString("picpath");
    }else{
      bookid[k][i] = "0000";
      bookname[k][i] = "N/A";
      price[k][i] = "0.00";
      picpath[k][i] = "img/book/0000.jpg";
    }
  }
  pstmt.setString(1,"社会科学");
  resultSet = pstmt.executeQuery();
  k = 3;
  for(int i=0;i<8;i++){
    if(resultSet.next()){
      bookid[k][i] = resultSet.getString("bookid");
      bookname[k][i] = resultSet.getString("bookname");
      price[k][i] = resultSet.getString("price");
      picpath[k][i] = resultSet.getString("picpath");
    }else{
      bookid[k][i] = "0000";
      bookname[k][i] = "N/A";
      price[k][i] = "0.00";
      picpath[k][i] = "img/book/0000.jpg";
    }
  }
  db.DBCPUtils.closeAll(resultSet,pstmt,con);
%>



<!-- Static navbar -->
<div class="navbar navbar-default navbar-static-top navbar-fixed-top" role="navigation">
  <div class="container">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#top_navi"></button>
      <a class="navbar-brand" href="index.jsp">图书商城</a>
    </div>
    <div class="navbar-collapse collapse" id="top_navi">
      <ul class="nav navbar-nav">
        <li class="active"><a href="index.jsp">首页</a></li>
        <li><a href="order.jsp">我的订单</a></li>
        <li><a href="userInfo.jsp">个人中心</a></li>
        <li><a href="friendLink.jsp">查找图书</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right hidden-sm">
        <%
          if(session.getAttribute("username")==null){
            out.println("<li><a href='login.jsp'>登录</a></li>");
            out.println("<li><a href='register.jsp'>注册</a></li>");
          }else{
            out.println("<li><a href='userInfo.jsp'>"+session.getAttribute("username").toString()+" 欢迎您</a></li>");
            out.println("<li><a href='logout.jsp'>退出</a></li>");
          }
        %>

        <li><a href="cart.jsp"><span class="glyphicon glyphicon-shopping-cart">购物车</span></a></li>
      </ul>
    </div><!--/.nav-collapse -->
  </div>
</div>
<!--content-->
<div class="container" style="margin-top: 7rem">
  <div class="jumbotron">
    <h1>图书商城</h1>
    <p>欢迎光临图书商城！</p>
    <p>作者：亓志强(15069130060)</p>
    <p><a class="btn btn-primary btn-lg" href="mailto:zq_qi1997@163.com" role="button">联系作者</a></p>
  </div>

  <div class="col">
    <nav class="navbar navbar-inverse navbar-embossed navbar-expand-lg" role="navigation">
      <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-collapse-01"></button>
        <a class="navbar-brand" href="#">图书分类</a>
      </div>
      <div class="navbar-collapse collapse" id="navbar-collapse-01">
        <%--<div class="collapse navbar-collapse" id="navbar-collapse-01">--%>
          <ul class="nav navbar-nav mr-auto">
            <li class="active" id="tab_1" ><a href="#">计算机</a></li>
            <li id="tab_2"><a href="#">外语学习</a></li>
            <li id="tab_3"><a href="#">经济管理</a></li>
            <li id="tab_4"><a href="#">社会科学</a></li>
          </ul>
        </div><!-- /.navbar-collapse -->
    </nav><!-- /navbar -->
  </div>


  <%--<ul class="nav nav-tabs" id="myTabs">--%>
    <%--&lt;%&ndash;加入data-toggle=tab目的为避免页面随靶点乱动&ndash;%&gt;--%>
    <%--<li class="active" id="tab_1"><a href="#" data-toggle="tab" >计算机</a></li>--%>
    <%--<li id="tab_2"><a href="#" data-toggle="tab">外语学习</a></li>--%>
    <%--<li id="tab_3"><a href="#" data-toggle="tab">经济管理</a></li>--%>
    <%--<li id="tab_4"><a href="#" data-toggle="tab">社会科学</a></li>--%>
  <%--</ul>--%>
  <div class="row" id="category_res"></div>

</div>
<!--footer-->
<div class="navbar navbar-default navbar-static-bottom" style="text-align: center">
  欢迎光临图书商城
</div>
</body>
<%--<script color="26,188,156" opacity="1" count="99" src="https://cdn.bootcss.com/canvas-nest.js/1.0.1/canvas-nest.js" type="text/javascript" charset="utf-8"></script>--%>
<script type="text/javascript">
    function getData(category){
        url = "/searchBook?func=category&search="+category;
        console.log(url);
        $.getJSON(url,function(result){
            var res=eval(result.res);
            delete result["res"];
            if(res > 0){
                $("#category_res").html("");
                $.each(result, function(i, field){
                    var bookid = field["bookid"];
                    var picpath = field["picpath"];
                    var bookname = field["bookname"];

                    // $("#search_res").append(field + " "+ i + "<br> ");
                    $("#category_res").append("<div class=\"col-sm-4 col-md-3\">" +
                        "<div class=\"thumbnail\" >" +
                        "<a href=\"bookInfo.jsp?bookid="+bookid+"\">" +
                        "<img alt=\"100%x200\" src=\""+picpath+"\" data-src=\"holder.js/100%x200\" data-holder-rendered=\"false\">" +
                        "</a>" +
                        "<div class=\"caption center\">" +
                        "<h3>"+bookname+"</h3>" +
                        "<p><a class=\"btn btn-primary btn-block\" role=\"button\" href=\"bookInfo.jsp?bookid="+bookid+"\">查看详情</a></p>" +
                        "</div>" +
                        "</div>" +
                        "</div>");

                });
            }else if(res.equals(0)){
                $("#category_res").html("<a class=\"btn btn-primary btn-block\">无相关图书</a>");
            }else{
                $("#category_res").html("<a class=\"btn btn-primary btn-block\">查询出错</a>");
            }
        });
    }
    $(document).ready(function(){
        console.log("page prepared");
        getData("计算机");
        $('#tab_1').click(function(){
            $('#tab_1').addClass("active");
            $('#tab_2').removeClass("active");
            $('#tab_3').removeClass("active");
            $('#tab_4').removeClass("active");

            getData("计算机")

        });
        $('#tab_2').click(function(){
            $('#tab_2').addClass("active");
            $('#tab_1').removeClass("active");
            $('#tab_3').removeClass("active");
            $('#tab_4').removeClass("active");
            getData("外语学习")
        });
        $('#tab_3').click(function(){
            $('#tab_3').addClass("active");
            $('#tab_2').removeClass("active");
            $('#tab_1').removeClass("active");
            $('#tab_4').removeClass("active");
            getData("经济管理")
        });
        $('#tab_4').click(function(){
            $('#tab_4').addClass("active");
            $('#tab_2').removeClass("active");
            $('#tab_3').removeClass("active");
            $('#tab_1').removeClass("active");
            getData("社会科学")
        });

    });
</script>
</html>