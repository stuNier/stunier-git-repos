package com.cdut.Service.Impl;

import com.cdut.Bean.User;
import com.cdut.Mapper.UserMapper;
import com.cdut.Service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    private Logger logger = LoggerFactory.getLogger(UserService.class);

    @Override
    public User queryUserByName(String name) {
        User user = new User();
        user.setName(name);
        List<User> result = userMapper.select(user);
        if(result.size() == 0){
            logger.info("未查询到该用户名，用户为空");
            return null;
        }
        return result.get(0);
    }

    @Override
    public User queryUserByPhone(String phone){
        User user = new User();
        user.setPhone(phone);
        List<User> result = userMapper.select(user);
        if(result.size() == 0){
            logger.info("phone未注册");
            return null;
        }
        return result.get(0);
    }

    @Override
    public User queryUserByEmail(String email){
        User user = new User();
        user.setEmail(email);
        List<User> result = userMapper.select(user);
        if(result.size() == 0){
            logger.info("email未注册");
            return null;
        }
        return result.get(0);
    }

    @Override
    public Boolean addUser(User user){
        if(userMapper.select(user).size() == 0){
            user.setCreated(new Date());
            user.setUpdated(new Date());
            userMapper.insert(user);
            return true;
        }
        return false;
    }
}
