package com.lhy.utils.testdemo;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

/**
 * <p>Title: ImageTest.java</p>
 * @author smallFish
 * @version 1.0
 * <p>功能描述: </p>
 */
public class ImageTest {
	 public static void main(String[] args) throws IOException {
	        BufferedImage image = ImageIO.read(new File("C:\\Users\\BigBoss\\Pictures\\2.jpg"));
	        Graphics g = image.getGraphics();
	        g.setColor(Color.green);//画笔颜色
	        g.drawRect(100, 100, 100, 100);//矩形框(原点x坐标，原点y坐标，矩形的长，矩形的宽)
	        //g.dispose();
	        FileOutputStream out = new FileOutputStream("C:\\Users\\BigBoss\\Pictures\\test.jpg");//输出图片的地址
	        ImageIO.write(image, "jpeg", out);
	    }
}

