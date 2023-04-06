package com.lhy.controller;

import com.lhy.service.UserService;
import com.lhy.utils.FaceSpot;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.Objects;
import java.util.UUID;

@Controller
public class UserMessageController {

    @Value("${upload.path}")
    private String uploadPath;

    @Autowired
    private UserService userService;

    @RequestMapping("/userImage")
    public String userImage(@RequestParam("fileName")MultipartFile file, HttpSession session) throws Exception{
        if(file.getSize()!=0) {
            //获取原始图片的拓展名
            String fileType = Objects.requireNonNull(file.getOriginalFilename()).substring(file.getOriginalFilename().lastIndexOf("."));
            //新的文件名字
            String newFileName = (String) session.getAttribute("username") + fileType;
            //封装上传文件位置的全路径
            File targetFile = new File(uploadPath + "\\user", newFileName);
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
            userService.updateUserImage((String) session.getAttribute("username"),uploadPath + "\\user\\" + newFileName);
        }
        return "redirect:/mymessage";
    }
}
