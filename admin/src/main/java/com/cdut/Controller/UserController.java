package com.cdut.Controller;

import com.cdut.Bean.User;
import com.cdut.Commons.ResultUtils;
import com.cdut.Service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.HashMap;
import java.util.Map;

@Controller
@ResponseBody
public class UserController {

    private Logger logger = LoggerFactory.getLogger(UserController.class);

    @Autowired
    private UserService userService;

    @RequestMapping("/user/{userName}")
    public User queryUser(@PathVariable(value = "userName") String name){
        return userService.queryUserByName(name);
    }

    /**
     * 登录
     * @param user 登录用户信息
     * @return
     */
    @RequestMapping("/login")
    public ResultUtils login(User user, HttpServletRequest request){
        ResultUtils resultUtils = new ResultUtils();
        userService.queryUserByName(user.getName());
        if(userService.queryUserByName(user.getName()).getPassword().equals(user.getPassword())){
            logger.info("登录成功");
            request.getSession().setAttribute("name", user.getName());
            resultUtils.setResultCode(200);
            resultUtils.setResultMessage("登录成功");
            Map<String , String> map = new HashMap<>();
            map.put("name", user.getName());
            resultUtils.setData(map);
            return resultUtils;
        }
        resultUtils.setResultMessage("登录失败，密码错误！");
        resultUtils.setResultCode(0);
        return resultUtils;

    }

    /**
     * 注册
     * @param user 注册用户信息
     * @return
     */
    @RequestMapping("/register")
    public ResultUtils register(@Valid User user){
        ResultUtils resultUtils = new ResultUtils();
        if(userService.addUser(user)){
            //添加成功
            resultUtils.setResultMessage("注册成功！");
            resultUtils.setResultCode(200);
            return resultUtils;
        }
        resultUtils.setResultMessage("注册失败！");
        resultUtils.setResultCode(0);
        //添加失败
        return resultUtils;
    }

    /**
     * 通过用户名查询用户，有该用户设置code：0，未注册code：200
     * @param name 用户名
     * @return
     */
    @RequestMapping("/checkname")
    public ResultUtils checkName(@RequestParam(value = "name") String name){
        logger.info(name);
        ResultUtils resultUtils = new ResultUtils();
        if(userService.queryUserByName(name)!=null){
            logger.info("该用户名已被注册！");
            resultUtils.setResultMessage("该用户名已被注册！");
            resultUtils.setResultCode(0);
            return resultUtils;
        }
        logger.info("可以使用的用户名");
        resultUtils.setResultMessage("可以使用的用户名");
        resultUtils.setResultCode(200);
        return resultUtils;
    }

    /**
     * 检测手机号是否被注册
     * @param phone
     * @return
     */
    @RequestMapping("/checkphone")
    public ResultUtils checkPhone(@RequestParam(value = "phone") String phone){
        logger.info(phone);
        ResultUtils resultUtils = new ResultUtils();
        if(userService.queryUserByPhone(phone)!=null){
            logger.info("该手机号已被注册！");
            resultUtils.setResultMessage("该手机号已被注册！");
            resultUtils.setResultCode(0);
            return resultUtils;
        }
        logger.info("可以使用的手机号");
        resultUtils.setResultMessage("可以使用的手机号");
        resultUtils.setResultCode(200);
        return resultUtils;
    }

    /**
     * 检测有限是否被注册
     * @param email
     * @return
     */
    @RequestMapping("/checkemail")
    public ResultUtils checkEmail(@RequestParam(value = "email") String email){
        logger.info(email);
        ResultUtils resultUtils = new ResultUtils();
        if(userService.queryUserByEmail(email)!=null){
            logger.info("该邮箱已被注册！");
            resultUtils.setResultMessage("该邮箱已被注册！");
            resultUtils.setResultCode(0);
            return resultUtils;
        }
        logger.info("可以使用的邮箱");
        resultUtils.setResultMessage("可以使用的邮箱");
        resultUtils.setResultCode(200);
        return resultUtils;
    }


    @RequestMapping("/getuserinfo")
    public ResultUtils getUserInfo(String username){
        ResultUtils<User> resultUtils = new ResultUtils<>();
        logger.info("getuserinfo : param = {}", username);

        User user = userService.queryUserByName(username);
        if(user == null){
            logger.info("用户名{}在数据库中不存在，无法查询到该用户名", username);
            resultUtils.setResultMessage("fail");
            resultUtils.setResultCode(0);
            return resultUtils;
        }
        resultUtils.setResultMessage("success");
        resultUtils.setResultCode(200);
        resultUtils.setData(user);
        return resultUtils;
    }


}
