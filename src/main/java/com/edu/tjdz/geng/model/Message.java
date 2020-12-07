package com.edu.tjdz.geng.model;

import java.util.HashMap;
import java.util.Map;

public class Message {
    //100-成功，200-失败
    private int code;
    //返回一些相关信息
    private String msg;

    //核心属性，数据库查询出来的结果就放在datas中
    private Map<String, Object> datas = new HashMap<String, Object>();

    public static Message success() {
        Message result = new Message();
        result.setCode(100);
        result.setMsg("处理成功");
        return result;
    }

    public static Message fail() {
        Message result = new Message();
        result.setCode(200);
        result.setMsg("处理失败");
        return result;
    }

    //核心方法，调用它就可以网datas中放置任意数据。
    public Message add(String key, Object value) {
        this.getDatas().put(key, value);
        return this;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getDatas() {
        return datas;
    }

    public void setDatas(Map<String, Object> datas) {
        this.datas = datas;
    }
}