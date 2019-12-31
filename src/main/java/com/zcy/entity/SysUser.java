package com.zcy.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import java.time.LocalDateTime;
import lombok.Data;
import lombok.experimental.Accessors;

/**
* 系统用户表
*
* @author zhuangcy
* @since 2019-12-31
*/
@Data
@Accessors(chain = true)
public class SysUser{

    /**
    * 用户主键id
    */
    @TableId(value = "user_id", type = IdType.AUTO)
    private Integer userId;

    /**
    * 用户名称
    */
    private String username;

    /**
    * 用户密码
    */
    private String password;

    /**
    * 性别
    */
    private String gender;

    /**
    * 手机号
    */
    private String phone;

    /**
    * 用户状态/0启用/1禁用
    */
    private Integer state;

    /**
    * 创建人id
    */
    private Integer createdId;

    /**
    * 创建人
    */
    private String createdBy;

    /**
    * 创建时间
    */
    private LocalDateTime createdDate;

    /**
    * 修改人id
    */
    private Integer updatedId;

    /**
    * 修改人
    */
    private String updatedBy;

    /**
    * 修改时间
    */
    private LocalDateTime updatedDate;
}
