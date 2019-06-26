package com.cdut.Service.Impl;

import com.cdut.Bean.App;
import com.cdut.Bean.AppExample;
import com.cdut.Mapper.AppMapper;
import com.cdut.Mapper.UserAppMapper;
import com.cdut.Service.AppService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class AppServiceimpl implements AppService {

    @Autowired
    private AppMapper appMapper;

    @Autowired
    private UserAppMapper userAppMapper;

    @Override
    public App queryByNameAndVersion(String name, String version){
        App app = new App();
        app.setAppname(name);
        app.setVersion(version);

        AppExample appExample =new AppExample();
        AppExample.Criteria criteria =appExample.createCriteria();
        //添加查询条件
        criteria.andAppnameEqualTo(app.getAppname());
        criteria.andVersionEqualTo(app.getVersion());
        List<App> result=appMapper.selectByExample(appExample);
        if(result.isEmpty()){
            return null;
        }
        else
            return result.get(0);
    }

    @Override
    public boolean uploadApp(App app){
        AppExample appExample=new AppExample();
        AppExample.Criteria criteria =appExample.createCriteria();
        criteria.andVersionEqualTo(app.getVersion());
        criteria.andAppnameEqualTo(app.getAppname());
        if (appMapper.selectByExample(appExample).isEmpty()){
            return false;
        }
        appMapper.insert(app);
        return true;
    }

    @Override
    public boolean deleteApp(Long id){
        AppExample appExample=new AppExample();
        AppExample.Criteria criteria=appExample.createCriteria();
        criteria.andIdEqualTo(id);
        if(appMapper.selectByExample(appExample).isEmpty()){
            return false;
        }
        appMapper.deleteByExample(appExample);
        return true;
    }

    @Override
    public List<App> queryByAppname(String appname){
        AppExample appExample=new AppExample();
        AppExample.Criteria criteria=appExample.createCriteria();
        criteria.andAppnameEqualTo(appname);
        return appMapper.selectByExample(appExample);
    }

    @Override
    public List<App> queryByUsername(String username){
        return userAppMapper.queryAppByUserName(username);
    }

    @Override
    public List<App> queryAllApp(){
        AppExample appExample=new AppExample();
        return appMapper.selectByExample(appExample);
    }

    @Override
    public int countApp(){
        AppExample appExample =new AppExample();
        appExample.createCriteria();
        return appMapper.countByExample(appExample);
    }

    @Override
    public List<App> selectSpeRowApp(int startRow, int pageSize){
        Map<String, Integer> map = new HashMap();
        map.put("startRow", startRow);
        map.put("pageSize", pageSize);
        return appMapper.selectSpeRowApp(map);
    }
}
