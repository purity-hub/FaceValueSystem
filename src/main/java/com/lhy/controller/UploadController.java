package com.lhy.controller;

import com.alibaba.fastjson.JSON;
import com.baidu.aip.face.AipFace;
import com.lhy.model.Face;
import com.lhy.model.FaceContrast;
import com.lhy.model.FaceV3DetectBean;
import com.lhy.service.FaceService;
import com.lhy.service.UploadService;
import com.lhy.service.UserService;
import com.lhy.service.impl.AuthService;
import com.lhy.utils.Base64Util;
import com.lhy.utils.FaceSpot;
import com.lhy.utils.GsonUtils;
import com.lhy.utils.HttpUtil;
import org.apache.commons.io.IOUtils;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.HashMap;

@Controller
@ResponseBody
public class UploadController {

    private static final String AppID = "28043826";
    private static final String APIKey = "rSG3K9cU0ux30sS60S4sDGyN";
    private static final String SecretKey = "NZFhawFCoC23KLP47btB8hR1EqXqhaHG";

    static AipFace client = null;
    static {
        client = new AipFace(AppID, APIKey, SecretKey);
        // 可选：设置网络连接参数
        client.setConnectionTimeoutInMillis(2000);
        client.setSocketTimeoutInMillis(60000);
    }

    @Autowired
    private UploadService uploadService;

    @Autowired
    private FaceService faceService;

    @Autowired
    private UserService userService;

    @Value("${upload.path}")
    private String uploadPath;

    @RequestMapping(value = "/facematch",method = RequestMethod.POST)
    public String uploadImage(@RequestParam("username") String username, @RequestParam("file") MultipartFile file, HttpSession session) throws IOException {
//        MultipartFile file = request.getFile("file");
//        String resultUrl;
//        assert file != null;
//        byte[] bytes = file.getBytes();
//        resultUrl = uploadService.uploadImage( bytes, ".png");
//        return ResponseEntity.ok(resultUrl);
        String userImage = userService.selectUserImage(username);
        String url = "https://aip.baidubce.com/rest/2.0/face/v3/match";
        try {
            // 本地文件路径
            HashMap<String, String> map = new HashMap<>();
            //将上传的图片转换为base64编码
            String image1 = Base64Util.encode(file.getBytes());
            map.put("image", image1);
            map.put("image_type", "BASE64");
            map.put("face_type", "LIVE");
            map.put("quality_control", "LOW");
            map.put("liveness_control", "LOW");
            String param = GsonUtils.toJson(map);
            //用户的图片
            HashMap<String, String> map2 = new HashMap<>();
            //将userImage路径转化为MultiPartFile
            File file2 = new File(userImage);
            byte[] bytes = IOUtils.toByteArray(Files.newInputStream(file2.toPath()));
            //将文件转换为base64编码
            String image2 = Base64Util.encode(bytes);
            //将文件file1转换为字节数组
            map2.put("image", image2);
            map2.put("image_type", "BASE64");
            map2.put("face_type", "LIVE");
            map2.put("quality_control", "LOW");
            map2.put("liveness_control", "LOW");
            String param2 = GsonUtils.toJson(map2);
            String param3 = "["+param+","+param2+"]";
            // 注意这里仅为了简化编码每一次请求都去获取access_token，线上环境access_token有过期时间， 客户端可自行缓存，过期后重新获取。
            String accessToken = AuthService.getAuth();
            String result = HttpUtil.post(url, accessToken, "application/json", param3);
            JSON json = JSON.parseObject(result);
            FaceContrast bean = JSON.toJavaObject(json, FaceContrast.class);
            if (bean.getResult().getScore() > 80) {
                session.setAttribute("username", username);
                return "success";
            } else {
                return "fail";
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "fail";
    }
    @RequestMapping(value = "/faceupload")
    @ResponseBody
    public String saveService(@RequestParam("fileName") MultipartFile file) {
        //将用户上传图片保存至本地
        String fileName = FaceSpot.saveFile(file
                , uploadPath);

        if (fileName!=null) {

            //将上传的照片转为二进制的数据流
            byte[] byface = FaceSpot.FileToByte(file);

            //调用人脸检测的方法
            String str = FaceSpot.detectFace(byface, "1");

            //将字符串转换为json对象
            JSON json = JSON.parseObject(str);
            FaceV3DetectBean bean = JSON.toJavaObject(json, FaceV3DetectBean.class);

            //将需要的人脸检测数据封存入Face对象中
            Face face = new Face();

            if (bean!=null) {
                for (int i = 0; i < bean.getResult().getFace_list().size(); i++) {
                    // 获取年龄
                    int ageOne = bean.getResult().getFace_list().get(i).getAge();
                    face.setAge(ageOne);

                    // 获取美丑打分
                    Double beautyOne = (Double) bean.getResult().getFace_list().get(i).getBeauty();
                    face.setBeauty(beautyOne);

                    // 获取性别 male(男)、female(女)
                    String gender = bean.getResult().getFace_list().get(i).getGender().getType();
                    face.setGender(gender);

                    // 获取是否带眼睛 none:无眼镜，common:普通眼镜，sun:墨镜
                    String glasses = bean.getResult().getFace_list().get(i).getGlasses().getType();
                    face.setGlasses(glasses);
                    // 获取是否微笑，none:不笑；smile:微笑；laugh:大笑
                    String expression = bean.getResult().getFace_list().get(i).getExpression().getType();
                    face.setExpression(expression);

                    //保存用户头像的对外访问地址在数据库中
                    face.setImgPath("http://localhost:8080/FaceValueSystem_war_exploded/upload/"+fileName);
                }
                faceService.insertFact(face);
            }else {
                System.out.println("要确保网络和你的百度人脸检测应用ID是正常的额~~");
            }
        }else {
            System.out.println("请上传一张帅照额~~~~");
        }
        return "success";
    }
    @RequestMapping("/scanFace")
    @ResponseBody
    public Double scanFace(String img) {
        img = img.substring(img.indexOf(",")+1);
        img = img.replaceAll(" ","+");
        HashMap<String, String> options = new HashMap<String, String>();
        options.put("face_field", "age,beauty,expression,faceshape,gender,glasses,race,qualities");
        options.put("max_face_num", "1");
        options.put("face_type", "LIVE");
        String imgStr = img;
        String imageType = "BASE64";
        JSONObject res = client.detect(imgStr, imageType, options);
        String str = res.toString();
        JSON json = JSON.parseObject(str);
        FaceV3DetectBean bean = JSON.toJavaObject(json, FaceV3DetectBean.class);
        double score = 0;
        if(bean!=null){
            score = bean.getResult().getFace_list().get(0).getBeauty();
        }
        return score;
    }
}
