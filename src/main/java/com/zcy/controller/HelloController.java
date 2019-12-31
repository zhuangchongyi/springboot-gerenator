package com.zcy.controller;


import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 * @author zhuangcy
 * @since 2019-12-13
 */
@Controller
public class HelloController {

    @ResponseBody
    @RequestMapping("hi")
    public String hi() {
        return "hi";
    }


    @RequestMapping("hello/index")
    public ModelAndView templatesIndex() {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("index");
        modelAndView.addObject("name", "SpringBoot");
        return modelAndView;
    }

    @RequestMapping("hello/{param}")
    public ModelAndView templatesHello(@PathVariable String param) {
        System.out.println(param);
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("hello/" + param);
        modelAndView.addObject("name", "SpringBoot");
        return modelAndView;
    }

}

