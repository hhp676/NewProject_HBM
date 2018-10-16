/**
 * Project Name:hbm-fe-easyui
 * File Name:CommonController.java
 * Package Name:com.hginfo.hbm.fe.eu.web
 * Date:2017年3月8日上午10:24:03
 * Copyright (c) 2017, hongguaninfo.com All Rights Reserved.
 *
 */

package com.hginfo.hbm.fe.mc.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hginfo.hbm.base.entity.sys.SysUser;
import com.hginfo.hbm.base.service.sys.SysUserService;
import com.hginfo.hdubbo.annotation.HReference;
import com.hginfo.hutils.SmsUtil;
import com.hginfo.hutils.StringUtil;

/**
 * 全局公共组件Controller层：需要赋权。
 * ClassName:CommonController <br/>
 * Date: 2017年3月8日 上午10:24:03 <br/>
 * @since V1.0.0
 */
@Controller
@RequestMapping("/common")
public class CommonController {
    
    /**
     * 
     */
    @HReference
    private SysUserService sysUserService;
    
    
    /**
     * 用户详情，除用户管理模块外使用。
     * @param userId 
     * @param model 
     * @return 用户详情页
     */
    @RequestMapping(value = "/sysUser/detail/{userId}")
    public String showSysUserViewOnly(@PathVariable Long userId, Model model) {
        SysUser user = sysUserService.getUserById(userId);
        if (user != null && StringUtil.isNotEmpty(user.getMobile())) {
            user.setMobile(SmsUtil.hidePhone4Number(user.getMobile()));
        }
        model.addAttribute("user", user);
        return "sys/user/common/sysUserInfo_detail";
    }
    
}

