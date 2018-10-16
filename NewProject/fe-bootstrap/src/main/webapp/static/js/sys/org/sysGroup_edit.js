/**
 * 组织架构。 Created by qiujingde on 2016/12/22. / / / / /
 */

var sysGroupLayout = $("#sysGroupLayout");
var sysGroupForm = $("#sysGroupForm");

$("#sysGroupForm #orgId").combotree({
	onLoadSuccess: function() {
		$("#sysGroupForm #orgId").combotree("setValue", orgId);
	}
});

sysGroupForm.validate({
	rules:{
		groupName: {required: true},
		groupCode: {required: true}
	}
});

// 保存---------------------------------------------------------------------------------------------------
sysGroupLayout.find("[tag=ok]").click(function() {
	//验证表单--------------------------------------------------
	if(!sysGroupForm.validate().form()) return false;
	sysGroupLayout.block();
	HgUtil.post("/"+formUrl, $("#sysGroupForm").serialize(), function(data){
    	if (data.success){
    		HgUi.ok("保存数据成功!", function() {
    			sysOrgTree.popWin.window("close");
    		    sysOrgTree.treegrid.treegrid("reload");
    		});
    	}else{
    		sysGroupLayout.unblock();
    		/*HgUi.error(data.data, function() {
    		});*/
    	}
	});
});

// 取消---------------------------------------------------------------------------------------------------
sysGroupLayout.find("[tag=cancel]").click(function() {
	sysOrgTree.popWin.window("close");
});
