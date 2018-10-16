var sysUserTabLogViewGrid = new HgUi.Datagrid("sysUserTabLogView_grid");
sysUserTabLogViewGrid.toolbar = $ ("#sysUserTabLog_toolbar");
sysUserTabLogViewGrid.options.tipCells = ["operCode","operName","reqUri","operIp","key1","key2","key3","content","operRes","crtTime"];
sysUserTabLogViewGrid.init();

// 清空查询---------------------------------------------------------------------------------------------------
sysUserTabLogViewGrid.toolbar.find("[tag=clear]").click(function() {
    sysUserTabLogViewGrid.grid.datagrid("removeFilterRule");
    sysUserTabLogViewGrid.grid.datagrid("load");
});