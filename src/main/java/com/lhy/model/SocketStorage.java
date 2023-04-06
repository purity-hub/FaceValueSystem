package com.lhy.model;

import javax.websocket.Session;
import java.util.concurrent.ConcurrentHashMap;

public class SocketStorage {

    private SocketStorage() {
    }

    public static ConcurrentHashMap<String, Session> sessionMap = new ConcurrentHashMap<String, Session>();

    public static ConcurrentHashMap<String, String> nameMap = new ConcurrentHashMap<String, String>();

    public static ConcurrentHashMap<String, String> roomMap = new ConcurrentHashMap<String, String>();
}
