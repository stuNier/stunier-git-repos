package com.cdut.Service;

import com.cdut.Bean.App;

import java.util.List;

public interface AppService {
    public App queryByNameAndVersion(String name, String version);
    public boolean uploadApp(App app);
    public boolean deleteApp(Long id);
    public List<App> queryByAppname(String appname);
    public List<App> queryByUsername(String username);
    public List<App> queryAllApp();
    public int countApp();
    public List<App> selectSpeRowApp(int startRow, int pageSize);

}
