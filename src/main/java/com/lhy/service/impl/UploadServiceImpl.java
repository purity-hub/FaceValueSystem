package com.lhy.service.impl;

import com.lhy.service.UploadService;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

@Service
public class UploadServiceImpl implements UploadService {

    // 本地上传
    @Override
    public String uploadFileToNginx2(byte[] file, String fix) {

        String ROOT_PATH = "D:\\deptuploadImage\\";
        File targetFile = new File(ROOT_PATH);
        if (!targetFile.exists()) {
            targetFile.mkdirs();
        }
        FileOutputStream out = null;
//        String fileName = UUID.randomUUID().toString();
        String fileName = "test";
        try {
            out = new FileOutputStream(ROOT_PATH + fileName + fix);
            out.write(file);
            out.flush();
            out.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return fileName + fix;
    }

    @Override
    public String uploadImage(byte[] file, String fix) {
        String path = uploadFileToNginx2(file, fix);
        return path;
    }
}
