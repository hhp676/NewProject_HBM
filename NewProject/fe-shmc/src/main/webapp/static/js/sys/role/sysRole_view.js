/**
 * 
 */
var sysRoleGrid = new HgUi.Datagrid("sysRole_grid");
sysRoleGrid.checkUpdateAuth = true;
sysRoleGrid.toolbar = $("#sysRole_toolbar");
sysRoleGrid.options = {
	onSelect: function(rowIndex, rowData) {
		$("#sysRoleAuthView").panel('refresh');
		
		sysRoleUserGrid.grid.datagrid('options').url = G_CTX_PATH + '/sys/sysUserRole/list';
		sysRoleUserGrid.grid.datagrid('reload', {
			roleId: rowData['roleId']
		});
	}
};
sysRoleGrid.mode = "rowEdit"; // 行编辑模式
sysRoleGrid.options.isShowContextMenu = true;
sysRoleGrid.options.contextMenuAboutHidden = false;
sysRoleGrid.options.tipCells = ["roleName","roleCode","descr"];
sysRoleGrid.options.aboutUrl = "/sys/sysRole/aboutOne";
sysRoleGrid.init();
sysRoleGrid.grid.datagrid('enableFilter', [
	{
	    field: 'isFinal',
	    type: 'combobox',
	    options: {
	    	panelHeight:'auto',
	    	editable:false,
            data:$.merge([{"text":"---请选择---","value":""}],HgUtil.getDictComboboxData('trueOrFalse')),
	        onChange: function(value) {
		        if (value == ''){
			        sysRoleGrid.grid.datagrid('removeFilterRule', 'isFinal');
		        }
		        else{
			        sysRoleGrid.grid.datagrid('addFilterRule', {
			            field: 'isFinal',
			            op: 'equal',
			            value: value
			        });
		        }
		        sysRoleGrid.grid.datagrid('doFilter');
	        }
	    }
	}
]);
sysRoleGrid.bindDefaultToolbarEvent();

// --------------------------保存数据------------------------------------------------------------------
sysRoleGrid.toolbar.find("[tag=save]").click(function() {
	if (sysRoleGrid.isEditing == true){
		if (sysRoleGrid.grid.datagrid("validateRow", sysRoleGrid.editingIndex)){
			var data = sysRoleGrid.getEditorsData();
			//console.log(data);
			var editRow = sysRoleGrid.grid.datagrid("getRows")[sysRoleGrid.editingIndex];
			var submitUrl = "/sys/sysRole/create";
			if (editRow.roleId){
				submitUrl = "/sys/sysRole/update";
				data.roleId = editRow.roleId;
			}
			if (!HgUtil.repeatSubmitCheck($(this), submitUrl)){
				return;
			}
			HgUtil.post(submitUrl, data, function(data) {
				if (!data.success){
					sysRoleGrid.showMsgbox("error", data.data, 330);
				}
				else{
					HgUi.ok("保存成功!", function() {
						sysRoleGrid.grid.datagrid("reload");
					});
				}
			});
			
		}
		else{
			sysRoleGrid.showMsgbox("alert", "有一条数据未校验通过!", 180);
		}
	}
	
});

// -------------------------删除-----------------------------------------------------------------------
sysRoleGrid.toolbar.find("[tag=del]").click(function() {
	var row = sysRoleGrid.grid.datagrid("getSelected");
	if (!row){
		$.messager.alert("提示", "请选择一条数据", "warning");
		return;
	}
	$.messager.confirm("确认删除", "确认删除选中数据?<br/>该动作将同时删除该角色设置的关联信息", function(r) {
		if (r){
			HgUtil.getJson("/sys/sysRole/delete", {
				roleId: row.roleId
			}, function(data) {
				if(data.success){
					HgUi.ok("删除成功!", function() {
						sysRoleGrid.grid.datagrid("reload");
					});
				}else{
					HgUi.error("删除失败!"+data.data);
				}
			});
			
		}
	});
	
});

// 清空查询---------------------------------------------------------------------------------------------------
sysRoleGrid.toolbar.find("[tag=clear]").click(function() {
	sysRoleGrid.grid.datagrid("removeFilterRule");
	sysRoleGrid.grid.datagrid("load", {});
});
