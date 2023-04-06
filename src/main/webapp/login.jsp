<%--
  Created by IntelliJ IDEA.
  User: purity
  Date: 2022/10/21
  Time: 18:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>颜值PK系统</title>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="multipart/form-data; charset=utf-8"/>
    <link rel="stylesheet" href="https://cdn.staticfile.org/font-awesome/4.7.0/css/font-awesome.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/bootstrap.min.css">
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
                <button class="btn btn-primary" onclick="send_image()">登录</button>
            </div>
        </div>
    </div>
</div>
<div class="cotn_principal">
    <div class="cont_centrar">
        <div class="cont_login">
            <div class="cont_info_log_sign_up">
                <div class="col_md_login">
                    <div class="cont_ba_opcitiy">
                        <h2>登录</h2>
                        <p>已有账号,登录</p>
                        <button class="btn_login" onClick="cambiar_login()">登录</button>
                    </div>
                </div>
                <div class="col_md_sign_up">
                    <div class="cont_ba_opcitiy">
                        <h2>注册</h2>
                        <p>没用账号,注册账号</p>
                        <button class="btn_sign_up" onClick="cambiar_sign_up()">注册</button>
                    </div>
                </div>
            </div>
            <div class="cont_back_info">
                <div class="cont_img_back_grey"><img src="images/background.jpg" alt=""/></div>
            </div>
            <div class="cont_forms">
                <div class="cont_img_back_"><img src="images/background.jpg" alt=""/></div>
                <div class="cont_form_login"><a href="#" onClick="ocultar_login_sign_up()"><i class="material-icons">&#xE5C4;</i></a>
                    <h2>登录</h2>
                    <input id="username" name="username" type="text" placeholder="用户名" value="<%=session.getAttribute("username")!=null?session.getAttribute("username"):""%>"/>
                    <input name="password" type="password" placeholder="密码"/>
                    <button class="btn_login" onClick="cambiar_login1()">登录</button>
                    <br>
                    <button type="button" class="btn_face" data-bs-toggle="modal" data-bs-target="#exampleModal"
                            onclick="login_face()">使用人脸登录
                    </button>
                </div>
                <div class="cont_form_sign_up"><a href="#" onClick="ocultar_login_sign_up()"><i class="material-icons">&#xE5C4;</i></a>
                    <h2>注册</h2>
                    <form action="" class="was-validated">
                        <div class="form-group">
                            <div class="row g-3 align-items-center">
                                <div class="col-auto">
                                    <label for="username1" class="col-form-label">用户名:</label>
                                </div>
                                <div class="col-auto">
                                    <input type="text" class="form-control" id="username1" placeholder="用户名"
                                           name="username1" required>
                                    <div class="valid-feedback">验证成功！</div>
                                    <div class="invalid-feedback">请输入用户名！</div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row g-3 align-items-center">
                                <div class="col-auto">
                                    <label for="password1" class="col-form-label">密码:</label>
                                </div>
                                <div class="col-auto">
                                    <input type="text" class="form-control" id="password1" placeholder="密码"
                                           name="password1" required>
                                    <div class="valid-feedback">验证成功！</div>
                                    <div class="invalid-feedback">请输入密码！</div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row g-3 align-items-center">
                                <div class="col-auto">
                                    <label for="password2" class="col-form-label">密码:</label>
                                </div>
                                <div class="col-auto">
                                    <input type="text" class="form-control" id="password2" placeholder="确认密码"
                                           name="password2" required>
                                    <p class="valid-feedback" id="passwordconfirm">两次密码相同</p>
                                </div>
                            </div>
                        </div>
                    </form>
                    <button class="btn_sign_up" onClick="cambiar_sign_up1()">注册</button>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    //监听password2
    document.getElementById('password2').addEventListener('input',function (){
        var password1 = document.getElementById('password1').value;
        var password2 = document.getElementById('password2').value;
        if(password1!==password2){
            document.getElementById('passwordconfirm').innerHTML = "两次密码不一致"
        }else{
            document.getElementById('passwordconfirm').innerHTML = "两次密码一致"
        }
    })
    //监听password1
    document.getElementById('password1').addEventListener('input',function (){
        var password1 = document.getElementById('password1').value;
        var password2 = document.getElementById('password2').value;
        if(password1!==password2){
            document.getElementById('passwordconfirm').innerHTML = "两次密码不一致"
        }else{
            document.getElementById('passwordconfirm').innerHTML = "两次密码一致"
        }
    })
    //访问用户媒体设备的兼容方法
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

    function login_face() {
        if ($("#username").val() === "") {
            alert("请输入用户名");
            //关闭弹窗Model
            $("#exampleModal").modal('hide');
            return;
        }
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
        formData.append("file", file);
        formData.append("username", $("#username").val());
        console.log(formData.get("file"))
        console.log(formData.get("username"))
        //这里用ajax方式发起请求设置contenttype:false总是报错
        axios
            .post('${pageContext.request.contextPath}/facematch', formData, {
                headers: {
                    'Content-Type': 'multipart/form-data',
                },
            })
            .then((res) => {
                console.log(res)
                if (res.data === "success") {
                    window.location.href = "${pageContext.request.contextPath}/index.jsp"
                } else {
                    //消息提示
                    alert("登录失败");
                }
            })
            .catch((err) => {
                console.log(err)
            })
    }

    function cambiar_login1() {
        $.ajax({
            url: "${pageContext.request.contextPath}/login",
            type: "post",
            data: {
                username: $("input[name='username']").val(),
                password: $("input[name='password']").val()
            },
            success: function (data) {
                if (data === "success") {
                    window.location.href = "${pageContext.request.contextPath}/index";
                } else {
                    window.location.href = "${pageContext.request.contextPath}/loginview";
                }
            }
        })
    }

    function cambiar_sign_up1() {
        var username1 = $('#username1').val()
        var password1 = $('#password1').val()
        var password2 = $('#password2').val()
        if(username1==="" || password1 ==="" || password2 === ""){
            return;
        }
        if(password1 !== password2){
            return;
        }
        //注册
        $.ajax({
            url: "${pageContext.request.contextPath}/register",
            type: "post",
            data: {
                username: $("input[name='username1']").val(),
                password: $("input[name='password1']").val()
            },
            success: function (data) {
                if (data === "success") {
                    window.location.href = "${pageContext.request.contextPath}/index";
                } else {
                    window.location.href = "${pageContext.request.contextPath}/loginview";
                }
            }
        })
    }

    //
</script>
<%--<script>--%>
<%--    drawStars();--%>

<%--    //画星空背景--%>
<%--    function drawStars() {--%>
<%--        var canvas = document.getElementById('canvas'),--%>
<%--            ctx = canvas.getContext('2d'),--%>
<%--            w = canvas.width = window.innerWidth,--%>
<%--            h = canvas.height = window.innerHeight,--%>

<%--            hue = 217, //色调色彩--%>
<%--            stars = [], //保存所有星星--%>
<%--            count = 0,  //用于计算星星--%>
<%--            maxStars = 1300; //星星数量--%>

<%--        //canvas2是用来创建星星的源图像，即母版，--%>
<%--        //根据星星自身属性的大小来设置--%>
<%--        var canvas2 = document.createElement('canvas'),--%>
<%--            ctx2 = canvas2.getContext('2d');--%>
<%--        canvas2.width = 100;--%>
<%--        canvas2.height = 100;--%>
<%--        //创建径向渐变，从坐标(half，half)半径为0的圆开始，--%>
<%--        //到坐标为(half,half)半径为half的圆结束--%>
<%--        var half = canvas2.width / 2,--%>
<%--            gradient2 = ctx2.createRadialGradient(half, half, 0, half, half, half);--%>
<%--        gradient2.addColorStop(0.025, '#CCC');--%>
<%--        //hsl是另一种颜色的表示方式，--%>
<%--        //h->hue,代表色调色彩，0为red，120为green，240为blue--%>
<%--        //s->saturation，代表饱和度，0%-100%--%>
<%--        //l->lightness，代表亮度，0%为black，100%位white--%>
<%--        gradient2.addColorStop(0.1, 'hsl(' + hue + ', 61%, 33%)');--%>
<%--        gradient2.addColorStop(0.25, 'hsl(' + hue + ', 64%, 6%)');--%>
<%--        gradient2.addColorStop(1, 'transparent');--%>

<%--        ctx2.fillStyle = gradient2;--%>
<%--        ctx2.beginPath();--%>
<%--        ctx2.arc(half, half, half, 0, Math.PI * 2);--%>
<%--        ctx2.fill();--%>

<%--        // End cache--%>
<%--        function random(min, max) {--%>
<%--            if (arguments.length < 2) {--%>
<%--                max = min;--%>
<%--                min = 0;--%>
<%--            }--%>

<%--            if (min > max) {--%>
<%--                var hold = max;--%>
<%--                max = min;--%>
<%--                min = hold;--%>
<%--            }--%>

<%--            //返回min和max之间的一个随机值--%>
<%--            return Math.floor(Math.random() * (max - min + 1)) + min;--%>
<%--        }--%>

<%--        function maxOrbit(x, y) {--%>
<%--            var max = Math.max(x, y),--%>
<%--                diameter = Math.round(Math.sqrt(max * max + max * max));--%>
<%--            //星星移动范围，值越大范围越小，--%>
<%--            return diameter / 2;--%>
<%--        }--%>

<%--        var Star = function () {--%>
<%--            //星星移动的半径--%>
<%--            this.orbitRadius = random(maxOrbit(w, h));--%>
<%--            //星星大小，半径越小，星星也越小，即外面的星星会比较大--%>
<%--            this.radius = random(60, this.orbitRadius) / 8;--%>
<%--            //所有星星都是以屏幕的中心为圆心--%>
<%--            this.orbitX = w / 2;--%>
<%--            this.orbitY = h / 2;--%>
<%--            //星星在旋转圆圈位置的角度,每次增加speed值的角度--%>
<%--            //利用正弦余弦算出真正的x、y位置--%>
<%--            this.timePassed = random(0, maxStars);--%>
<%--            //星星移动速度--%>
<%--            this.speed = random(this.orbitRadius) / 50000;--%>
<%--            //星星图像的透明度--%>
<%--            this.alpha = random(2, 10) / 10;--%>

<%--            count++;--%>
<%--            stars[count] = this;--%>
<%--        }--%>

<%--        Star.prototype.draw = function () {--%>
<%--            //星星围绕在以屏幕中心为圆心，半径为orbitRadius的圆旋转--%>
<%--            var x = Math.sin(this.timePassed) * this.orbitRadius + this.orbitX,--%>
<%--                y = Math.cos(this.timePassed) * this.orbitRadius + this.orbitY,--%>
<%--                twinkle = random(10);--%>

<%--            //星星每次移动会有1/10的几率变亮或者变暗--%>
<%--            if (twinkle === 1 && this.alpha > 0) {--%>
<%--                //透明度降低，变暗--%>
<%--                this.alpha -= 0.05;--%>
<%--            } else if (twinkle === 2 && this.alpha < 1) {--%>
<%--                //透明度升高，变亮--%>
<%--                this.alpha += 0.05;--%>
<%--            }--%>

<%--            ctx.globalAlpha = this.alpha;--%>
<%--            //使用canvas2作为源图像来创建星星，--%>
<%--            //位置在x - this.radius / 2, y - this.radius / 2--%>
<%--            //大小为 this.radius--%>
<%--            ctx.drawImage(canvas2, x - this.radius / 2, y - this.radius / 2, this.radius, this.radius);--%>
<%--            //没旋转一次，角度就会增加--%>
<%--            this.timePassed += this.speed;--%>
<%--        }--%>

<%--        //初始化所有星星--%>
<%--        for (var i = 0; i < maxStars; i++) {--%>
<%--            new Star();--%>
<%--        }--%>

<%--        function animation() {--%>
<%--            //以新图像覆盖已有图像的方式进行绘制背景颜色--%>
<%--            ctx.globalCompositeOperation = 'source-over';--%>
<%--            ctx.globalAlpha = 0.5; //尾巴--%>
<%--            ctx.fillStyle = 'hsla(' + hue + ', 64%, 6%, 2)';--%>
<%--            ctx.fillRect(0, 0, w, h)--%>

<%--            //源图像和目标图像同时显示，重叠部分叠加颜色效果--%>
<%--            ctx.globalCompositeOperation = 'lighter';--%>
<%--            for (var i = 1, l = stars.length; i < l; i++) {--%>
<%--                stars[i].draw();--%>
<%--            }--%>


<%--            //调用该方法执行动画，并且在重绘的时候调用指定的函数来更新动画--%>
<%--            //回调的次数通常是每秒60次--%>
<%--            window.requestAnimationFrame(animation);--%>
<%--        }--%>

<%--        animation();--%>
<%--    }--%>
<%--</script>--%>
</html>

