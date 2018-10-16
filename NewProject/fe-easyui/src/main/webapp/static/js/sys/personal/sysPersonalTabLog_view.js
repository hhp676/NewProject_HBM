var sysPersonalTabLogViewGrid = new HgUi.Datagrid("sysPersonalTabLogView_grid");
sysPersonalTabLogViewGrid.toolbar = $ ("#sysPersonalTabLog_toolbar");
sysPersonalTabLogViewGrid.options.tipCells = ["operCode","operName","reqUri","operIp","key1","key2","key3","content","operRes","crtTime"];
sysPersonalTabLogViewGrid.init();
sysPersonalTabLogViewGrid.grid.datagrid("enableFilter");
//清空查询---------------------------------------------------------------------------------------------------
sysPersonalTabLogViewGrid.toolbar.find("[tag=clear]").click(function() {
	sysPersonalTabLogViewGrid.grid.datagrid("removeFilterRule");
	sysPersonalTabLogViewGrid.grid.datagrid("load", {});
});