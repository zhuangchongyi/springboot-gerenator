package com.zcy.controller;


import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author zhuangcy
 * @since 2019-12-13
 */
@Controller
@RequestMapping("/hello/")
public class HelloController {

    @ResponseBody
    @RequestMapping("hi")
    public String hi(){
        return "hello";
    }


}

