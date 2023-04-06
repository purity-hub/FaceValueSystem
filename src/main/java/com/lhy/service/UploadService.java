package com.lhy.service;

public interface UploadService {
    public String uploadFileToNginx2(byte[] file, String fix);
    public String uploadImage(byte[] file, String fix);
}
