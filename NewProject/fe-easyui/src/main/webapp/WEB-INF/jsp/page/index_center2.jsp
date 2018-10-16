<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ include file="/WEB-INF/jsp/common/meta.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="easyui-layout" fit=true>
		<div region="west" style="width: 230px;" split=true>
			<div class="easyui-accordion" fit=true style="width: 230px;"
				id="indexAccord">
				<div title="&nbsp;组织管理1" data-options="iconCls:'icon_zuzhi_16'">
					<table class="easyui-datagrid" fit=true
						data-options="autoRowHeight:true" showHeader=false
						singleSelect=true style="width: 230px;">
						<thead>
							<tr>
								<th data-options="field:'listprice',width:'500px'">List
									Price</th>
							</tr>
						</thead>
						<tr>
							<td><span style="display: block; padding-left: 5px;">
									<a href="#" class="easyui-linkbutton"
									data-options="plain:true,iconCls:'icon_dot'">&nbsp;&nbsp;&nbsp;菜单1</a>
							</span></td>
						</tr>
						<tr>
							<td><span style="display: block; padding-left: 5px;">
									<a href="#" class="easyui-linkbutton"
									data-options="plain:true,iconCls:'icon_dot'">&nbsp;&nbsp;&nbsp;菜单222</a>
							</span></td>
						</tr>
					
					</table>
				</div>
				<div title="&nbsp;组织管理2" data-options="iconCls:'icon_zuzhi_16'">
					<table class="easyui-datagrid" fit=true
						data-options="autoRowHeight:true" showHeader=false
						singleSelect=true style="width: 230px;">
						<thead>
							<tr>
								<th data-options="field:'listprice',width:'500px'">List
									Price</th>
							</tr>
						</thead>
						<tr>
							<td><span style="display: block; padding-left: 5px;">
									<a href="#" class="easyui-linkbutton"
									data-options="plain:true,iconCls:'icon_dot'">&nbsp;&nbsp;&nbsp;菜单111</a>
							</span></td>
						</tr>
						<tr>
							<td><span style="display: block; padding-left: 5px;">
									<a href="#" class="easyui-linkbutton"
									data-options="plain:true,iconCls:'icon_dot'">&nbsp;&nbsp;&nbsp;菜单22222222</a>
							</span></td>
						</tr>
						
					</table>
				</div>
				<div title="&nbsp;组织管理3" data-options="iconCls:'icon_zuzhi_16'"
					style="padding: 10px;"></div>
				
			</div>
		</div>
		<div region="center">
			<div id="tab" class="easyui-tabs" fit=true>
				<div data-options="iconCls:'icon_auto_blue__home'" title="首页">
					welcome!!!!!!!!!!!!!!!1111
				</div>
			</div>
		</div>
	</div>

</body>

</html>