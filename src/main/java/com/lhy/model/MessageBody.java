package com.lhy.model;

import java.util.Date;

public class MessageBody {

    /**
     * 发送人姓名
     */
    private String fromName;

    /**
     * 接收人姓名
     */
    private String toName;

    /**
     * 消息内容
     */
    private String content;

    /**
     *
     * 发送时间
     */
    private Date sendTime;

    public MessageBody() {
    }

    public MessageBody(String fromName, String toName, String content, Date sendTime) {
        this.fromName = fromName;
        this.toName = toName;
        this.content = content;
        this.sendTime = sendTime;
    }

    public String getFromName() {
        return fromName;
    }

    public void setFromName(String fromName) {
        this.fromName = fromName;
    }

    public String getToName() {
        return toName;
    }

    public void setToName(String toName) {
        this.toName = toName;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getSendTime() {
        return sendTime;
    }

    public void setSendTime(Date sendTime) {
        this.sendTime = sendTime;
    }
}
