/**
 * 组织架构。 Created by qiujingde on 2016/12/22. / /
 */

var sysOrgEditLayout = $("#sysOrgEditLayout");
var sysOrgEditForm = $("#sysOrgEditForm");

$("#sysOrgEditForm #fid").combotree({
	onLoadSuccess: function() {
		$("#sysOrgEditForm #fid").combotree("setValue", fid);
	}
});

sysOrgEditForm.validate({
	rules:{
		orgName: {required: true},
		orgCode: {required: true}
	}
});
// 保存---------------------------------------------------------------------------------------------------
sysOrgEditLayout.find("[tag=ok]").click(function() {
	//验证表单--------------------------------------------------
	if(!sysOrgEditForm.validate().form()) return false;
	sysOrgEditLayout.block();
	HgUtil.post("/"+formUrl, $("#sysOrgEditForm").serialize(), function(data){
		if (data.success){
			HgUi.ok("保存数据成功!", function() {
				sysOrgTree.popWin.window("close");
				sysOrgTree.treegrid.treegrid("reload");
			});
		}else{
			sysOrgEditLayout.unblock();
			/*HgUi.error(data.data, function() {
		});*/
		}
	});
});

// 取消---------------------------------------------------------------------------------------------------
sysOrgEditLayout.find("[tag=cancel]").click(function() {
	sysOrgTree.popWin.window("close");
});
