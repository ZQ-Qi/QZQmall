var xmlhttp;
function verify(){
    var username=document.getElementById("username").value;


    //创建XMLHttpRequest对象

    if(window.XMLHttpRequest){
        //针对FireFox,Mozillar,Opera,Safari,IE7,IE8
        xmlhttp = new XMLHttpRequest();

        //对某些特定版本的mozillar浏览器的bug进行修正
        if(xmlhttp.overrideMineType){
            xmlhttp.overrideMineType("text/xml");
        }
    }else if(window.ActiveXObject){
        //针对IE5，IE5.5，IE6

        //两个可以用于创建XMLHTTPRequest对象的控件名称。保存在一个JS数组中。
        var activexName = ["MSXML2.XMLHTTP","Microsoft.XMLHTTP"];
        for(var i = 0; i<activeName.length; i++){
            //取出一个控件名进行创建，如果成功就终止循环
            try{
                xmlhttp = new ActiveXObject(activexName[i]);
                break;
            }catch(e){}
        }

    }

    if(xmlhttp){
        alert("XMLHttpRequest对象创建成功！");
        return;
    }else{
        alert("XMLHttpRequest对象创建失败！");
    }


    //注册回调函数,只写函数名，不能写括号，写括号表示调用函数。
    xmlhttp.onreadystatechange = callback;

    //设置连接信息(请求方式，请求的url,true表示异步方式交互)
    xmlhttp.open("GET","AJAXServer?name=" + username, true);

    //发送数据，开始和服务器进行交互。
    xmlhttp.send(null);


    //使用POST方式请求，需要手动设置http的请求头
    //xmlhttp.setRequestHeader("Content-Type","aplication/x-www-form-urlencoded");
    //xmlhttp.send("name=" + username);

}

//回调函数
function callback(){
    //判断对象的状态是否交互完成
    if(xmlhttp.readyState == 4){
        //判断http的交互是否成功
        if(xmlhttp.status == 200){
            //获取服务器端返回的数据（文本）
            var resbonseText = xmlhttp.responseText;
            //将数据显示在页面上
            var divNode = document.getElementById("result");

            //设置元素节点中的html内容
            divNode.innerHTML = responseText;
        }

    }
}