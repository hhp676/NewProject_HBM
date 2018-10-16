<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/WEB-INF/jsp/common/meta.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>关联关系附件上传demo</title>
</head>
<body>
    <div class="easyui-layout" fit="true">
        <div data-options="region:'center',border:false" style="padding: 0px; ">
            <form id="relationFileUpload" class="hgform">
	            <table id="acceptDetailModelList" class="easyui-datagrid" nowrap="false"
		            data-options="
		                border:false,
		                url:'${ctx}/common/demo/fileDemo/getDataGridFileModel.do',
		                fitColumns:true,
		                striped:true,
		                singleSelect:true,
		                rownumbers:true,
		                scrollbarSize:0,
		                onLoadSuccess: acceptDetailModelListLoadSuccess">
		            <thead>
		                 <tr>
		                    <th data-options="field:'modelVerson',width:20" align="center">附件版本</th>
		                    <th data-options="field:'bizCode',width:20" align="center">业务编码</th>
		                    <th data-options="field:'modelName',width:50" align="center">附件名称</th>
	                        <th data-options="field:'OPERATE',width:100,formatter:newUpFileHtml">上传附件</th>
		                </tr>
		            </thead>
		        </table>
	        </form>
        </div>
        <div data-options="region:'south',border:false" 
            style="text-align: right;padding: 0px; background-color: #e0e0e0;">
                <a href="javascript:void(0);" style="float:right;margin:3px;" class="btn btn-success btn-sm" onclick="relationFileUpload();" ><i class="fa fa-save"></i>保存</a>
        </div>
    </div>
    <script type="text/javascript">
    //记录需要上传的个数(用于后续附件数量校验)
    var modelFileCount=0;
    //datagrid加载完成后执行初始化
    function acceptDetailModelListLoadSuccess(data){
    	modelFileCount=data.rows.length;
    	//合并单元格
    	HgUi.mergeDatagridCellsByFieldsStr($("#acceptDetailModelList"), "modelVerson,bizCode");
    }
    
    //格式化装入文件上传框
    function newUpFileHtml(value, row,index){
    	var html=
    		'<input type="hidden" id="modelID'+index+'" name="modelID'+index+'" value="'+row.modelID+'">'+
    		'<input type="file" id="file'+index+'" name="file'+index+'" style="color: black;">';
    	return html;
    }
    
    function relationFileUpload(){
    	//数组填充,记数
        var count=0;
    	//需要上传的附件id数组
        var fileIDArray=new Array();
        for(var i=0;i<=modelFileCount;i++){
            var obj=$("#file"+i);
            if(obj!=null && obj.val()!='' && obj.val()!=undefined){
                fileIDArray[count]=obj.attr('id');
                count++;
            }
        }
        if(fileIDArray.length<modelFileCount){
            $.messager.alert("提示","部分附件未选择对应文件!","warning");
            return false;
        }
        //组装form内参数封装为Map(Name值不可重复)
        var params=HgUtil.paramArrayToMap($("#relationFileUpload").serializeArray());
        $.messager.progress({
            title:"稍等",
            msg:"正在提交..."
        });
        var url=G_CTX_PATH+'/common/demo/fileDemo/relationFileUpload.do';
        $.ajaxFileUpload({
            url : url,
            type : 'POST',
            fileElementId : fileIDArray, //文件选择框的id属性 
            dataType : 'text',
            data : params,
            success : function(result,status) {
                $.messager.progress("close");
                if (result == "success") {
                	HgUi.ok("操作成功", function()  {
                        //TODO
                    });
                } else {
                	HgUi.error(result,function(){
                		
                	});
                }
            },
            error : function(data, status, e) {
                //服务器响应失败时的处理函数 
                $.messager.progress("close");
                $.messager.alert("error", '出错了');
            }
        });
    }
    </script>
</body>
</html>