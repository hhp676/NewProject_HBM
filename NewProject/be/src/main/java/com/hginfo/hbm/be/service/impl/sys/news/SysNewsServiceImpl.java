/*
 * Project Name:hbm-be.
 * File Name:SysNewsServiceImpl.java
 * Package Name:com.hginfo.hbm.be.service.impl.sys
 * Date:2017年06月27日 下午6:54:47
 * Copyright (c) 2016, hongguaninfo.com All Rights Reserved.
 *
 */
package com.hginfo.hbm.be.service.impl.sys.news;

import com.hginfo.hbm.base.entity.sys.news.SysNews;
import com.hginfo.hbm.base.service.sys.news.SysNewsService;
import com.hginfo.hbm.be.dao.sys.news.SysNewsDao;
import com.hginfo.hbm.be.service.base.BizService;
import com.hginfo.hdubbo.annotation.HService;

/**
 * 消息表: sys_news. <br />
 * service impl 层 <br />
 * Date: 2017年06月27日 下午6:54:47 <br />
 *
 * @author qiujingde
 * @since V1.0.0
 */
@HService
public class SysNewsServiceImpl extends BizService<SysNews, SysNewsDao>
        implements SysNewsService {

}
