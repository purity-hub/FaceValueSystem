<%--
  Created by IntelliJ IDEA.
  User: purity
  Date: 2022/10/28
  Time: 21:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>颜值PK系统-组团PK</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <script type="text/javascript" src="js/bootstrap.bundle.min.js"></script>
    <script type="text/javascript" src="js/jquery.min.js"></script>
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
                    <a class="nav-link active" aria-current="page"
                       href="${pageContext.request.contextPath}/index">首页</a>
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
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/mymessage">个人信息</a>
                        </li>
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
    <form action="${pageContext.request.contextPath}/teamFacelist" method="post" enctype="multipart/form-data">
        <div class="row align-items-center">
            <div class="col-3">
                <p class="lead">
                    团队1
                </p>
                <input type="text" class="form-control" name="name1" id="teamname1" aria-describedby="teamnameHelp1">
                <div id="teamnameHelp1" class="form-text">请给团队起一个好听的名字</div>
                <div>
                        <label for="formFile1" class="form-label">选择文件</label>
                        <input class="form-control" type="file" id="formFile1" name="file1" value="上传图片"
                               multiple="multiple">
                </div>
            </div>
            <div class="col-3">
                <p class="lead">
                    团队2
                </p>
                <input type="text" class="form-control" id="teamname2" name="name2" aria-describedby="teamnameHelp2">
                <div id="teamnameHelp2" class="form-text">请给团队起一个好听的名字</div>
                <div>
                        <label for="formFile2" class="form-label">选择文件</label>
                        <input class="form-control" type="file" id="formFile2" name="file2" value="上传图片"
                               multiple="multiple">

                </div>
            </div>
            <div class="col align-self-center">
                <button type="submit" class="btn btn-primary">提交</button>
            </div>
        </div>
    </form>
</div>
<script>
    function sumbitteam() {
        var teamname1 = document.getElementById("teamname1").value;
        var teamname2 = document.getElementById("teamname2").value;
        if (teamname1 === "" || teamname2 === "") {
            alert("团队名不能为空");
        } else {
            $.ajax({
                url: '${pageContext.request.contextPath}/teamFace',
                type: 'post',
                data: {
                    file1: $("#formFile1").val(),
                    file2: $("#formFile2").val(),
                    name1: teamname1,
                    name2: teamname2
                },
                success: function (res) {
                    if (res === "success") {
                        window.location.href = "${pageContext.request.contextPath}/facelist";
                    } else {
                        window.location.href = "${pageContext.request.contextPath}/facelist";
                    }
                }
            })
        }
    }
</script>
</body>
</html>
