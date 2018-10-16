<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/meta.jsp"%>
<div class="easyui-panel" fit=true style="padding-top: 20px;">
	<table class="hgtable" id="modifyPwdTb">
		<tr style="height: 40px;">
			<td width="200px" align="right"><b>旧密码</b><sup>*</sup>：</td>
			<td width="200px;"><input class="easyui-textbox" name="oldPwd"
				type="password" style="width: 100%; height: 28px; padding: 5px"
				data-options="iconCls:'icon-lock',iconWidth:38" value="" /></td>
		</tr>
		<tr style="height: 40px;">
			<td align="right"><b>新密码</b><sup>*</sup>：</td>
			<td><input class="easyui-textbox" name="newPwd" type="password"
				style="width: 100%; height: 28px; padding: 5px"
				data-options="iconCls:'icon-lock',iconWidth:38,validType:'length[6,20]'" /></td>
		</tr>
		<tr style="height: 40px;">
			<td align="right"><b>确认新密码</b><sup>*</sup>：</td>
			<td><input class="easyui-textbox" name="repeatPwd"
				type="password" style="width: 100%; height: 28px; padding: 5px"
				data-options="iconCls:'icon-lock',iconWidth:38,validType:'length[6,20]'" /></td>

		</tr>
		<tr style="height: 40px;">
			<td></td>
			<td style="padding-top: 10px;">
				<a href="javascript:void(0);" class="btn btn-primary shiny btn-lg active" tag="save">
					<i class="fa fa-save"></i>
					保存
				</a>
			</td>

		</tr>

	</table>
</div>
<script type="text/javascript">
	$("#modifyPwdTb [tag=save]").click(function() {
		var oldPwd = $("#modifyPwdTb [name=oldPwd]").val();
		var newPwd = $("#modifyPwdTb [name=newPwd]").val();
		var repeatPwd = $("#modifyPwdTb [name=repeatPwd]").val();

		if (newPwd.length == 0 && oldPwd.length != 0) {
			$.messager.alert("提示","新密码不能为空","warning");
			return false;
		}if (newPwd.length !=0 && oldPwd.length == 0) {
			$.messager.alert("提示","旧密码不能为空","warning");
			return false;
		}if (oldPwd.length == 0 && newPwd.length == 0) {
			$.messager.alert("提示","新密码和旧密码不能为空","warning");
			return false;
		}
		if (newPwd != repeatPwd) {
			$.messager.alert("提示", "确认新密码与新密码不一致", "warning");
			return false;
		}
		HgUtil.post("/sys/sysPersonal/modifyPwd/update", {
			oldPwd : oldPwd,
			newPwd : newPwd
		}, function(data) {
			if (!data.success) {
				$.messager.alert("提示", data.data, "warning");
			} else {
				HgUi.ok("修改密码成功!", function() {
					var tab = new HgUi.Tab();
					tab.refreshCurrent();
				});
			}
		});
	});
</script>
