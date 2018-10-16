package com.xxl.job.core.registry.impl;

import com.xxl.job.core.registry.RegistHelper;
import com.xxl.job.core.util.DBUtil;

import javax.sql.DataSource;

/**
 * Created by xuxueli on 16/9/30.
 */
public class DbRegistHelper implements RegistHelper {
    
    private static String ORACLE = "oracle";

    private DataSource dataSource;
    
    private String dbType;
    
    public void setDataSource(DataSource dataSource) {
        this.dataSource = dataSource;
    }
    
    public void setDbType(String dbType) {
        this.dbType = dbType;
    }

    @Override
    public int registry(String registGroup, String registryKey, String registryValue) {
        
        String updateSql = "";
        String insertSql = "";
        if (ORACLE.equals(dbType)) {
            updateSql = "UPDATE JOB_TRIGGER_REGISTRY SET update_time_ = sysdate WHERE registry_group_ = ? AND registry_key_ = ? AND registry_value_ = ?";
            insertSql = "INSERT INTO JOB_TRIGGER_REGISTRY( id_, registry_group_ , registry_key_ , registry_value_, update_time_) VALUES(seq_job_trigger_registry_id.nextval , ? , ? , ?, sysdate)";
        } else {
            updateSql = "UPDATE JOB_TRIGGER_REGISTRY SET update_time_ = NOW() WHERE registry_group_ = ? AND registry_key_ = ? AND registry_value_ = ?";
            insertSql = "INSERT INTO JOB_TRIGGER_REGISTRY( registry_group_ , registry_key_ , registry_value_, update_time_) VALUES(? , ? , ?, NOW())";
        }
        
        
        int ret = DBUtil.update(dataSource, updateSql, new Object[]{registGroup, registryKey, registryValue});
        if (ret<1) {
            ret = DBUtil.update(dataSource, insertSql, new Object[]{registGroup, registryKey, registryValue});
        }
        return ret;
    }
}
