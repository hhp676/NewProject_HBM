package com.hginfo.hbm.be.service.impl.sys.task;

import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import com.hginfo.hbm.base.entity.sys.SysUser;
import com.hginfo.hbm.base.entity.sys.news.SysNews;
import com.hginfo.hbm.base.entity.sys.news.SysNewsInner;
import com.hginfo.hbm.base.entity.sys.news.SysNewsOuter;
import com.hginfo.hbm.base.entity.sys.news.SysNewsTemplete;
import com.hginfo.hbm.base.entity.sys.news.SysNewsType;
import com.hginfo.hbm.base.entity.sys.task.SysTask;
import com.hginfo.hbm.base.entity.sys.task.SysTaskDo;
import com.hginfo.hbm.base.entity.sys.task.SysTaskHandleLog;
import com.hginfo.hbm.base.entity.sys.task.SysTaskHandler;
import com.hginfo.hbm.base.entity.sys.task.SysTaskNewsTemplete;
import com.hginfo.hbm.base.entity.sys.task.SysTaskType;
import com.hginfo.hbm.base.service.sys.task.SysTaskWebService;
import com.hginfo.hbm.be.freemarker.BeFreeMarkerFactory;
import com.hginfo.hbm.be.freemarker.FreeMarkerUtil;
import com.hginfo.hbm.be.service.impl.sys.SysUserServiceImpl;
import com.hginfo.hbm.be.service.impl.sys.news.SysNewsInnerServiceImpl;
import com.hginfo.hbm.be.service.impl.sys.news.SysNewsOuterServiceImpl;
import com.hginfo.hbm.be.service.impl.sys.news.SysNewsServiceImpl;
import com.hginfo.hbm.be.service.impl.sys.news.SysNewsTypeServiceImpl;
import com.hginfo.hdubbo.annotation.HService;
import com.hginfo.hutils.NumberUtil;
import com.hginfo.hutils.StringUtil;
import com.hginfo.hutils.exception.BaseRuntimeException;

import freemarker.template.Template;
import freemarker.template.TemplateException;

/**
 * task对外暴漏接口: SysTaskWebService. <br/>
 * @author yinyanzhen
 */
@HService
public class SysTaskWebServiceImpl implements SysTaskWebService {
    /**
     * 消息表记录消息来源.
     */
    private static final String NEWS_FROM = "sysTask";
    /**
     */
    @Autowired
    private SysUserServiceImpl sysUserService;
    /**
     */
    @Autowired
    private SysTaskServiceImpl          taskService;
    /**
     */
    @Autowired
    private SysTaskTypeServiceImpl          taskTypeService;
    /**
     */
    @Autowired
    private SysTaskNewsTempleteServiceImpl taskNewsTempleteService;
    /**
     */
    @Autowired
    private SysTaskHandlerServiceImpl   taskHandlerService;
    /**
     */
    @Autowired
    private SysTaskHandleLogServiceImpl taskHandleLogService;
    /**
     */
    @Autowired
    private SysNewsServiceImpl newsService;
    /**
     */
    @Autowired
    private SysNewsInnerServiceImpl newsInnerService;
    /**
     */
    @Autowired
    private SysNewsOuterServiceImpl newsOuterService;
    /**
     */
    @Autowired
    private SysNewsTypeServiceImpl newsTypeService;
    /**
     */
    @Autowired
    private BeFreeMarkerFactory freeMarkerFactory;
    
    @Override
    public void addSysTask(List<SysTask> sysTasks) {
        for (SysTask task : sysTasks) {
            //保存任务信息,并返回处理后的task,用于后续处理
            task = saveTaskInfo(task);
            //保存任务消息
            try {
                saveTaskNews(task);
            } catch (Exception e) {
                e.printStackTrace();
            }
            //保存任务办理日志
            SysTaskHandleLog handleLog = new SysTaskHandleLog();
            handleLog.setTaskId(task.getId());
            handleLog.setUserId(null);
            handleLog.setTaskHandleTime(new Date());
            handleLog.setTaskHandleType("0");
            taskHandleLogService.add(handleLog);
        }
    }
    
    @Override
    public void doSysTask(List<SysTaskDo> sysTaskDos) {
        for (SysTaskDo sysTaskDo : sysTaskDos) {
            //更新任务办理信息
            SysTask systask = this.getTaskByBuinessId(sysTaskDo.getBusinessId());
            if (systask == null || systask.getIsDelete() == 1) {
                throw new BaseRuntimeException("任务不存在,无法办理!");
            }
            if ("1".equals(systask.getTaskStatus())) {
                //已被办理过的任务,自动跳过,不再进行办理动作
                continue;
            }
            systask.setTaskStatus("1");
            taskService.update(systask);
            //任务办理消息处理
            saveNewsForDoTask(systask, sysTaskDo);
            
            //记录办理日志
            SysTaskHandleLog handleLog = new SysTaskHandleLog();
            handleLog.setTaskId(systask.getId());
            handleLog.setUserId(sysTaskDo.getUserId());
            handleLog.setTaskHandleTime(new Date());
            handleLog.setTaskHandleType("1");
            handleLog.setDescr(sysTaskDo.getDescr());
            taskHandleLogService.add(handleLog);
        }
    }
    /**
     * saveNewsForDoTask:(任务办理时消息处理). <br/>
     * @author yinyanzhen
     * @param systask systask
     * @param sysTaskDo sysTaskDo
     * @since V1.0.0
     */
    private void saveNewsForDoTask(SysTask systask, SysTaskDo sysTaskDo) {
        SysNews newsFilter = new SysNews();
        newsFilter.setBizId(systask.getId());
        newsFilter.setNewsFrom(NEWS_FROM);
        newsFilter.setNewsDoNode(1);
        //查询
//        newsService.getOne(filter, loadProps)
    }
    
    @Override
    public void deleteTasks(Long userId, List<Long> businessIds) {
        for (Long businessId : businessIds) {
            SysTask task = this.getTaskByBuinessId(businessId);
            //不存在任务,已经删除任务,不做处理
            if (task == null || "1".equals(task.getIsDelete())) {
                continue;
            }
            task.setIsDelete(1);
            taskService.update(task);
            //保存任务办理日志
            SysTaskHandleLog handleLog = new SysTaskHandleLog();
            handleLog.setTaskId(task.getId());
            handleLog.setUserId(userId);
            handleLog.setTaskHandleTime(new Date());
            handleLog.setTaskHandleType("2");
            taskHandleLogService.add(handleLog);
        }
    }
    
    @Override
    public void doReplaceTaskHandlers(List<SysTask> sysTasks) {
        for (SysTask sysTask : sysTasks) {
            //删除原办理人
            SysTaskHandler handler = new SysTaskHandler();
            handler.setTaskId(sysTask.getId());
            taskHandlerService.deleteBatch(handler);
            //添加新办理人
            for (Long taskHandlerId : sysTask.getBo().getSysTaskHandlerIds()) {
                SysTaskHandler taskHandler = new SysTaskHandler();
                taskHandler.setUserId(taskHandlerId);
                taskHandler.setTaskId(sysTask.getId());
                taskHandlerService.add(taskHandler);
            }
            //保存任务办理日志
            SysTaskHandleLog handleLog = new SysTaskHandleLog();
            handleLog.setTaskId(sysTask.getId());
            handleLog.setUserId(null);
            handleLog.setTaskHandleTime(new Date());
            handleLog.setTaskHandleType("3");
            taskHandleLogService.add(handleLog);
        }
        
    }
    
    /**
     * getTaskByBuinessId:(业务id获取任务信息). <br/>
     * @author yinyanzhen
     * @param businessId
     * @return SysTask SysTask
     * @since V1.0.0
     */
    @Override
    public SysTask getTaskByBuinessId(Long businessId) {
        SysTask sysTask = new SysTask();
        sysTask.setBusinessId(businessId);
        sysTask.setIsDelete(0);
        return taskService.getOne(sysTask);
        
    }

    /**
     * saveTaskInfo:(保存任务). <br/>
     * @author yinyanzhen
     * @param task task
     * @return  SysTask SysTask
     * @since V1.0.0
     */
    private SysTask saveTaskInfo(SysTask task) {
        //code获取任务类型
        SysTaskType taskType = new SysTaskType();
        taskType.setTaskTypeCode(task.getTaskTypeCode());
        taskType.setIsDelete(0);
        taskType = taskTypeService.getOne(taskType);
        //获取任务主键
        task.setId(taskService.getDao().getIdentityid());
        task.setTaskTypeId(taskType.getId());
        task.setTaskStatus("0");
        //保存任务
        taskService.getDao().save(task);
        for (Long taskHandlerId : task.getBo().getSysTaskHandlerIds()) {
            SysTaskHandler taskHandler = new SysTaskHandler();
            taskHandler.setUserId(taskHandlerId);
            taskHandler.setTaskId(task.getId());
            taskHandlerService.add(taskHandler);
        }
        return task;
    }

    /**
     * saveTaskNews:(保存任务发送消息). <br/>
     * @author yinyanzhen
     * @param task task
     * @throws TemplateException 
     * @throws IOException 
     * @since V1.0.0
     */
    private void saveTaskNews(SysTask task) throws IOException, TemplateException {
        //获取全部的消息类型
        SysNewsType filter = new SysNewsType();
        filter.setIsDelete(0);
        List<SysNewsType> newsTypes = newsTypeService.getAllList(filter);
        //保存办理人通知消息
        //遍历通知类型编码
        for (String newsTypeCode : task.getBo().getNewsTypeCodes()) {
            //匹配获取通知类型
            for (SysNewsType newsType : newsTypes) {
                if (newsType.getNewsTypeCode().equals(newsTypeCode)) {
                    //遍历处理节点
                    for (int newsDoNode : task.getBo().getNewsDoNodes()) {
                        SysTaskNewsTemplete sysTaskNewsTempleteFilter = new SysTaskNewsTemplete();
                        sysTaskNewsTempleteFilter.setNewsTypeId(newsType.getId());
                        sysTaskNewsTempleteFilter.setNewsDoNode(newsDoNode);
                        sysTaskNewsTempleteFilter.setTaskTypeId(task.getTaskTypeId());
                        //查询模版表,对应模版
                        SysTaskNewsTemplete sysTaskNewsTemplete = 
                            taskNewsTempleteService.getOne(sysTaskNewsTempleteFilter, "sysNewsTemplete");
                        //模版信息
                        SysNewsTemplete newsTemplete = sysTaskNewsTemplete.getSysNewsTemplete();
                        //获取使用的freemaker模版
                        Template temp = freeMarkerFactory.getTemplate(newsTemplete.getFreemakerPath());
                        //设定消息配置信息
                        SysNews sysNews = new SysNews();
                        sysNews.setId(newsService.getDao().getIdentityid());
                        sysNews.setNewsTypeId(newsType.getId());
                        sysNews.setNewsTempleteId(sysTaskNewsTemplete.getNewsTempleteId());
                        sysNews.setNewsFrom(NEWS_FROM);
                        sysNews.setNewsDoNode(newsDoNode);
                        sysNews.setBizId(task.getId());
                        sysNews.setIsToall(0);
                        //信息节点为新增动作时,需要设定详细消息,并进行发送
                        if (newsDoNode == 0) {
                            //当前环节为新增时,初始化信息
                            sysNews.setIsInit(1);
                            //遍历办理人
                            for (Long userId : task.getBo().getSysTaskHandlerIds()) {
                                SysUser user = sysUserService.getUserById(userId);
                                //
                                Map<String, Object> freeMakerMap = new HashMap();
                                freeMakerMap.put("user", user);
                                freeMakerMap.put("task", task);
                                String newsContent = FreeMarkerUtil.generateHtmlFromFtl(temp, freeMakerMap);
                                //根据是否内部消息,内部消息,需要存SysNewsInner,外部消息存SysNewsOuter
                                if (newsType.getIsIn() == 1) {
                                    SysNewsInner newsInner = new SysNewsInner();
                                    newsInner.setNewsId(sysNews.getId());
                                    newsInner.setUserId(userId);
                                    newsInner.setTimerLv(newsTemplete.getTimerLv());
                                    newsInner.setImportantLv(newsTemplete.getImportantLv());
                                    newsInner.setNewsTitle("任务新增:" + task.getTaskName());
                                    newsInner.setNewsContent(newsContent);
                                    //设置状态为待阅
                                    newsInner.setNewsStatus(0);
                                    newsInnerService.add(newsInner);
                                } else {
                                    SysNewsOuter newsOuter = new SysNewsOuter();
                                    newsOuter.setNewsId(sysNews.getId());
                                    newsOuter.setUserId(userId);
                                    newsOuter.setUserEmail(user.getEmail());
                                    newsOuter.setUserMobile(user.getMobile());
                                    newsOuter.setTimerLv(newsTemplete.getTimerLv());
                                    newsOuter.setImportantLv(newsTemplete.getImportantLv());
                                    newsOuter.setNewsTitle("任务新增:" + task.getTaskName());
                                    newsOuter.setNewsContent(newsContent);
                                    //设置发送次数以及发送状态
                                    newsOuter.setSendCount(0);
                                    newsOuter.setSendStatus(0);
                                    newsOuterService.add(newsOuter);
                                }
                            }
                        } else {
                            //其它环节不进行初始化
                            sysNews.setIsInit(0);
                        }
                        //保存消息
                        newsService.add(sysNews);
                    }
                }
            }
        }
        //保存业务通知消息
        for (SysNews.UserNew userNew : task.getBo().getUserNews()) {
            for (SysNewsType newsType : newsTypes) {
                if (newsType.getNewsTypeCode().equals(userNew.getNewsTypeCode())) {
                    //设定消息配置信息,业务通知,不存在模版与对应环节信息
                    SysNews sysNews = new SysNews();
                    sysNews.setId(newsService.getDao().getIdentityid());
                    sysNews.setNewsTypeId(newsType.getId());
                    sysNews.setNewsTempleteId(null);
                    sysNews.setNewsFrom(NEWS_FROM);
                    sysNews.setNewsDoNode(null);
                    sysNews.setBizId(task.getId());
                    sysNews.setIsInit(1);
                    sysNews.setIsToall(0);
                    SysUser user = sysUserService.getUserById(userNew.getUserId());
                    //根据是否内部消息,内部消息,需要存SysNewsInner,外部消息存SysNewsOuter
                    if (newsType.getIsIn() == 1) {
                        SysNewsInner newsInner = new SysNewsInner();
                        newsInner.setUserId(userNew.getUserId());
                        newsInner.setNewsId(sysNews.getId());
                        newsInner.setNewsTitle(userNew.getTitle());
                        newsInner.setNewsContent(userNew.getContent());
                        //设置状态为待阅
                        newsInner.setNewsStatus(0);
                        newsInnerService.add(newsInner);
                    } else {
                        SysNewsOuter newsOuter = new SysNewsOuter();
                        newsOuter.setUserId(userNew.getUserId());
                        newsOuter.setNewsId(sysNews.getId());
                        newsOuter.setUserEmail(user.getEmail());
                        newsOuter.setUserMobile(user.getMobile());
                        newsOuter.setNewsTitle(userNew.getTitle());
                        newsOuter.setNewsContent(userNew.getContent());
                        //设置发送次数以及发送状态
                        newsOuter.setSendCount(0);
                        newsOuter.setSendStatus(0);
                        newsOuterService.add(newsOuter);
                    }
                }
            }
        }
    }
    
}
