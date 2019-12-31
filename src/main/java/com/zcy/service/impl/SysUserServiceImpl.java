package com.zcy.service.impl;

import com.zcy.entity.SysUser;
import com.zcy.dao.SysUserMapper;
import com.zcy.service.SysUserService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * 系统用户表 服务实现类
 *
 * @author zhuangcy
 * @since 2019-12-31
 */
@Service
public class SysUserServiceImpl extends ServiceImpl<SysUserMapper, SysUser> implements SysUserService {

}
