package com.hginfo.hbm.agent.org.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.hginfo.hbpm.agent.api.service.org.HbpmOrgService;

/**
 * hbpm-org-agent 的接口实现
 * Date: 2017年6月26日 下午5:32:31 <br/>
 * @author qun
 */
public class HbpmOrgServiceImpl extends BaseService implements HbpmOrgService {

    @Override
    public String getUserId(String postId) {
        List<String> userIdList = getUserIdListByPostId(postId);
        return userIdList == null ? null : userIdList.get(0);
    }

    @Override
    public List<String> getUserIdListByDeptId(String deptId) {
        
        List<String> userIdList = null;
        
        String sql = "SELECT DISTINCT sup.USER_ID_ USERID FROM SYS_USER_POSITION sup "
            + " LEFT JOIN sys_user su ON sup.USER_ID_ = su.USER_ID_ LEFT JOIN sys_position sp ON sup.POSITION_ID_ = sp.POSITION_ID_"
            + " WHERE su.IS_DELETE_ = 0 AND sp.IS_DELETE_ = 0"
            + " AND FIND_IN_SET( sp.ORG_ID_, get_org_children (?))";
        
        if (ORACLE.equals(dbType())) {
            sql = "SELECT DISTINCT sup.USER_ID_ USERID FROM SYS_USER_POSITION sup "
                + " LEFT JOIN sys_user su ON sup.USER_ID_ = su.USER_ID_ LEFT JOIN sys_position sp ON sup.POSITION_ID_ = sp.POSITION_ID_"
                + " WHERE su.IS_DELETE_ = 0 AND sp.IS_DELETE_ = 0"
                + " AND EXISTS(  "
                + "    SELECT so_temp.org_id_ "
                + "    FROM SYS_ORGANIZATION so_temp "
                + "    WHERE sp.org_id_ = so_temp.org_id_ "
                + "    START WITH so_temp.org_id_ = ? CONNECT BY PRIOR so_temp.org_id_ = so_temp.FID_ )";
        }
        
        List<Map<String, Object>> list = this.query(sql, new Object[]{ deptId });
        if (list != null && list.size() > 0) {
            userIdList = new ArrayList<>();
            for (Map<String, Object> map : list) {
                userIdList.add(map.get("USERID").toString());
            }
        }
        return userIdList;
        
    }

    @Override
    public List<String> getUserIdListByPostId(String postId) {
        List<String> userIdList = null;
        
        String sql = "SELECT DISTINCT sup.USER_ID_ USERID FROM SYS_USER_POSITION sup LEFT JOIN sys_user su ON sup.USER_ID_ = su.USER_ID_ WHERE su.IS_DELETE_ = 0 and FIND_IN_SET(sup.POSITION_ID_, get_pos_children(?))";
        if (ORACLE.equals(dbType())) {
            sql = "SELECT DISTINCT sup.USER_ID_ USERID FROM SYS_USER_POSITION sup LEFT JOIN sys_user su ON sup.USER_ID_ = su.USER_ID_ "
                + " WHERE su.IS_DELETE_ = 0 "
                + "  AND EXISTS( "
                + "    SELECT sp_temp.position_id_ "
                + "    FROM sys_position sp_temp "
                + "    WHERE sup.position_id_ = sp_temp.position_id_ "
                + "    START WITH sp_temp.position_id_ = ? CONNECT BY PRIOR sp_temp.position_id_ = sp_temp.FID_ )";
        }
        List<Map<String, Object>> list = this.query(sql, new Object[]{ postId });
        if (list != null && list.size() > 0) {
            userIdList = new ArrayList<>();
            for (Map<String, Object> map : list) {
                userIdList.add(map.get("USERID").toString());
            }
        }
        return userIdList;
    }

    @Override
    public String getUserName(String userId) {
        String sql = "select su.user_name_ USERNAME from sys_user su where su.user_id_ = ?";
        List<Map<String, Object>> list = this.query(sql, new Object[]{ userId });
        if (list != null && list.size() > 0) {
            return list.get(0).get("USERNAME").toString();
        }
        return null;
    }
    
}

