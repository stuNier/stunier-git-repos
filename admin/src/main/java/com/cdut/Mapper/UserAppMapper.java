package com.cdut.Mapper;

import com.cdut.Bean.App;

import java.util.List;

public interface UserAppMapper {
     List<App> queryAppByUserName(String username);

}
