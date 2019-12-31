package com.zcy.controller;


import com.zcy.entity.SysUser;
import com.zcy.service.SysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import org.springframework.stereotype.Controller;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * 系统用户表 前端控制器
 *
 * @author zhuangcy
 * @since 2019-12-30
 */
@Controller
@RequestMapping("/user/")
public class SysUserController {
    @Autowired
    private SysUserService sysUserService;

    @GetMapping("list")
    @ResponseBody
    public List<SysUser> list(){
        List<SysUser> list = sysUserService.list();
        return list;
    }
    @GetMapping("get")
    @ResponseBody
    public SysUser get(@RequestParam Integer userId){
        SysUser sysUser = sysUserService.getById(userId);
        return sysUser;
    }

    @GetMapping("login")
    public String index() {
        return "index";
    }
}

