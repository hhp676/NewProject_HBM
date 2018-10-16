package com.hginfo.hbm.fe.eu.web.sys;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hginfo.hbm.base.entity.sys.SysLog;
import com.hginfo.hbm.base.page.BasePage;
import com.hginfo.hbm.base.service.sys.SysLogService;
import com.hginfo.hbm.fe.eu.page.Page;
import com.hginfo.hdubbo.annotation.HReference;
import com.hginfo.hutils.StringUtil;

/**
 * ClassName:SysLogController.
 * Date: 2016年12月27日 上午10:51:05 <br/>
 * @author yangfeng
 * @since V1.0.0
 */
@Controller
@RequestMapping("/sys/sysLog")
public class SysLogController {
    
    /**
     * Service.
     */
    @HReference
    private SysLogService sysLogService;
    
    /**
     * view.
     * @author yangfeng
     * @return page
     * @since V1.0.0
     */
    @RequestMapping(value = "/view")
    public String showSysLog() {
        return "sys/log/sysLog_view";
    }
    
    /**
     * 分页数据。
     * @param pageInfo 分页信息
     * @param formFilter 表单过滤条件
     * @param keyword 关键字
     * @return 字典组分页数据
     */
    @RequestMapping(value = "/list")
    @ResponseBody
    public Page<SysLog> list(BasePage<SysLog> pageInfo, SysLog formFilter, String keyword) {
        parseKeyword(formFilter, keyword);
        return new Page<>(sysLogService.getPageList(pageInfo, formFilter));
    }
    
    /**
     * parseKeyword.
     * @author yangfeng
     * @param formFilter formFilter
     * @param keyword keyword
     * @since V1.0.0
     */
    private void parseKeyword(SysLog formFilter, String keyword) {
        if (!StringUtil.isEmptyOrBlank(keyword)) {
            StringBuilder sb = new StringBuilder();
            sb.append(" AND (");
            sb.append(" KEY1_ LIKE '%").append(keyword).append("%' OR ");
            sb.append(" KEY2_ LIKE '%").append(keyword).append("%' OR ");
            sb.append(" KEY3_ LIKE '%").append(keyword).append("%' OR ");
            sb.append(" KEY4_ LIKE '%").append(keyword).append("%' OR ");
            sb.append(" KEY5_ LIKE '%").append(keyword).append("%')");
            formFilter.setFilterStr(sb.toString());
        }
    }
    
}
