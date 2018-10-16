<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/meta.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>附件上传</title>
</head>
<body>
		<table class="easyui-datagrid" idField="attId" toolbar="#purchaseFile_toolbar" id="purchaseFile_grid" 
			pagination="true" fit=true rownumbers="true" fitColumns="true" singleSelect="true" showFooter="true"
			data-options="">
			<thead>
				<tr>
					<th field="attName" width="50"
					   editor="{type:'textbox',options:{required:true,missingMessage:'此输入项为必填项',validType:'length[1,125]'}}">附件名称</th>
					<th field="sysFile.descr" width="100" 
					   editor="{type:'textbox',options:{missingMessage:'此输入项为必填项',validType:'length[1,500]'}}">备注</th>
				</tr>
			</thead>
		</table>
		
		<div id="purchaseFile_toolbar">
				<table class="table_form_result">
					<caption>
					    <shiro:hasPermission name="<%= Auths.Sys.FILE_UPLOAD %>">
							<!-- ie下,必须是点到文件框选择文件才可以成功上传,故只能使用层叠样式实现 -->
							<!-- 开始层叠样式,将按钮和webupload堆叠yyzh -->
							<div style="position: relative;width:55px;height: 20px;float: left;">
								<a href="javascript:void(0)" class="a_btn_blue" 
								   style="position: absolute;margin-top: 2px;" tag="add"><em>新建</em></a>
								<!-- 设置webupload样式为透明,并设置为上层显示 -->
								<div href="javascript:void(0)" id="purchase_file_uploader_packer"
									onmouseenter="$('#addFiles').css('background-color','rgb(230,230,230)');"
									onmouseleave="$('#addFiles').css('background-color','rgb(245,245,245)');"
									style="position: absolute; filter: alpha(opacity=0);opacity:0;
										float: left;margin-top: 0px;z-index: 2;width: 55px;height: 25px;">&nbsp;</div>
							</div>
						</shiro:hasPermission>
						<shiro:hasPermission name="<%= Auths.Sys.FILE_UPDATEATTACH %>">
							<a href="javascript:void(0)" class="a_btn_green" tag="save"><em>保存</em></a>
						</shiro:hasPermission>
						<shiro:hasPermission name="<%= Auths.Sys.FILE_DELETEATTACH %>">
							<a href="javascript:void(0)" class="a_btn_red" tag="del"><em>删除</em></a>
						</shiro:hasPermission>
					        <a href="javascript:void(0)" class="a_btn_orange" tag="undo"><em>撤销</em></a>
						    <a href="javascript:void(0)" class="a_btn_blue" tag="downFile"><em>下载</em></a>
					</caption>
				</table>
		</div>

	<script type="text/javascript">
		var purchaseFile_attachmentGrid = HgWebUpload.initAttachmentGrid({
			editEnable:true,
			gridObj:"#purchaseFile_grid",
            toolbarObj:"#purchaseFile_toolbar",
            formData:{ 
            	   "bizType":"ict",
            	   "relationPk":"${relationPk}",
            	   "fileType":"${fileType}",
            	   "groupType":"${groupType}"
            },
            uploadButtonObj:'#purchase_file_uploader_packer',
		});
		 purchaseFile_attachmentGrid.loadUrl("/sys/sysFile/fileList");
		 
	</script>
</body>

</html>
