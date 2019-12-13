package com.zcy.controller;


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
    public String hi(){
        return "hi";
    }

    @RequestMapping("/login")
    public String index() {
        return "redirect:hello.html";
    }

    @RequestMapping("hello/index")
    public ModelAndView templatesIndex(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("index");
        modelAndView.addObject("name", "SpringBoot");
        return modelAndView;
    }
    @RequestMapping("hello")
    public ModelAndView templatesHello(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("hello");
        modelAndView.addObject("name", "SpringBoot");
        return modelAndView;
    }

}

