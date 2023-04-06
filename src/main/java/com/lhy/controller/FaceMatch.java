package com.lhy.controller;


import com.lhy.utils.GsonUtils;
import com.lhy.utils.HttpUtil;

import java.util.HashMap;

/**
 * 人脸对比
 */
public class FaceMatch {
    public static void faceMatch() {
        // 请求url
        String url = "https://aip.baidubce.com/rest/2.0/face/v3/match";
        try {

            HashMap<String, String> map = new HashMap<>();
            map.put("image", "图片的base64编码");
            map.put("image_type", "BASE64");
            map.put("face_type", "LIVE");
            map.put("quality_control", "LOW");
            map.put("liveness_control", "LOW");
            String param = GsonUtils.toJson(map);

            // 注意这里仅为了简化编码每一次请求都去获取access_token，线上环境access_token有过期时间， 客户端可自行缓存，过期后重新获取。
            String accessToken = "[调用鉴权接口获取的token]";

            String result = HttpUtil.post(url, accessToken, "application/json", param);
            System.out.println(result);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        FaceMatch.faceMatch();
    }
}
