<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ include file="/WEB-INF/jsp/common/meta.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>选择表</title>
</head>
<body>
	<div class="easyui-layout" data-options="fit:true" id="sysMetaTable_layout">
		<div class="easyui-panel" data-options="fit:true">
			<table singleSelect=true fit=true id="sysMetaTable_grid" fitColumns=true rownumbers="true"
				data-options="url:'${ctx}/sys/sysMetadata/metaTableList'">
			    <thead>
			        <tr>
			            <th data-options="field:'tableName',width:150">表名</th>
			            <th data-options="field:'tableDesc',width:150">备注</th>
			        </tr>
			    </thead>
			</table>
		</div>
    <script type="text/javascript" src="${ctx}/static/js/sys/metadata/sysMetaTable_view.js?jsTimer=${jsTimer}"></script>
</body>
</html>