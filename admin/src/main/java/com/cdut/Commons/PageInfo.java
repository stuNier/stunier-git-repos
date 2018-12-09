package com.cdut.Commons;

import java.util.List;

public class PageInfo <T>{

    //当前页码
    private int pageNum;

    //页面大小
    private int pageSize;

    //页面数
    private int pageTotal;

    //当前页面数据
    private List<T> data;

    public int getPageNum(){
        return pageNum;
    }
    public void setPageNum(int pageNum){
        this.pageNum = pageNum;
    }

    public int getPageSize(){
        return pageSize;
    }
    public void setPageSize(int pageSize){
        this.pageSize = pageSize;
    }

    public int getPageTotal(){
        return pageTotal;
    }
    public void setPageTotal(int pageTotal){
        this.pageTotal = pageTotal;
    }

    public List<T> getData(){
        return data;
    }

    public void setData(List<T> data){
        this.data = data;
    }
}
