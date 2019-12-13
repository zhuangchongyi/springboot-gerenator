package com.zcy.controller;


import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author zhuangcy
 * @since 2019-12-13
 */
@Controller
public class HelloController {

    @RequestMapping("hi")
    public String hi(){
        return "hello";
    }

}

