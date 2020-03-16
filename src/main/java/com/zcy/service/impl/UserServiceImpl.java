package com.zcy.service.impl;

import com.zcy.entity.User;
import com.zcy.dao.UserDao;
import com.zcy.service.UserService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 *  服务实现类
 *
 * @author zhuangcy
 * @since 2020-03-16
 */
@Service
public class UserServiceImpl extends ServiceImpl<UserDao, User> implements UserService {

}
