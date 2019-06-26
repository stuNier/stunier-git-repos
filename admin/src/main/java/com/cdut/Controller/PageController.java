package com.cdut.Controller;


import com.cdut.Commons.ResultUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@ResponseBody
public class PageController {

    private Logger logger = LoggerFactory.getLogger(PageController.class);

    @RequestMapping("/page/{pageName}")
    public ModelAndView toPage(@PathVariable(value = "pageName") String pageName){
        logger.info("pageName:{}",pageName);
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName(pageName);
        return modelAndView;
    }

    @RequestMapping("/result")
    public ResultUtils resultUtils(){
        ResultUtils resultUtils = new ResultUtils();
        resultUtils.setResultCode(200);
        resultUtils.setResultMessage("返回成功");
        return resultUtils;
    }
}
