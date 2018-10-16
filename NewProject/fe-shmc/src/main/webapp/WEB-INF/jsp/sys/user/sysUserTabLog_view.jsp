<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/meta.jsp"%>
<table singleSelect=true fit=true id="sysUserTabLogView_grid" striped=true
    fitColumns=true 
    class="" pagination="true"
        pageSize="${defaultPageSize}" pageList="${defaultPageList}" 
    data-options="url:'${ctx}/sys/sysUser/sysUserTabLogList?userId=${filter.userId}'">
    <thead>
        <tr>
            <th data-options="field:'userLogId',hidden:true,width:150">主键</th>
            <th data-options="field:'operCode',width:150">操作编码</th>
			<th data-options="field:'operName',width:150">操作名称</th>
			<th data-options="field:'reqUri',width:150">请求URI</th>
            <th data-options="field:'operIp',width:150">操作IP</th>
            <th data-options="field:'key1',width:100">关键词1</th>
            <th data-options="field:'key2',width:100">关键词2</th>
            <th data-options="field:'key3',width:100">关键词2</th>
            <th data-options="field:'operRes',width:50,
                formatter:HgUtil.fieldFormatterFunc('LOG_RESULT')" align="center">操作结果</th>
            <th data-options="field:'content',width:150">日志内容</th>
            <th data-options="field:'crtTime',width:150,formatter:HgUtil.formatToDateTime" align="center">操作时间</th>
        </tr>
    </thead>
</table>
    <div id="sysUserTabLog_toolbar" tag=listen_hotkey>
        
    </div>
    <script type="text/javascript" src="${ctx}/static/js/sys/user/sysUserTabLog_view.js"></script>
</body>
</html>