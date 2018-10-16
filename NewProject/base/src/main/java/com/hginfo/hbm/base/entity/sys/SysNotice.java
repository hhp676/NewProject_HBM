/*
 * Project Name:hbm-base.
 * File Name:SysNotice.java
 * Package Name:com.hginfo.hbm.base.entity.sys
 * Date:2017年06月27日 下午6:54:47
 * Copyright (c) 2016, hongguaninfo.com All Rights Reserved.
 */
package com.hginfo.hbm.base.entity.sys;


import com.hginfo.hbm.base.BizEntity;
import com.hginfo.hbm.base.meta.TableMeta;
import org.hibernate.annotations.DynamicInsert;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Transient;
import java.util.Date;

/**
 * 通知公告: sys_notice. <br />
 * entity 层 <br />
 * Date: 2017年06月27日 下午6:54:47 <br />
 *
 * @author yinyanzhen
 * @since V1.0.0
 */
@Entity(name = "SYS_NOTICE")
@DynamicInsert
public class SysNotice extends BizEntity {

    /**
     * serialVersionUID.
     * @since V1.0.0
     */
    private static final long serialVersionUID = 1L;

    /**
     * 数据库表元数据。
     */
    static final TableMeta TABLE_META = new TableMeta();

    static {
        TABLE_META.setAlias("sn");
        TABLE_META.addField("noticeId", "NOTICE_ID_", Long.class);
        TABLE_META.addField("sortNo", "SORT_NO_", Long.class);
        TABLE_META.addField("startTime", "START_TIME_", Date.class);
        TABLE_META.addField("endTime", "END_TIME_", Date.class);
        TABLE_META.addField("autoPub", "AUTO_PUB_", Integer.class);
        TABLE_META.addField("title", "TITLE_", String.class);
        TABLE_META.addField("content", "CONTENT_", String.class);
        TABLE_META.addField("isDelete", "IS_DELETE_", Integer.class);
        TABLE_META.addField("isFinal", "IS_FINAL_", Integer.class);
        TABLE_META.addField("crtTime", "CRT_TIME_", Date.class);
        TABLE_META.addField("updTime", "UPD_TIME_", Date.class);
        TABLE_META.addField("crtUserId", "CRT_USER_ID_", Long.class);
        TABLE_META.addField("updUserId", "UPD_USER_ID_", Long.class);
    }

    /**
     * NOTICE_ID_ : 主键。
     */
    private Long noticeId;
    /**
     * SORT_NO_ : 排序。
     */
    private Long sortNo;
    /**
     * START_TIME_ : 开始时间。
     */
    private Date startTime;
    /**
     * END_TIME_ : 结束时间。
     */
    private Date endTime;
    /**
     * AUTO_PUB_ : 自动发布(0否,1是)。
     */
    private Integer autoPub;
    /**
     * TITLE_ : 标题。
     */
    private String title;
    /**
     * CONTENT_ : 正文。
     */
    private String content;

    @Override
    @Transient
    public Long getId() {
        return getNoticeId();
    }

    @Override
    public void setId(Long id) {
        setNoticeId(id);
    }

    @Id
    @Column(name = "NOTICE_ID_")
    public Long getNoticeId() {
        return noticeId;
    }

    public void setNoticeId(Long noticeId) {
        this.noticeId = noticeId;
    }

    @Column(name = "SORT_NO_")
    public Long getSortNo() {
        return sortNo;
    }

    public void setSortNo(Long sortNo) {
        this.sortNo = sortNo;
    }

    @Column(name = "START_TIME_")
    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    @Column(name = "END_TIME_")
    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    @Column(name = "AUTO_PUB_")
    public Integer getAutoPub() {
        return autoPub;
    }

    public void setAutoPub(Integer autoPub) {
        this.autoPub = autoPub;
    }

    @Column(name = "TITLE_")
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    @Column(name = "CONTENT_")
    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    @Override
    @Transient
    public TableMeta getTableMeta() {
        return TABLE_META;
    }

}
