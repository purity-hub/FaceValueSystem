package com.lhy.utils;

import com.baidu.aip.face.AipFace;
import com.baidu.aip.face.FaceVerifyRequest;
import com.baidu.aip.util.Base64Util;
import org.json.JSONObject;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.UUID;

public class FaceSpot {
	/*
	 * 在你创建完毕应用后，平台将会分配给您此应用的相关凭证：API Key、Secret Key。
	 * 使用秘钥将可以在下一步中获取调用接口所需的Access Token。
	 */
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

	public static void main(String[] args) throws IOException {
		 String filePath = "C:\\img\\zt01.jpg";

		 byte[] imgData = FileToByte(new File(filePath));

		 System.out.println(detectFace(imgData,"1"));
//		String filePath1 = "F:/3.jpg";
//		String filePath2 = "F:/7.jpg";
//		byte[] imgData1 = FileUtil.readFileByBytes(filePath1);
//		byte[] imgData2 = FileUtil.readFileByBytes(filePath2);
//		System.out.println(faceverify(imgData1));
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
	/**
	 *<p>Title: FileToByte</p>
	 *<p>功能描述: 将上传的文件转换为字节流</p>
	 * @param file
	 * @return
	 * @throws IOException
	 */
	public static byte[] FileToByte(MultipartFile file){

		try {
			// 将数据转为流
			InputStream content = file.getInputStream();

			ByteArrayOutputStream swapStream = new ByteArrayOutputStream();
			byte[] buff = new byte[100];
			int rc = 0;
			while ((rc = content.read(buff, 0, 100)) > 0) {
				swapStream.write(buff, 0, rc);
			}
			// 获得二进制数组
			return swapStream.toByteArray();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	/**
	 *<p>Title: saveFile</p>
	 *<p>功能描述:将用户上传的文件保存至本地指定目录 </p>
	 */
	public static String saveFile(MultipartFile file,String savePath) {
		if (file.getSize()!=0) {
			//获取原始图片的拓展名
	        String originalFilename = file.getOriginalFilename();
	        //新的文件名字
	        String newFileName = UUID.randomUUID()+"_"+originalFilename;
	        //封装上传文件位置的全路径
	        File targetFile = new File(savePath,newFileName);
	        try {
	        	//把本地文件上传到封装上传文件位置的全路径
				file.transferTo(targetFile);
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

	        return newFileName;
		}

		return null;
	}
}
