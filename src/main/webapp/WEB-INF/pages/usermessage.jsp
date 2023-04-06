<%--
  Created by IntelliJ IDEA.
  User: purity
  Date: 2022/10/28
  Time: 21:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户信息</title>
  <link rel="stylesheet" href="css/bootstrap.min.css">
  <script type="text/javascript" src="js/bootstrap.bundle.min.js"></script>
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
<p class="lead">
  这里可以上传自己的真实图片，以便于人脸登录
</p>
<p class="lead">
  用户名: ${user.username}
</p>
<p class="lead">
  密码: ${user.password}
</p>
<img width="200px" height="200px" src="${pageContext.request.contextPath}/upload/user/${user.username}.jpg">
<div class="col-3">
<form action="${pageContext.request.contextPath}/userImage" method="post" enctype="multipart/form-data">
  <label for="formFile" class="form-label">选择文件</label>
  <input class="form-control" type="file" id="formFile" name="fileName" value="上传图片">
  <button type="submit" class="btn btn-primary">提交</button>
</form>
</div>
</body>
</html>
