package com.lhy.controller;

import com.alibaba.fastjson.JSONObject;
import com.lhy.model.MessageBody;
import com.lhy.model.SocketStorage;
import org.springframework.stereotype.Component;

import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import java.io.EOFException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;

@Component
@ServerEndpoint("/socket/{name}")
public class TestWebSocket {

    @OnOpen
    public void onOpen(@PathParam("name") String name, Session session) throws IOException {
        if (SocketStorage.sessionMap.putIfAbsent(name, session) != null){
            throw new RuntimeException("用户名已存在，请更换用户名。");
        }
        SocketStorage.nameMap.put(session.getId(), name);
        MessageBody systemMessage = new MessageBody();
        systemMessage.setContent(name + "成功建立连接");
        systemMessage.setFromName("system");
        //通知自己
        session.getBasicRemote().sendText(JSONObject.toJSONString(systemMessage));
        //只有一个人
        if (SocketStorage.sessionMap.size() == 1){
            systemMessage.setContent("当前只有你一个人在线");
            session.getBasicRemote().sendText(JSONObject.toJSONString(systemMessage));
        }
        //只有两个用户
        if (SocketStorage.sessionMap.size() == 2){
            for (Session s : SocketStorage.sessionMap.values()){
                if(!s.getId().equals(session.getId())){
                    // 通知另一个用户
                    systemMessage.setToName(SocketStorage.nameMap.get(s.getId()));
                    systemMessage.setContent(name + "成功建立连接");
                    s.getBasicRemote().sendText(JSONObject.toJSONString(systemMessage));
                    systemMessage.setContent(SocketStorage.nameMap.get(s.getId()) + "已经在线");
                    session.getBasicRemote().sendText(JSONObject.toJSONString(systemMessage));
                    //加入房间
                    SocketStorage.roomMap.put(SocketStorage.nameMap.get(s.getId()), SocketStorage.nameMap.get(session.getId()));
                    SocketStorage.roomMap.put(SocketStorage.nameMap.get(session.getId()), SocketStorage.nameMap.get(s.getId()));
                }
            }
        }
        //大于两个用户
        if (SocketStorage.sessionMap.size() > 2){
            //随机选择一个用户,且这个用户不属于任何房间且不包括自己
            String randomId = null;
            for (String id : SocketStorage.sessionMap.keySet()){
                //id是名字
                if (SocketStorage.roomMap.get(id) == null && !id.equals(SocketStorage.nameMap.get(session.getId()))){
                    randomId = id;
                    break;
                }
            }
            if (randomId == null){
                systemMessage.setContent("房间已满，请稍后再试。");
                session.getBasicRemote().sendText(JSONObject.toJSONString(systemMessage));
            }else{
                //加入房间
                SocketStorage.roomMap.put(SocketStorage.nameMap.get(randomId), SocketStorage.nameMap.get(session.getId()));
                SocketStorage.roomMap.put(SocketStorage.nameMap.get(session.getId()), SocketStorage.nameMap.get(randomId));
                //通知另一个用户
                systemMessage.setToName(SocketStorage.nameMap.get(randomId));
                systemMessage.setContent(name + "成功建立连接");
                SocketStorage.sessionMap.get(randomId).getBasicRemote().sendText(JSONObject.toJSONString(systemMessage));
                systemMessage.setContent(SocketStorage.nameMap.get(randomId) + "已经在线");
                session.getBasicRemote().sendText(JSONObject.toJSONString(systemMessage));
            }
        }
    }

    @OnClose
    public void onClose(Session session){
        String name = SocketStorage.nameMap.remove(session.getId());
        SocketStorage.sessionMap.remove(name);
        //退出房间
        if(SocketStorage.roomMap.get(session.getId()) != null){
            SocketStorage.roomMap.remove(SocketStorage.nameMap.get(session.getId()));
            SocketStorage.roomMap.remove(SocketStorage.nameMap.get(SocketStorage.roomMap.get(session.getId())));
        }
    }

    @OnMessage
    public void onMessage(String message, Session session) throws IOException {
        MessageBody messageBody = JSONObject.parseObject(message, MessageBody.class);
        if (messageBody == null){
            return;
        }
        String fromUser = SocketStorage.nameMap.get(session.getId());
        //设置发消息的人
        messageBody.setFromName(fromUser);
        messageBody.setSendTime(new Date());
        //输出SocketStorage.roomMap
        for (String key : SocketStorage.roomMap.keySet()){
            System.out.println(key + " : " + SocketStorage.roomMap.get(key));
        }
        //输出SocketStorage.sessionMap
        for (String key : SocketStorage.sessionMap.keySet()){
            System.out.println(key + " : " + SocketStorage.sessionMap.get(key));
        }
        System.out.println(SocketStorage.roomMap.get(SocketStorage.nameMap.get(session.getId())));
        Session toSession = SocketStorage.sessionMap.get(SocketStorage.roomMap.get(SocketStorage.nameMap.get(session.getId())));
        System.out.println("toSession : " + toSession);
        messageBody.setToName(SocketStorage.nameMap.get(toSession.getId()));
        toSession.getBasicRemote().sendText(JSONObject.toJSONString(messageBody));
    }

    @OnError
    public void onError(Session session, Throwable error){
        if (error instanceof EOFException && error.getMessage() == null){
            String name = SocketStorage.nameMap.get(session.getId());
            SocketStorage.nameMap.remove(session.getId());
            SocketStorage.sessionMap.remove(name);
            //退出房间
            SocketStorage.roomMap.remove(session.getId());
            SocketStorage.roomMap.remove(SocketStorage.roomMap.get(session.getId()));
        }
    }
}
