package com.cdut.Controller;

import com.cdut.Bean.App;
import com.cdut.Commons.PageInfo;
import com.cdut.Commons.ResultUtils;
import com.cdut.Service.AppService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@ResponseBody
public class AppController {

    private int pageSize = 5;

    //分页信息
    private PageInfo<App> pageInfo = new PageInfo<> ();

    @Autowired
    private AppService appService;

    public AppController() {
        //设置单页大小
        pageInfo.setPageSize(pageSize);
    }

    @RequestMapping("/setpageinfo")
    public ResultUtils<PageInfo<App>> setPageInfo(){
        ResultUtils<PageInfo<App>> resultUtils= new ResultUtils();

        //初始化PageInfo 查询数据库的app记录数 查询第一页的记录
        int count = appService.countApp();
        int pageTotal = count/pageSize + 1;
        //设置总页数
        pageInfo.setPageTotal(pageTotal);
        //设置当前页
        pageInfo.setPageNum(1);
        //设置单页数据
        List<App> list= appService.selectSpeRowApp(0, pageInfo.getPageSize());
        pageInfo.setData(list);

        resultUtils.setData(pageInfo);
        resultUtils.setResultMessage("success");
        return resultUtils;
    }

    @RequestMapping("/getappinfo")
    public ResultUtils<PageInfo<App>> getAppInfo(int pagenum){
        ResultUtils<PageInfo<App>> resultUtils= new ResultUtils();

        pageInfo.setPageNum(pagenum);
        int startRow;
        startRow = (pagenum-1) * pageInfo.getPageSize();
        pageInfo.setData(appService.selectSpeRowApp(startRow, pageInfo.getPageSize()));

        resultUtils.setData(pageInfo);
        resultUtils.setResultMessage("success");
        return resultUtils;
    }

}
