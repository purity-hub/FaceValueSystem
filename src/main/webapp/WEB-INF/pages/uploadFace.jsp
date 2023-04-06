<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.staticfile.org/font-awesome/4.7.0/css/font-awesome.css">
    <link rel="stylesheet" href="css/style.css">
    <link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet">
    <link rel='stylesheet prefetch' href='https://fonts.googleapis.com/icon?family=Material+Icons'>
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/jquery-ui.min.js"></script>
    <script type="text/JavaScript" src="js/jquery.mousewheel.js"></script>
    <script type="text/javascript" src="js/bootstrap.bundle.min.js"></script>
    <script type="text/javascript" src="js/index.js"></script>
    <script src="js/axios.min.js"></script>
</head>
<body>
<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true"
     data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">人脸识别</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="关闭"
                        onclick="close_capture()"></button>
            </div>
            <div class="modal-body">
                <!--<video id="video"controls>-->
                <div style="position: relative;">
                    <button id="capture">拍照</button>
                    <video id="video" style="position: relative;"></video>
                </div>
                <div id="html" style="position: absolute; top: 30px; right: 50px;">
                </div>
                <div style="display: block; position: relative;" id="none">
                    <canvas id="canvas" width="480" height="320">
                    </canvas>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-secondary" data-bs-dismiss="modal" onclick="close_capture()">关闭</button>
                <button class="btn btn-primary" onclick="send_image()">上传</button>
            </div>
        </div>
    </div>
</div>
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
    请上传图片
</p>
<div class="col-3">
<form action="${pageContext.request.contextPath}/save" method="post" enctype="multipart/form-data">
    <label for="formFile" class="form-label">选择文件</label>
    <input class="form-control" type="file" id="formFile" name="fileName" value="上传图片">
    <button type="submit" class="btn btn-primary">提交</button>
</form>
    <button class="btn btn_primary" type="button" data-bs-toggle="modal" data-bs-target="#exampleModal" onclick="faceupdate()">人脸拍照</button>
</div>
</body>
<script>
    function getUserMedia(constraints, success, error) {
        if (navigator.mediaDevices.getUserMedia) {
            //最新的标准API
            navigator.mediaDevices.getUserMedia(constraints).then(success).catch(error);
        } else if (navigator.webkitGetUserMedia) {
            //webkit核心浏览器
            navigator.webkitGetUserMedia(constraints, success, error)
        } else if (navigator.mozGetUserMedia) {
            //firfox浏览器
            navigator.mozGetUserMedia(constraints, success, error);
        } else if (navigator.getUserMedia) {
            //旧版API
            navigator.getUserMedia(constraints, success, error);
        }
    }

    //关闭摄像头
    function close_capture() {
        var video = document.getElementById("video");
        video.pause();
        //关闭全部的video
        var stream = video.srcObject;
        var tracks = stream.getTracks();
        for (var i = 0; i < tracks.length; i++) {
            var track = tracks[i];
            console.log(track);
            track.stop();
        }
    }

    let video = document.getElementById('video');
    let canvas = document.getElementById('canvas');
    let context = canvas.getContext('2d');

    function success(stream) {
        //兼容webkit核心浏览器
        let CompatibleURL = window.URL || window.webkitURL;
        //将视频流设置为video元素的源
        console.log(stream);

        //video.src = CompatibleURL.createObjectURL(stream);
        video.srcObject = stream;
        video.play();
    }

    function error(error) {
        console.log(`访问用户媒体设备失败${error.name}, ${error.message}`);
    }

    function faceupdate() {
        if (navigator.mediaDevices.getUserMedia || navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia) {
            //调用用户媒体设备, 访问摄像头
            getUserMedia({video: {width: 480, height: 320}}, success, error);
        } else {
            alert('不支持访问用户媒体');
        }
    }
    document.getElementById('capture').addEventListener('click', function () {
        context.drawImage(video, 0, 0, 480, 320);

        function convertCanvasToImage(canvas) {
            var image = new Image();
            image.src = canvas.toDataURL("image/png");
            return image;
        }
    })
    //exampleModal关闭时，关闭摄像头
    document.getElementById('exampleModal').addEventListener('hidden.bs.modal', function () {
        close_capture();
    })

    function dataURItoBlob(base64Data) {
        var byteString;
        if (base64Data.split(',')[0].indexOf('base64') >= 0)
            byteString = atob(base64Data.split(',')[1]);
        else
            byteString = unescape(base64Data.split(',')[1]);
        var mimeString = base64Data.split(',')[0].split(':')[1].split(';')[0];
        var ia = new Uint8Array(byteString.length);
        for (var i = 0; i < byteString.length; i++) {
            ia[i] = byteString.charCodeAt(i);
        }
        return new Blob([ia], {type: mimeString});
    }

    //将blob转换为file
    function blobToFile(theBlob, fileName) {
        theBlob.lastModifiedDate = new Date();
        theBlob.name = fileName;
        return theBlob;
    }

    $("#captureform").submit(function (e) {
        e.preventDefault();
    })
    function send_image() {
        //生成图片格式base64包括：jpg、png格式
        var base64Data = canvas.toDataURL("image/jpeg", 1.0);
        console.log(base64Data)
        //封装blob对象
        var blob = dataURItoBlob(base64Data);

        var file = blobToFile(blob, "imgSignature");

        //这里用ajax方式，需要使用Formdata形式
        var formData = new FormData();
        formData.append("fileName", file);
        console.log(formData.get("fileName"))
        //这里用ajax方式发起请求设置contenttype:false总是报错
        axios
            .post('${pageContext.request.contextPath}/faceupload', formData, {
                headers: {
                    'Content-Type': 'multipart/form-data',
                },
            })
            .then((res) => {
                console.log(res)
                if (res.data === "success") {
                    window.location.href = "${pageContext.request.contextPath}/query"
                } else {
                    //消息提示
                    alert("上传失败");
                }
            })
            .catch((err) => {
                console.log(err)
            })
    }
</script>
</html>
