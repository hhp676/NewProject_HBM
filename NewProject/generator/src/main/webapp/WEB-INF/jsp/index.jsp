<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@ include file="/WEB-INF/jsp/common/meta.jsp"%>
<title>HDP代码生成器</title>
</head>
<body>
	<form action="${ctx}/chooseTable" method="post">
		<div style="text-align: center;">
			<h3>HDP代码生成器</h3>
		</div>
		<div style="text-align: center;">
			<span style="color: red; ">${message}</span>
		</div>
		<table align="center">
			<tr>
				<td>驱动名称:</td>
				<td><input name="jdbcDriverName" value="${config.jdbcDriverName}" size="50"></td>
			</tr>
			<tr>
				<td>驱动URL:</td>
				<td><input name="jdbcDriverUrl" value="${config.jdbcDriverUrl}" size="80"></td>
			</tr>
			<tr>
				<td>用户名:</td>
				<td><input name="jdbcUserName" value="${config.jdbcUserName}" size="20"></td>
			</tr>
			<tr>
				<td>密 码:</td>
				<td><input name="jdbcPassword" value="${config.jdbcPassword}" type="password" size="20"></td>
			</tr>
			<tr>
				<td>schema:</td>
				<td><input name="jdbcSchema" value="${config.jdbcSchema}" type="text" size="20"></td>
			</tr>
			<tr>
				<td>包名称:</td>
				<td><input name="packageName" value="${config.packageName}" type="text" size="50"></td>
			</tr>
			<tr>
				<td>输出目录:</td>
				<td><input name="outPath" value="${config.outPath}" type="text" size="50"></td>
			</tr>			
			<tr>
				<td colspan="2" align="center" height="40"><input type="submit" value="下一步（选表）" size="50" /></td>
			</tr>
		</table>
	</form>
</body>
</html>
