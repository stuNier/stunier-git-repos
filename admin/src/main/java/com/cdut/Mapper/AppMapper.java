package com.cdut.Mapper;

import com.cdut.Bean.App;
import com.cdut.Bean.AppExample;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

public interface AppMapper {
    int countByExample(AppExample example);

    int deleteByExample(AppExample example);

    int deleteByPrimaryKey(Long id);

    int insert(App record);

    int insertSelective(App record);

    List<App> selectByExampleWithBLOBs(AppExample example);

    List<App> selectByExample(AppExample example);

    App selectByPrimaryKey(Long id);

    int updateByExampleSelective(@Param("record") App record, @Param("example") AppExample example);

    int updateByExampleWithBLOBs(@Param("record") App record, @Param("example") AppExample example);

    int updateByExample(@Param("record") App record, @Param("example") AppExample example);

    int updateByPrimaryKeySelective(App record);

    int updateByPrimaryKeyWithBLOBs(App record);

    int updateByPrimaryKey(App record);

    //查询startRow到endRow的app数据
    List<App> selectSpeRowApp(Map<String ,Integer> map);

}