<%--
  Created by IntelliJ IDEA.
  User: purity
  Date: 2022/11/14
  Time: 20:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>聊天</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <script type="text/javascript" src="js/bootstrap.bundle.min.js"></script>
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script src="https://cdn.bootcdn.net/ajax/libs/sockjs-client/1.5.1/sockjs.min.js"></script>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container-fluid">
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarTogglerDemo01"
                aria-controls="navbarTogglerDemo01" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarTogglerDemo01">
            <a class="navbar-brand" href="#">颜值PK系统</a>
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="${pageContext.request.contextPath}/index">首页</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/uploadFace">单人PK</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/teamFace">组团PK</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/onlinepk">在线PK</a>
                </li>
            </ul>
            <ul class="d-flex">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button"
                       data-bs-toggle="dropdown" aria-expanded="false">
                        <%=session.getAttribute("username")%>
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">退出</a></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/mymessage">个人信息</a></li>
                        <li>
                            <hr class="dropdown-divider">
                        </li>
                        <li><a class="dropdown-item" href="#">设置</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>
<div class="container">
        <div class="row align-items-center">
            <div class="col-3">
                <p class="lead">
                    <%=session.getAttribute("username")%>
                </p>
                <form action="" enctype="multipart/form-data">
                    <input id="file" class="filepath" onchange="changepic(this)" type="file"><br>
                    <img src="" id="show" width="200"><br>
                    颜值:<p id="yanzhi1"></p>
                </form>
            </div>
            <div class="col-3">
                <p class="lead">
                    对手
                </p>
                <img src="" id="show1" width="200" alt="对方未上传图片"><br>
                颜值:<p id="yanzhi2"></p>
            </div>
            <div class="col-3">
                <p class="lead">
                    聊天室
                </p>
                <input id="sendContent"/><button onclick="sendMessage()">发送</button><br/>
                <div id="messageView"></div>
            </div>
        </div>
</div>

</body>

<script>
    var webSocket;
    //页面加载完成后执行
    $(function () {
        connection();
    });

    function connection() {
        let name = '<%=session.getAttribute("username")%>';
        if (name){
            if ("WebSocket" in window) {
                webSocket = new WebSocket("ws://192.168.43.78:8080/FaceValueSystem_war_exploded/socket/"+name);
                //连通之后的回调事件
                webSocket.onopen = function() {
                    console.log("已经连通了websocket");
                };

                //接收后台服务端的消息
                webSocket.onmessage = function (evt) {
                    console.log("数据已接收:" +JSON.stringify(evt.data));
                    const messageBody = JSON.parse(evt.data);
                    if(messageBody.content.startsWith("分数 ")) {
                        $("#yanzhi2").text(messageBody.content.substring(3));
                    }
                    if(messageBody.content.startsWith("data:image")) {
                        $("#show1").attr("src",messageBody.content);
                    }
                    viewMessage(messageBody);
                };

                //连接关闭的回调事件
                webSocket.onclose = function() {
                    console.log("连接已关闭...");
                    let message = new Object();
                    message.fromName = "system";
                    message.content = "连接已关闭";
                    viewMessage(message);
                    //清除聊天记录
                    $("#messageView").empty();
                    $("#show").attr("src","");
                    connection();
                };
            }else{
                // 浏览器不支持 WebSocket
                alert("您的浏览器不支持 WebSocket!");
            }
        }else {
            alert("请输入你的名字")
        }
    }
    function sendMessage(){
        let content = $("#sendContent").val();
        if (content){
            let message = new Object();
            message.fromName = '<%=session.getAttribute("username")%>';
            message.toName = '';//后端指定
            message.content = content;
            $("#sendContent").val("");
            viewMessage(message);
            webSocket.send(JSON.stringify(message));
        }else {
            console.log("输入内容为空")
        }
    }
    function viewMessage(message){
        let messageHtml = "<div>"+message.fromName+": "+message.content+"</div>";
        $("#messageView").append(messageHtml);
        console.log(messageHtml);
    }
    function changepic() {
        var reads= new FileReader();
        f=document.getElementById('file').files[0];
        reads.readAsDataURL(f);
        reads.onload=function (e) {
            document.getElementById('show').src=this.result;
            var img = this.result;
            $.ajax({
                url:"${pageContext.request.contextPath}/scanFace",
                type:"post",
                data:{"img":img},
                success:function (res) {
                    $('#yanzhi1').text(res);
                    message = new Object();
                    message.fromName = '<%=session.getAttribute("username")%>';
                    message.toName = '';//后端指定
                    message.content = img;
                    webSocket.send(JSON.stringify(message));
                    message.content = '分数 '+res;
                    viewMessage(message);
                    webSocket.send(JSON.stringify(message));
                }
            })
        };
    }
</script>
</html>

