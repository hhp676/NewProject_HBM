<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/WEB-INF/jsp/common/meta.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户详情页面</title>
</head>
<body>
	<div class="easyui-layout" data-options="fit:true"
		id="sysUserDetail_layout">
		<c:if test="${mode == 'view'}">
			<h:hasAnyPermissions
				name='<%=Auths.Sys.USER_UPDATE + "," + Auths.Sys.USER_DELETE%>'>
				<div data-options="region:'north',border:false"
					style="text-align: left; padding: 5px 5px 5px; background-color: #fafafa">
					<h:hasAllPermissions name="<%=Auths.Sys.USER_UPDATE%>">
						<a href="javascript:void(0);" class="btn btn-success btn-sm" onclick="sysUserDetail.toEdit()"> 
							<i class="fa fa-edit"></i>修改
						</a>
					</h:hasAllPermissions>
					<h:hasAllPermissions name="<%=Auths.Sys.USER_DELETE%>">
						<a href="javascript:void(0);" class="btn btn-darkorange btn-sm" onclick="sysUserDetail.toDel()"> 
							<i class="fa fa-remove"></i>删除
						</a>
					</h:hasAllPermissions>
				</div>
			</h:hasAnyPermissions>
		</c:if>
		<div data-options="region:'center'" style="padding: 10 10 10 20px;">
			<div class="easyui-layout" fit=true data-options="border:false">
				<div data-options="region:'center',border:false">
					<div class="easyui-layout" fit=true data-options="border:false">
						<div data-options="region:'north',border:false"
							style="height: 115px; padding-top: 2px;" title=""
							collapsible=false>
							<div class='form-title'>登录信息</div>
							<form id="userAccountForm" class="hgform">
								<table class="hgtable">
									<tr>
										<td style="width: 78px;" align="right">登录名<sup>*</sup>：
										</td>
										<td style="width: 170px">
										  <input type="text" name="loginName" ${user.userId != null?'disabled':''}
                                            value="${user.userAccount.loginName}" style="width: 130px;" /><br />
										</td>
										<td align="right" style="display: none; width: 70px;"
											tag="pwd">初始密码<sup>*</sup>：
										</td>
										<td style="width: 170px; display: none;" tag="pwd">
										  <input
											name="loginPwd" type="text"
											onfocus="this.type='password'"
											<c:if test="${user.userId != null}">
												 value="111111"
											</c:if>
											style="width: 130px;" /><br /></td>
									</tr>
									<tr>
										<td align="right">描述：</td>
										<td colspan="3"><textarea name="descr" 
												${mode == 'view'?'disabled':''}
												style="width: 376px; height: 26px;">${user.userAccount.descr}</textarea><br />
										</td>
									</tr>
								</table>
							</form>
						</div>
						<div data-options="region:'center'" title=""
							style="padding-top: 2px;">
							<div class='form-title'>用户信息</div>
							<form id="userInfoForm" class="hgform">
								<table class="hgtable">
									<tr>
										<td style="width: 78px;" align="right">用户名<sup>*</sup>：
										</td>
										<td style="width: 170px;">
												<input type="text"
													name="userName" value="${user.userName}" 
													${mode == 'view'?'disabled':''} style="width: 140px;" />
										</td>
										<td align="right">英文名：</td>
										<td style="width: 170px;"><input name="engName"
											value="${user.engName}" ${mode == 'view'?'disabled':''}
											style="width: 140px;" /><br /></td>
									</tr>
									<tr>
										<td align="right">性别<sup>*</sup>：
										</td>
										<td style="width: 170px;"><select type="text"
											name="gender" class="easyui-combobox"
											${mode == 'view'?'disabled':''} style="width: 142px;"
											panelHeight='auto'
											data-options="url: '${ctx}/sys/common/sysDict/itemList/maleOrFemale',
	                              			   valueField: 'itemValue', textField: 'itemName', 
	                              			   value:'${user.gender}',
	                              			   editable: false, prompt: '---请选择---',
                                               onChange:sysUserDetail.genderOnChange">
										</select><br /></td>
										<td align="right">手机号码：</td>
										<td style="width: 170px;"><input name="mobile"
											value="${user.mobile}" ${mode == 'view'?'disabled':''}
											style="width: 140px;" /><br /></td>
									</tr>
									<tr>
										<td align="right">生日：</td>
										<td style="width: 170px;"><input name="birthday"
											type="text" class="Wdate" ${mode == 'view'?'disabled':''}
											onfocus="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-%d'})"
											value="${user.birthday}" style="width: 140px;" /><br /> <!-- <input name="birthday" class="easyui-datebox" editable=false 
										  data-options="buttons:HgUi.dateboxButtons" value="${user.birthday}" style="width: 140px;" />-->
										</td>
										<td align="right">联系电话：</td>
										<td style="width: 170px;"><input name="telephone"
											prompt="格式:XXX-XXXXXXXX" ${mode == 'view'?'disabled':''}
											value="${user.telephone}" style="width: 140px;" /><br /></td>
									</tr>
									<tr>
										<td align="right">邮箱：</td>
										<td colspan="3"><input name="email"
											${mode == 'view'?'disabled':''} value="${user.email}"
											style="width: 374px;" />
										</td>
									</tr>
									<tr>
										<td align="right">地址：</td>
										<td colspan="3"><input name="address"
											${mode == 'view'?'disabled':''} value="${user.address}"
											style="width: 374px;" /></td>
									</tr>
									<tr>
										<td align="right">描述：</td>
										<td colspan="3"><textarea name="descr" 
												${mode == 'view'?'disabled':''}
												style="width: 374px; height: 26px;">${user.descr}</textarea>
										</td>
									</tr>
								</table>
							</form>
						</div>
						<div data-options="region:'south'"
							style="height: 170px; padding-top: 2px;" title=""
							collapsible=false>
							<div class="form-title">员工信息</div>
							<form id="userStaffForm" class="hgform">
								<table class="hgtable">
									<tr>
										<td style="width: 85px;" align="right">员工号<sup>*</sup>：
										</td>
										<td style="width: 170px;"><input name="staffCode"
											value="${user.staffInfo.staffCode}"
											${mode == 'view'?'disabled':''} style="width: 130px;" /><br />
										</td>
										<td style="width: 70px;" align="right">员工状态<sup>*</sup>：
										</td>
										<td style="width: 170px;"><select type="text"
											name="staffStatus" class="easyui-combobox"
											${mode == 'view'?'disabled':''} style="width: 132px;"
											panelHeight='auto' editable="false"
											data-options="url: '${ctx}/sys/common/sysDict/itemList/STAFF_STATUS',
                              			   valueField: 'itemValue', textField: 'itemName', 
                              			   value:'${user.staffInfo.staffStatus}',
                              			   prompt: '---请选择---',
                              			   onChange:sysUserDetail.staffStatusOnChange">
										</select><br /></td>
									</tr>
									<tr>
										<td align="right">入职日期<sup>*</sup>：
										</td>
										<td><input name="entryTime" type="text" class="Wdate"
											id="sysUserDetailEntryTime" ${mode == 'view'?'disabled':''}
											onfocus="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'sysUserDetailQuitTime\',{d:0})||\'%y-%M-%d\'}'})"
											value="<fmt:formatDate value="${user.staffInfo.entryTime}" pattern="yyyy-MM-dd"/>"
											style="width: 130px;" /><br /></td>
										<td align="right">离职日期：</td>
										<td><input name="quitTime" type="text" class="Wdate"
											id="sysUserDetailQuitTime" ${mode == 'view'?'disabled':''}
											onfocus="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'sysUserDetailEntryTime\',{d:0});}'})"
											value="<fmt:formatDate value="${user.staffInfo.quitTime}" pattern="yyyy-MM-dd"/>"
											style="width: 132px;" /></td>
									</tr>
									<tr>
										<td align="right">身份证号：</td>
										<td><input name="idCard" ${mode == 'view'?'disabled':''}
											value="${user.staffInfo.idCard}" style="width: 130px;" />
										<td align="right">银行帐号：</td>
										<td><input name="bankCard"
											${mode == 'view'?'disabled':''}
											value="${user.staffInfo.bankCard}" style="width: 132px;" />
									</tr>
									<tr>
										<td align="right">描述：</td>
										<td colspan="3"><textarea name="descr" 
												${mode == 'view'?'disabled':''}
												style="width: 374px; height: 26px;">${user.staffInfo.descr}</textarea>
										</td>
									</tr>
								</table>
							</form>
						</div>
					</div>
				</div>
				<div data-options="region:'east'" style="width: 410px;">
					<div class="easyui-tabs" fit=true data-options="border:false">
						<div title="角色信息">
							<c:if test="${mode != 'view'}">
								<table fit=true id="userRole_grid" fitColumns=true
									singleSelect=true
									data-options="url:'${ctx}/sys/sysRole/getList'">
									<thead>
										<tr>
											<th data-options="field:'roleId',checkbox:true"></th>
											<th data-options="field:'roleName',width:120">角色名称</th>
											<th data-options="field:'roleCode',width:120">角色代码</th>
											<th data-options="field:'descr',width:200">描述</th>
										</tr>
									</thead>
								</table>
							</c:if>
							<c:if test="${mode == 'view'}">
								<table fit=true fitColumns=true class="easyui-datagrid"
									pagination="true" singleSelect=true
									pageSize="${defaultPageSize}" pageList="${defaultPageList}"
									data-options="
								        url:'${ctx}/sys/sysUser/sysUserTabRoleList?userId=${user.userId}'">
									<thead>
										<tr>
											<th data-options="field:'roleId',hidden:true,width:150">主键</th>
											<th data-options="field:'roleName',width:150">角色名称</th>
											<th data-options="field:'roleCode',width:150">角色编码</th>
											<th data-options="field:'descr',width:150">角色描述</th>
										</tr>
									</thead>
								</table>
							</c:if>
						</div>
						<div title="权限信息">
							<table style="width: 100%" id="sysAuthManage_grid_userAuth_table">
								<tr>
									<td align="right" width="10%">名称：</td>
									<td width="30%"><input id="authName" class="easyui-textbox"></td>
									<td>
										&nbsp;<a href="javascript:void(0);" onclick="sysAuthManage_grid_userAuth.searchStr();" class="btn-palegreen  btn-sm"> 
												<i class="fa fa-search"></i>定位
										</a>
									</td>
									<td id="treeGridShowNext">
										&nbsp;<a href="javascript:void(0);" onclick="sysAuthManage_grid_userAuth.showNext();" class="btn-yellow  btn-sm"> 
											<i class="fa fa-angle-down"></i>下一个
										</a>
									</td>
								</tr>
							</table>
							<c:if test="${mode != 'view'}">
								<table id="sysAuthManage_grid_userAuth" class="easyui-treegrid"
								    toolbar="#sysAuthManage_grid_userAuth_table"
									fit=true fitColumns=true singleSelect=true
									data-options="idField:'authId',treeField:'authName',cascadeCheck:true">
									<thead>
										<tr>
											<th data-options="field:'authName',width:180">名称</th>
											<th
												data-options="field:'authShowType',formatter:function(val){if(val == 2) {return '权限';}else if(val == 1){return '模块';}}"
												width="30px">类型</th>
										</tr>
									</thead>
								</table>
							</c:if>
							<c:if test="${mode == 'view'}">
								<table id="sysAuthManage_grid_userAuth" class="easyui-treegrid"
								    toolbar="#sysAuthManage_grid_userAuth_table"
									fit=true fitColumns=true singleSelect=true
									data-options="idField:'authId',treeField:'authName',
									       url:'${ctx}/sys/sysAuthMenu/getUserAuthList?userId=${user.userId}'">
									<thead>
										<tr>
											<th data-options="field:'authName',width:50">名称</th>
											<th data-options="field:'userAuthFrom',width:40">来源</th>
										</tr>
									</thead>
								</table>
							</c:if>
						</div>
						<div title="负权限信息">
							<table style="width: 100%"
								id="sysAuthManage_grid_userNAuth_table">
								<tr>
									<td align="right" width="10%">名称：</td>
									<td width="30%"><input id="authName" class="easyui-textbox"></td>
									<td>
										&nbsp;<a href="javascript:void(0);" onclick="sysAuthManage_grid_userNAuth.searchStr();" class="btn-palegreen  btn-sm"> 
												<i class="fa fa-search"></i>定位
										</a>
									</td>
									<td id="treeGridShowNext">
										&nbsp;<a href="javascript:void(0);" onclick="sysAuthManage_grid_userNAuth.showNext();" class="btn-yellow  btn-sm"> 
											<i class="fa fa-angle-down"></i>下一个
										</a>
									</td>
									
								</tr>
							</table>
							<c:if test="${mode != 'view'}">
								<table id="sysAuthManage_grid_userNAuth" class="easyui-treegrid"
								    toolbar="#sysAuthManage_grid_userNAuth_table"
									fit=true fitColumns=true singleSelect=true
									data-options="idField:'authId',treeField:'authName',cascadeCheck:true">
									<thead>
										<tr>
											<th data-options="field:'authName',width:180">名称</th>
											<th
												data-options="field:'authShowType',formatter:function(val){if(val == 2) {return '权限';}else if(val == 1){return '模块';}}"
												width="30px">类型</th>
										</tr>
									</thead>
								</table>
							</c:if>
							<c:if test="${mode == 'view'}">
								<table id="sysAuthManage_grid_userNAuth" class="easyui-treegrid"
								    toolbar="#sysAuthManage_grid_userNAuth_table"
									fit=true fitColumns=true singleSelect=true
									data-options="idField:'authId',treeField:'authName',
                                            url:'${ctx}/sys/sysAuthMenu/getUserNAuthList?userId=${user.userId}'">
									<thead>
										<tr>
											<th data-options="field:'authName',width:180">名称</th>
											<th
												data-options="field:'authShowType',
                                                    formatter:function(val){
                                                        if(val == 2) {
                                                            return '权限';
                                                        }else if(val == 1){return '模块';}}"
												width="30px">类型</th>
										</tr>
									</thead>
								</table>
							</c:if>
						</div>
						<div title="岗位信息">
							<c:if test="${mode != 'view'}">
								<table id="userposition_tree"
									data-options="url:'${ctx}/sys/org/orgTree',idField: 'nodeId',
	               				 	treeField: 'name',pagination: false,fit: true, fitColumns: true, singleSelect: true,
	               					cascadeCheck:false, checkbox: function(row){if (row.nodeType ==2){return true;}}">
									<thead>
										<tr>
											<th data-options="field:'name',width:40">名称</th>
											<th
												data-options="field:'nodeType',width:15,formatter:HgUtil.fieldFormatterFunc('orgNodeType')">类型</th>
											<th data-options="field:'code',width:20">编码</th>
										</tr>
									</thead>
								</table>
							</c:if>
							<c:if test="${mode == 'view'}">
								<table id="userposition_tree" class="easyui-datagrid"
									data-options="fit: true, fitColumns: true, singleSelect: true, 
	                                    url:'${ctx}/sys/sysUser/sysUserTabPosList?userId=${user.userId}'">
									<thead>
										<tr>
											<th data-options="field:'sysPosition.positionName',width:40">岗位名称</th>
											<th
												data-options="field:'isMajor',width:20,
                                                    formatter:HgUtil.fieldFormatterFunc('isMajorPztn')"
												align="center">岗位类别</th>
											<th data-options="field:'sysPosition.positionCode',width:40">岗位编码</th>
										</tr>
									</thead>
								</table>
							</c:if>
						</div>
						<div title="小组信息">
							<c:if test="${mode != 'view'}">
								<table id="usergroup_tree"
									data-options="url:'${ctx}/sys/org/orgTree',idField: 'nodeId',
                                    treeField: 'name',pagination: false,fit: true,fitColumns: true, singleSelect: true,
                                    cascadeCheck:false, checkbox: function(row){if (row.nodeType ==3){return true;}}">
									<thead>
										<tr>
											<th data-options="field:'name',width:40">名称</th>
											<th
												data-options="field:'nodeType',width:15,formatter:HgUtil.fieldFormatterFunc('orgNodeType')">类型</th>
											<th data-options="field:'code',width:20">编码</th>
										</tr>
									</thead>
								</table>
							</c:if>
							<c:if test="${mode == 'view'}">
								<table id="usergroup_tree" class="easyui-datagrid"
									data-options="fit: true,fitColumns: true, singleSelect: true, 
                                    url:'${ctx}/sys/sysUser/sysUserTabGroupList?userId=${user.userId}'">
									<thead>
										<tr>
											<th data-options="field:'sysGroup.groupName',width:15">小组名称</th>
											<th data-options="field:'sysGroup.groupCode',width:15">小组编码</th>
											<th
												data-options="field:'isLeader',
									             formatter:HgUtil.fieldFormatterFunc('sysGroupDuty'),width:15">小组职责</th>
										</tr>
									</thead>
								</table>
							</c:if>
						</div>
					</div>
				</div>
			</div>
		</div>
		<c:if test="${mode != 'view'}">
			 <div data-options="region:'south',border:false" style="text-align: right; padding: 5px 5px 5px; background-color: #f2f2f2;">
    			<a href="javascript:void(0);" class="btn btn-sky btn-sm" tag="ok"> 
					<i class="fa fa-check-square-o"></i>确认
				</a>
				<a href="javascript:void(0);" class="btn btn-warning btn-sm" tag="cancel"> 
					<i class="fa fa-close"></i>取消
				</a>
    		</div>
		</c:if>
	</div>

	<script type="text/javascript">
		var sysUserDetail = {};
	</script>
	<script type="text/javascript"
		src="${ctx}/static/js/sys/user/sysUser_detail.js"></script>
	<script type="text/javascript">
		sysUserDetail.userId = "${user.userId}";
		sysUserDetail.roleIds = "${roleIds}";
		sysUserDetail.positionIds = "${positionIds}";
		sysUserDetail.groupIds = "${groupIds}";
		sysUserDetail.mode = "${mode}";
     	if(sysUserDetail.mode != 'view'){
    	     sysUserDetail.initSysUserDetail(sysUserDetail.mode);
     	}
	</script>
</body>

</html>
