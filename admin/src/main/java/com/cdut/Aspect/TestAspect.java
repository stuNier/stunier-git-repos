package com.cdut.Aspect;

import org.aspectj.lang.annotation.Aspect;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Aspect
public class TestAspect {

    private Logger logger= LoggerFactory.getLogger(TestAspect.class);

    public void before(){
        logger.info("AOP:before");
    }

    public void after(){
        logger.info("AOP:after");
    }
}
