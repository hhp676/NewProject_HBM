sysUserDetail.toEdit = function(){
	$("#userDetailWin").window("close");
	$("#sysUser_toolbar [tag=edit]").click();
}

sysUserDetail.toDel = function(){
	$("#userDetailWin").window("close");
	$("#sysUser_toolbar [tag=del]").click();
}

//校验性别
sysUserDetail.genderOnChange = function(newValue,oldValue) {
	$("#userInfoForm").validate().element($("#userInfoForm [name='gender']"));
}
//校验人员状态
sysUserDetail.staffStatusOnChange = function(newValue,oldValue) {
	$("#userStaffForm").validate().element($("#userStaffForm [name='staffStatus']"));
}

sysUserDetail.initSysUserDetail = function(mode) {
	var authManage = new sysAuthManage(1,"userAuth");
	//初始化权限选择树
	authManage.init({userId: sysUserDetail.userId});
	var authNManage = new sysAuthManage(-1,"userNAuth");
	//初始化负权限选择树
	authNManage.init({userId: sysUserDetail.userId});

	//初始化角色grid
	$("#userRole_grid").datagrid({checkOnSelect:true,selectOnCheck:false,singleSelect:true,onLoadSuccess:function(data){
		var roleIdAry = sysUserDetail.roleIds.split(",");
		for (var index in roleIdAry) {
			for (var rowIndex in data.rows) {
				if (data.rows[rowIndex].roleId == roleIdAry[index]) {
					$("#userRole_grid").datagrid("checkRow", rowIndex);
				}
			}			
		}
	}});
	//初始化岗位tree
	$("#userposition_tree").treegrid({onLoadSuccess:function(data){
		var positionIdAry = sysUserDetail.positionIds.split(",");
		 for(var index in positionIdAry){
			 $("#userposition_tree").treegrid ('checkNode', "p_"+positionIdAry[index]);
	     }
	}});
	
	//初始化用户组tree
	$("#usergroup_tree").treegrid({onLoadSuccess:function(data){
		var groupIdAry = sysUserDetail.groupIds.split(",");
		 for(var index in groupIdAry){
			 $("#usergroup_tree").treegrid ('checkNode', "g_"+groupIdAry[index]);
	     }
	}});
	
	
	if (mode == "view"){
		// 查看详情时移除按钮
		$("#sysUserDetail_layout [tag='ok']").parent().remove();
	} 

	$('#userAccountForm').validate({
		rules: { 
			loginName : {required: true, rangelength: [1, 25]},
			loginPwd : {required: true, rangelength: [6, 20]},
		}
	});
	
	$("#userInfoForm").validate({
		rules: { 
			userName : {required: true, rangelength: [1, 20]},
			engName : {rangelength: [1, 50]},
			gender : {required: true},
			mobile : {mobile: true},
			telephone : {telephone: true},
			email : {email:true,rangelength: [1, 100]},
			address : {rangelength: [1, 200]},
		}
	});
	$("#userStaffForm").validate({
		rules: { 
			staffCode : {required: true, rangelength: [1, 32]},
			staffStatus : {required: true},
			entryTime : {required: true},
			idCard : {idCard: true},
			bankCard : {number: true, rangelength:[16,20]},
			descr : {rangelength: [0, 500]}
		}
	});

	$("#sysUserDetail_layout [tag='ok']").click(function() {
		if (mode == 'add') {
			_saveSysUser(true);
		} else {
			_saveSysUser();
		}
		
	});
	
	$("#sysUserDetail_layout [tag='cancel']").click(function() {
		$("#sysUserDetail_layout").parent().window("close");
	});
	
	
	
	
	

	
	// 私有页面方法------------------------------------------------------------------------------------------------------
	function _saveSysUser(isAdd) {
		// 验证表单--------------------------------------------------
		var accountCheck = $('#userAccountForm').validate().form();
		var infoCheck = $('#userInfoForm').validate().form();
		var staffCheck = $('#userStaffForm').validate().form();
		
		var staffStatus = $("#userStaffForm [name='staffStatus']").val();
		var sysUserDetailQuitTime = $("#sysUserDetailQuitTime").val();
		if(staffStatus == '0' && sysUserDetailQuitTime ==''){
			HgUi.notice("员工状态设置为离职时,离职时间不能为空!");
			return false;
		}
		if (accountCheck && infoCheck && staffCheck) {
			$("#sysUserDetail_layout").block();
			_commitSysUser(isAdd);
		}
	
		
	};
	
	
	
	function _commitSysUser(isAdd) {
		var submitData = {};
		submitData["userName"] = $.trim($("#userInfoForm [name='userName']").val());
		submitData["engName"] = $.trim($("#userInfoForm [name='engName']").val());
		submitData["gender"] = $("#userInfoForm [name='gender']").val();
		submitData["mobile"] = $.trim($("#userInfoForm [name='mobile']").val());
		submitData["birthday"] = $("#userInfoForm [name='birthday']").val();
		submitData["telephone"] = $.trim($("#userInfoForm [name='telephone']").val());
		submitData["email"] = $.trim($("#userInfoForm [name='email']").val());
		submitData["address"] = $.trim($("#userInfoForm [name='address']").val());
		submitData["descr"] = $.trim($("#userInfoForm [name='descr']").val());
		
		submitData["userAccount.loginName"] = $.trim($("#userAccountForm [name='loginName']").val());
		submitData["userAccount.loginPwd"] = $.trim($("#userAccountForm [name='loginPwd']").val());
		submitData["userAccount.descr"] = $.trim($("#userAccountForm [name='descr']").val());		
		submitData["staffInfo.staffCode"] = $.trim($("#userStaffForm [name='staffCode']").val());
		submitData["staffInfo.staffStatus"] = $("#userStaffForm [name='staffStatus']").val();
		submitData["staffInfo.entryTimeStr"] = $("#userStaffForm [name='entryTime']").val();
		submitData["staffInfo.quitTimeStr"] = $("#userStaffForm [name='quitTime']").val();
		submitData["staffInfo.idCard"] = $.trim($("#userStaffForm [name='idCard']").val());
		submitData["staffInfo.bankCard"] = $.trim($("#userStaffForm [name='bankCard']").val());
		submitData["staffInfo.descr"] = $.trim($("#userStaffForm [name='descr']").val());
		
		//tab中数据
		var checkedRoleRows = $("#userRole_grid").datagrid("getChecked");
		var checkedRoleIds = [];
		for(var index in checkedRoleRows){
			checkedRoleIds.push(checkedRoleRows[index].roleId);
		}
		submitData["roleIds"] = checkedRoleIds.join(",");
		
		authManage.onSave(function(checkedAuthIds){
			submitData["authIds"] = checkedAuthIds.join(',');
			
		});
		authNManage.onSave(function(checkedAuthIds){
			submitData["nAuthIds"] = checkedAuthIds.join(',');
		})
		
		var positionRows = $("#userposition_tree").treegrid("getCheckedNodes");
		var positionCheckedIds = [];
		for(var index in positionRows){
			positionCheckedIds.push(positionRows[index].baseId);
		}
		
		var groupRows = $("#usergroup_tree").treegrid("getCheckedNodes");
		var groupCheckedIds = [];
		for(var index in groupRows){
			groupCheckedIds.push(groupRows[index].baseId);
		}
		submitData["positionIds"] = positionCheckedIds.join(',');
		submitData["groupIds"] = groupCheckedIds.join(',');
		
		var submitUrl = "/sys/sysUser/addUser";
		if (!isAdd) {
			submitUrl = "/sys/sysUser/updUser";
			submitData["userId"] = sysUserDetail.userId;
		}
			
		
		HgUtil.post(submitUrl, submitData, function(data) {	
			HgUi.ok("保存数据成功!", function() {
				var _editCallback = $("#sysUserDetail_layout").parent().window("options").editCallback;
				
				$("#sysUserDetail_layout").parent().window("close");
				
				//2017-03-28 需要支持其他功能中修改用户信息，获取是否有editCallback
				if (_editCallback) {
					_editCallback();
				} else {
					$('#sysUser_grid').datagrid("reload");
				}
			});
		},function(data){
			HgUi.error(JSON.parse(data.responseText).data,function(){
				$("#sysUserDetail_layout").unblock();
			});			
		});
	}
	
};

$("#sysAuthManage_grid_userAuth_table #treeGridShowNext").hide();
var sysAuthManage_grid_userAuth = {};
sysAuthManage_grid_userAuth.grid = $("#sysAuthManage_grid_userAuth");
sysAuthManage_grid_userAuth.onLoadSuccess = function(row, data){
	/*sysAuthManage_grid_userAuth.data = data;*/
}

/**
 * 查询匹配字段值
 * @author yinyanzhen
 */
sysAuthManage_grid_userAuth.searchStr = function(){
	sysAuthManage_grid_userAuth.sysAuthLocation = 
		new sysAuthLocation(sysAuthManage_grid_userAuth.grid, 
			 $("#sysAuthManage_grid_userAuth_table #authName").val(), 
			 $("#sysAuthManage_grid_userAuth_table #treeGridShowNext"));
	sysAuthManage_grid_userAuth.sysAuthLocation.searchStr();
}
/**
 * 定位下一个匹配值
 */
sysAuthManage_grid_userAuth.showNext = function (){
	sysAuthManage_grid_userAuth.sysAuthLocation.showNext();
}

/**************************************负授权定位***************************************/
$("#sysAuthManage_grid_userNAuth_table #treeGridShowNext").hide();
var sysAuthManage_grid_userNAuth = {};
sysAuthManage_grid_userNAuth.grid = $ ("#sysAuthManage_grid_userNAuth");
sysAuthManage_grid_userNAuth.onLoadSuccess = function(row, data){
	/*sysAuthManage_grid_userNAuth.data = data;*/
}

/**
 * 查询匹配字段值
 * @author yinyanzhen
 */
sysAuthManage_grid_userNAuth.searchStr = function(){
	sysAuthManage_grid_userNAuth.sysAuthLocation = 
		new sysAuthLocation(sysAuthManage_grid_userNAuth.grid, 
			 $("#sysAuthManage_grid_userNAuth_table #authName").val(), 
			 $("#sysAuthManage_grid_userNAuth_table #treeGridShowNext"));
	sysAuthManage_grid_userNAuth.sysAuthLocation.searchStr();
}
/**
 * 定位下一个匹配值
 */
sysAuthManage_grid_userNAuth.showNext = function (){
	sysAuthManage_grid_userNAuth.sysAuthLocation.showNext();
}


