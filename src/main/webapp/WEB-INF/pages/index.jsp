<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>颜值测试pk排行榜</title>
    <meta name="keywords" content=""/>
    <meta name="description" content=""/>
    <link href="css/templatemo_style.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <script type="text/javascript" src="js/bootstrap.bundle.min.js"></script>
    <script type="text/javascript" src="js/jquery-1-4-2.min.js"></script>
    <script type="text/javascript" src="js/jquery-ui.min.js"></script>
    <script type="text/javascript" src="js/showhide.js"></script>
    <script type="text/JavaScript" src="js/jquery.mousewheel.js"></script>

    <link rel="stylesheet" type="text/css" href="css/ddsmoothmenu.css"/>

    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/ddsmoothmenu.js"></script>

    <script type="text/javascript">
        ddsmoothmenu.init({
            mainmenuid: "templatemo_menu", //menu DIV id
            orientation: 'h', //Horizontal or vertical menu: Set to "h" or "v"
            classname: 'ddsmoothmenu', //class added to menu's outer DIV
            //customtheme: ["#1c5a80", "#18374a"],
            contentsource: "markup" //"markup" or ["container_id", "path_to_menu_file"]
        })
    </script>
    <!-- Load the CloudCarousel JavaScript file -->
    <script type="text/JavaScript" src="js/cloud-carousel.1.0.5.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {

            // This initialises carousels on the container elements specified, in this case, carousel1.
            $("#carousel1").CloudCarousel(
                {
                    reflHeight: 40,
                    reflGap: 2,
                    titleBox: $('#da-vinci-title'),
                    altBox: $('#da-vinci-alt'),
                    buttonLeft: $('#slider-left-but'),
                    buttonRight: $('#slider-right-but'),
                    yRadius: 30,
                    xPos: 480,
                    yPos: 32,
                    speed: 0.15,
                    autoRotate: "yes",
                    autoRotateDelay: 1500
                }
            );
        });

    </script>

</head>

<body id="home">
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
<div id="templatemo_header_wrapper">
    <div id="site_title"><h1><a href="#">颜值排行榜</a></h1></div>

    <div id="templatemo_menu" class="ddsmoothmenu">
        <ul>
        </ul>
        <!-- <br style="clear: left" /> -->
    </div> <!-- end of templatemo_menu -->
    <div class="cleaner"></div>
</div>    <!-- END of templatemo_header_wrapper -->

<!-- 轮播图 -->
<div id="templatemo_slider">
    <!-- This is the container for the carousel. -->
    <div id="carousel1"
         style="width:1000px; height:460px;background:none;/*overflow:scroll;*/ margin-left: 0px; margin-top: 20px">
        <c:forEach items="${faces }" var="face" varStatus="top">
            <a href="#" rel="lightbox"><img class="cloudcarousel" src="${face.imgPath}" alt="CSS Templates 2"
                                            title="Website Templates 2"/></a>
        </c:forEach>
    </div>

    <!-- Define left and right buttons. -->
    <center>
        <input id="slider-left-but" type="button" value=""/>
        <input id="slider-right-but" type="button" value=""/>
    </center>
</div>
<div id="templatemo_main">
    <div class="col one_third fp_services">
        <h2>颜值排行榜</h2>
        <c:forEach items="${faces }" var="face" varStatus="top">
            Top${top.index+1}
            <div class="rp_pp">
                <img src="${face.imgPath}" alt="Image ${top.index}" style="height: 160px;width: 160px;"/>
                <p>人脸检测数据</p>
                <p>
                    <span>年龄：${face.age}</span><br/>
                    <span>颜值：${face.beauty}</span><br/>
                    <span>性别：${face.gender=="male"?"男":"女"}</span><br/>
                    <!-- 获取是否带眼睛 none:无眼镜，common:普通眼镜，sun:墨镜 -->
                    <span>是否戴眼镜:${face.glasses=="none"?"无眼镜":face.glasses=="common"?"普通眼镜":"墨镜"}</span><br/>
                    <!-- 获取是否微笑，none:不笑；smile:微笑；laugh:大笑 -->
                    <span>表情：${face.expression=="none"?"不笑":face.expression=="smile"?"微笑":"大笑"}</span><br/>
                </p>
                <div class="cleaner"></div>
            </div>
        </c:forEach>
    </div>
    <div class="cleaner"></div>
</div>
</div> <!-- END of templatemo_footer -->
</body>
</html>
