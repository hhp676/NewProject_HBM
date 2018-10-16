var sysMetadataEntityGrid = new HgUi.Datagrid("sysMetadataEntity_grid");
sysMetadataEntityGrid.checkUpdateAuth = true;
sysMetadataEntityGrid.toolbar = $("#sysMetadataEntity_toolbar");
sysMetadataEntityGrid.mode = "rowEdit"; //行编辑模式
sysMetadataEntityGrid.options.isShowContextMenu = true;
sysMetadataEntityGrid.options.aboutUrl = "/sys/sysMetadata/aboutEntity";
sysMetadataEntityGrid.options.tipCells = ["entityCode", "entityName", "tableName", "tableAlias", "engName", "i18nCode", "descr"];

sysMetadataEntityGrid.options.onSelect = function(index,row) {
	//刷新字段列表
	if (row && row.entityId){
		sysMetadataEntityGrid.selectedRow = row;
		
		$("#sysMetadataField_grid").datagrid({url:G_CTX_PATH+"/sys/sysMetadata/fieldList/" + row.entityId});	
	}
};

sysMetadataEntityGrid.options.onLoadSuccess = function(data) {
	sysMetadataEntityGrid.grid.datagrid("selectRow",0);
};

sysMetadataEntityGrid.clickTableBtn = function(){
	window.sysMetaTableListWinCallback = function(row){
		var tableNameEd = sysMetadataEntityGrid.grid.datagrid('getEditor', {index:sysMetadataEntityGrid.editingIndex,field:"tableName"});
		$(tableNameEd.target).textbox("setValue",row.tableName);
		$(tableNameEd.target).textbox("setText",row.tableName);
	};
	
	HgUi.window({id:"sysMetaTableListWin",title:"选择表",width:650,height:400,
		url:"/sys/sysMetadata/sysMetaTableView"});
};


sysMetadataEntityGrid.init();
sysMetadataEntityGrid.grid.datagrid("enableFilter");


sysMetadataEntityGrid.bindDefaultToolbarEvent();

// --------------------------保存数据------------------------------------------------------------------
sysMetadataEntityGrid.toolbar.find("[tag=save]").click(function() {
	if (sysMetadataEntityGrid.isEditing == true) {
		if (sysMetadataEntityGrid.grid.datagrid("validateRow", sysMetadataEntityGrid.editingIndex)) {
			var data = sysMetadataEntityGrid.makeSubmitData();
			var editRow = sysMetadataEntityGrid.grid.datagrid("getRows")[sysMetadataEntityGrid.editingIndex];
			var submitUrl = "/sys/sysMetadata/addEntity";
			if (editRow.entityId) {
				submitUrl = "/sys/sysMetadata/updateEntity";
				data.entityId = editRow.entityId;
			}			
			HgUtil.post(submitUrl, data, function(data) {
				if (!data.success) {
					sysMetadataEntityGrid.showMsgbox("error",data.data,330);
				} else {
					HgUi.ok("保存成功!",function(){
						sysMetadataEntityGrid.grid.datagrid("reload");
					});
				}
			});

		} else {
			sysMetadataEntityGrid.showMsgbox("alert","有一条数据未校验通过!",180);
		}
	}

});


//-------------------------删除-----------------------------------------------------------------------
sysMetadataEntityGrid.toolbar.find("[tag=del]").click(function(){
	var row = sysMetadataEntityGrid.grid.datagrid("getSelected");
	if (!row) {
		$.messager.alert("提示","请选择一条实体数据","warning");
		return;
	}
	$.messager.confirm("确认删除", "确认将选中的实体删除?", function(r){
		if (r) {
			HgUtil.getJson("/sys/sysMetadata/deleteEntity",{entityId:row.entityId},function(data){
				if (!data.success) {
					$.messager.alert("提示","删除失败,"+data.data,"warning");
				} else {
					HgUi.ok("删除成功!",function(){
						sysMetadataEntityGrid.grid.datagrid("reload");
					});	
				}
			});
			
		}
	});
	
	
});






// 组织提交数据
sysMetadataEntityGrid.makeSubmitData = function() {
	return sysMetadataEntityGrid.getEditorsData();
};



// 清空查询---------------------------------------------------------------------------------------------------


sysMetadataEntityGrid.toolbar.find("[tag=clear]").click(function() {
	sysMetadataEntityGrid.grid.datagrid("getPanel").find("tr.datagrid-filter-row td input").each(function(){
		$(this).val("");
	});	
	sysMetadataEntityGrid.grid.datagrid("removeFilterRule");
	sysMetadataEntityGrid.grid.datagrid("load", {});
});

