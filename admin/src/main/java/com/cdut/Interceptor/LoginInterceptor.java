package com.cdut.Interceptor;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoginInterceptor extends HandlerInterceptorAdapter {

    private Logger logger = LoggerFactory.getLogger(LoggerFactory.class);

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        logger.info("执行prehandle方法");
        String username =  (String)request.getSession().getAttribute("name");
        if(username == null){
            logger.info("Interceptor：跳转到login页面！");

            request.getRequestDispatcher("/page/login").forward(request, response);
            return false;
        }else {
            return true;
        }
    }
}
