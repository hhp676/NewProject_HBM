<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/WEB-INF/jsp/common/meta.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>SysRole</title>
</head>
<body>
    <div class="easyui-layout" fit=true>
        <div data-options="region:'center',title:'角色管理',border:false"
            style="padding: 0px;" class="easyui-datagrid-layout">
            <table singleSelect=true fit=true id="sysRole_grid" fitColumns=true
                toolbar="#sysRole_toolbar" pagination="true"
                pageSize="${defaultPageSize}" pageList="${defaultPageList}"
                data-options="url:'${ctx}/sys/sysRole/list'">
                <thead>
                    <tr>
                        <th data-options="field:'roleId',width:160,hidden:true" >主键</th>
                        <th data-options="field:'roleName',width:120"
                            editor="{type:'textbox',options:{required:true,missingMessage:'此输入项为必填项',validType:['length[0,120]']}}">角色名称</th>
                        <th data-options="field:'roleCode',width:120"
                            editor="{type:'textbox',options:{required:true,missingMessage:'此输入项为必填项',validType:['length[0,60]']}}">角色代码</th>
                        <th data-options="field:'descr',width:200"
                            editor="{type:'textbox',options:{required:true,missingMessage:'此输入项为必填项',validType:['length[0,200]']}}">描述</th>
                        <th data-options="field:'isFinal',width:120,formatter:function(value){return HgUtil.getDictItemName('trueOrFalse',value);}"
                            editor="{type:'combobox',options:{url:'${ctx}/sys/common/sysDict/itemList/trueOrFalse',textField:'itemName',valueField:'itemValue', panelHeight:'auto',mode:'remote',editable:false}}"
                            align="center">是否锁定</th>

                    </tr>
                </thead>
            </table>
            <div id="sysRole_toolbar" tag=listen_hotkey>
                <table>
                    <tr>
                    <td>
                        <shiro:hasPermission name="<%= Auths.Sys.ROLE_ADD %>">
                          <a href="javascript:void(0);" class="btn btn-primary" tag="add"><i class="fa fa-plus"></i>新建</a>
                        </shiro:hasPermission>
                        <shiro:hasPermission name="<%= Auths.Sys.ROLE_UPDATE %>">
                            <a href="javascript:void(0);" tag="update" style="display: none"><i class="fa fa-plus"></i>修改</a>
                        </shiro:hasPermission>
                        <h:hasAnyPermissions name='<%= Auths.Sys.ROLE_ADD + "," + Auths.Sys.ROLE_UPDATE %>'>
                            <a href="javascript:void(0);" class="btn btn-success" tag="save"><i class="fa fa-save"></i>保存</a>
                        </h:hasAnyPermissions>
                        <shiro:hasPermission name="<%= Auths.Sys.ROLE_DELETE %>">
                            <a href="javascript:void(0);" class="btn btn-darkorange" tag="del"><i class="fa fa-remove"></i>删除</a>
                        </shiro:hasPermission>

                       <a href="javascript:void(0);" class="btn btn-azure" tag="undo"><i class="fa fa-mail-reply"></i>撤销</a>
                       <a href="javascript:void(0);" class="btn btn-yellow"
                        tag="clear"><i class="fa fa-eraser"></i>清空查询</a>
                      </td>
                    </tr>
                </table>
            </div>
        </div>
        <div data-options="region:'east',collapsible:false,split:true,border:false,title:'角色配置信息'" style="width: 50%;">
            <div id="sysRoleView_tabs" class="easyui-tabs" style="height:100%;">
                <shiro:hasPermission name="<%= Auths.Sys.ROLE_AUTH_VIEW %>">
                <div title="角色权限" style="padding: 0px; display: none;">
                    <div id="sysRoleAuthView" class="easyui-panel" fit=true  data-options="border:false,href:'${ctx}/sys/sysRole/sysRoleAuthView'"></div>
                </div>
                </shiro:hasPermission>
                
                <shiro:hasPermission name="<%= Auths.Sys.ROLE_USER_VIEW %>">
                <div title="授权用户" style="padding: 0px; display: none;height:100%;">
                    <%@ include file="./sysRoleUser_view.jsp" %>
                </div>
                </shiro:hasPermission>
            </div>

        </div>

    </div>
    <script type="text/javascript"
        src="${ctx}/static/js/sys/role/sysRole_view.js?jsTimer=${jsTimer}"></script>
</body>
</html>