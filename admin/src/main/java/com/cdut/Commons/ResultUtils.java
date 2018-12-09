package com.cdut.Commons;

public class ResultUtils <T>{

    //数据结果
    private T data;

    //状态信息
    private String resultMessage;

    //状态码
    private int resultCode;


    public ResultUtils(T data, String resultMessage, int resultCode) {
        this.data = data;
        this.resultMessage = resultMessage;
        this.resultCode = resultCode;
    }

    public ResultUtils() {
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }

    public String getResultMessage() {
        return resultMessage;
    }

    public void setResultMessage(String resultMessage) {
        this.resultMessage = resultMessage;
    }

    public int getResultCode() {
        return resultCode;
    }

    public void setResultCode(int resultCode) {
        this.resultCode = resultCode;
    }
}
