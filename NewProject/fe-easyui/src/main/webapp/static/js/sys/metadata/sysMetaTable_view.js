var sysMetaTableGrid = new HgUi.Datagrid("sysMetaTable_grid");
sysMetaTableGrid.options.isShowContextMenu = false;
sysMetaTableGrid.options.onDblClickRow = function(index,row) {
	if (window.sysMetaTableListWinCallback) {
		window.sysMetaTableListWinCallback(row);
    }
	$("#sysMetaTable_layout").layout().parent().window("close");
};

sysMetaTableGrid.options.onLoadSuccess = function(data) {
	sysMetaTableGrid.grid.datagrid("selectRow",0);
	sysMetaTableGrid.tipDblClick();
};

sysMetaTableGrid.options.remoteFilter = false;
sysMetaTableGrid.init();
sysMetaTableGrid.grid.datagrid("enableFilter");





