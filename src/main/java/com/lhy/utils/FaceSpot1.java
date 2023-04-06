package com.lhy.utils;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;

import org.json.JSONObject;

import com.baidu.aip.face.AipFace;
import com.baidu.aip.face.FaceVerifyRequest;
import com.baidu.aip.util.Base64Util;

public class FaceSpot1 {
	private static final String AppID = "28009296";
	private static final String APIKey = "gUd6IskctXlF2NBylHdE38Tb";
	private static final String SecretKey = "uFLGdvvC0mbANHR7jsayiKGKFGr7CFrR";

	static AipFace client = null;
	static {
		client = new AipFace(AppID, APIKey, SecretKey);
		// 可选：设置网络连接参数
		client.setConnectionTimeoutInMillis(2000);
		client.setSocketTimeoutInMillis(60000);
	}

	public static void main(String[] args) throws IOException {
		 String filePath = "C:\\img\\111.jpg";

		 byte[] imgData = FileToByte(new File(filePath));

		 System.out.println(detectFace(imgData,"1"));
	}

	/**
	 * 人脸检测
	 *
	 * @return
	 * @throws IOException
	 */
	public static String detectFace(File file, String max_face_num) {
		try {
			return detectFace(FileToByte(file), max_face_num);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 人脸检测
	 *
	 * @return
	 * @throws IOException
	 */
	public static String detectFace(byte[] arg0, String max_face_num) {
		try {

			HashMap<String, String> options = new HashMap<String, String>();
			options.put("face_field", "age,beauty,expression,faceshape,gender,glasses,race,qualities");
			options.put("max_face_num", max_face_num);
			//LIVE表示生活照：通常为手机、相机拍摄的人像图片、或从网络获取的人像图片等
			options.put("face_type", "LIVE");

			// 图片数据
			String imgStr = Base64Util.encode(arg0);
			String imageType = "BASE64";
			JSONObject res = client.detect(imgStr, imageType, options);
			System.out.println(res.toString(2));
			return res.toString();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 活体检测
	 * @param arg0
	 * @return
	 */
	public static String faceverify(byte[] arg0){
		String imgStr = Base64Util.encode(arg0);
        String imageType = "BASE64";
        FaceVerifyRequest req = new FaceVerifyRequest(imgStr, imageType);
        ArrayList<FaceVerifyRequest> list = new ArrayList<FaceVerifyRequest>();
        list.add(req);
        JSONObject res = client.faceverify(list);
        return res.toString();
	}

	/**
	 *<p>Title: FileToByte</p>
	 *<p>功能描述: 测试使用</p>
	 * @param file
	 * @return
	 * @throws IOException
	 */
	private static byte[] FileToByte(File file) throws IOException {
		// 将数据转为流
		InputStream content = new FileInputStream(file);
		ByteArrayOutputStream swapStream = new ByteArrayOutputStream();
		byte[] buff = new byte[100];
		int rc = 0;
		while ((rc = content.read(buff, 0, 100)) > 0) {
			swapStream.write(buff, 0, rc);
		}
		// 获得二进制数组
		return swapStream.toByteArray();
	}
}
