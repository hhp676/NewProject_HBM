/*
 * Project Name:hbm-be.
 * File Name:SysNoticeServiceImpl.java
 * Package Name:com.hginfo.hbm.be.service.impl.sys
 * Date:2017年06月27日 下午6:54:47
 * Copyright (c) 2016, hongguaninfo.com All Rights Reserved.
 *
 */
package com.hginfo.hbm.be.service.impl.sys;

import com.hginfo.hdubbo.annotation.HService;
import com.hginfo.hbm.be.dao.sys.SysNoticeDao;
import com.hginfo.hbm.be.service.base.BizService;
import com.hginfo.hbm.base.entity.sys.SysNotice;
import com.hginfo.hbm.base.service.sys.SysNoticeService;

/**
 * 通知公告: sys_notice. <br />
 * service impl 层 <br />
 * Date: 2017年06月27日 下午6:54:47 <br />
 *
 * @author yinyanzhen
 * @since V1.0.0
 */
@HService
public class SysNoticeServiceImpl extends BizService<SysNotice, SysNoticeDao>
        implements SysNoticeService {

}
