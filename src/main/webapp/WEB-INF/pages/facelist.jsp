<%@ page import="java.util.List" %>
<%@ page import="com.lhy.model.Team" %><%--
  Created by IntelliJ IDEA.
  User: purity
  Date: 2022/10/29
  Time: 15:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>团队排行</title>
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
    <div class="row align-items-center">
        <div class="col-3">
            <p class="lead">
                总排行
            </p>
            <ol class="list-group list-group-numbered">
                <%List<Team> teams = (List<Team>) request.getAttribute("teams");%>
                <%for (Team team:teams) {%>
                    <li class="list-group-item d-flex justify-content-between align-items-start" onclick="teamPeople(<%=team.getId()%>)">
                        <div class="ms-2 me-auto">
                            团队名:<div class="fw-bold"><%=team.getName()%></div>
                            得分:<%=team.getScore()%>分
                        </div>
                    </li>
                <%}%>
            </ol>
        </div>
        <div class="col-3">
            <p class="lead">
                团队排行
            </p>
            <ol id="teampeople" class="list-group list-group-numbered">
                <li class="list-group-item d-flex justify-content-between align-items-start" hidden>

                </li>
            </ol>
        </div>
    </div>
</div>
</body>
<script>
    function teamPeople(teamId){
        $.ajax({
            url: "${pageContext.request.contextPath}/teamPeople",
            type: "post",
            data: {
                "teamId": teamId
            },
            success: function (data) {
                var team = JSON.parse(data);
                console.log(team)
                var html = "<ol id=\"teampeople\" class=\"list-group list-group-numbered\">";
                for (var i = 0; i < team.teamPeople.length; i++) {
                    var teamPeople = team.teamPeople[i];
                    html += "<li class=\"list-group-item d-flex justify-content-between align-items-start\">\n" +
                        "                    <div class=\"ms-2 me-auto\">\n" +
                        "                        图片:<img class=\"fw-bold\" alt='未找到' width=\"200px\" height=\"200px\" src='"+teamPeople.imgPath+"'/>\n"  +
                        "                        年龄:" + teamPeople.age + "岁<br>" +
                        "                        颜值:" + teamPeople.beauty + "分<br>" +
                        "                        性别:" + teamPeople.gender + "<br>" +
                        "                        表情:" + teamPeople.expression + "<br>" +
                        "                        是否戴眼镜:" + teamPeople.glasses + "<br>" +
                        "                    </div>\n" +
                        "                </li>";
                }
                html += "</ol>";
                $("#teampeople").replaceWith(html);
            }
        })
    }
</script>
</html>
